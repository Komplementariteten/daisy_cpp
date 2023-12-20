cmake_policy(SET CMP0048 NEW)
cmake_minimum_required(VERSION 3.20)
set(LIB_DAISY daisy)

set(LIB_DAISY_PATH /home/me/Workspace/other/libDaisy)
link_directories("${LIB_DAISY_PATH}/build")

include_directories(AFTER ${LIB_DAISY_PATH}/src/
        ${LIB_DAISY_PATH}/Drivers/CMSIS/Include
        ${LIB_DAISY_PATH}/Drivers/CMSIS/Device/ST/STM32H7xx/Include
        ${LIB_DAISY_PATH}/Drivers/STM32H7xx_HAL_Driver/Inc
        ${LIB_DAISY_PATH}/Drivers/STM32H7xx_HAL_Driver/Inc/Legacy
        ${LIB_DAISY_PATH}/Middlewares/ST/STM32_USB_Device_Library/Core/Inc
        ${LIB_DAISY_PATH}/Middlewares/ST/STM32_USB_Device_Library/Class/CDC/Inc
        ${LIB_DAISY_PATH}/Middlewares/ST/STM32_USB_Host_Library/Core/Inc
        ${LIB_DAISY_PATH}/Middlewares/ST/STM32_USB_Host_Library/Class/MSC/Inc
        ${LIB_DAISY_PATH}/Middlewares/Third_Party/FatFs/src
        ${LIB_DAISY_PATH}/src/sys
        ${LIB_DAISY_PATH}/src/usbd
        ${LIB_DAISY_PATH}/src/usbh
)