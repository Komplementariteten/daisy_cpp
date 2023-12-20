target extended-remote /dev/ttyACM0
# monitor tpwr enable
# monitor arm semihosting enable
monitor swdp_scan
# set debug arm
# set debug remote
# set debug auto-load 
# set debug serial 
# set debug target 1
# monitor redirect_stdout enable
# break DefaultHandler
# break HardFault
load
start
attach 1
echo "Upload success!"