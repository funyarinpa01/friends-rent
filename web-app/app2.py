from flask import Flask, render_template, request, redirect, url_for

app = Flask(__name__)

client_info_ = None
friend_info_ = None
order_info_ = None


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/shop')
def shop():
    return render_template('shop.html')


@app.route('/order')
def order():
    return render_template('order.html')


@app.route('/statistics')
def statistics():
    return render_template('statistics.html')


@app.route('/statistics-output')
def statistics_output():
    # get and process query result from DB and render it
    data_ = [["First Name", "Last Name"], ["Yaroslav", "Morozevych"], ["Itachi", "Uchiha"]]
    return render_template('statistics-output.html', data=data_)


@app.route('/index', methods=['GET', 'POST'])
def get_client_info():
    global client_info_

    if request.method == 'POST':
        client_info = {
            "first_name": request.form.get('name'),
            "last_name": request.form.get('sname'),
            "email": request.form.get('email'),
            "password": request.form.get('password')
        }
        client_info_ = client_info
        return redirect(url_for('shop'))


@app.route('/order', methods=['POST'])
def get_order_info():
    global friend_info_, order_info_

    if request.method == 'POST':
        friend_info = {
            "friend_id": 10
        }
        order_info = {
            "party_type": request.form.get('party-type'),
            "begin_date": request.form.get('begin-date'),
            "end_date": request.form.get('end-date'),
            "present": request.form.get('present')
        }
        friend_info_ = friend_info
        order_info_ = order_info
        # Add order info to DB
        return redirect(url_for('shop'))


@app.route('/statistics', methods=['POST'])
def get_query_info():
    if request.method == 'POST':
        query_info = {
            "query_id": request.form.get('query-id'),
            "person_name": request.form.get('person-name'),
            "n_times": request.form.get('times-num'),
            "begin_date": request.form.get('begin-date'),
            "end_date": request.form.get('end-date')
        }
        # Send Query to DB and re-render the page
        return redirect(url_for('statistics_output'))


if __name__ == '__main__':
    print("Hello")
    app.run(debug=True)
