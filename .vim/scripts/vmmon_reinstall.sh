#!/bin/bash

vmmon_reinstall()
{
  read -p 'Enter build type: ' bt
  #local VMMON_PATH=`find . -name vmmon.ko | grep "vmmon/vmmon.ko"`
  local VMMON_PATH=`find . -name vmmon.ko | grep $bt`
  if [ -z $VMMON_PATH ]; then
    echo "vmmon.ko not found for build type=$bt! available vmmon.ko:"
    find . -name vmmon.ko
    return
  fi

  VMMON_PATH=`readlink -f ${VMMON_PATH}`
  echo "vmmon path: $VMMON_PATH"
  ls -lart $VMMON_PATH
  sudo rmmod -f vmmon
  sudo insmod ${VMMON_PATH}
  lsmod | grep vmmon

  #create device files
  if [ -c /dev/vmmon ]; then
    sudo chmod 777 /dev/vmmon
    echo "/dev/vmmon exist"
  else
    sudo mknod /dev/vmmon c 62 0
    sudo chmod 777 /dev/vmmon
    echo "creating /dev/vmmon"
  fi
  #
  if [ -c /dev/vmx86.$USER ]; then
    sudo chmod 777 /dev/vmx86.$USER
    echo "/dev/vmx86.$USER exist"
  else
    sudo mknod /dev/vmx86.$USER c 62 0
    sudo chmod 777 /dev/vmx86.$USER
    echo "creating /dev/vmx86.$USER"
  fi
  echo "Done!"
}

vmmon_reinstall
