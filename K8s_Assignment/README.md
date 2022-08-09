##########Kubernetes Assignment#####
I have created k8s_part1.yaml for Part 1 assignment
And k8s_part2.yaml for Part 2 Assignment
#####################################


Part 1:

Q1: Run the container image infracloudio/csvserver:latest in background and check if it's running.

Sol:
omkar@MyDockerVM:~/csvserver/solution$ docker run -d -i infracloudio/csvserver:latest
Unable to find image 'infracloudio/csvserver:latest' locally
latest: Pulling from infracloudio/csvserver
ae43b40a9945: Pull complete
7bb33bb2db38: Pull complete
c82d72e1bb76: Pull complete
Digest: sha256:20bc5a93fac217270fe5c88d639d82c6ecb18fc908283e046d9a3917a840ec1f
Status: Downloaded newer image for infracloudio/csvserver:latest
5bc3a3b7669027e9ca0f5509478e7d19a04467067c78f618a04465cb599a59a0

Container Failed:
omkar@MyDockerVM:~/csvserver/solution$ docker ps -a
CONTAINER ID   IMAGE                           COMMAND                  CREATED          STATUS                      PORTS     NAMES
5bc3a3b76690   infracloudio/csvserver:latest   "/csvserver/csvserver"   46 seconds ago   Exited (1) 45 seconds ago             happy_margulis

 
Q2: If it's failing then try to find the reason, once you find the reason, move to the next step.
Sol:
Reason for container to fail: inputdata file was missing inside the container.
omkar@MyDockerVM:~/csvserver/solution$ docker logs 5bc3a3b76690
2022/06/02 08:20:23 error while reading the file "/csvserver/inputdata": open /csvserver/inputdata: no such file or directory

Create a inputdata named file and bind mount it to path  /csvserver/inputdata inside the container
docker run -v $(pwd)/inputdata:/csvserver/inputdata -d -i infracloudio/csvserver:latest
docker run -v $(pwd)/inputFile:/csvserver/inputFile -d -i infracloudio/csvserver:latest


Q3: Write a bash script gencsv.sh to generate a file named inputFile whose content looks like:
omkar@MyDockerVM:~/csvserver/solution$ cat gencsv.sh
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
  echo "$i,$RANDOM" >> inputFile
done


Q4: Run the container again in the background with file generated in (3) available inside the container
Sol:
docker run -v $(pwd)/inputdata:/csvserver/inputdata -v $(pwd)/inputFile:/csvserver/inputFile -d -i infracloudio/csvserver:latest


Q5: Get shell access to the container and find the port on which the application is listening. Once done, stop / delete the running container.
Sol:
omkar@MyDockerVM:~/csvserver/solution$ docker ps -a
CONTAINER ID   IMAGE                           COMMAND                  CREATED         STATUS         PORTS      NAMES
0f577c4e37b2   infracloudio/csvserver:latest   "/csvserver/csvserver"   2 minutes ago   Up 2 minutes   9300/tcp   blissful_nightingale
omkar@MyDockerVM:~/csvserver/solution$ docker exec -it blissful_nightingale bash
[root@0f577c4e37b2 csvserver]#
[root@0f577c4e37b2 csvserver]#
[root@0f577c4e37b2 csvserver]# netstat -anulpt
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp6       0      0 :::9300                 :::*                    LISTEN      1/csvservers


Q6: Same as (4), run the container and make sure,
    The application is accessible on the host at http://localhost:9393
    Set the environment variable CSVSERVER_BORDER to have value Orange.

Sol:
docker run -v $(pwd)/inputdata:/csvserver/inputdata -v $(pwd)/inputFile:/csvserver/inputFile -p 9393:9300 -e CSVSERVER_BORDER="Orange" -d -i infracloudio/csvserver:latest

omkar@MyDockerVM:~/csvserver/solution$ curl http://localhost:9393
<!DOCTYPE html>
<html>
<head>
  <title>CSV Server</title>
  <style>
  th, td {
    padding: 5px;
  }
  </style>
</head>
<body>
<!-- Y3N2c2VydmVyIGdlbmVyYXRlZCBhdDogMTY1NDE2MTE0MA== -->
<h3 style="border:3px solid Orange">Welcome to the CSV Server</h3><table><tr><th>Index</th><th>Value</th></tr></table

