from flask_wtf import FlaskForm
from wtforms import BooleanField, StringField, SubmitField
from wtforms import validators
from wtforms.validators import DataRequired, Length, NoneOf, AnyOf


class SubscriptionForm(FlaskForm):

### Write your solution here!
    coursecode = StringField('coursecode', validators=[DataRequired()])
    neptun = StringField("neptun", validators=[DataRequired(), Length(6)])
    name = StringField("name", validators=[DataRequired()])
    iamhuman = BooleanField("ishuman", validators=[DataRequired()])
    submit = SubmitField("Subscribe")
###    
