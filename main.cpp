//
// Created by me on 17.12.23.
//

#include "main.h"

DaisySeed hw;

int main(void) {
    hw.Init();
    GPIO m_led;

    m_led.Init(D1, GPIO::Mode::OUTPUT);

    while (1)
    {
        m_led.Write(true);
        System::Delay(500);
        m_led.Write(false);
        System::Delay(500);
        m_led.Toggle();
        System::Delay(500);
        m_led.Toggle();
    }
    
}