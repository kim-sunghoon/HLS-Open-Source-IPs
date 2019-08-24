############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2018 Xilinx, Inc. All Rights Reserved.
############################################################
set hls_prj conv1x1
open_project ${hls_prj}.prj
set_top ${hls_prj}

add_files ${hls_prj}.cc
open_solution "solution1"
set_part {xczu3eg-sbva484-1-e} -tool vivado
create_clock -period 10 -name default

## C simulation
# csim_design

## C code synthesis to generate Verilog code
csynth_design

## C and Verilog co-simulation
## This usually takes a long time so it is commented
## You may uncomment it if necessary
# cosim_design

## export synthesized Verilog code
# export_design -format ip_catalog

exit
