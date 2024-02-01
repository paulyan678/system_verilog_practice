# Setup common path variables for design and verification folders
export VERIF_ROOT=${PWD}/..
export RUN_DIR=${VERIF_ROOT}/run/
export QVERSION=2023.2

# Set Questa license
export MGLS_LICENSE_FILE=1717@10.0.10.167

# Set Mobiveil License
export LM_LICENSE_FILE=1718@10.0.10.167:$LM_LICENSE_FILE

# Not sure what this is exactly so leaving it here for now
# Server setup for simulations 
if [ "$1" == "jenkins" ]; then 
    export use_home_extra=1
else
    export use_home_extra=0
fi

# Check which server we are on (Toronto, Vancouver or Jinan), assign the backup simulation path accordingly based on the server and the use_home_extra variable
result=$(echo $HOSTNAME | grep -i "YVR")
resultj=$(echo $HOSTNAME | grep -i "TNA")
if [[ "$result" != "" ]];
then
    export YVR_SERV="YES"
    export HOME_EXTRA="/workspace/"
elif [[ "$resultj" != "" ]];
then
    export YVR_SERV="NO"
    export HOME_EXTRA="/workspace/"
    export LM_LICENSE_FILE=5280@10.10.10.168:5280@10.10.10.167:27000@10.10.10.167:4071@10.10.10.168:1055@10.10.10.167:1881@10.10.10.167:27020@10.10.10.167:1880@10.10.10.167:27001@10.10.10.168:1718@10.0.10.167
else
    export YVR_SERV="NO"
    export HOME_EXTRA="/NetApp/"
    export LM_LICENSE_FILE=5280@10.10.10.168:5280@10.10.10.167:27000@10.10.10.167:4071@10.10.10.168:1055@10.10.10.167:1881@10.10.10.167:27020@10.10.10.167:1880@10.10.10.167:27001@10.10.10.168:1718@10.0.10.167
fi

# Installation directory of the Synopsys VIP
export DESIGNWARE_HOME=/opt/Synopsys/designware/vip_2021_03
export SYNOPSYS_VIP_DIR=/cad/library/panorama/synopsys_vip
# Enable License polling
export DW_WAIT_LICENSE=1 

# For ARM cosim
export LD_LIBRARY_PATH=/usr/local/lib:${LD_LIBRARY_PATH}

# Installation directory of the simulator and the customized UVM package
export MTI_HOME=/mentor/sim/${QVERSION}
export VIS_HOME=/mentor/vis/${QVERSION}/visualizer
export QUESTA_SIM_HOME=${MTI_HOME}/questasim
export QUESTA_UVM_HOME=${MTI_HOME}/questasim/verilog_src/questa_uvm_pkg-1.2
export QUESTA_MVC_HOME=/mentor/qvip/${QVERSION}
export UVM_HOME=${MTI_HOME}/questasim/verilog_src/uvm-1.2

export PATH=${VIS_HOME}/linux_x86_64:${PATH}
export PATH=${QUESTA_SIM_HOME}/linux_x86_64:${PATH}
export PATH=${DESIGNWARE_HOME}/bin:${PATH}

# ARM cortext 
export PATH=/arm/tools/gcc-arm-none-eabi-10.3-2021.10/bin:$PATH
export PATH=/arm/tools/gcc-arm-none-eabi-10.3-2021.10/arm-none-eabi/bin:$PATH
export PATH=/arm/tools/gcc-arm-10.3-2021.07-x86_64-aarch64-none-elf/bin/:$PATH

SIMULATIONS=${HOME_EXTRA}$USER"/dir"$(echo ${PWD} |sed -e 's/\//\./g')".simulations"
if [ -d "simulations" ]; then
    echo "Local simulation folder already exists, remove it"
    rm -rf simulations
else
    echo "Local simulation folder does not exist"
fi
if [ ! -d "$SIMULATIONS" ]; then
    echo "Remote simulation folder does not exist, creating it at $SIMULATIONS"
    mkdir $SIMULATIONS
else
    echo "Remote simulation folder already exists at $SIMULATIONS"
fi
echo "Linking local simulation folder to $SIMULATIONS"
ln -s $SIMULATIONS simulations

if [ ! -d "scripts" ]; then
    ln -s  $VERIF_ROOT/verif/common_veri/script/panorama scripts
fi

if [ ! -d "$SIMULATIONS/rtlsim" ]; then
    mkdir $SIMULATIONS/rtlsim
fi

if [ ! -d "$SIMULATIONS/gatesim" ]; then
    mkdir $SIMULATIONS/gatesim
fi
if [ ! -d "$SIMULATIONS/worklib" ]; then
    mkdir $SIMULATIONS/worklib
fi

if [ ! -d "result" ]; then
    mkdir $RUN_DIR/result
    mkdir $RUN_DIR/result/RTL
    mkdir $RUN_DIR/result/RTL/0
fi

echo "${PATH/:$"/\n"}"
