--task1  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem

select * 
from (select 
         case when t.grade >=8 then t.name 
          end as name
         ,t.grade
          ,t.marks from (select s.*, g.grade 
                         from Students s join grades g on s.Marks between g.Min_Mark and g.Max_Mark
                         )t
         ) m 
  order by m.grade desc, m.name asc, m.marks ASC
  
--task2  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/occupations/problem
select min(Doctor), min(Professor), min(Singer), min(Actor)
from(
  select row_Number()over (Partition by Occupation order by name) as RowNumber,
    case when Occupation='Doctor' then Name end as Doctor,
    case when Occupation='Professor' then Name end as Professor,
    case when Occupation='Singer' then Name end as Singer,
    case when Occupation='Actor' then Name end as Actor
   from OCCUPATIONS )m
  group by RowNumber
  order by Rownumber;
 
  
--task3  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-9/problem
select distinct city 
from station
where 	city not like 'A%' 
	and city not like 'E%' 
	and city not like 'I%' 
	and city not like 'O%' 
	and city not like 'U%'
 
--task4  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-10/problem

select distinct city 
from station
where city not like '%a' 
    and city not like '%e' 
    and city not like '%i' 
    and city not like '%o' 
    and city not like '%u'
    
--task5  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-11/problem
select distinct city 
from station
where (city not like 'A%' 
    and city not like 'E%' 
    and city not like 'I%' 
    and city not like 'O%' 
    and city not like 'U%') or
    (city not like '%a' 
    and city not like '%e' 
    and city not like '%i' 
    and city not like '%o' 
    and city not like '%u')
    
--task6  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-12/problem
select distinct city 
from station
where city not like 'A%' 
    and city not like 'E%' 
    and city not like 'I%' 
    and city not like 'O%' 
    and city not like 'U%'
     and city not like '%a' 
    and city not like '%e' 
    and city not like '%i' 
    and city not like '%o' 
    and city not like '%u'
    
--task7  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/salary-of-employees/problem
select name
from employee
where salary>2000 and months <10
order by employee_id
    
--task8  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem
select * 
from (select 
         case when t.grade >=8 then t.name 
          end as name
         ,t.grade
          ,t.marks from (select s.*, g.grade 
                         from Students s join grades g on s.Marks between g.Min_Mark and g.Max_Mark
                         )t
         ) m 
  order by m.grade desc, m.name asc, m.marks ASC
