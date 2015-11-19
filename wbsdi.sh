#!/usr/bin/env bash
# Installer script for use with homestead and webasyst framework.
# All keys for interacting with github and bitbucket must be set.
# Installs also webasyst shop-script 6.


while getopts "h:d:b:" optname
  do
    case "$optname" in
      "h")
        WBSHOST=$OPTARG
      ;;
      "d")
        WBSHOST="$WBSHOST/$OPTARG" # unused here
      ;;
      "b")
        WBSHOSTDB=$OPTARG
      ;;
      "?")
        echo "Unknown option $OPTARG"
      ;;
      ":")
        echo "No argument value for option $OPTARG"
      ;;
      *)
      # Should not occur
      echo "Unknown error while processing options"
      ;;
    esac
  done


# cloning webasyst framework
echo "Cloning webasyst framework...";
git clone git@github.com:webasyst/webasyst-framework.git "$WBSHOST"


# copying config files from examples
# adding shop to apps
awk '/return array\(/ { print; print "    \x27shop\x27 => true,"; next }1' ${WBSHOST}/wa-config/apps.php.example > ${WBSHOST}/wa-config/apps.php
# admin to wbs path
sed 's/admin/wbs/' ${WBSHOST}/wa-config/config.php.example > ${WBSHOST}/wa-config/config.php
# db
# note: database should already be created
cp ${WBSHOST}/wa-config/db.php.example ${WBSHOST}/wa-config/db.tmp.php
sed -i 's/\x27user\x27 => \x27root\x27/\x27user\x27 => \x27homestead\x27/' ${WBSHOST}/wa-config/db.tmp.php
sed -i 's/\x27password\x27 => \x27\x27/\x27password\x27 => \x27secret\x27/' ${WBSHOST}/wa-config/db.tmp.php
sed -i 's/\x27database\x27 =>  \x27wa\x27/\x27database\x27 => \x27'"$WBSHOSTDB"'\x27/' ${WBSHOST}/wa-config/db.tmp.php
awk $'/\'default\' => array\(/ { print; print "\t\t\x27sql_mode\x27 => \x27TRADITIONAL\x27,"; next }1' ${WBSHOST}/wa-config/db.tmp.php > ${WBSHOST}/wa-config/db.php
rm -f ${WBSHOST}/wa-config/db.tmp.php
# locale
cp ${WBSHOST}/wa-config/locale.php.example ${WBSHOST}/wa-config/locale.php
# system config
cp ${WBSHOST}/wa-config/SystemConfig.class.php.example ${WBSHOST}/wa-config/SystemConfig.class.php


# installing shop-script 6
git clone git@github.com:webasyst/shop-script.git ${WBSHOST}/wa-apps/shop
