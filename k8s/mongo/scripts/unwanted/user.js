    const rootUser = cat('/etc/mongo-creds/admin/MONGO_INITDB_ROOT_USERNAME');
   // print("first line executed");
    const rootPass = cat('/etc/mongo-creds/admin/MONGO_INITDB_ROOT_PASSWORD');
    
    const adminDb = db.getSiblingDB('admin');
   // adminDb.createUser({user: 'mongo_admin',pwd: 'Muruga321',roles: [ { role: 'root', db: 'admin' } ]});
    adminDb.auth(rootUser.trim(),rootPass.trim());
    print(rootUser.trim());
   // print(rootPass);
   const myDb = db.getSiblingDB('mynewdb');
   myDb.createUser({ user: 'nithya', pwd: 'test321', roles: [{ role: 'readWrite', db: 'mynewdb' }]});
   print("Hello world");
