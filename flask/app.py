from flask import Flask, render_template, request,session
from flask_sqlalchemy import SQLAlchemy
# from sshtunnel import SSHTunnelForwarder
from sqlalchemy import or_ , and_ ,create_engine, Column, text, Integer, TEXT, TypeDecorator
import time



app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = "postgresql://postgres:qweasd@localhost:5432/exam_sql"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)



@app.route('/tes')
def index():
   return render_template('home.html')

@app.route('/ENDPOINT', methods=['GET'])
# @token_required
def testing_cuy():

    sql = text("""SELECT
                    sum ( items.price ) AS total_price 
                FROM
                    items
                    JOIN sales_records ON items.ID = sales_records.item_id
                    JOIN users ON sales_records.user_id = users.ID 
                WHERE
                    users.age > 20
                """)
    data = db.engine.execute(sql)
    output = []

    for data in data:
        print('data',data[0])
        data_ouput = {}
        data_ouput['total_price'] = data[0]
        # data_ouput['tes'] = data[1]
        output.append(data_ouput)

    return render_template('result.html',data=output)
#     # return {"data" : output}



data=[
    {
        'name':'Audrin',
        'place': 'kaka',
        'mob': '7736'
    },
    {
        'name': 'Stuvard',
        'place': 'Goa',
        'mob' : '546464'
    }
]


@app.route("/")
def home():
    return render_template('result.html', data=data)

if __name__ == '__main__':
    app.run(debug=True)
