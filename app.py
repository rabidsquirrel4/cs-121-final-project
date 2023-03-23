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
DEBUG = False

def show_options():
    print("Welcome to Leo and Rachel's Football(Soccer) Bet Application.")
    while True:
        print("What would you like to do? ")
        print("     (c)reate account")
        print("     (u)ser login")
        print("     (b)et on a game")
        print("     (l)ook something up")
        print("     (q)uit")
        option = input("Enter an option: ").lower()
        if option == 'c':
            create_user()
        elif option == 'u':
            user_login()
        elif option == 'b':
            make_bet()
        elif option == 'l':
            lookup_stat()
        elif option == 'q':
            quit_ui()
        else:
            print('Please enter a valid option.')

def create_user():
    username = input("Please enter the username you would like to use: ")
    print("Passwords must be 8-12 characters in length.")
    password = input("Please enter your password: ")

def user_login():
    username = input("Please enter your username: ")
    password = input("Please enter your password: ")
    sql = "SELECT authenticate('%s', '%s');" % (username, password)
    try:
        cursor = conn.cursor()
        cursor.execute(sql)
        successful = cursor.fetchone()[0]
        if DEBUG:
            print(successful)
        if successful == 1:
            print("Successfully logged in!")
        else:
            print("Please try logging in again.")
    except Exception as err:
        if DEBUG:
            sys.err(err)
            return

def make_bet():
    game_id = input("Please enter your the Game ID of the game " + 
                     "you would like to make a bet on: ")
    client_id = input("Please enter the ID of the client making the bet : ")
    type_id = input("Please enter the ID of the type of bet being placed: ")
    amount_placed = input("Please enter the amount of the bet: ")
    sql = """CALL sp_place_bet(%s, %s, %s, %s);
        """ % (game_id, client_id, type_id, amount_placed)
    try:
        cursor = conn.cursor()
        cursor.execute(sql)        
    except Exception as err:
        print("Something went wrong with placing the bet, please try again.")
        if DEBUG:
            sys.err(err)
        return
    print("Bet made successfully!")

def lookup_stat():
    """Initial interface for user to look up statistics."""
    print("What would you like look up? ")
    print("     (a)ctive: look up if team is active")
    print("     (h)ighest scoring games from 2009 to 2019")
    print("     (r)eal madrid vs barcelona statistics")
    print("     (q)uit")
    option = input("Enter an option: ").lower()
    if option == 'a':
        get_is_active()
    if option == 'h':
        highest_scoring()
    elif option == 'r':
        madrid_vs_barcelona()
    elif option == 'q':
        quit_ui()
    else:
        print('Please enter a valid option.')

def get_is_active():
    """ 
    Let's the user search the database for teams that are active or not.
    """
    team_name = input("Please enter the team you would like to look up stats" +
                      " for:")
    sql = """
    SELECT COUNT(*) 
    FROM teams
    WHERE team_name LIKE '%s'
    """ % team_name
    try:
        cursor = conn.cursor()
        cursor.execute(sql)
        count = cursor.fetchone()[0]
        if DEBUG:
            print(count)
        if count > 0:
            print("Yes, " + team_name + " is active!")
        else:
            print("No, " + team_name + " is not active.")
    except Exception as err:
        if DEBUG:
            sys.err(err)
            return

def highest_scoring():
    sql = """
    SELECT games.game_id, games.game_date, 
       t1.team_name || ' vs. ' || t2.team_name AS match, 
       games.ft_home_goals + games.ft_away_goals AS total_goals
    FROM games
    INNER JOIN teams t1 ON games.home_id = t1.team_id
    INNER JOIN teams t2 ON games.away_id = t2.team_id
    WHERE games.game_date BETWEEN '2009-01-01' AND '2019-12-31'
    ORDER BY total_goals DESC
    LIMIT 5;
    """
    try:
        cursor = conn.cursor()
        cursor.execute(sql)
        rows = cursor.fetchall()
        if DEBUG:
            print(rows)
        print(rows)
    except Exception as err:
        if DEBUG:
            sys.err(err)
            return

def madrid_vs_barcelona():
    sql = """
    SELECT SUM(ft_home_goals + ft_away_goals) AS total_goals
    FROM games
    INNER JOIN odds ON games.game_id = odds.game_id
    INNER JOIN teams t1 ON games.home_id = t1.team_id AND t1.team_name = 'Real Madrid'
    INNER JOIN teams t2 ON games.away_id = t2.team_id AND t2.team_name = 'Barcelona'
    WHERE games.game_date BETWEEN '2009-01-01' AND '2018-12-31'
    AND odds.home_win > odds.away_win
    AND t1.team_id = odds.game_id;
    """
    try:
        cursor = conn.cursor()
        cursor.execute(sql)
        rows = cursor.fetchall()
        if DEBUG:
            print(rows)
        print(rows)
    except Exception as err:
        if DEBUG:
            sys.err(err)
            return

def quit_ui():
    """
    Quits the program, printing a good bye message to the user.
    """
    print('Good bye!')
    exit()


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

def main():
    """
    Main function for starting things up.
    """
    show_options()

if __name__ == '__main__':
    # make connection a global variable
    conn = get_conn()
    main()