
#
from WebApp import db

from typing import List, Optional
from sqlalchemy.orm import Mapped, mapped_column, relationship
from sqlalchemy import ForeignKey
from sqlalchemy.types import String, Integer


class Course(db.Model):
### Write your solution here!
    id: Mapped[int] = mapped_column(primary_key=True)

    name: Mapped[str] = mapped_column(String(), unique=True)
    code: Mapped[int] = mapped_column(String(), unique=True)
    students: Mapped[List["Student"]] = relationship(primaryjoin="Course.id == Student.course_id")
###    


class Student(db.Model):
### Write your solution here!
    id: Mapped[int] = mapped_column(primary_key=True)

    name: Mapped[str] = mapped_column(String())
    neptun: Mapped[int] = mapped_column(String(), unique=True)

    course_id: Mapped[str] = mapped_column(ForeignKey("course.id"))
    course: Mapped[List["Course"]] = relationship(back_populates="students")
###    
