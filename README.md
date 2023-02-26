# A Bash shell script to download and compile Bitcoin Core on Ubuntu

**Example for Bitcoin Core version 24.0:**

Just execute in a terminal:

cd $HOME; git clone https://github.com/hMsats/bash_shell_script_download_and_compile_bitcoin_core_on_ubuntu.git; cd bash_shell_script_download_and_compile_bitcoin_core_on_ubuntu; chmod +x maken.sh; ./maken.sh 24.0

to install the bash script, execute the script and download, compile and test Bitcoin Core version 24.0 in your Ubuntu Linux home directory.

You'll find bitcoind and bitcoin-cli in bitcoin-24.0/src and bitcoin-qt in bitcoin-24.0/src/qt.

All Bitcoin Core tests are run.

The necessary packages are installed and the appropriate berkeley-db version is downloaded and compiled.

Bitcoin Core is downloaded from https://bitcoincore.org.

Total compilation time will be on the order of 1 hour or more.

This script was tested on a fairly fresh Ubuntu install (Ubuntu 20.04.4 LTS).

This script was recently tested on a fresh Ubuntu install (Ubuntu 22.04.2 LTS).

Because of how the checksums are calculated, the script "maken.sh" only works for Bitcoin Core versions 22.0 or higher. 
To compile earlier versions set "do_check_bitcoin_core_download=0" inside the script "maken.sh".
