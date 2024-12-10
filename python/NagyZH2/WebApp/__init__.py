import os
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate

basedir = os.path.abspath(os.path.dirname(__file__))

app = Flask(__name__)

#required for web forms
app.config["SECRET_KEY"] = "d8cc89ea7c7fa1684b36cc456378e61b"

#required for SQLAlchemy
app.config["SQLALCHEMY_DATABASE_URI"] = os.environ.get('DATABASE_URL') or \
        'sqlite:///' + os.path.join(basedir, 'mydb.db')
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"]= False

db = SQLAlchemy(app)
migrate = Migrate(app, db)


from WebApp import routes, models