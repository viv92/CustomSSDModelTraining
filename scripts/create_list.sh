#!/bin/bash

root_dir=../
sub_dir=ImageSets/Main
bash_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
for dataset in trainval test
do
  dst_file=$bash_dir/$dataset.txt
  #echo "-----dst_file = $dst_file"
  if [ -f $dst_file ]
  then
    rm -f $dst_file
  fi

  echo "Create list for $dataset..."
  dataset_file=$root_dir/$dataset/$sub_dir/$dataset.txt

  img_file=$bash_dir/$dataset"_img.txt"
  cp $dataset_file $img_file
  sed -i "s/^/$dataset\/JPEGImages\//g" $img_file
  sed -i "s/$/.jpg/g" $img_file

  label_file=$bash_dir/$dataset"_label.txt"
  cp $dataset_file $label_file
  sed -i "s/^/$dataset\/Annotations\//g" $label_file
  sed -i "s/$/.xml/g" $label_file

  paste -d' ' $img_file $label_file >> $dst_file

  rm -f $label_file
  rm -f $img_file

  # Generate image name and size infomation.
  if [ $dataset == "test" ]
  then
    ../../caffe-ssd/build/tools/get_image_size $root_dir $dst_file $bash_dir/$dataset"_name_size.txt"
  fi

  # Shuffle trainval file.
  if [ $dataset == "trainval" ]
  then
    rand_file=$dst_file.random
    cat $dst_file | perl -MList::Util=shuffle -e 'print shuffle(<STDIN>);' > $rand_file
    mv $rand_file $dst_file
  fi
done
