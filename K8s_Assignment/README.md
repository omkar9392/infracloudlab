##########Kubernetes Assignment#####

#Part 1 assignment: k8s_part1.yaml
#Part 2 assignment: k8s_part2.yaml

# Pre-requisites:
# Create a local directory /localdir. This will be mounted as a hostpath.
# If using minikube - kindly run below minikube command to mount the local directory to the minikube  
# minikube mount /localdir:/localdir &
#####################################

Part 1:
Q1: Run the container image infracloudio/csvserver:latest using Kubernetes

#####################################
Solution:
#####################################
1. Git Clone the repo
2. cd K8s_Assignment/
3. kubectl apply -f k8s_part1.yaml


#####################################
Output:
#####################################
omkar@omkar-vishwakarma:~/Documents/Assignments/infracloudlab/K8s_Assignment$ kubectl get all
NAME                              READY   STATUS    RESTARTS   AGE
pod/csvserver-85c6bbf7dc-mstzp    2/2     Running   0          2m7s
pod/prometheus-7fc559bb57-k9dgw   2/2     Running   0          2m6s

NAME                 TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
service/csvserver    NodePort    10.103.240.0   <none>        9300:32000/TCP   2m7s
service/kubernetes   ClusterIP   10.96.0.1      <none>        443/TCP          75d
service/prometheus   NodePort    10.98.32.1     <none>        9090:31000/TCP   2m7s

NAME                         READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/csvserver    1/1     1            1           2m7s
deployment.apps/prometheus   1/1     1            1           2m7s

NAME                                    DESIRED   CURRENT   READY   AGE
replicaset.apps/csvserver-85c6bbf7dc    1         1         1       2m7s
replicaset.apps/prometheus-7fc559bb57   1         1         1       2m7s


