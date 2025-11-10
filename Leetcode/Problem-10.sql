/* 
Write an SQL Query to find the winner in each group .
the winner in each group is the player who scored the maximum total points
within the group in the case of tie, the lowest player_id wins.
*/


select *  from matches

select * from  players

With CTE as 
(
select first_player as Player, sum(first_score) as Score
from matches
group by first_player
union all 
select second_player as Player, sum(second_score) as Score 
from matches
group by second_player
),
Score_card as
(
select C.Player, P.group_id ,sum(C.Score) Score
from CTE C
inner join players P
on C.Player = P.player_id
group by C.Player, P.group_id
),
decision_taking as
(
select *,
dense_rank() over (partition by group_id order by Score desc, Player asc) as rn
from Score_card
)
select * from decision_taking
where rn = 1

