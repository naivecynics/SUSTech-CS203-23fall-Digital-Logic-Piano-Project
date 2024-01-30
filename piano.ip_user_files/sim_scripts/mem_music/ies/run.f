-makelib ies_lib/xil_defaultlib -sv \
  "C:/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "C:/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/blk_mem_gen_v8_4_1 \
  "../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../piano.srcs/sources_1/ip/mem_music/sim/mem_music.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

