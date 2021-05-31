from flask import Flask, render_template, request, redirect, url_for, flash, session, logging
from scripts.database import DataBase
from wtforms import Form, StringField, TextAreaField, PasswordField, validators
from passlib.hash import sha256_crypt
import psycopg2
from config import config


db = DataBase()

app = Flask(__name__)
app.config['SEND_FILE_MAX_AGE_DEFAULT'] = 0  # don't touch it for now, stops browser from caching old css, etc.
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'

client_info_ = None
friend_info_ = None
order_info_ = None


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/login', methods=['GET', 'POST'])
def login():
    roles = ['friend', 'client']
    if request.method == 'POST':
        email = request.form['email']
        password_candidate = request.form['password']

        # params = config()
        # conn = psycopg2.connect(**params)
        # cur = conn.cursor()

        res = db._run_query("SELECT * FROM users WHERE email = %s", [email])
        if len(res) > 0:
            entry = res[0]
            password = entry[3]
            if sha256_crypt.verify(password_candidate, password):
                session['logged_in'] = True
                session['username'] = email
                flash('logged in', 'success')
                return redirect(url_for('index'))
            else:
                return render_template('login.html', error='passwords do not match')
        else:
            render_template('login.html', error='email is not found')
    return render_template('login.html', roles=roles)


@app.route('/logout')
def logout():
    session.clear()
    flash('logged out', 'success')
    return redirect(url_for('login'))


@app.route('/shop')
def shop():
    return render_template('shop.html')


@app.route('/order')
def order():
    return render_template('order.html')


@app.route('/statistics')
def statistics():
    return render_template('statistics.html', data=[])


class RegistrationForm(Form):
    name = StringField(u'First Name', [validators.InputRequired()])
    sname = StringField(u'Second Name', [validators.InputRequired()])
    email = StringField(u'Email', [validators.InputRequired()])
    password = PasswordField(u'Password', [validators.InputRequired()])


@app.route('/register', methods=['GET', 'POST'])
def register():
    roles = ['friend', 'client']
    form = RegistrationForm(request.form)
    if request.method == 'POST' and form.validate():
        first_name = form.name.data
        second_name = form.sname.data
        email = form.email.data
        password = sha256_crypt.hash(str(form.password.data))

        params = config()
        conn = psycopg2.connect(**params)
        cur = conn.cursor()

        cur.execute("INSERT INTO users(first_name, second_name, email, password) VALUES (%s, %s, %s, %s)",
                    (first_name, second_name, email, password))

        cur.close()

        conn.commit()

        conn.close()

        flash("You were successfully registered", "success")

        return redirect(url_for('login'))
    return render_template('register.html', form=form, roles=roles)


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
        db = DataBase()
        db.insert_order(client_info_, friend_info_, order_info_)
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
        data_ = [["First Name", "Last Name"], ["Yaroslav", "Morozevych"], ["Itachi", "Uchiha"]]
        return render_template('statistics.html', data=data_)


if __name__ == '__main__':
    app.secret_key = 'akatsuki php developers'
    app.run(debug=True)
