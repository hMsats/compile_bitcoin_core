# A Bash shell script to download and compile Bitcoin Core 29.0 and later on Ubuntu Linux

**Example for Bitcoin Core version 29.0:**

Just copy and past the 4 lines below in a terminal (Ctrl Alt T) and press Enter:

    git clone https://github.com/hMsats/compile_bitcoin_core.git;\
    cd compile_bitcoin_core;\
    chmod +x maken.sh;\
    ./maken.sh 29.0

to install the bash script, execute the script and download, compile and test Bitcoin Core version 29.0 in your Ubuntu Linux home directory. You may have to answer a few questions.

Find `bitcoind`, `bitcoin-cli` and `bitcoin-qt` in `$HOME/bitcoin-29.0/build/bin`

All Bitcoin Core tests are run (for bitcoind and bitcoin-qt).

The necessary packages are installed and the appropriate berkeley-db version is downloaded and compiled.

Bitcoin core 29.0 or higher uses `cmake`. 

This compiled version uses descriptor wallets.

Bitcoin Core is downloaded from https://bitcoincore.org/bin.

Total compilation time will be on the order of an hour.

The shell script name "maken" means "to make" in Dutch.

**Extra**

To compile Bitcoin Core for legacy wallets, use `maken_legacy_wallets.sh` which also downloads and compiles BERKELEY-DB necessary for legacy wallets.

For bitcoin core 28.1 and lower `autotools` is applied, while for 29.0 or higher `cmake`.

For bitcoin core versions 28.1 or lower find `bitcoind` and `bitcoin-cli` in `$HOME/bitcoin-28.1/src` and bitcoin-qt in `$HOME/bitcoin-28.1/src/qt` For version 29.0 and higher find `bitcoind`, `bitcoin-cli` and `bitcoin-qt` in `$HOME/bitcoin-29.0/build/bin`
