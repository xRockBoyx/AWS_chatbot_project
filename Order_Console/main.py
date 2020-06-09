from flask import Flask
from flask import render_template
import pymysql.cursors

app = Flask(__name__)

@app.route("/")
def hello():
    data = []
    connection = pymysql.connect(host='',
                             user='',
                             password='',
                             db='',
                             charset='utf8mb4',
                             cursorclass=pymysql.cursors.DictCursor)
    try:
        with connection.cursor() as cursor:
            # Read a single record
            sql = "SELECT * FROM Orders"
            cursor.execute(sql)
            for i in cursor.fetchall():
                data.append(i)
            # print(cursor.fetchall())
    finally:
        connection.close()      
    return render_template(r"css.html",data=data)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=3000)