script_name=$1
script_alias=$2

sudo cat /*/*/.bashrc | grep $script_alias | wc -l > cache
script_exist=$(cat cache)
rm cache
if [ $script_exist != "0" ]; then
    echo The script alias is already used, try something else
fi
paths=$(ls /*/*/.bashrc)
if [ $script_exist = "0" ] ; then
  for i in $paths; do
    sudo echo "alias $script_alias='bash $(pwd)/$script_name'" >> $i
  done
fi