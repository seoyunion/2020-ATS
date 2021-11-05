import sqlite3
conn = sqlite3.connect('test.db')
cur = conn.cursor()
# conn.execute('CREATE TABLE customer(name,category,region)')

sql_qry = "insert into customer(name,category,region) values (?, ?, ?)"
cur.execute(sql_qry, ('홍길동', 1, '서울'))
cur.execute(sql_qry, ('홍길동', 2, '서울'))
cur.execute(sql_qry, ('홍길동', 3, '서울'))

sql_qry = 'select * from customer'
print("DATA")
for _ in cur.execute(sql_qry):
	print(_)

conn.close()


