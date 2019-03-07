#!/bin/bash

## system update
sudo apt-get update

## JQ
sudo apt -y install jq

## Create LIMS2 fs
sudo mkdir -p /opt/sci/global/software/lims2/lib/
sudo mkdir -p /opt/sci/global/conf/lims2/
sudo mkdir -p /opt/sci/global/scripts/
sudo mkdir -p /opt/sci/local/report_cache/lims2_cache_fp_report/localhost/
sudo mkdir -p /nfs/team87/farm3_lims2_vms/conf/primers/
sudo mkdir -p /mnt/volume/
sudo mkdir -p /var/lims2/logs/

## home dir
parent_path=$HOME

for my_package in $(cat $parent_path/lims2_dependencies.json | jq .sys_packages[]); do
  echo sudo apt -y install $my_package | bash
done

for perl_module in $(cat $parent_path/lims2_dependencies.json | jq .perl_modules[]); do
    echo "sudo perl -MCPAN -e 'install $perl_module'" | bash
    sudo chmod -R 755 /usr/local/share/perl/5.22.1/
done;

git clone https://github.com/htgt/WebApp-Common.git /tmp/WebApp-Common
git clone https://github.com/htgt/Design-Creation.git /tmp/Design-Creation
git clone https://github.com/htgt/Eng-Seq-Builder.git /tmp/Eng-Seq-Builder
git clone https://github.com/htgt/HTGT-Admin-Utils.git /tmp/HTGT-Admin-Utils
git clone https://github.com/htgt/Dist-Zilla-PluginBundle-Author-HTGT.git /tmp/Dist-Zilla-PluginBundle-Author-HTGT
git clone https://github.com/htgt/LIMS2-REST-Client.git /tmp/LIMS2-REST-Client
git clone https://github.com/htgt/LIMS2-Tasks.git /tmp/LIMS2-Tasks
git clone https://github.com/htgt/LIMS2-WebApp.git /tmp/LIMS2-WebApp
git clone https://github.com/htgt/LIMS2-Utils.git /tmp/LIMS2-Utils
git clone https://github.com/htgt/HTGT-QC-Common.git /tmp/HTGT-QC-Common
git clone https://github.com/htgt/LIMS2-Exception.git /tmp/LIMS2-Exception
git clone https://github.com/fschwach/Bio-Tools-Primer3Redux.git /tmp/Bio-Tools-Primer3Redux
git clone https://github.com/Ensembl/ensembl.git /tmp/ensembl

cp -r  /tmp/WebApp-Common/lib/* /opt/sci/global/software/lims2/lib/
cp -r  /tmp/WebApp-Common/shared_templates /opt/sci/global/software/lims2/lib/WebAppCommon/
cp -r /tmp/Design-Creation/lib/* /opt/sci/global/software/lims2/lib/
cp -r /tmp/Eng-Seq-Builder/lib/* /opt/sci/global/software/lims2/lib/
cp -r /tmp/HTGT-Admin-Utils/lib/* /opt/sci/global/software/lims2/lib/
cp -r /tmp/Dist-Zilla-PluginBundle-Author-HTGT/lib/* /opt/sci/global/software/lims2/lib/
cp -r /tmp/LIMS2-REST-Client/lib/* /opt/sci/global/software/lims2/lib/
cp -r /tmp/LIMS2-Tasks/lib/* /opt/sci/global/software/lims2/lib/
cp -r /tmp/LIMS2-WebApp/lib/* /opt/sci/global/software/lims2/lib/
cp -r /tmp/LIMS2-Utils/lib/* /opt/sci/global/software/lims2/lib/
cp -r /tmp/HTGT-QC-Common/lib/* /opt/sci/global/software/lims2/lib/
cp -r /tmp/LIMS2-Exception/lib/* /opt/sci/global/software/lims2/lib/
cp -r /tmp/Bio-Tools-Primer3Redux/lib/* /opt/sci/global/software/lims2/lib/
cp -r /tmp/ensembl/modules/Bio/* /opt/sci/global/software/lims2/lib/Bio/

rm -rf /tmp/WebApp-Common
rm -rf /tmp/Design-Creation
rm -rf /tmp/Eng-Seq-Builder
rm -rf /tmp/HTGT-Admin-Utils
rm -rf /tmp/Dist-Zilla-PluginBundle-Author-HTGT
rm -rf /tmp/LIMS2-REST-Client
rm -rf /tmp/LIMS2-Tasks
rm -rf /tmp/LIMS2-WebApp
rm -rf /tmp/LIMS2-Utils
rm -rf /tmp/HTGT-QC-Common
rm -rf /tmp/LIMS2-Exception
rm -rf /tmp/Bio-Tools-Primer3Redux
rm -rf /tmp/ensembl
