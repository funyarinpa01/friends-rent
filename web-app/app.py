from flask import Flask, render_template, request, redirect, url_for, flash, session, logging
from wtforms import Form, StringField, TextAreaField, PasswordField, validators
from passlib.hash import sha256_crypt
import psycopg2
import datetime

from scripts.database import DataBase
from scripts.queries import args_names, results_names
from scripts.config import config


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
    if request.method == 'POST':
        email = request.form['email']
        password_candidate = request.form['password']

        # params = config()
        # conn = psycopg2.connect(**params)
        # cur = conn.cursor()

        db = DataBase()
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
    return render_template('login.html')


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
    return render_template('register.html', form=form)


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
        query_id = int(request.form.get('query-id'))
        if query_id not in range(1, 13):
            pass  # in production, throw some server error or reload with an error message
            # in practice, this can only happen if someone intentionally hacks the select

        args = []
        for arg in args_names[query_id - 1]:
            value = request.form.get(arg)
            if not value:
                return render_template('statistics.html', data=[])
            try:
                value = datetime.datetime.strptime(value, '%Y-%m-%d').date()
            except ValueError as e:
                if not str(e).endswith(" does not match format '%Y-%m-%d'"):  # this is a real error
                    raise e
            args.append(value)

        # db = DataBase(**config())
        db = DataBase()
        data_ = db.run_task_query(query_id, args)

        if not data_:
            data_ = [['No results.']]
        else:
            data_.insert(0, results_names[query_id - 1])

        return render_template('statistics.html', data=data_)


if __name__ == '__main__':
    app.secret_key = 'akatsuki php developers'
    app.run(debug=True)
