#!/bin/bash
declare -i index
declare -i min_id
declare -i max_id
declare -i final_id
final_id=`mysql -BN -e "select max(id) from user"` ;

for index in `seq -f "%.0f" 1 100000 $final_id`; do
  min_id=$index;
  max_id=$[$index+99999];
  echo "processing $min_id to $max_id"
  echo "update user set email=replace(replace(email,"\r",""),"\n","") where user_id between $min_id and $max_id; select row_count()" | mysql test
  sleep 0.1
done
