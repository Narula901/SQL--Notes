
create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

select * from icc_world_cup

/*
Write a query to produce the output from icc_world_cup table.
team_name, no_of_matches_played , no_of_wins , no_of_losses
*/
with CTE as 
(
select Team_1 as Team
from icc_world_cup
union all
select Team_2 as Team
from icc_world_cup 
),
CTE_1 as
(
select Team, count(*) as Total_matches_played
from CTE
group by Team
),
CTE_2 as
(
select winner, count(1) as No_of_Wins 
from icc_world_cup
group by winner
),
CTE_3 as
(
select C1.Team, C2.winner, Total_matches_played, No_of_Wins
from CTE_1 C1 
full outer join CTE_2 C2
on C1.Team = C2.winner
),
CTE_4 as
(
select Team,Total_matches_played,
case when No_of_Wins is null then 0 
else No_of_Wins 
end No_of_Wins
from CTE_3
)
select *,(Total_matches_played - No_of_Wins) No_of_Loss
from CTE_4



-----Same Process as i used earlier but a compact one


with CTE as
(
select Team_1, count(*) as cnt
from icc_world_cup
group by Team_1
union all
select Team_2, count(*) as cnt
from icc_world_cup
group by Team_2
),
Total_Matches_Played as
(
select Team_1 as Team, sum(cnt) as Total_Matches_Played 
from CTE
group by Team_1
),
Win_Count as
(
select Winner, count(*) win_cnt 
from icc_world_cup
group by Winner
)
select T.Team, T.Total_Matches_Played, COALESCE(W.win_cnt,0) No_of_win,
COALESCE((T.Total_Matches_Played-W.win_cnt),T.Total_Matches_Played) No_of_losses
from Total_Matches_Played T
left outer Join Win_Count W
on T.Team = W.Winner









