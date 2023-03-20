README

STUDENT NAMES 
Leo Afriyie-Buabeng,    Rachel Shi

STUDENT EMAILS
lafriyie@caltech.edu,   rshi@caltech.edu

INTRODUCTION
The goal of this project is to create an app where users will be able to look 
at historical soccer data to make an informed bet and allowing them to make said bet. 
When making bets on soccer, the most common bets placed are the winners of the games and the number of goals scored in said game. 

We decided to use data from the top-flight division of Spain, La Liga. 
This is considered one of the best leagues in recent soccer history because it 
featured both Lionel Messi and Cristiano Ronaldo at the same time in their primes.

We also wanted to have a an admin-client based app where admin can manage account creation by clients while managing datasets. 

SOURCE
We took our data from the site : https://www.football-data.co.uk/spainm.php. 

LOADING DATA FROM THE COMMAND LINE
The data should be loaded in the following order:
* This assumes one has mysql already installed and opened and in the same directory as the stored files. 

        mysql> DROP DATABASE IF EXISTS soccerdb;
        mysql> CREATE DATABASE soccerdb;
        mysql> USE soccerdb; 
        mysql> source setup.sql;
        mysql> source load-data.sql;
        mysql> source setup-passwords.sql;
        mysql> source setup-routines.sql;
        mysql> source grant-permissions.sql;
        mysql> source queries.sql;


INSTRUCTIONS FOR PYTHON PROGRAM 
Please install the Python MySQL Connector using pip3 if not installed already.

After loading the data and verifying you are in the correct database, 
run the following to open the python application:

mysql> quit;

$ python3 app_client.py

OR

$ python3 app_admin.py

Please log in with the following user/passwords:

For app_client.py, the following customers are registered:
    USER | PASSWORD
    mfreeman | mfreemanpw
    cpratt | cprattpw
    wferrell | wferrellpw
    ebanks | ebankspw
    warnett | warnettpw

For app_admin.py, the following admins are registered:
    USER | PASSWORD
    lorem | ipsum
    tired | student 

Here is a suggested guide to using app_client.py:
    1.  Select option [a] to learn more about some products.
    2. Remember a product ID you want to buy!
    3. Select option [b] to purchase that item.
    4. Remember your purchase ID.
    5. Select option [d] to write a review using your purchase ID.
    6. Select option [c] to request a product.

Here is a suggested guide to using app_admin.py:
    1. Select option [a] to see which requests are unfulfilled.
    2. Remember a request ID you want to fulfill.
    3. Select option [b] to fulfill that request.
    4. Select option [c] to see how much money you've made!

Files written to user's system:
- No files are written to the user's system.


USER INTERFACE 

NAVIGATIONAL STRUCTURE

