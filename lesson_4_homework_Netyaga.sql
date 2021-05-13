схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task13 (lesson3)
--Компьютерная фирма: Вывести список всех продуктов и производителя с указанием типа продукта (pc, printer, laptop). Вывести: model, maker, type
select p.model, p.maker, p.type
from product p join printer p1 on p.model=p1.model
union all 
select p.model, p.maker, p.type
from product p join laptop p1 on p.model=p1.model 
union all 
select p.model, p.maker,  p.type
from product p join PC p1 on p.model=p1.model


--task14 (lesson3)
--Компьютерная фирма: При выводе всех значений из таблицы printer дополнительно вывести для тех, у кого цена вышей средней PC - "1", у остальных - "0"
 select *
 ,case when price >(select avg(price) from PC) 
       then 1
       else 0
  end as flag 
 from printer
--task15 (lesson3)
--Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL)
select name
from ships
where class is null

select *
from ships 
where class not in (select class from classes)

select a.name 
from (select *
      from ships s left join classes c on s.class=c.class) a
where a.type is null 


--task16 (lesson3)
--Корабли: Укажите сражения, которые произошли в годы, не совпадающие ни с одним из годов спуска кораблей на воду.
select *
from battles
where date_part('year' ,date) not in (select launched  from ships )
--task17 (lesson3)
--Корабли: Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships.
select battle
from outcomes 
where ship in (select name from ships where class='Kongo')
--task1  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_300) для всех товаров (pc, printer, laptop) с флагом, если стоимость больше > 300. Во view три колонки: model, price, flag
create view all_products_flag_300
as
select *
,case when t.price >300
      then 1
 end as flag
from
	(select model, price from printer
	union all 
	select model, price from laptop 
	union all 
	select model, price from pc )t
	
	
select * from all_products_flag_300
--task2  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_avg_price) для всех товаров (pc, printer, laptop) с флагом, если стоимость больше cредней . Во view три колонки: model, price, flag

create view all_products_flag_avg_price
as
select *
,case when t.price > (select avg(t.price) from (select model, price from printer
											union all 
											select model, price from laptop 
											union all 
											select model, price from pc )t)
      then 1
 end as flag
from (select model, price from printer
		union all 
		select model, price from laptop 
		union all 
		select model, price from pc ) t
	
	
select * from all_products_flag_avg_price
--task3  (lesson4)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'. Вывести model

with  all_printer as 
(select p.model,p.price,pr.maker 
from printer p join product pr on p.model=pr.model )

select model
from all_printer
where maker='A'
and price >(select avg(price) from all_printer where maker in ('D','C'))

--task4 (lesson4)
-- Компьютерная фирма: Вывести все товары производителя = 'A' со стоимостью выше средней по принтерам производителя = 'D' и 'C'. Вывести model
with  all_product as 
(select p.model,p.price,pr.maker, pr.type 
from printer p join product pr on p.model=pr.model 
union all
select p.model,p.price,pr.maker, pr.type 
from laptop p join product pr on p.model=pr.model 
union all
select p.model,p.price,pr.maker, pr.type  
from pc p join product pr on p.model=pr.model )

select model
from all_product
where maker='A'
and price >(select avg(price) from all_product where maker in ('D','C') and type='Printer')

--task5 (lesson4)
-- Компьютерная фирма: Какая средняя цена среди уникальных продуктов производителя = 'A' (printer & laptop & pc)
with  all_product as 
(select p.model,p.price,pr.maker, pr.type 
from printer p join product pr on p.model=pr.model 
union
select p.model,p.price,pr.maker, pr.type 
from laptop p join product pr on p.model=pr.model 
union
select p.model,p.price,pr.maker, pr.type  
from pc p join product pr on p.model=pr.model )

select avg(price)
from all_product
where maker='A'

