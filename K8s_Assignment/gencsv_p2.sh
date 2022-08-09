#!/bin/bash


if [ $# -lt 1 ];
then	
   Seq=10
else
   Seq=$1
fi

rm -rf inputdata
touch inputdata

for i in `seq $Seq`
do 
  echo "$i,$RANDOM" >> /workdir/inputdata
done 

#chmod 777 inputdata

#sleep 1000

