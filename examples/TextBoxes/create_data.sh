cur_dir=$(cd $( dirname ${BASH_SOURCE[0]} ) && pwd )
root_dir=$cur_dir/../..

cd $root_dir

redo=true
data_root_dir="$HOME/Documents/Textboxes"
mapfile="$root_dir/examples/TextBoxes/labelmap_voc.prototxt"
anno_type="detection"
label_type="txt"
db="lmdb"
min_dim=0
max_dim=0
width=0
height=0

extra_cmd="--encode-type=jpg --encoded"
if $redo
then
  extra_cmd="$extra_cmd --redo"
fi
for subset in train test
do
  python $root_dir/scripts/create_annoset.py --anno-type=$anno_type --label-type=$label_type --label-map-file=$mapfile --min-dim=$min_dim --max-dim=$max_dim --resize-width=$width --resize-height=$height --check-label $extra_cmd $data_root_dir $data_root_dir/TextBoxes/examples/TextBoxes/$subset.txt $data_root_dir/$db/$dataset_name"_"$subset"_"$db examples/$dataset_name 2>&1 | tee $root_dir/data/$dataset_name/$subset.log
done
