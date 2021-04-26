����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task1
--�������: ��� ������� ������ ���������� ����� �������� ����� ������, ����������� � ���������. �������: ����� � ����� ����������� ��������.
  SELECT cl.class
  ,count(o.ship)
  FROM classes cl 
  JOIN ships sh ON cl.class=sh.class
  left JOIN Outcomes o ON sh.name=o.ship AND o.RESULT='sunk'
  GROUP BY cl.class
 
--task2
--�������: ��� ������� ������ ���������� ���, ����� ��� ������ �� ���� ������ ������� ����� ������. ���� ��� ������ �� ���� ��������� ������� ����������, ���������� ����������� ��� ������ �� ���� �������� ����� ������. �������: �����, ���.
 select t.* 
 from (
  SELECT cl.class
  ,sh.launched 
  FROM classes cl 
  JOIN ships sh ON cl.class=sh.class
  where sh.class=sh.name 
  union 
  SELECT cl.class
  ,min (sh.launched)
  FROM classes cl 
  JOIN ships sh ON cl.class=sh.class
  where cl.class not in (select name from ships)
  group by cl.class
  ) t
  
--task3
--�������: ��� �������, ������� ������ � ���� ����������� �������� � �� ����� 3 �������� � ���� ������, ������� ��� ������ � ����� ����������� ��������.

 select c.class
 ,c.ship_all
 ,l.Ship_sunk
 from ( SELECT cl.class
		  ,count(sh.name) as ship_all
		  FROM classes cl 
		  JOIN ships sh ON cl.class=sh.class
		  GROUP BY cl.class) c
 join (SELECT cl.class
	  ,count(o.ship) as Ship_sunk
	  FROM classes cl 
	  JOIN ships sh ON cl.class=sh.class
	  JOIN Outcomes o ON sh.name=o.ship AND o.RESULT='sunk'
	  GROUP BY cl.class) l
 on c.class=l.class
 
 
--task4
--�������: ������� �������� ��������, ������� ���������� ����� ������ ����� ���� �������� ������ �� ������������� (������ ������� �� ������� Outcomes).

 select distinct  o.ship 
 from outcomes o 
 join ships s on o.ship=s.name
 join classes c on s.class =c.class and c.numguns = (select max(numguns) from classes where displacement=c.displacement group by displacement)
 
--task5
--������������ �����: ������� �������������� ���������, ������� ���������� �� � ���������� ������� RAM � � ����� ������� ����������� ����� ���� ��, ������� ���������� ����� RAM. �������: Maker
 select distinct p.maker 
 from product p 
 where p.model in (select distinct model from pc where speed= (select max (speed) from PC where ram =(select min(ram) from pc)))
 and p.maker in (select p.maker from product p join printer pr on p.model=pr.model)