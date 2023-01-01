cmd=$1
name=$2
sudo cat /*/*/.bashrc | grep 'alias mpc' | wc -l > cache
bashrcline=$(cat cache)
rm cache
paths=$(ls /*/*/.bashrc)
if [ $bashrcline = "0" ] ; then
  for i in $paths; do
    echo "alias mpc='bash $(pwd)/mass_produce.sh'" >> $i
  done
fi
declare -i number=$3

for (( i = 0; i < number; i++ )); do
    current_name=$name$i
    $cmd $current_name
done

