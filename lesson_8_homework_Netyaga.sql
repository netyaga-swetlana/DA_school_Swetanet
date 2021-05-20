--task1  (lesson8)
-- oracle: https://leetcode.com/problems/department-top-three-salaries/
# Write your MySQL query statement below
select  Department, Employee, Salary
from
(select e.name as Employee, e.salary, d.name as Department, 
 dense_rank () over (partition by d.name order by e.salary desc) as nm
from Employee e join Department d on e.departmentid=d.id) a
where nm <=3
order by Department

--task2  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/17

SELECT distinct member_name,status, sum(unit_price * amount) over (partition by member_name) as costs
from FamilyMembers f join Payments p on f.member_id=p.family_member
and p.date BETWEEN'2005-01-01' and '2005-12-31'


--task3  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/13

select name 
from (select DISTINCT  name, count(id) over (partition by name) as cnt 
from passenger ) a
 where cnt >1

--task4  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38

 select  count (*) as count
from Student
where first_name='Anna'

--task5  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/35

select count(classroom) as COUNT 
from schedule
where date ='2019-09-02'

--task6  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38

select  count (*) as count
from Student
where first_name='Anna'

--task7  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/32

select floor(avg(TIMESTAMPDIFF(YEAR , BirthDay, CURDATE()) )) as age
from FamilyMembers 


--task8  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/27

SELECT distinct good_type_name, sum(p.unit_price * p.amount) over (partition by good_type_name) as costs
from  Payments p  join goods g on p.good=g.good_id
join GoodTypes gt on g.type=gt.good_type_id
Where p.date BETWEEN'2005-01-01' and '2005-12-31'

--task9  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/37

select min(TIMESTAMPDIFF(YEAR , BirthDay, CURDATE()) ) as year
from Student

--task10  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/44

select round (max(TIMESTAMPDIFF(YEAR , s.BirthDay, CURDATE()) ),0) as max_year
from Student s join Student_in_class sc on s.id=sc.student
join Class c on c.id=sc.class
and c.name like'10%'

--task11 (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/20

SELECT distinct status, member_name,sum(p.unit_price * p.amount) over (partition by member_name) as costs
from FamilyMembers f 
join Payments p on f.member_id=p.family_member
join goods g on g.good_id=p.good
join GoodTypes gt on gt.good_type_id=g.type
and gt.good_type_name='entertainment'

--task12  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/55

delete from company
where id in (select company 
            From (select company,count (id) as Cnt from Trip group by company)a
            where cnt = (select min (cnt) from (select company,count (id) as Cnt from Trip group by company)a))

--task13  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/45

select distinct classroom
from (SELECT classroom, COUNT(*) over (partition by classroom) as cnt from Schedule) a
WHERE cnt = (select max(cnt) from (SELECT classroom, COUNT(*) over (partition by classroom) as cnt from Schedule) a)

--task14  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/43

select t.last_name
from Subject s join Schedule h on s.id=h.subject
join Teacher t on h.teacher=t.id
where s.name='Physical Culture'
ORDER BY t.last_name

--task15  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/63

select * 
from (SELECT concat(last_name,'.', substring(first_name,1,1),'.',substring(middle_name,1,1),'.') as name
FROM Student)a
order by name
