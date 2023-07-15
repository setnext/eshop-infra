# ESHOP-Product Data Setup

## Create MongoDB Cluster

		cd /Users/nbabu/work/git/eshop-infra/k8s/mongo/operator/overlays/dev
		kubectl create -k .

## Get in to mongo shell

		kubectl exec -it setnext-mongodb-0 -n mongodb -- mongo
		kubectl exec -it setnext-mongodb-1 -n mongodb -- mongo
		kubectl exec -it setnext-mongodb-2 -n mongodb -- mongo

## Copy Data

		kubectl cp data/products_108_items.json setnext-mongodb-0:/tmp/products_108_items.json -n mongodb

		kubectl cp data/category.json setnext-mongodb-0:/tmp/category.json -n mongodb

		mongoimport --collection=products --db=eshop --file=/tmp/products_108_items.json --type=json -u setnext-user -p setnext@321

		kubectl exec -it setnext-mongodb-0 -n mongodb /bin/bash

		mongoimport --collection=category --db=eshop --file=/tmp/category.json --type=json -u setnext-user -p setnext@321

		kubectl exec -it setnext-mongodb-0 -n mongodb -- mongoimport --collection=category --db=eshop --file=/tmp/category.json --type=json -u setnext-user -p setnext@321

## Validate Data

		use eshop;
		db.auth('setnext-user','setnext@321')
		db.products.find()
		db.products.count()

## Build ESHOP-PRODUCT REPO

		Have the MVN Path in PATH in .bash_profile

		export M2_HOME=/Users/nbabu/work/runtime/apache-maven-3.8.6
		export PATH=$PATH:$M2_HOME/bin

		Then go to the path

		run

		mvn clean install

## Build Docker

		docker build -t setnext/eshop-product:v10 .
		docker tag setnext/eshop-product:v10 localhost:5001/setnext/eshop-product:v10
		docker push localhost:5001/setnext/eshop-product:v10
		docker push setnext/eshop-product:v9

## Deploy eshop-product

		change the mongodb url in application.yml

		/Users/nbabu/work/git/eshop-product/cicd/yaml/overlays/dev

		then

		kubectl apply -k . -n web



