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

Bets 
Odds
Games
Teams
Client
Bet_types






FUNCTIONS AND PROCEDURES
We expect to return the following and so will implement functions that do so:
Return the earnings a person has accumulated (total_earnings)
Return the earnings from a single bet (get_payout)
Return all the bets a client has made (show_client_history)
Returns games specific to teams before a given date(show_team_history)
Returns all the goals in a given time period(get_goals)
Returns all the odds for a given team or game (get_odds)

We expect to make the following and so will implement procedures that do so:
Keep track of the clients in our database ( add_client(client_id, is_admin, username, password))
Keep track of bets in our database ( add_new_bet(bet_id, game_id, client_id, bet_type, amount_placed, is_correct))
Keep track of games and their odds (add_game())
Teams come and go and we would want to keep track of that(update_teams())




EXPECTED UI 



ROADBLOCKS




STRETCH GOALS 
Changing the DDL to make the data season-specific 
