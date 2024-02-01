##############################################
# Subsystem specific environmental var setup #
##############################################

# Name of top level verification tb module
export VERIF_TB_NAME=denali_tb

# Name of top level RTL folder and path to it
export TOP_DESIGN_NAME=denali
export RTL_RELEASE_VERSION=v_29
export RTL_RELEASE_HOME=/cad/releases/panorama/revA/rtl_releases
export DESIGN_NAME=denali
export DESIGN_ROOT=${RTL_RELEASE_HOME}/${RTL_RELEASE_VERSION}
export PRECOMPILE_RTL_LIB_ROOT=/workspace/share/Panorama_RTL_Libs
export PRECOMPILE_RTL_LIB_PATH=${PRECOMPILE_RTL_LIB_ROOT}/${RTL_RELEASE_VERSION}/libs

# Name of each subsystem
export CORTEX_DESIGN_NAME=cortex_a55
export M3SS_DESIGN_NAME=arm_m3_wrapper
export PCIE_RC_DESIGN_NAME=pcie_rc_ss
export PCIE_EP_DESIGN_NAME=pcie_dm_ss
#export EMMC_DESIGN_NAME=emmc_ss
#export USB_DESIGN_NAME=usb_ss
export CCE_DESIGN_NAME=cce
export JPEG_DESIGN_NAME=jpeg_codec
export GPU2D_DESIGN_NAME=gpu2d_ss
export CULTUS_DESIGN_NAME=cpu_ss
export DDR_DESIGN_NAME=ddr_ss
export PERI_DESIGN_NAME=peri_ss
export DECSS_DESIGN_NAME=decoder_ss
export ENCSS_DESIGN_NAME=encoder_ss
export VIDSS_DESIGN_NAME=video_ss
export D2D_DESIGN_NAME=d2d_ss

# Paths to each subsystem RTL directory
export CULTUS_DESIGN_DIR=${DESIGN_ROOT}/ips/${CULTUS_DESIGN_NAME}
export CULTUS_CORTEX_DESIGN_DIR=${CULTUS_DESIGN_DIR}/ips/${CORTEX_DESIGN_NAME}
export DDR_DESIGN_DIR=${DESIGN_ROOT}/ips/${DDR_DESIGN_NAME}
export PCIE_EP_DESIGN_DIR=${DESIGN_ROOT}/ips/${PCIE_EP_DESIGN_NAME}
export PERI_DESIGN_DIR=${DESIGN_ROOT}/ips/${PERI_DESIGN_NAME}
export ENCSS_DESIGN_DIR=${DESIGN_ROOT}/ips/${ENCSS_DESIGN_NAME}
export ENCSS_M3SS_DESIGN_DIR=${ENCSS_DESIGN_DIR}/ips/${M3SS_DESIGN_NAME}
export DECSS_DESIGN_DIR=${DESIGN_ROOT}/ips/${DECSS_DESIGN_NAME}
export DECSS_M3SS_DESIGN_DIR=${DECSS_DESIGN_DIR}/ips/${M3SS_DESIGN_NAME}
export VIDSS_DESIGN_DIR=${DESIGN_ROOT}/ips/${VIDSS_DESIGN_NAME}
export VIDSS_M3SS_DESIGN_DIR=${VIDSS_DESIGN_DIR}/ips/${M3SS_DESIGN_NAME}
export VIDSS_CCE_DESIGN_DIR=${VIDSS_DESIGN_DIR}/ips/${CCE_DESIGN_NAME}
export VIDSS_JPEG_DESIGN_DIR=${VIDSS_DESIGN_DIR}/ips/${JPEG_DESIGN_NAME}
export VIDSS_GPU2D_DESIGN_DIR=${VIDSS_DESIGN_DIR}/ips/${GPU2D_DESIGN_NAME}
#export EMMC_DESIGN_DIR=${PERI_DESIGN_DIR}/ips/${EMMC_DESIGN_NAME}
#export USB_DESIGN_DIR=${PERI_DESIGN_DIR}/ips/${USB_DESIGN_NAME}
export D2D_DESIGN_DIR=${DESIGN_ROOT}/ips/${D2D_DESIGN_NAME}


