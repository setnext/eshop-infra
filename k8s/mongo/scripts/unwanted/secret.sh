kubectl create secret generic mongodb-secret -n db \
--from-file=MONGO_INITDB_ROOT_USERNAME=creds/rootUsername.txt \
--from-file=MONGO_INITDB_ROOT_PASSWORD=creds/rootPassword.txt \
--from-file=MONGODB_USERNAME=creds/username.txt \
--from-file=MONGODB_PASSWORD=creds/password.txt \
--from-file=MONGODB_USERS_LIST=creds/userlist.txt \
