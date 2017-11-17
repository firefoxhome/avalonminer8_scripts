#!/bin/bash
cd ~
git clone https://github.com/Canaan-Creative/Avalon-extras.git && \
    cd Avalon-extras && \
    mkdir -p /home/factory/Desktop && \
    cp ./scripts/factory/desktop/* /home/factory/Desktop/ && \
    cd ~/Desktop/ && \
    rm burnavalon7_* testavalon7_* update_7*  burnauc3.desktop update_auc3* AvalonMiner_test_script.desktop  && \
    mkdir /home/factory/Xilinx && \
    mv /home/factory/14.6 /home/factory/Xilinx
echo "Install finish"
