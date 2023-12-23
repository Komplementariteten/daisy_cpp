#include <pstl/glue_numeric_defs.h>

#include "daisy_seed.h"
#include "daisysp.h"

#define NUMBER_OF_FLOATS 1024
#define TEST_MEMORY_SIZE (NUMBER_OF_FLOATS * 32)

using namespace daisy;
using namespace daisysp;

static DaisySeed hw;
static int value_count = 0;


void store_value(float value){
	int32_t *ram = (int32_t *)0xC0000000;
	unsigned char const *p = reinterpret_cast<unsigned char const *>(&value);
	memcpy((sizeof(float) * value_count) + ram, p, sizeof(float));
	value_count++;
}

float get_avg_from_ram(){
	int32_t *ram = (int32_t *)0xC0000000;
	float sum = 0.0;
	for (size_t i = 0; i < NUMBER_OF_FLOATS; i++)
	{
		unsigned char const *p = (unsigned char const *)((sizeof(float) * i) + ram);
		const float* f = reinterpret_cast<const float*>(p);
		sum += *f;
	}

	hw.PrintLine("%d", sum);
	return (sum / NUMBER_OF_FLOATS);
}

/** Verify FLT_FMT/FLT_VAR accuracy
 */
void VerifyFloats()
{
    char ref[32];
    char tst[32];
    bool result = true;
    for(float f = -100.0; f < 100.0; f += 0.001)
    {
        sprintf(tst, FLT_FMT(3), FLT_VAR(3, f));

        const double f_tst = strtod(tst, nullptr);

        /* verify down to the least significant digit, which is off because of truncation */
        if(abs((double)f - f_tst) > 1.0e-3)
        {
            sprintf(ref, "%.3f", f);
            hw.PrintLine(
                "mismatch: ref = %s, dsy = %s, float = %.6f", ref, tst, f);
            result = false;
        }
    }
    hw.PrintLine("FLT_FMT(3)/FLT_VAR(3) verification: %s",
                 result ? "PASS" : "FAIL");
}



/* float ReadAndLog(DaisySeed& hw, int number_of_values) {
	// std::vector<float> values;
	for (auto i = 0; i < number_of_values; i++) {
		avg += value;
		// values.push_back(value);
		System::Delay(1);
	}
	hw.adc.Stop();
	// System::Delay(1);
	return avg / number_of_values;
} */


int main(void)
{
	hw.PrintLine("This may be used anywhere too");
	hw.Configure();
	hw.Init();
	hw.StartLog(true);
	VerifyFloats();
    // hw.PrintLine("Verify CRT floating point format: %.3f.", 123.0f);

	Led led1;
	led1.Init(hw.GetPin(28), false);
	float avg = 0.0;
	AdcChannelConfig adcConfig;
	adcConfig.InitSingle(hw.GetPin(21));

	hw.adc.Init(&adcConfig, 1);
	hw.adc.Start();
	
	while(1) {
		for (size_t i = 0; i < NUMBER_OF_FLOATS; i++)
		{
			auto value = hw.adc.GetFloat(0);
			store_value(value);
			System::Delay(1);
		}
		avg = get_avg_from_ram();
		value_count = 0;
		// auto avg_falue = ReadAndLog(hw, 40) / 40.0;
		// hw.PrintLine("cycle done %f", avg);
		System::Delay(500);
	}
}
