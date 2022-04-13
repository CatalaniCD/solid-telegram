
# read 1
while read -r line;
do
  echo $line
done < keys

# read 2
lines=$(<keys)

echo test1
echo $lines

# read and store in an array
IFS='\0' read -r -a array <<< $lines


echo test2
echo "${array[0]}"
echo "//"
echo "${array[1]}"

# using sed
array=($(echo $lines | sed 's/,/\n/g'))

echo test3
echo "${array[0]}"
echo "//"
echo "${array[1]}"

# using tr
arrayb=($(echo $lines | tr ',' "\n"))

echo test4
echo "${arrayb[0]}"
echo "//"
echo "${arrayb[1]}"

# read arrayb
readarray myarray < keys

echo test5
echo "${myarray[0]}"
echo "//"
echo "${myarray[1]}"

# to a dict
declare -A ary='([key]="${myarray[0]}" [sec]="${myarray[1]}")'
declare -r ary
echo "test6 dictionary"
echo "${ary[*]}"
