#!/bin/sh
#Cadence VIP environment setup for XMSIM in mode 2s (64-bit mode)
#Usage:
#	${CDN_VIP_ROOT}/bin/cdn_vip_setup_env -cdn_vip_root ${CDN_VIP_ROOT} \
#		-sim xmsim -mode 2s -method sv_uvm -cdn_vip_lib $CDN_VIP_LIB_PATH -cdnautotest -64 \
#		-install "axi uart ddr3sdram ddr4sdram pcie i2c jtag ocp i3c" \
#		-sim_root ${CDS_INST_DIR}

#Xcelium installation
##CDS_INST_DIR=/cadence/XCELIUM2009
CDS_INST_DIR=/cadence/${XCELIUM_VERSION}
export CDS_INST_DIR

#CDN_VIP_ROOT:: Environment variable pointing to Cadence VIP installation
##CDN_VIP_ROOT=/home_extra/share/vip_releases/vipcat_11.30.074-21_Feb_2021_08_43_17
CDN_VIP_ROOT=/cadence/vipcat_11.30.078-11_Aug_2021_08_15_01
export CDN_VIP_ROOT

#CDS_ARCH:: Platform for Cadence VIP libraries
#This is obtained from: ${CDN_VIP_ROOT}/bin/cds_plat
CDS_ARCH=lnx86

#DENALI:: Environment variable pointing to Cadence VIP base libraries
DENALI=${CDN_VIP_ROOT}/tools.${CDS_ARCH}/denali_64bit
export DENALI

#CDN_VIP_VIPLIB_PATH:: Location of Cadence VIP precompiled libraries
#This is an installation directory.
#CDN_VIP_VIPLIB_PATH=/cadence/vipcat_11.30.078-11_Aug_2021_08_15_01
CDN_VIP_VIPLIB_PATH=${CDN_VIP_ROOT}/packages

#CDN_VIP_LIB_PATH:: Location of Cadence VIP compiled libraries
#This is a user-specified directory.
#IMPORTANT:: The libraries must be recompiled (-install option)
#after each new VIP download (and after each Xcelium installation upgrade).
export CDN_VIP_LIB_PATH=${VIP_LIB_DIR}

#SPECMAN_PATH:: Environment variable dictating locations (and search order)
#for multiple Cadence VIP components: Virtual Machine, compiled libraries
#for Cadence VIP pre compiled libraries
SPECMAN_PATH=${CDN_VIP_VIPLIB_PATH}:${CDN_VIP_LIB_PATH}/64bit
export SPECMAN_PATH

#Additional components in ${PATH} to ensure necessary executables are available
PATH=${CDS_INST_DIR}/tools.${CDS_ARCH}/bin:${PATH}
export PATH

#Additional components in ${LD_LIBRARY_PATH} to ensure necessary libraries are available
LD_LIBRARY_PATH=${CDN_VIP_LIB_PATH}/64bit:${DENALI}/verilog:${CDS_INST_DIR}/tools.${CDS_ARCH}/specman/lib/64bit:${CDS_INST_DIR}/tools.${CDS_ARCH}/lib/64bit:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH

# The *USING_CCORE* variables correspond to the VIPs for which simulations will proceed with the C implementation (instead of the VIP Virtual Machine)
CDN_AXI_USING_CCORE="OPTIMIZED"
export CDN_AXI_USING_CCORE

# Disable automatic nc to xm remapping
CDN_VIP_DISABLE_REMAP_NC_XM= 
export CDN_VIP_DISABLE_REMAP_NC_XM
