-- Find the number of goals Real Madrid and Barcelona scored against each other, 
-- between 2009 and 2018 where the home team had the higher odds to win:
SELECT SUM(ft_home_goals + ft_away_goals) AS total_goals
FROM games
INNER JOIN odds ON games.game_id = odds.game_id
INNER JOIN teams t1 ON games.home_id = t1.team_id AND t1.team_name = 'Real Madrid'
INNER JOIN teams t2 ON games.away_id = t2.team_id AND t2.team_name = 'Barcelona'
WHERE games.game_date BETWEEN '2009-01-01' AND '2018-12-31'
  AND odds.home_win > odds.away_win
  AND t1.team_id = odds.game_id;


-- The number of goals Real Madrid and Barcelona scored against each other, 
-- between 2009 and 2018 where the away team had the higher odds to win:
SELECT SUM(ft_home_goals + ft_away_goals) AS total_goals
FROM games
INNER JOIN odds ON games.game_id = odds.game_id
INNER JOIN teams t1 ON games.home_id = t1.team_id AND t1.team_name = 'Real Madrid'
INNER JOIN teams t2 ON games.away_id = t2.team_id AND t2.team_name = 'Barcelona'
WHERE games.game_date BETWEEN '2009-01-01' AND '2018-12-31'
  AND odds.away_win > odds.home_win
  AND t2.team_id = odds.game_id;

-- The top 5 highest scoring games between 2009 and 2019:
SELECT games.game_id, games.game_date, 
       CONCAT(t1.team_name, ' vs. ', t2.team_name) AS match, 
       games.ft_home_goals + games.ft_away_goals AS total_goals
FROM games
INNER JOIN teams t1 ON games.home_id = t1.team_id
INNER JOIN teams t2 ON games.away_id = t2.team_id
WHERE games.game_date BETWEEN '2009-01-01' AND '2019-12-31'
ORDER BY total_goals DESC
LIMIT 5;

-- The most underperforming games according to odds 
-- (games that had higher odds for over goals > 2.5):
SELECT games.game_id, games.game_date, 
       CONCAT(t1.team_name, ' vs. ', t2.team_name) AS match, 
       odds.goals_over_2.5, odds.goals_under_2.5, 
       games.ft_home_goals + games.ft_away_goals AS total_goals,
       CASE 
         WHEN games.ft_home_goals + games.ft_away_goals > odds.goals_over_2.5
            THEN 'over'
         WHEN games.ft_home_goals + games.ft_away_goals < odds.goals_under_2.5 
            THEN 'under'
         ELSE 'push'
       END AS bet_result,
       ABS(games.ft_home_goals + games.ft_away_goals - odds.goals_over_2.5) 
            AS over_diff,
       ABS(games.ft_home_goals + games.ft_away_goals - odds.goals_under_2.5) 
            AS under_diff
FROM games 
INNER JOIN odds ON g.game_id = odds.game_id
INNER JOIN teams t1 ON games.home_id = t1.team_id
INNER JOIN teams t2 ON g.away_id = t2.team_id
WHERE g.game_date BETWEEN '2019-01-01' AND '2022-12-31' 
AND o.website_name = 'BetBrain'
ORDER BY GREATEST(over_diff, under_diff) DESC
LIMIT 5;

-- Removing the worst performing team according to average odds from the database
DELETE FROM teams WHERE team_id = 
(SELECT teams.team_id, AVG(odds.home_win) AS avg_home_win, 
        AVG(odds.away_win) AS avg_away_win
FROM teams
LEFT JOIN games ON teams.team_id = games.home_id OR teams.team_id = games.away_id
LEFT JOIN odds ON games.game_id = odds.game_id
WHERE games.game_date BETWEEN '2009-01-01' AND '2019-12-31'
GROUP BY teams.team_id
HAVING AVG(odds.home_win) + AVG(odds.away_win) > 0
ORDER BY (AVG(odds.home_win) + AVG(odds.away_win)) ASC
LIMIT 1);