--task6 (lesson4)
-- Компьютерная фирма: Сделать view с количеством товаров (название count_products_by_makers) по каждому производителю. Во view: maker, count
create view count_products_by_makers
as
select  t.maker
,count(t.maker) as count 
from 
(select p.model,p.price,pr.maker, pr.type 
from printer p join product pr on p.model=pr.model 
union all
select p.model,p.price,pr.maker, pr.type 
from laptop p join product pr on p.model=pr.model 
union all
select p.model,p.price,pr.maker, pr.type  
from pc p join product pr on p.model=pr.model ) t
group by t.maker

select * from count_products_by_makers
--task7 (lesson4)
-- По предыдущему view (count_products_by_makers) сделать график в colab (X: maker, y: count)
/***request = """
select count as cnt
,maker 
from count_products_by_makers
order by cnt

"""
df= pd.read_sql_query(request, conn)
fig = px.bar(x=df.maker.to_list(), y=df.cnt.to_list(), labels={'x':'maker', 'y':'count'})
fig.show()***/

--task8 (lesson4)
-- Компьютерная фирма: Сделать копию таблицы printer (название printer_updated) и удалить из нее все принтеры производителя 'D'
create table printer_updated
as
select * 
from printer 
where model not in (select model from product where maker='D')
--task9 (lesson4)
-- Компьютерная фирма: Сделать на базе таблицы (printer_updated) view с дополнительной колонкой производителя (название printer_updated_with_makers)
create view printer_updated_with_makers
as
select p.*
,pr.maker
from  printer_updated p 
join product pr on p.model=pr.model 

select * from printer_updated_with_makers
--task10 (lesson4)
-- Корабли: Сделать view c количеством потопленных кораблей и классом корабля (название sunk_ships_by_classes). Во view: count, class (если значения класса нет/IS NULL, то заменить на 0)
create view sunk_ships_by_class
as
select count(t.ship) as count
,case when t.class is null 
      then 'O'
      else t.class
 end as class
from 	(select o.*
		,c.class
		from outcomes o
		left join ships s on o.ship=s.name
		left join classes c on s.class=c.class
		where result ='sunk')t
 group by t.class

--task11 (lesson4)
-- Корабли: По предыдущему view (sunk_ships_by_classes) сделать график в colab (X: class, Y: count)
/***  #join
request = """
select count as cnt
,class as cls
from sunk_ships_by_class

"""
df= pd.read_sql_query(request, conn)
fig = px.bar(x=df.cls.to_list(), y=df.cnt.to_list(), labels={'x':'class', 'y':'count'})
fig.show() ***/
 
--task12 (lesson4)
-- Корабли: Сделать копию таблицы classes (название classes_with_flag) и добавить в нее flag: если количество орудий больше или равно 9 - то 1, иначе 0
create table classes_with_flag
as
select *
,case when numguns >=9 
      then 1
      else 0
  end as flag
from classes 

--task13 (lesson4)
-- Корабли: Сделать график в colab по таблице classes с количеством классов по странам (X: country, Y: count)
/***
#join
request = """
select count(class) as cnt
,country
from classes 
group by country 

"""
df= pd.read_sql_query(request, conn)
fig = px.bar(x=df.country.to_list(), y=df.cnt.to_list(), labels={'x':'country', 'y':'count'})
fig.show()
***/

--task14 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название начинается с буквы "O" или "M".

select count(name)
from ships 
where name like 'O%' or name like 'M%'

--task15 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название состоит из двух слов.

select count(name)
from ships 
where name like '% %'

--task16 (lesson4)
-- Корабли: Построить график с количеством запущенных на воду кораблей и годом запуска (X: year, Y: count)
/***
#join
request = """
select count (name) as cnt
,launched as year
from ships
group by launched
order by launched 

"""
df= pd.read_sql_query(request, conn)
fig = px.bar(x=df.year.to_list(), y=df.cnt.to_list(), labels={'x':'year', 'y':'count'})
fig.show()
***/