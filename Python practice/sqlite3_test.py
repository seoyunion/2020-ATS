import sqlite3
conn = sqlite3.connect('test.db') #하나의 DB에는 같은 이름을 가진 테이블을 하나만 만들 수 있다
cur = conn.cursor()
conn.execute('CREATE TABLE customer(name,category,region)') 

sql_qry = "insert into customer(name,category,region) values (?, ?, ?)"
cur.execute(sql_qry, ('홍길동', 1, '서울'))
cur.execute(sql_qry, ('홍길동', 2, '서울'))
cur.execute(sql_qry, ('홍길동', 3, '서울'))
#커서에 따라서 처음부터 하나씩 데이터를 가져

sql_qry = 'select * from customer'
print("DATA")
for _ in cur.execute(sql_qry):
	print(_)

conn.close()


