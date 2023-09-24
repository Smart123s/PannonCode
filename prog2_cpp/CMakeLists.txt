cmake_minimum_required(VERSION 3.26)
project(prog2cpp)

set(CMAKE_CXX_STANDARD 17)

add_executable(prog2cpp main.cpp
        osobjektum.h
        kocka.h
        gula.h
        tetraeder.h
        objektumtar.h)
