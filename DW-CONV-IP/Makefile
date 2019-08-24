##==========================================================================
## Makefile
##==========================================================================
## @brief: A makefile the compiles and synthesizes the cordic program
##
## @desc: 1. "make" runs csim by default
##        2. "make csim" compiles & executes the fixed-point implementation
##        3. "make clean" cleans up the directory

DESIGN := dwconv3x3
SOURCES := $(DESIGN).cc $(DESIGN)_test.cc
OBJECTS := $(SOURCES:.cc=.o)
INCLUDES := $(DESIGN).h typedefs.h dcl.h
CLEAN_FILES := $(OBJECTS) $(DESIGN) $(DESIGN).exe
CLEAN_FILES += test_data/output.dat
VIVADO_HLS_CLEANUP := $(DESIGN)*prj $(DESIGN).log vivado_hls.log apcc.log

## change to true if using ap[u]int in ISO-C project
USE_ARBITRARY_PRECISION = true
# Change to true if using SystemC types or SC_MODULE, etc.
USE_SYSTEMC	= false
## Automatically setup the software paths
SHELL           := sh
KERNEL          := $(shell if [[ $$(uname -s) == Linux ]];then echo Linux; else echo Win; fi)
ARCH            := $(shell if [[ $$(uname -m) =~ 64$$ ]];then echo x86_64; else echo x86; fi)
OS              := $(KERNEL)_$(ARCH)
ifeq ($(KERNEL), Win)
VIVADO_HLS_EXE_FILENAME := vivado_hls.bat
APCC= $(VIVADO_HLS_ROOT)/$(OS)/bin/apcc_bin.exe
else
VIVADO_HLS_EXE_FILENAME := vivado_hls
APCC:= apcc
endif
VIVADO_HLS_EXE   := $(shell which $(VIVADO_HLS_EXE_FILENAME))
VIVADO_HLS_ROOT  := $(VIVADO_HLS_EXE:/bin/$(VIVADO_HLS_EXE_FILENAME)=)
VIVADO_HLS_INC_PATH := $(VIVADO_HLS_ROOT)/include
SYSTEMC_INC_PATH := $(VIVADO_HLS_ROOT)/$(OS)/tools/systemc/include
SYSTEMC_LIB_PATH := $(VIVADO_HLS_ROOT)/$(OS)/tools/systemc/lib

# ######################################################
# Setup C compiler and options
#
# Use APCC for ISO-C projects that use ap[u]int types; gcc otherwise
ifeq ($(USE_ARBITRARY_PRECISION),true)
CC				:= $(APCC)
CFLAGS		+= -DBIT_ACCURATE
else
CC				:= gcc
endif
CXX			:= g++
# C compiler flags
CFLAGS		+= -ggdb
CFLAGS		+= -w
CFLAGS		+= -I$(VIVADO_HLS_INC_PATH)
# C++ compiler flags
CXXFLAGS		+= -ggdb
CXXFLAGS		+= -I$(VIVADO_HLS_INC_PATH)
# Linker flags
LDFLAGS		+= -lm 
# # SystemC additional flags
ifeq ($(USE_SYSTEMC), true)
CXXFLAGS		+= -I$(SYSTEMC_INC_PATH)
LDFLAGS		+= -L$(SYSTEMC_LIB_PATH)
LDLIBS		+= -lsystemc
endif

# ######################################################
# Rules

all: csim


csim: $(DESIGN)
	./$(DESIGN)

$(DESIGN): $(OBJECTS)

hls: 
	@echo "run vivado hls"
	vivado_hls -f run.tcl


.PHONY: clean
clean:
	rm -rf $(CLEAN_FILES) $(VIVADO_HLS_CLEANUP)
