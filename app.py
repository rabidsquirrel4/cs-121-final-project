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

def main():
    show_options()

def show_options():
    print("Welcome to Leo and Rachel's Football(Soccer) Bet Application.")
    print("What would you like to do? ")
    print("     (b)et on a game")
    print("     (l)ook something up")
    print("     (q)uit")
    option = input("Enter an option: ").lower()
    if option == 'b':
        make_bet()
    elif option == 'l':
        lookup_stat()
    else:
        print('Please enter a valid option.')

def make_bet():
    pass

def lookup_stat():
    team_name = input("Please enter the team you would like to look up stats" +
                      " for:")
    sql = """
    SELECT * 
    FROM games
    WHERE home_id LIKE '%s'
    """ % team_name

def get_is_active():
    pass

def get_average_odds():
    pass    

def get_sum_goals():
    print('Sum of goals: ')
    # select database first
    sql = 'SELECT * FROM client;'
    try:
        cursor = conn.cursor()
        cursor.execute(sql)
        row = cursor.fetchone()
        rows = cursor.fetchall()
    except Exception as err:
        if DEBUG:
            sys.err(err)
            return

def get_conn():
    """"
    Returns a connected MySQL connector instance, if connection is successful.
    If unsuccessful, exits.
    """
    try:
        conn = mysql.connector.connect(
          host='localhost',
          user='appadmin',
          # Find port in MAMP or MySQL Workbench GUI or with
          # SHOW VARIABLES WHERE variable_name LIKE 'port';
          port='3306',
          password='adminpw',
          database='soccerdb'
        )
        print('Successfully connected.')
        return conn
    except mysql.connector.Error as err:
        # Remember that this is specific to _database_ users, not
        # application users. So is probably irrelevant to a client in your
        # simulated program. Their user information would be in a users table
        # specific to your database.
        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR and DEBUG:
            sys.stderr('Incorrect username or password when connecting to DB.')
        elif err.errno == errorcode.ER_BAD_DB_ERROR and DEBUG:
            sys.stderr('Database does not exist.')
        elif DEBUG:
            sys.stderr(err)
        else:
            sys.stderr('An error occurred, please contact the administrator.')
        sys.exit(1)

if __name__ == '__main__':
    main()
    # make connection a global variable
    conn = get_conn()