#!/bin/bash
clear
sudo apt-get update
sudo apt-get install libpam-google-authenticator -y
google-authenticator -t -d -f -q -r 3 -R 30 -w 3
sudo /bin/su -c "echo 'auth required pam_google_authenticator.so nullok' >> /etc/pam.d/sshd"
sudo sed -i 's/@include common-auth/# @include common-auth/' /etc/pam.d/sshd
sudo sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/' /etc/ssh/sshd_config
sudo /bin/su -c "echo 'AuthenticationMethods publickey,password publickey,keyboard-interactive' >> /etc/ssh/sshd_config"
sudo systemctl restart sshd.service