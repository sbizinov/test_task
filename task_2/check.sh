#!/bin/bash
if [ ! -d data ]; then
mkdir data
fi
# Crutch to parse root dir
journalctl -q  _SYSTEMD_UNIT=sshd.service | grep "Accepted publickey" | awk '{print $9,$16,$1,$2,$3,$11 }' > data/logins
ssh-keygen -lf /root/.ssh/authorized_keys | cat -n > data/root

# Parse home dir.
FILES="/home/*/.ssh/authorized_keys"
for i in $FILES
do
  user_file=$(stat -c '%U' $i)
  ssh-keygen -lf "$i"  | cat -n  > data/$user_file
done 

#Read lines and generate output. 

while IFS= read -r line; do
  user_name=$(echo $line | awk '{print $1}')
  time=$(echo $line | awk '{print $3,$4,$5}')
  ip=$(echo $line | awk '{print $6}')
  checksum=$(echo $line | awk '{print $2}')
  echo "Login time: $time, User: $user_name , IP: $ip , Number of a key in auth file: $(grep "$checksum"  data/$user_name )"
done < data/logins
