#!/bin/bash

rm -rf inputFile
touch inputFile
chmod 666 inputFile

if [ $# -lt 1 ];
then	
   Seq=10
else
   Seq=$1
fi

for i in `seq $Seq`
do 
  echo "$i,$RANDOM" >> /localdir/inputdata
done 

