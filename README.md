# Homestead wbs shop-script development in directory

## Description:
Laravel Homestead based, per project, environment.
For testing in directory with Apache2.

## Requirements:
* Vagrant
* VirtualBox
* Composer

## Adds:
* after.sh - installs more stuff
* aliases - dev custom aliases

## Usage
1. Mkdir for project <project.dev>
1. In <project.dev> "git clone git@github.com:truetamtam/hs_wbs_indir.git homestead"
1. In homestead directory "composer install"
1. In bash or cmd, from homestead directory "vendor/bin/homestead make".
1. Edit "Homestead.yaml" if necessary.
1. Installing webasyst framework and shop-script from homestead directory "./wbsdi.sh -h /var/www/<project.dev>/indir -b wbsdir"
1. In homestead directory "vagrant up"