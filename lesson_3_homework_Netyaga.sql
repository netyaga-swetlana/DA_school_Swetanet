схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task1
--Корабли: Для каждого класса определите число кораблей этого класса, потопленных в сражениях. Вывести: класс и число потопленных кораблей.
  SELECT cl.class
  ,count(o.ship)
  FROM classes cl 
  JOIN ships sh ON cl.class=sh.class
  left JOIN Outcomes o ON sh.name=o.ship AND o.RESULT='sunk'
  GROUP BY cl.class
 
--task2
--Корабли: Для каждого класса определите год, когда был спущен на воду первый корабль этого класса. Если год спуска на воду головного корабля неизвестен, определите минимальный год спуска на воду кораблей этого класса. Вывести: класс, год.
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
--Корабли: Для классов, имеющих потери в виде потопленных кораблей и не менее 3 кораблей в базе данных, вывести имя класса и число потопленных кораблей.

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
--Корабли: Найдите названия кораблей, имеющих наибольшее число орудий среди всех кораблей такого же водоизмещения (учесть корабли из таблицы Outcomes).

 select distinct  o.ship 
 from outcomes o 
 join ships s on o.ship=s.name
 join classes c on s.class =c.class and c.numguns = (select max(numguns) from classes where displacement=c.displacement group by displacement)
 
--task5
--Компьютерная фирма: Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker
 select distinct p.maker 
 from product p 
 where p.model in (select distinct model from pc where speed= (select max (speed) from PC where ram =(select min(ram) from pc)))
 and p.maker in (select p.maker from product p join printer pr on p.model=pr.model)