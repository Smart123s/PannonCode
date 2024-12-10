from flask import render_template, flash, redirect, jsonify
from WebApp import app, db
from WebApp.forms.subscriptionForm import SubscriptionForm
from .models import Course, Student


test_courses = [
        {'id': 1, "code" : "VEMISAB254ZF", 'name': 'Python programozas',   'students': [ 
                                                                    { "neptun" : "JJJJJJ", "name" : "John"},
                                                                    { "neptun" : "RRRRRR", "name" : "Robert"},
                                                                    { "neptun" : "MMMMMM", "name" : "Mary"}
                                                                ]},
        {'id': 2, "code" : "VEMISAB146AP",'name': 'Programozas alapjai',  'students': [ 
                                                                    { "neptun" : "KKKKKK", "name" : "Kevin"},
                                                                    { "neptun" : "WWWWWW", "name" : "William"},
                                                                    { "neptun" : "TTTTTT", "name" : "Thomas"}
                                                                ]},
        {'id': 3, "code" : "VEMISAB156GF",'name': 'Programozas I.',       'students': [
                                                                    { "neptun" : "BBBBBB", "name" : "Bob"}
                                                                ]} 
    ]


@app.route('/')
@app.route('/index')
def index():
    return render_template("index.html", name="Moodle Lite", page = "index", cnt = len(test_courses))



@app.route('/courses')
def listItems():  
    ### Write your solution here!
    courses = Course.query.all()
    return render_template("courses.html", name="Moodle Lite", courses=courses, page="courses")
    ###
    # return render_template("courses.html", name="Moodle Lite", courses=test_courses, page = "courses" )
    

@app.route('/subscription', methods=["GET", "POST"])
def order():
    ### Write your solution here!
    form = SubscriptionForm()

    if form.validate_on_submit():
        result = db.session.query(Course).filter_by(code = form.coursecode.data)
        if result.count() == 0:
            flash('{} not found! Check the list!'.format(form.coursecode.data))
            return redirect('/courses')

        db.session.add(Student(
            neptun = form.neptun.data,
            name = form.name.data,
            # ez így lehet duplicate DB call lett :)
            course_id = result.first().id,
        ))
        db.session.commit()
        """
        Feladat 2:
        coruse_codes = [a['code'] for a in test_courses]
        if form.coursecode.data in coruse_codes:
            for course in test_courses:
                if course['code'] == form.coursecode.data:
                    course['students'].append({
                        'neptun': form.neptun.data,
                        'name': form.name.data,
                    })
        """
        flash('You have successfully subscribed!')
        return redirect('/index')


    ###
    return render_template('subscription.html', name='Moodle Lite', form=form ,page="subscription")



### Write your solution here!
@app.route('/students/<course_code>', methods=["GET"])
def getStudents(course_code):
    course_id = db.session.query(Course).filter_by(code=course_code).first().id
    result = db.session.query(Student).filter(Student.course_id == course_id)
    if list(result):
        student_list = list(result)
        return [ {
            'id': r.id,
            'neptun' : r.neptun,
            'name': r.name,
        } for r in student_list]
    else:
        return {}
###