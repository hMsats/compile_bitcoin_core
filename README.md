# A Bash shell script to download and compile Bitcoin Core on Ubuntu Linux

**Example for Bitcoin Core version 30.0:**

Just copy and past the 4 lines below in a terminal (Ctrl Alt T) and press Enter:

    git clone https://github.com/hMsats/compile_bitcoin_core.git;\
    cd compile_bitcoin_core;\
    chmod +x maken.sh;\
    ./maken.sh 30.0

to install the bash script, execute the script and download, compile and test Bitcoin Core version 30.0 in your Ubuntu Linux home directory. You may have to answer a few questions.

Find `bitcoind`, `bitcoin-cli` and `bitcoin-qt` in `$HOME/bitcoin-30.0/build/bin`

All Bitcoin Core tests are run (for bitcoind and bitcoin-qt).

The necessary ubuntu packages are installed.

This compiled version uses descriptor wallets.

Bitcoin Core is downloaded from https://bitcoincore.org/bin.

Total compilation time will be on the order of an hour.

The shell script name "maken" means "to make" in Dutch.