# Paths to each subsystem verification directory
export COMMON_VERI_DIR=${PWD}/../verif/common_veri
export ALICE_VERI_DIR=${PWD}/../alice_veri
export ALICE_PCIE_RC_VERI_DIR=${PWD}/../alice_veri/pcie_rc_veri
export CULTUS_VERI_DIR=${PWD}/../cultus_veri
export DDR_VERI_DIR=${PWD}/../ddr_veri
export PCIE_EP_VERI_DIR=${PWD}/../pcie_veri
export VIDSS_VERI_DIR=${PWD}/../video_veri
export VIDSS_M3SS_VERI_DIR=${PWD}/../video_veri/m3_veri
export VIDSS_CCE_VERI_DIR=${PWD}/../video_veri/cce_veri
export ENCSS_VERI_DIR=${PWD}/../encoder_veri
export ENCSS_M3SS_VERI_DIR=${PWD}/../encoder_veri/m3_veri
export DECSS_VERI_DIR=${PWD}/../decoder_veri
export DECSS_M3SS_VERI_DIR=${PWD}/../decoder_veri/m3_veri

export QUADRA_LIB=/cad/library/quadra
export PANORAMA_LIB=/cad/library/panorama

# Are these still needed?
export CDS_VERSION=2103
export XCELIUM_VERSION=XCELIUM${CDS_VERSION}
export MDV_XLM_HOME=/cadence/${XCELIUM_VERSION}
export CDS_INST_DIR=${MDV_XLM_HOME}
export FORCE_MDV_XLM_HOME=true
export PATH=/cadence/VMANAGER${CDS_VERSION}/tools/bin:${PATH}
export INDAGO_ROOT=/cadence/INDAGO${CDS_VERSION}
export DW_WAIT_LICENSE=1
export CADENCE_VIP_LIC_Q_TIMEOUT=-1
export CDN_VIP_LIB_PATH=/cadence/vipcat_11.30.078-11_Aug_2021_08_15_01/
export VIP_LIB_DIR=${CDN_VIP_LIB_PATH}
source cdn_vip_env_xrun_sv_uvm_64_2103.sh

if [ "$1" == "fpga" ]; then #FIXME: use local pano_fpga_vivado repo on v_05 release because FPGA flow hasn't been updated for v_05 release yet
    export FPGA_ROOT=/home/yiming.song/project/pano_fpga_vivado_1
fi

source ./path.sh

#Support for jenkins
if [ "$2" == "live_sim" ]; then
    if [ "$1" == "jenkins" ]; then
        source ./set_env.sh jenkins live_sim
    elif [ "$1" == "local" ]; then
        source ./set_env.sh local live_sim
    else
        exit 1
    fi
elif [ "$1" == "live_sim" ]; then
    source ./set_env.sh live_sim
elif [ "$1" == "jenkins" ]; then
    source ./set_env.sh jenkins
elif [ "$1" == "local" ]; then
    source ./set_env.sh local
else
    source ./set_env.sh
fi

#Support for rdoq encoder
if [ "$1" == "rdoq" ]; then
    export ENCSS_M3SS_DESIGN_DIR=${DESIGN_ROOT}/ips/${ENCSS_DESIGN_NAME}/ips/${M3SS_DESIGN_NAME}
    export ENCSS_DESIGN_DIR=${PWD}/../../${ENCSS_DESIGN_NAME}
elif [ "$2" == "ranger_enc_ss" ]; then
    export ENCSS_M3SS_DESIGN_DIR=${DESIGN_ROOT}/ips/${ENCSS_DESIGN_NAME}/ips/${M3SS_DESIGN_NAME}
    export ENCSS_DESIGN_DIR=${PWD}/../../../${ENCSS_DESIGN_NAME}
fi
