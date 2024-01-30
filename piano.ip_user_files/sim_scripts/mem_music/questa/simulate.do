onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib mem_music_opt

do {wave.do}

view wave
view structure
view signals

do {mem_music.udo}

run -all

quit -force
