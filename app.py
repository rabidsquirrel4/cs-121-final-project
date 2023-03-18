"""
Python Application for CS 121 Final Project 

Student Names:  Leo Afriyie-Buabeng,    Rachel Shi
Student Emails: lafriyie@caltech.edu,   rshi@caltech.edu
"""
import sys  # to print error messages to sys.stderr
import mysql.connector
# To get error codes from the connector, useful for user-friendly
# error-handling
import mysql.connector.errorcode as errorcode

# Debugging flag to print errors when debugging that shouldn't be visible
# to an actual client. Set to False when done testing.
DEBUG = True


