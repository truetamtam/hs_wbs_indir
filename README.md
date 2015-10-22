# Homestead wbs shop-script development in directory

## Description:
Laravel Homestead based, per project, environment.
For testing in directory with Apache2.

## Requirements:
* Vagrant
* VirtualBox
* Composer

## Usage
1. Mkdir for project wbsdir.dev
  1. Installing webasyst framework and shop-script from homestead directory "./wbsdi.sh -h /var/www/wbsdir.dev/indir -b wbsdir"
  1. In some.dev "git clone git@github.com:truetamtam/hs_wbs_indir.git homestead"
1. In homestead directory "composer install"
  1. Vendor/bin/homestead make
  1. Edit Homestead.yaml
  1. In homestead directory "vagrant up"