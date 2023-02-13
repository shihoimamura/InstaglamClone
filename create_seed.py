
with open('db/seeds.rb', 'w') as f:
    for i in range(50):
        print("User.create(name: '", i, "', email: '",i,"@",i,"', password: '",i,i,i,i,i,i,"')", file=f, sep="")
