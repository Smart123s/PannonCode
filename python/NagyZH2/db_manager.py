from WebApp import app, db
from WebApp.models import Course

app.app_context().push()

db.session.add_all([
   Course(id=1, code="VEMISAB254ZF", name = 'Python programozas'),
   Course(id=2, code="VEMISAB146AP", name = 'Programozas alapjai'),
   Course(id=3, code="VEMISAB156GF", name = 'Programozas I')
  ]
)
db.session.commit()

