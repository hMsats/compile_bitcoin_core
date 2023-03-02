# A Bash shell script to download and compile Bitcoin Core on Ubuntu Linux

**Example for Bitcoin Core version 24.0:**

Just copy and past the 4 lines below in a terminal (Ctrl Alt T) and press Enter:

    git clone https://github.com/hMsats/compile_bitcoin_core.git;\
    cd compile_bitcoin_core;\
    chmod +x maken.sh;\
    ./maken.sh 24.0

to install the bash script, execute the script and download, compile and test Bitcoin Core version 24.0 in your Ubuntu Linux home directory. You may have to answer a few questions.

You'll find `bitcoind` and `bitcoin-cli` in `$HOME/bitcoin-24.0/src` and `bitcoin-qt` in `$HOME/bitcoin-24.0/src/qt`.

All Bitcoin Core tests are run (for bitcoind and bitcoin-qt).

The necessary packages are installed and the appropriate berkeley-db version is downloaded and compiled.

Bitcoin Core is downloaded from https://bitcoincore.org.

Total compilation time will be on the order of an hour.

The shell script name "maken" means "to make" in Dutch.

This script was tested on a fairly fresh Ubuntu install (Ubuntu 20.04.4 LTS).

This script was recently tested on a fresh Ubuntu install (Ubuntu 22.04.2 LTS).

Because of how the checksums are calculated, the script "maken.sh" only works for Bitcoin Core versions 22.0 or higher. 
To compile earlier versions set "do_check_bitcoin_core_download=0" inside the script "maken.sh".
