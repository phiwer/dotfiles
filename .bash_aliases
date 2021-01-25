#!/usr/bin/env bash

function clear_dtc {
    adb root
    adb shell cmd_line_diag_client raw -t 1201 --data 14FFFFFF
}

bitwise_and() {
    local IFS='&'
    printf "%s\n" "$(( $* ))"
}

function test_dtc {
    dtc=$1
    dtc_name=$2

    dtc_raw=$(adb shell cmd_line_diag_client raw -t 1201 --data 1904 "$dtc" ff)
    dtc_raw=($dtc_raw) # Convert to string array and take hex string
    dtc_raw=${dtc_raw[5]}
    dtc_value="0x${dtc_raw:10:2}"

    echo "Testing DTC for ${dtc_name}"
    echo "Raw byte data: ${dtc_raw}"
    echo "6th byte data: ${dtc_value}"
    if [ $(bitwise_and $dtc_value "0x80") -ne 0 ]
    then
	# other script actions go here
	echo "bit 7 set: Warning indicator requested"
    fi
    if [ $(bitwise_and $dtc_value "0x40") -ne 0 ]
    then
	# other script actions go here
	echo "bit 6 set: Test not completed this monitoring cycle"
    fi
    if [ $(bitwise_and $dtc_value "0x20") -ne 0 ]
    then
	# other script actions go here
	echo "bit 5 set: Test failed since last clear"
    fi
    if [ $(bitwise_and $dtc_value "0x10") -ne 0 ]
    then
	# other script actions go here
	echo "bit 4 set: Test not completed since last clear"
    fi
    if [ $(bitwise_and $dtc_value "0x08") -ne 0 ]
    then
	# other script actions go here
	echo "bit 3 set: Confirmed DTC"
    fi
    if [ $(bitwise_and $dtc_value "0x04") -ne 0 ]
    then
	# other script actions go here
	echo "bit 2 set: Pending"
    fi
    if [ $(bitwise_and $dtc_value "0x02") -ne 0 ]
    then
	# other script actions go here
	echo "bit 1 set: Test failed this monitoring cycle"
    fi
    if [ $(bitwise_and $dtc_value "0x01") -ne 0 ]
    then
	# other script actions go here
	echo "bit 0 set: Test failed"
    fi

    echo "-------------------------------"
    echo ""
    echo ""
}

function read_dtc {
    adb root

    test_dtc "960900" "TCAM"

    test_dtc "960A00" "MOST"

    test_dtc "960B00" "APIX"
}