Key:
(1) | (#) -- option into deeper level
(B) | (X) -- option up one level
(*)       -- jump to specified level
(_)       -- user data entry

Layers:
 0   1   2   3   4   5
 |   |   |   |   |   |
(1) Login    |   |   |
    (_) Username |   |
    (_) Password |   |
    (0) Admin tools  |
        (1) Superuser account
            (#) Choose user
                (*) Return to layer 1 as admin'd user
        (2) Modify user
            (1) Add user
                (_) New username
                (_) New password
                (_) Admin status
            (2) Remove user
            (3) Change privileges
            (B) Back
        (3) Export logs
            (_) Export filename target
        (B) Back
    (1) Log existing activity
        (#) Choose category
            (#) Choose activity
                (#) Choose time format
                (B) Back
            (B) Back
        (B) Back
    (2) View logged data
        (1) ??
    (3) View reports
        (1) Sleep statistics
            (1) Bedtime
            (2) Wake time
            (3) Sleep duration
            (4) Sleep goals
            (B) Back
        (2) Activity tracking
            (1) Specific activity
                (#) Choose activity
                    (1) Dates of interest
                    (2) Averages
                    (3) Goals
                    (B) Back
                (B) Back
            (2) Category aggregates
                (#) Choose category
                    (1) Dates of interest
                    (2) Averages
                    (B) Back
                (B) Back
            (B) Back
        (B) Back
    (4) View logging options
    (5) Add new activity
        (#) Choose category
            (_) Activity name
            (_) Logging symbol
            (_) Optional description
            (_) Optional goal time
            (*) Return to layer 1 as same user
    (X) Logout
(X) Exit


DATA CLEANING AND PROJECT SCOPING
The original data contained the following columns with the explained keys:

Div = League Division
Date = Match Date (dd/mm/yy)
Time = Time of match kick off
HomeTeam = Home Team
AwayTeam = Away Team
FTHG and HG = Full Time Home Team Goals
FTAG and AG = Full Time Away Team Goals
FTR and Res = Full Time Result (H=Home Win, D=Draw, A=Away Win)
HTHG = Half Time Home Team Goals
HTAG = Half Time Away Team Goals
HTR = Half Time Result (H=Home Win, D=Draw, A=Away Win)

Attendance = Crowd Attendance
Referee = Match Referee
HS = Home Team Shots
AS = Away Team Shots
HST = Home Team Shots on Target
AST = Away Team Shots on Target
HHW = Home Team Hit Woodwork
AHW = Away Team Hit Woodwork
HC = Home Team Corners
AC = Away Team Corners
HF = Home Team Fouls Committed
AF = Away Team Fouls Committed
HFKC = Home Team Free Kicks Conceded
AFKC = Away Team Free Kicks Conceded
HO = Home Team Offsides
AO = Away Team Offsides
HY = Home Team Yellow Cards
AY = Away Team Yellow Cards
HR = Home Team Red Cards
AR = Away Team Red Cards
HBP = Home Team Bookings Points (10 = yellow, 25 = red)
ABP = Away Team Bookings Points (10 = yellow, 25 = red)

B365H = Bet365 home win odds
B365D = Bet365 draw odds
B365A = Bet365 away win odds
BSH = Blue Square home win odds
BSD = Blue Square draw odds
BSA = Blue Square away win odds
BWH = Bet&Win home win odds
BWD = Bet&Win draw odds
BWA = Bet&Win away win odds
GBH = Gamebookers home win odds
GBD = Gamebookers draw odds
GBA = Gamebookers away win odds
IWH = Interwetten home win odds
IWD = Interwetten draw odds
IWA = Interwetten away win odds
LBH = Ladbrokes home win odds
LBD = Ladbrokes draw odds
LBA = Ladbrokes away win odds
PSH and PH = Pinnacle home win odds
PSD and PD = Pinnacle draw odds
PSA and PA = Pinnacle away win odds
SOH = Sporting Odds home win odds
SOD = Sporting Odds draw odds
SOA = Sporting Odds away win odds
SBH = Sportingbet home win odds
SBD = Sportingbet draw odds
SBA = Sportingbet away win odds
SJH = Stan James home win odds
SJD = Stan James draw odds
SJA = Stan James away win odds
SYH = Stanleybet home win odds
SYD = Stanleybet draw odds
SYA = Stanleybet away win odds
VCH = VC Bet home win odds
VCD = VC Bet draw odds
VCA = VC Bet away win odds
WHH = William Hill home win odds
WHD = William Hill draw odds
WHA = William Hill away win odds

Bb1X2 = Number of BetBrain bookmakers used to calculate match odds averages and maximums
BbMxH = Betbrain maximum home win odds
BbAvH = Betbrain average home win odds
BbMxD = Betbrain maximum draw odds
BbAvD = Betbrain average draw win odds
BbMxA = Betbrain maximum away win odds
BbAvA = Betbrain average away win odds

MaxH = Market maximum home win odds
MaxD = Market maximum draw win odds
MaxA = Market maximum away win odds
AvgH = Market average home win odds
AvgD = Market average draw win odds
AvgA = Market average away win odds

BbOU = Number of BetBrain bookmakers used to calculate over/under 2.5 goals (total goals) averages and maximums
BbMx>2.5 = Betbrain maximum over 2.5 goals
BbAv>2.5 = Betbrain average over 2.5 goals
BbMx<2.5 = Betbrain maximum under 2.5 goals
BbAv<2.5 = Betbrain average under 2.5 goals

GB>2.5 = Gamebookers over 2.5 goals
GB<2.5 = Gamebookers under 2.5 goals
B365>2.5 = Bet365 over 2.5 goals
B365<2.5 = Bet365 under 2.5 goals
P>2.5 = Pinnacle over 2.5 goals
P<2.5 = Pinnacle under 2.5 goals
Max>2.5 = Market maximum over 2.5 goals
Max<2.5 = Market maximum under 2.5 goals
Avg>2.5 = Market average over 2.5 goals
Avg<2.5 = Market average under 2.5 goals

BbAH = Number of BetBrain bookmakers used to Asian handicap averages and maximums
BbAHh = Betbrain size of handicap (home team)
AHh = Market size of handicap (home team) (since 2019/2020)
BbMxAHH = Betbrain maximum Asian handicap home team odds
BbAvAHH = Betbrain average Asian handicap home team odds
BbMxAHA = Betbrain maximum Asian handicap away team odds
BbAvAHA = Betbrain average Asian handicap away team odds

GBAHH = Gamebookers Asian handicap home team odds
GBAHA = Gamebookers Asian handicap away team odds
GBAH = Gamebookers size of handicap (home team)
LBAHH = Ladbrokes Asian handicap home team odds
LBAHA = Ladbrokes Asian handicap away team odds
LBAH = Ladbrokes size of handicap (home team)
B365AHH = Bet365 Asian handicap home team odds
B365AHA = Bet365 Asian handicap away team odds
B365AH = Bet365 size of handicap (home team)
PAHH = Pinnacle Asian handicap home team odds
PAHA = Pinnacle Asian handicap away team odds
MaxAHH = Market maximum Asian handicap home team odds
MaxAHA = Market maximum Asian handicap away team odds	
AvgAHH = Market average Asian handicap home team odds
AvgAHA = Market average Asian handicap away team odds


Considering the scope of this project, the data source was limited to the 2010s
decade. This was a good idea since the pandemic had a serious ripple effect
over sports and we did not want to include this in our data. 

In cleaning our data, we:
* Took out all columns that could be derived by simple functions and procedures.
* Already implied data: We already know it is only the top flight so no division column.
* 'Redundant' Data was removed
* Stuck to one source that was present for all the years: Betbrain
* Used BetBrain's average odds instead of the market maximum and minimums
* Took out the Asian Handicap because we do not need that much scope for now.


We reduced our input data to: 

Date = Match Date (dd/mm/yy)
Time = Time of match kick off
HomeTeam = Home Team
AwayTeam = Away Team
FTHG = Full Time Home Team Goals
FTAG = Full Time Away Team Goals
HTHG = Half Time Home Team Goals
HTAG = Half Time Away Team Goals
HS = Home Team Shots
AS = Away Team Shots
HST = Home Team Shots on Target
AST = Away Team Shots on Target
HHW = Home Team Hit Woodwork
AHW = Away Team Hit Woodwork
HC = Home Team Corners
AC = Away Team Corners
HF = Home Team Fouls Committed
AF = Away Team Fouls Committed
HO = Home Team Offsides
AO = Away Team Offsides
HY = Home Team Yellow Cards
AY = Away Team Yellow Cards
HR = Home Team Red Cards
AR = Away Team Red Cards

BbAvH = Betbrain average home win odds
BbAvD = Betbrain average draw odds
BbAvA = Betbrain average away win odds

BbAv>2.5 = Betbrain average over 2.5 goals
BbAv<2.5 = Betbrain average under 2.5 goals

We also condensed 10 CSV files into 3: games, odds and teams which can be loaded
using our load-soccer.sql file, including database creation. 



DDL CREATION
We created 6 tables to effectively handle all necessary functions and procedures
as well as storing the necessary information we needed. The tables we created are as follows:

bets 
odds
games
teams
client
bet_types



FUNCTIONS AND PROCEDURES
We expect to return the following and so will implement functions that do so:
* Return the earnings a person has accumulated (total_earnings)
* Return the earnings from a single bet (get_payout)
* Return all the bets a client has made (show_client_history)
* Returns games specific to teams before a given date(show_team_history)
* Returns all the goals in a given time period(get_goals)
* Returns all the odds for a given team or game (get_odds)

We expect to make the following and so will implement procedures that do so:
* Keep track of the clients in our database ( add_client(client_id, is_admin, username, password))
* Keep track of bets in our database ( add_new_bet(bet_id, game_id, client_id, bet_type, amount_placed, is_correct))
* Keep track of games and their odds (add_game())
* Teams come and go and we would want to keep track of that(update_teams())



ROADBLOCKS
* We had some difficulties with the ER-Diagrams in Part A since one of our tables had two IDs that were both foreign keys referencing the same primary key in another table. This was something that we didn’t encounter in Assignment 6 and caused us a lot of confusion when we initially tried to design our ER-Diagrams. We ended up having to ask about it during office hours, and changed the ER Diagrams based on El’s suggestions.
We wrote our DDL before doing the functional dependency analysis in Part C and we wanted to change our DDL based on the analysis in Part C. However, this involved a lot of rethinking the check constraints we had as well as rewriting to allow NULL in a bunch of the attributes in different tables, which was a much larger change than we originally thought.

* We tried to write a query for -- The most underperforming games according to odds 
games that had higher odds for over goals > 2.5 for our final query:


SELECT games.game_id, games.game_date, 
       t1.team_name || vs ||t2.team_name AS match, 
       odds.goals_over_2_5, odds.goals_under_2_5, 
       games.ft_home_goals + games.ft_away_goals AS total_goals,
       CASE 
         WHEN games.ft_home_goals + games.ft_away_goals > odds.goals_over_2_5
            THEN 'over'
         WHEN games.ft_home_goals + games.ft_away_goals < odds.goals_under_2_5 
            THEN 'under'
         ELSE 'push'
       END AS bet_result,
       ABS(games.ft_home_goals + games.ft_away_goals - odds.goals_over_2_5) 
            AS over_diff,
       ABS(games.ft_home_goals + games.ft_away_goals - odds.goals_under_2_5) 
            AS under_diff
FROM games 
INNER JOIN odds ON games.game_id = odds.game_id
INNER JOIN teams t1 ON games.home_id = t1.team_id
INNER JOIN teams t2 ON games.away_id = t2.team_id
WHERE games.game_date BETWEEN '2019-01-01' AND '2022-12-31' 
AND odds.website_name = 'BetBrain'
ORDER BY GREATEST(over_diff, under_diff) DESC
LIMIT 5;


STRETCH GOALS FOR FUTURE IMPROVEMENT 
Changing the DDL to make the data season-specific 
Adding more league stats from leagues all over the world (only have la liga)
Adding stats from international games (friendlies and tournaments)
Adding player-specific data
Adding more betting data from more sites
Providing simulations for players who want to experience betting without using their own money. 

