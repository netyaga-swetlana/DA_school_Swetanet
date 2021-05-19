---colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1  (lesson7)
-- sqlite3: ������� �������� ������ � �� (sqlite3, project name: task1_7). � ������� table1 �������� 1000 ����� � ���������� ���������� (3 �������, ��� int) �� 0 �� 1000.
-- ����� ��������� ����������� ������������� ���� ���� �������

--task2  (lesson7)
-- oracle: https://leetcode.com/problems/duplicate-emails/
select email
from (select email, count(id) as cnt from person group by email) a
where cnt >1

--task3  (lesson7)
-- oracle: https://leetcode.com/problems/employees-earning-more-than-their-managers/
select employee
from (select e1.id,e1.name as employee, e1.salary, 
e2.name, e2.salary as  salary_m 
from employee e1 
join employee e2 on e1.managerid=e2.id ) a
where salary >salary_m

--task4  (lesson7)
-- oracle: https://leetcode.com/problems/rank-scores/
select score
,dense_rank()over (order by score desc)
from scores

--task5  (lesson7)
-- oracle: https://leetcode.com/problems/combine-two-tables/
select p.FirstName,p.LastName,
       a.City,a.State
from Person p left join Address a on p.PersonID=a.PersonID
