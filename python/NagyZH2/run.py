
from os import environ
from WebApp import app

if __name__ == '__main__':
    HOST = environ.get('SERVER_HOST', 'localhost')
    try:
        PORT = int(environ.get('SERVER_PORT', '6767'))
    except ValueError:
        PORT = 6767
    app.run(HOST, PORT)
