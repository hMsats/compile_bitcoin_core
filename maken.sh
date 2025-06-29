#!/bin/bash

#
# Bash script to compile Bitcoin Core on Ubuntu Linux.
#
# You'll find bitcoind,bitcoin-cli and bitcoin-qt in $HOME/bitcoin-29.0/build/bin
#
# Usage:
# ./maken.sh 29.0
# to download and compile Bitcoin Core version 29.0
#

# Set the "do"-variables to 1 or 0 to execute or
# not execute a specific part of the code
# All are 1 by default
do_download_and_unpack_bitcoin_core=1 # Download and unpack bitcoin core from bitcoincore.org
do_check_bitcoin_core_download=1
do_install_packages=1 # Download the packages needed to compile bitcoin core
do_compile_bitcoin_core=1 # Compile Bitcoin Core
do_strip_bitcoin_core=1 # Strip the executables of debug symbols
do_install_bitcoin_core=1 # Strip the executables of debug symbols
do_test_bitcoin_core=1 # Test Bitcoin Core

# Echo with sleep and newlines
function fecho () {
  sleep 5
  echo ""
  echo $1
  echo ""
  sleep 5
}
# Abort if directory exists
function dexab () {
  if [[ -d "$1" ]]; then
    echo "$1 already exists in your home directory"
    echo "Aborting this Bash script"
    exit
  fi
}
# Abort if file exists
function fexab () {
  if [[ -f "$1" ]]; then
    echo "$1 already exists in your home directory"
    echo "Aborting this Bash script"
    exit
  fi
}
# Abort if directory doesn't exist
function dnexab () {
  if [[ ! -d "$1" ]]; then
    echo "$1 doesn't exist in your home directory"
    echo "Aborting this Bash script"
    exit
  fi
}
# Abort if file doesn't exist
function fnexab () {
  if [[ ! -f "$1" ]]; then
    echo "$1 dowsn't exist in your home directory"
    echo "Aborting this Bash script"
    exit
  fi
}

# Demand 1 and only 1 command line argument
if [ $# != 1 ]; then
  echo "Usage:"
  echo "  ./maken.sh version"
  echo "Example:"
  echo "  ./maken.sh 29.0"
  echo "EXIT"
  exit
fi

VERSION=$1
BITCOIN_NAME=bitcoin-$VERSION

# Move to the home directory
cd $HOME

# 
# DOWNLOAD AND UNPACK BITCOIN CORE
#

if [ $do_download_and_unpack_bitcoin_core = 1 ]; then

  echo "Downloading $HOME/$BITCOIN_NAME.tar.gz in $HOME from bitcoincore.org"
  fexab $HOME/$BITCOIN_NAME.tar.gz
  \wget --quiet -O $BITCOIN_NAME.tar.gz https://bitcoincore.org/bin/bitcoin-core-$VERSION/$BITCOIN_NAME.tar.gz
  
  if [ $do_check_bitcoin_core_download = 1 ]; then
    fecho "Checking the bitcoin core download (ignore checksum format warning)"
    fexab SHA256SUMS
    \wget --quiet -O SHA256SUMS https://bitcoincore.org/bin/bitcoin-core-$VERSION/SHA256SUMS
    fnexab SHA256SUMS
    fexab SHA256SUMS.asc
    \wget --quiet -O SHA256SUMS.asc https://bitcoincore.org/bin/bitcoin-core-$VERSION/SHA256SUMS.asc
    fnexab SHA256SUMS.asc
    res0=$(sha256sum --ignore-missing --check SHA256SUMS $BITCOIN_NAME.tar.gz | sed "s/$BITCOIN_NAME.tar.gz: //")
    if [[ -z "$res0" || $res0 != "OK" ]]; then
      echo "Download of $BITCOIN_NAME.tar.gz has the wrong sha256 checksum"
      echo "Aborting this Bash script"
      # Don't leave traces. Avoid that we run into trouble when downloading the next version
      \rm SHA256SUMS
      \rm SHA256SUMS.asc
      exit
    else
      fecho "Download of bitcoin core OK"
    fi
    # Don't leave traces. Avoid that we run into trouble when downloading the next version
    \rm SHA256SUMS
    \rm SHA256SUMS.asc
  else
    fecho "Skip checking the bitcoin core download"
  fi

  fecho "Unpacking $HOME/$BITCOIN_NAME.tar.gz in $HOME"
  dexab $HOME/$BITCOIN_NAME
  \tar -zxf $BITCOIN_NAME.tar.gz

else
  echo "Skip downloading and unpacking bitcoin core"
fi

#
# INSTALL REQUIRED PACKAGES
#

if [ $do_install_packages = 1 ]; then
  fecho "Installing packages via sudo (password probably needed)"

  # Install packages
  sudo apt-get install make cmake libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler libboost-all-dev build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils python3 libqrencode-dev sqlite3 libsqlite3-dev libzmq3-dev
else
  fecho "Skip installing packages"
fi

#
# COMPILE BITCOIN CORE
#

if [ $do_compile_bitcoin_core = 1 ]; then
  # Execute in the Bitcoin directory:
  dnexab $HOME/$BITCOIN_NAME
  cd $HOME/$BITCOIN_NAME/

  fecho "Compiling Bitcoin Core"
  # Execute in the Bitcoin directory:
  dnexab $HOME/$BITCOIN_NAME
  cd $HOME/$BITCOIN_NAME/

  fecho "Compile with cmake"
  if [[ ! -d "cmake" ]]; then
    fecho "It looks like cmake isn't present. Note: bitcoin core version must be 29.0 or later?"
    echo "Aborting this Bash script"
    exit
  fi
  fecho "Executing cmake -B build including GUI"
  cmake -B build -DWITH_ZMQ=ON -DBUILD_GUI=ON
  # faster cmake
  #cmake -B build -DWITH_ZMQ=ON -DBUILD_TESTS=OFF

  fecho "Executing cmake --build build"
  cmake --build build

  if [ $do_strip_bitcoin_core = 1 ]; then
    fecho "Strip executables of debug symbols" 
    cd $HOME/$BITCOIN_NAME/build/bin
    fecho "Before stripping" 
    \du -ms bitcoin-cli bitcoind bitcoin-qt test_bitcoin bitcoin-tx bitcoin-util bitcoin-wallet
    fecho "Strip" 
    strip bitcoin-cli bitcoind bitcoin-qt test_bitcoin bitcoin-tx bitcoin-util bitcoin-wallet
    fecho "After stripping" 
    \du -ms bitcoin-cli bitcoind bitcoin-qt test_bitcoin bitcoin-tx bitcoin-util bitcoin-wallet
  else
    fecho "Skip strip executables of debug symbols" 
  fi

   
  fecho "You find bitcoind, bitcoin-cli and bitcoin-qt in build/bin"
else
  fecho "Skip compile bitcoin core"
fi

if [ $do_install_bitcoin_core = 1 ]; then
  fecho "Install bitcoin core"

  cd $HOME/$BITCOIN_NAME/
  sudo cmake --install build
fi

#
# TEST BITCOIN CORE
#

if [ $do_test_bitcoin_core = 1 ]; then
  fecho "Testing Bitcoin Core"

  cd $HOME/$BITCOIN_NAME
  fecho "Testing bitcoind"
  dnexab $HOME/$BITCOIN_NAME/build/bin
  cd $HOME/$BITCOIN_NAME/build/bin
  ./test_bitcoin
  fecho "Testing bitcoin-qt"
  ./test_bitcoin-qt
else
  fecho "Skip test bitcoin core"
fi

# Move back to the home directory
cd $HOME
