import os
from flask import Flask, render_template, request, session, redirect
from flask_mail import Mail, Message
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
from werkzeug.utils import secure_filename
import json


with open("config.json", "r") as c:
    params = json.load(c)["params"]

local_server = params["local_server"]


app = Flask(__name__)
app.secret_key = 'my_secret_key'
app.config['UPLOAD_FOLDER'] = params['upload_loc']
app.config.update(dict(
    MAIL_SERVER="smtp.googlemail.com",
    MAIL_PORT=465,
    MAIL_USE_TLS=False,
    MAIL_USE_SSL=True,
    MAIL_USERNAME=params["gmail_user"],
    MAIL_PASSWORD=params["gmail_pass"],
))

mail = Mail(app)


if local_server:
    app.config['SQLALCHEMY_DATABASE_URI'] = params["local_uri"]
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params["prod_uri"]
db = SQLAlchemy(app)


class Contacts(db.Model):
    sno = db.Column(db.Integer, primary_key=True, nullable=False)
    name = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(150), nullable=False)
    msg = db.Column(db.String(500), nullable=False)
    phone_num = db.Column(db.String(15), nullable=False)
    date = db.Column(db.String(30), nullable=True)


class Posts(db.Model):
    sno = db.Column(db.Integer, primary_key=True, nullable=False)
    title = db.Column(db.String(100), nullable=False)
    slug = db.Column(db.String(40), nullable=False)
    content = db.Column(db.String(500), nullable=False)
    date = db.Column(db.String(30), nullable=True)
    bg_file = db.Column(db.String(30), nullable=False)


@app.route('/')
def main():
    posts = Posts.query.all()
    postsLen = len(posts)
    postsShow = params["postsShow"]
    mod = postsLen % postsShow
    if 0 < mod < postsShow:
        pageCount = (postsLen // postsShow) + 1
    elif mod == 0:
        pageCount = postsLen // postsShow

    page = request.args.get('page')
    if page == None:
        page = 1
    page = int(page)

    if page == 1:
        prev = "#"
        next = f"/?page={page+1}"
    elif page == pageCount:
        prev = f"/?page={page-1}"
        next = "#"
    else:
        prev = f"/?page={page-1}"
        next = f"/?page={page+1}"

    posts = posts[(page-1)*postsShow:((page-1)*postsShow)+postsShow]

    return render_template('index.html', params=params, posts=posts, prev=prev, next=next)


@app.route('/about')
def about():
    return render_template('about.html', params=params)


@app.route('/contact', methods=['GET', 'POST'])
def contact():
    if request.method == 'POST':
        # GETTING EVERYTHING FROM THE CONTACT FORM
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        message = request.form.get('msg')
        date = datetime.now()

        # SENDING TO THE DATABASE
        entry = Contacts(name=name, email=email,
                         phone_num=phone, msg=message, date=date)
        db.session.add(entry)
        db.session.commit()

        # SENDING DIRECT EMAIL
        mailMessage = Message(subject=f"{name} from Blog", sender=email,
                              recipients=[params["gmail_user"]])
        mailMessage.body = f"{message}\n\nEmail: {email}\nPhone: {phone}"
        mail.send(mailMessage)

    return render_template('contact.html', params=params)


@app.route('/post/<string:post_slug>', methods=['GET'])
def post(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()
    return render_template('post.html', params=params, post=post)


@app.route('/add', methods=['GET', 'POST'])
def add():
    if request.method == 'POST':
        # GETTING EVERYTHING FROM THE CONTACT FORM
        title = request.form.get('title')
        slug = request.form.get('slug')
        bg_file = request.form.get('bg_file')
        content = request.form.get('content')
        date = datetime.now()

        # SENDING TO THE DATABASE
        entry = Posts(title=title, slug=slug, bg_file=bg_file,
                      content=content, date=date)
        db.session.add(entry)
        db.session.commit()

        posts = Posts.query.all()
        return render_template('dashboard.html', params=params, posts=posts)

    return render_template('add.html', params=params)


@app.route('/dashboard', methods=['GET', 'POST'])
def dashboard():
    posts = Posts.query.all()

    if 'user' in session and session['user'] == params['admin_user']:
        return render_template('dashboard.html', params=params, posts=posts)

    if request.method == 'POST':
        user = request.form.get('user')
        passw = request.form.get('pass')
        if user == params['admin_user'] and passw == params['admin_pass']:
            session['user'] = user

            return render_template('dashboard.html', params=params, posts=posts)

    return render_template('login.html')


@app.route('/edit/<string:sno>', methods=['GET', 'POST'])
def edit(sno):
    post = Posts.query.filter_by(sno=sno).first()

    if request.method == 'POST':
        title = request.form.get('title')
        slug = request.form.get('slug')
        bg_file = request.form.get('bg_file')
        content = request.form.get('content')

        post.title = title
        post.slug = slug
        post.bg_file = bg_file
        post.content = content

        db.session.commit()
        return redirect('/dashboard')

    return render_template('edit.html', params=params, post=post)


@app.route('/delete/<string:sno>')
def delete(sno):
    if 'user' in session and session['user'] == params['admin_user']:
        post = Posts.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
    return redirect('/dashboard')


@app.route('/logout')
def logout():
    session.pop('user')
    return redirect('/')


@app.route('/uploader', methods=['GET', 'POST'])
def uploader():
    if 'user' in session and session['user'] == params['admin_user']:
        if request.method == 'POST':
            f = request.files.get('file1')
            f.save(os.path.join(app.config['UPLOAD_FOLDER'],
                   secure_filename(f.filename)))
            return redirect('/dashboard')


app.run(debug=True)
