from flask import Flask, render_template

from scripts.database import DataBase


app = Flask(__name__)
app.config.update(SEND_FILE_MAX_AGE_DEFAULT=0)  # i think it stops the browser from caching old versions
db = DataBase()


@app.route("/")
def index():
    return render_template("index.html")


@app.route("/shop")
def shop():
    return render_template("shop.html")


@app.route("/order")
def order():
    return render_template("order.html")


@app.route("/statistics", methods=['GET', 'POST'])
def statistics():
    return render_template("statistics.html")


app.run(debug=True)
