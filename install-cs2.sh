#!/bin/bash
## usage install-cs2.sh cryptoserv-211.0-33103261.i686.rpm

# This script goes in QA stage

if [ "$#" -ne 1 ]
then
  echo "Usage: install-cs2.sh package_name e.g. install-cs2.sh cryptoserv-211.0-35146351.i686.rpm"
  exit 1
fi


Host=`hostname | tr [A-Z] [a-z]`
StageName=`hostname | tr [a-z] [A-Z]
echo $StageName

pkg=$1

export AUTHCODE="tKgXSMiHQNu1HcxyuApw"

if [ -f ~/package/$pkg ]
then
  #ECV out the host
  echo " ECV out the $StageName ... "
  cp ~/ecv_out_control.html /x/web/ECV/control.html

  cd /x/web/$StageName/cryptoserv
  echo "Shutting down cryptoserv ... "
  /x/web/$StageName/cryptoserv/shutdown.sh

  sleep 2
  echo " list process of cryptoserv ... "
  ps -wef | grep cryptoserv

  echo " Install new cryptoserv 2.0 from new rpm ... "
  chmod +x ~/packages/$pkg
  sudo -u crypto /bin/rpm -i --upgrade --force --nodeps --prefix=/x/web/$StageName --dbpath /x/web/$StageName/zrpmdb/ ~/packages/$pkg
  echo " Install finished ... "

  echo " display cryptoserv.txt from new rpm ... "
  cat /x/web/$StageName/cryptoserv/version.txt
  echo " run postinstall from new rpm ... "
  sudo -u crypto ./postinstall.sh cryptoserv cryptoserv /x/web/$StageName crypto

  echo " make sure CAL log send to the right pool on $Host ... "
  suffix="_cryptoserv"
  pool=$Host$suffix
  sudo -u crypto sed -i "s/$pool/cryptoserv/g" /x/web/$StageName/cryptoserv/cal_client.txt
  sudo -u crypto cdbmake3 /x/web/$StageName/cryptoserv/cal_client.cdb /x/web/$StageName/cryptoserv/cal_client.txt


  echo " make sure HSM request send to the local keymaker hsm agent ... "
  sudo -u crypto sed -i 's/kms_local_agent_host = 10.57.18.146/kms_local_agent_host = 127.0.0.1/g' /x/web/$StageName/cryptoserv/cryptoserv.txt
  #sudo -u crypto sed -i 's/kms_remote_agent_host = 10.57.18.146/kms_remote_agent_host = 127.0.0.1/g' /x/web/$StageName/cryptoserv/cryptoserv.txt
  sudo -u crypto cdbmake3 /xweb/$StageName/cryptoserv/cryptoserv.cdb /xweb/$StageName/cryptoserv/cryptoserv.txt

  echo " start cryptoserv 2.0 service ... "
  sleep 2
  sudo -u crypto rm -Rf /x/web/$StageName/cryptoserv/state-logs/lock
  /x/web/$StageName/cryptoserv/start.sh

  sleep 2
  echo " check number of cryptoservmux process in the $StageName ... "
  ps -wef | grep cryptoservmux | wc -l

  echo " check number of cryptoworker process in the $StageName ... "
  ps -wef | grep cryptoworker | wc -l

  echo "Shutting down cryptoserv ... "
  /x/web/$StageName/cryptoserv/shutdown.sh
  sleep 2

  echo " start cryptoserv 2.0 service twice ... "
  sleep 2
  sudo -u crypto rm -Rf /x/web/$StageName/cryptoserv/state-logs/lock
  /x/web/$StageName/cryptoserv/start.sh

  # ECV in the host
  echo " ECV in the $StageName ... "
  cp ~/ecv_in_control.html /x/web/ECV/control.html

else
  echo "~/packages/$pkg does not exist"
fi

