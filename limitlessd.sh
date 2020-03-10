#!/bin/bash
# shellcheck disable=SC2034

# Copyright (c) 2018
# All rights reserved.
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.

: '
# Run this file

```
bash -ic "$(wget -4qO- -o- raw.githubusercontent.com/Limitless-VIP/masternode/master/limitlessd.sh)" ; source ~/.bashrc
```

'

# Github user and project.
GITHUB_REPO='Limitless-VIP/Limitless'
# Display Name.
DAEMON_NAME='Limitless Core'
# Coin Ticker.
TICKER='VIP'
# Binary base name.
BIN_BASE='limitless'
# Directory.
DIRECTORY='.Limitless'
# Conf File.
CONF='limitless.conf'
# Port.
DEFAULT_PORT=8007
# Amount of Collateral needed
COLLATERAL=4000000
# Fallback Blockcount
BLOCKCOUNT_FALLBACK_VALUE=0
# Multiple on single IP.
MULTI_IP_MODE=1
# Direct Daemon Download if github has no releases.
#DAEMON_DOWNLOAD='https://limitlessvip.co.za/wallets/limitless-v3.0.0-lin64.tar.gz'
MASTERNODE_GENKEY_COMMAND='createmasternodekey'
MASTERNODE_LIST='listmasternodes'
MASTERNODE_CALLER='getmasternode'
MASTERNODE_NAME='masternode'

# Tip Address
TIPS='TWeABR8rX5Fp4xe7bnrZ4r3KjE37xyegN1'
# Dropbox Addnodes
DROPBOX_ADDNODES='nmf60k4s9ih4pcp'
# If set to 1 then use addnodes from dropbox.
USE_DROPBOX_ADDNODES=1
# Dropbox Bootstrap
DROPBOX_BOOTSTRAP='2n3bcru58jocs35'
# If set to 1 then use bootstrap from dropbox.
USE_DROPBOX_BOOTSTRAP=1
# Dropbox blocks and chainstake folders.
DROPBOX_BLOCKS_N_CHAINS='5nj1co4hlqc1qk0'

ASCII_ART () {
echo -e "\\e[0m"
clear 2> /dev/null
cat << "LIMITLESS"
    __    _           _ __  __              
   / /   (_)___ ___  (_) /_/ /__  __________
  / /   / / __ `__ \/ / __/ / _ \/ ___/ ___/
 / /___/ / / / / / / / /_/ /  __(__  |__  ) 
/_____/_/_/ /_/ /_/_/\__/_/\___/____/____/  
                                            
LIMITLESS
}

cd ~/ || exit
COUNTER=0
rm -f ~/___mn.sh
while [[ ! -f ~/___mn.sh ]] || [[ $( grep -Fxc "# End of masternode setup script." ~/___mn.sh ) -eq 0 ]]
do
  rm -f ~/___mn.sh
  echo "Downloading Masternode Setup Script."
  wget -4qo- rawcdn.githack.com/Limitless-VIP/masternode/a47a2df8d09b748225e97602666db309ddd18754/main.sh -O ~/___mn.sh
  COUNTER=$((COUNTER+1))
  if [[ "${COUNTER}" -gt 3 ]]
  then
    echo
    echo "Download of masternode setup script failed."
    echo
    exit 1
  fi
done

(
  sleep 2
  rm ~/___mn.sh
) & disown

(
# shellcheck disable=SC1091
# shellcheck source=/root/___mn.sh
. ~/___mn.sh
DAEMON_SETUP_THREAD
)
# shellcheck source=/root/.bashrc
. ~/.bashrc
stty sane
