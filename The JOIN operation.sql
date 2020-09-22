# 1. The first example shows the goal scored by a player with the last name 'Bender'. The * says to list all the columns in the table - a shorter way
#of saying matchid, teamid, player, gtime
#Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'
SELECT matchid,player FROM goal 
WHERE teamid = 'GER';
 
# 2. From the previous query you can see that Lars Bender's scored a goal in game 1012. Now we want to know what teams were playing in that match.
#Notice in the that the column matchid in the goal table corresponds to the id column in the game table. We can look up information
# about game 1012 by finding that row in the game table. Show id, stadium, team1, team2 for just game 1012

SELECT id,stadium,team1,team2
  FROM game where id = 1012;
  
 # 3. Modify it to show the player, teamid, stadium and mdate for every German goal.
 
 select player,mdate,coach from goal 
 join game 
 on matchid = game.id 
 join eteam 
 on teamid = eteam.id;
 
 # 4. Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
 
select x.team1,x.team2,y.player 
from goal as y 
join game as x 
on x.id = y.matchid 
where y.player like 'Mario%'

# 6.List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.

select mdate,teamname from game join eteam 
on team1 = eteam.id 
where team1 in 
(select id from eteam where coach = 'Fernando Santos')

#7. List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'

select player from goal join game 
on matchid = id 
where stadium = 'National Stadium, Warsaw'

# 8.show the name of all players who scored a goal against Germany.

select distinct player from goal join game 
on goal.matchid = game.id 
where teamid != 'GER' 
and (team1 = 'GER' or team2 = 'GER')

# 9. Show teamname and the total number of goals scored.

select teamname,count(teamid) from goal join eteam 
on teamid = id 
group by teamid,teamname 
order by teamname

# 10. Show the stadium and the number of goals scored in each stadium.
select stadium,count(matchid) from game join goal 
on game.id = goal.matchid 
group by stadium

# 11. For every match involving 'POL', show the matchid, date and the number of goals scored.

select matchid,G.mdate,count(matchid) 
from goal 
join (select *from game where team1 = 'POL' or team2 = 'POL' ) as G 
on matchid = G.id 
group by matchid

# 12. List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises.
#mdate	team1	score1	team2	score2
#1 July 2012	ESP	4	ITA	0
#10 June 2012	ESP	1	ITA	1
#10 June 2012	IRL	1	CRO	3
#...
#Notice in the query given every goal is listed. If it was a team1 goal then a 1 appears in score1, otherwise there is a 0. You could SUM this column to get a count of the #goals scored by team1. Sort your result by mdate, matchid, team1 and team2.

select mdate,team1,
sum(case when team1 = teamid then 1 else 0 end) score1, team2,
sum(case when team2 = teamid then 1 else 0 end) score2 
from game left join goal 
on id = matchid 
group by id,mdate,team1,team2 
order by mdate,matchid,team1,team2
 

