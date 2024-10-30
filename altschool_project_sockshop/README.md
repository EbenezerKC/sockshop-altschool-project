
# PROVISION A SOCKS SHOP MICROSERVICE

Using Terraform as Iaac, Running on azure Kubernetes cluster. 
 I will be deploying 10 services under the following categories: carts, catalogue, frontend, orders, payment, queue-master, rabbitmq, session-db, shipping, and user. Check the folders above for codes or you can clone the repo.

 


## Prerequiste:

- A cluster running

- An Ubuntu machine

- Terraform installed

- Kubectl installed

- Azure CLI

Sections Explained:

1. PROVIDER.TF
in this section, we are going to create a providers file for the sock shop microservice. we will be creating a new namespace for it and we will be naming it sock-shop

We will also need to specify the location of the Kube config file for the providers listed.

We need to input the name of our cluster into the file, so anywhere you see ‘ClusterName’ replace it with the name of your cluster.

2. CARTS
In this section, we are going to be writing a terraform-Kubernetes script that deploys the carts application into the cluster. The carts application is going to be running on port 80 and it also has its own database which is a Mongo DB.

3. CATALOGUE
Just like the carts section above. we are going to also be deploying the catalogue section of the sock-shop microservice. This service is also running on port 80 and has a MySQL DB as you can see in the file above.

4. FRONTEND
the frontend service is going to be the front page of the sock-shop application. it is going to also be deployed in the sock-shop namespace with 1 replica. the frontend service doesn’t have a database. it also runs on port 80.

5. ORDERS
the next service we will be deploying will be the order service. this is the service where customers can make orders.
we will just be pulling the already created app from docker. The order service runs on port 27017 and has its own mongo db database.

6. PAYMENTS
the payment service just like every other service will be deployed in the sock-shop namespace. with just 1 replica.
This is going to be a service where customers can make payments. and like every other service also we are pulling the payment service from docker. It's running on port 80.

7. queue-master
The queue master has only one replica. it also runs on a port 80 with a CPU limit of 300m and memory limit of 500Mi

8. The RabbitMQ
the RabbitMQ is for the order queue. and it has an exporter which runs on the port 9090. The management container runs on port 15672 while the service runs on port 5672.

9. SESSION-DB
the session db is a Redis container that is used to store data. the redis container is running on port 6379. The service is also running on port 6379 as in the file above.

10. SHIPPING
the shipping service is where shipping is made in the sock shop microservice. it has its own image which we will be pulling from docker. It runs on port 80.

11. USER
the user service of the sock shop microservice is where users can be created.
As you should expect we are using a database to store information about the user.the database used here is mongo db. and the service is running on port 27017
there is also a volume mount in the DB.


## Deployment

To run the terraform files use the command below:

$ terraform init

$ terraform apply

to check if the sock shop has been deployed you can use this command:

$ kubectl get svc -n sock-shop

with the command above you should see all the services that were deployed in the sock-shop namespace.

VIEWING ON-BROWSER
Now that you have deployed the sock-shop you would want to also view that on your browser.

First, we will need to run this command to display the services we have:

$ kubectl get svc -n sock-shop

then you should see a frontend service also present.

we will need to edit it with this command:

$ kubectl edit svc front-end -n sock-shop

after typing this a new page should pop up.

Scroll down to the point where you see this ‘type: ClusterIP’ and change it to these exact words:

LoadBalancer


After saving the file, you will see a load balancer created for the front-end service.
if you didn't see it. 
Run the following command.

kubectl get svc front-end -n sock-shop

Then copy the external IP and paste it on your browswer.

if the site is not reachable, type it like this:

http://( your external IP):(port)

e.g:

http://45.233.54.1:80