function loop_test {
    if [ $# -eq 0 ]; then
	echo "Usage: loop_test <count>"
	return
    fi
    rm results.txt || true
    count=$1
    for ((i=1;i<=count;i++)); do
	echo "Running iteration: ${i}"
	component_test_run | tee result_"${i}".txt
	pass_fail_count=$(cat result_"${i}".txt | grep -a "INFO" | grep -c -e "Result: PASSED" -e "Result: FAILED")
	pass_count=$(cat result_"${i}".txt | grep -a "INFO" | grep -c -e "Result: PASSED")
	fail_count=$(cat result_"${i}".txt | grep -a "INFO" |  grep -c -e "Result: FAILED")
	if [ $pass_fail_count -eq 0 ]
	then
	    echo "${i} N/A" >> results.txt
	    echo "NA"
	elif [ $pass_count -gt 0 ]
	then
	    echo "${i} PASSED" >> results.txt
	    echo "PASS"
	elif [ $fail_count -gt 0 ]
	then 
	    echo "${i} FAILED" >> results.txt
	    echo "FAIL"
	fi
    done
}


function run_test {
    if [ $# -eq 0 ]; then
	echo "Usage: run_test <count>"
	return
    fi
    rm results.txt || true
    count=$1
    for ((i=1;i<=count;i++)); do
	echo "Running iteration: ${i}"
	component_test_run > result_"${i}".txt
	pass_fail_count=$(cat result_"${i}".txt | grep -a "INFO" | grep -c -e "Result: PASSED" -e "Result: FAILED")
	pass_count=$(cat result_"${i}".txt | grep -a "INFO" | grep -c -e "Result: PASSED")
	fail_count=$(cat result_"${i}".txt | grep -a "INFO" |  grep -c -e "Result: FAILED")
	if [ $pass_fail_count -eq 0 ]
	then
	    echo "${i} N/A" >> results.txt
	    echo "${i} N/A"
	elif [ $pass_count -gt 0 ]
	then
	    echo "${i} PASSED" >> results.txt
	    echo "${i} PASSED"
	elif [ $fail_count -gt 0 ]
	then 
	    echo "${i} FAILED" >> results.txt
	    echo "${i} FAILED"
	fi
    done
}

function set_garage_mode_one {
    adb wait-for-device shell setprop android.car.garagemodeduration 1
}

function get_wakeup_from_suspend_to_ram {
    adb wait-for-device shell getprop | grep wakeup_from_suspend_to_ram 
}

function sync_time {
    adb shell su root date $(date +%m%d%H%M%Y.%S)
}

function ash {
    adb wait-for-device shell
}

function alc {
    adb logcat
}

function logcat_wifi {
    adb logcat -vcolor WiFiAdapter_Man:I WiFiAdapter_Ipcb:I WiFiAdapter_Supp:I WiFiAdapter_SoftApCtrl:I WiFiAdapter_SoftApCtrl:I *:S
}

function sync_component {
    adb root && adb remount && adb sync
}

function ihu_reboot {
    adb wait-for-device shell ihu_reboot
}

function flash_from_build_server {
    if [ $# -eq 0 ]
    then
	echo "usage: flash_from_build_server ihu_vcc|robot_taxi"
	return
    fi

    BUILD_VARIANT=$1
    FLASHFILES_DIR="$HOME/sources/flashfiles/$BUILD_VARIANT"
    mkdir -p "$FLASHFILES_DIR"
    rsync -v --times --stats --update --progress "pwerner@gotsvl1734.vccnet.volvocars.net:~/sources/$BUILD_VARIANT/out/target/product/ihu_abl_car/fast_flashfiles/*" "$FLASHFILES_DIR/"
    cd ~/sources/aosp/icup
    ihu_update_developer --flashfiles "$FLASHFILES_DIR"
}



function add_subdirectories() {
    FIND_PATH=$(command -v find)
    GREP_PATH="grep"
    DIRENAME_PATH=$(command -v dirname)

    for proj in $("${FIND_PATH}" "${AOSP_VCC_HW_DIR}"/"${1}" -name CMakeLists.txt); do
        dir=$("${DIRENAME_PATH}" "${proj}")
	echo $dir
        "${GREP_PATH}" test <<< "${dir}" > /dev/null
	echo "${GREP_PATH}"3
        if test $? -ne 0; then
            "${GREP_PATH}" x86_64-android <<< "${dir}" > /dev/null
	    echo $dir
            if test $? -eq 0; then
		echo $dir
                echo "add_subdirectory(${dir})" >> "${CMAKE_PROJECT_PATH}"
            fi
        fi
    done
}

function aosp_gen_cmake() {
    # list of connectivity projects
    PROJ_LIST=("$@")

    #declare -a PROJ_LIST=("connectivity/netman" "connectivity/radio")
    PWD=`pwd`
    AOSP_ROOT_DIR="$PWD"
    AOSP_OUT_DIR="${AOSP_ROOT_DIR}"/out
    AOSP_CLION_DIR="${AOSP_ROOT_DIR}"/development/ide/clion
    CMAKE_PROJECT_PATH="${AOSP_CLION_DIR}"/CMakeLists.txt

    if [ ! -d $AOSP_CLION_DIR ]; then
        echo "Please execute from root AOSP."
        return
    fi

    echo $CMAKE_PROJECT_PATH

    AOSP_VCC_HW_DIR="${AOSP_ROOT_DIR}"/vendor/volvocars/hardware

    # remove existing CMakeLists.txt
    rm -f "${CMAKE_PROJECT_PATH}" || true

    cat << EOF > "${CMAKE_PROJECT_PATH}"
    cmake_minimum_required(VERSION 3.6)
    project(vcc_native)
EOF

    if test "${#PROJ_LIST[@]}" -ne 0; then
	for item in "${PROJ_LIST[@]}"; do
	    echo "${item}"
            add_subdirectories "${item}"
	done
    else
	    add_subdirectories
    fi
}

function build_sync_systemui {
    m -j6 VccSystemUI && adb root && adb remount && adb shell stop && adb sync system && sleep 1 && adb shell start
}

export SOONG_GEN_CMAKEFILES=1
export SOONG_GEN_CMAKEFILES_DEBUG=1

alias adb='adb wait-for-device'
