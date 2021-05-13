����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task13 (lesson3)
--������������ �����: ������� ������ ���� ��������� � ������������� � ��������� ���� �������� (pc, printer, laptop). �������: model, maker, type
select p.model, p.maker, p.type
from product p join printer p1 on p.model=p1.model
union all 
select p.model, p.maker, p.type
from product p join laptop p1 on p.model=p1.model 
union all 
select p.model, p.maker,  p.type
from product p join PC p1 on p.model=p1.model


--task14 (lesson3)
--������������ �����: ��� ������ ���� �������� �� ������� printer ������������� ������� ��� ���, � ���� ���� ����� ������� PC - "1", � ��������� - "0"
 select *
 ,case when price >(select avg(price) from PC) 
       then 1
       else 0
  end as flag 
 from printer
--task15 (lesson3)
--�������: ������� ������ ��������, � ������� class ����������� (IS NULL)
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
--�������: ������� ��������, ������� ��������� � ����, �� ����������� �� � ����� �� ����� ������ �������� �� ����.
select *
from battles
where date_part('year' ,date) not in (select launched  from ships )
--task17 (lesson3)
--�������: ������� ��������, � ������� ����������� ������� ������ Kongo �� ������� Ships.
select battle
from outcomes 
where ship in (select name from ships where class='Kongo')
--task1  (lesson4)
-- ������������ �����: ������� view (�������� all_products_flag_300) ��� ���� ������� (pc, printer, laptop) � ������, ���� ��������� ������ > 300. �� view ��� �������: model, price, flag
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
-- ������������ �����: ������� view (�������� all_products_flag_avg_price) ��� ���� ������� (pc, printer, laptop) � ������, ���� ��������� ������ c������ . �� view ��� �������: model, price, flag

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
-- ������������ �����: ������� ��� �������� ������������� = 'A' �� ���������� ���� ������� �� ��������� ������������� = 'D' � 'C'. ������� model

with  all_printer as 
(select p.model,p.price,pr.maker 
from printer p join product pr on p.model=pr.model )

select model
from all_printer
where maker='A'
and price >(select avg(price) from all_printer where maker in ('D','C'))

--task4 (lesson4)
-- ������������ �����: ������� ��� ������ ������������� = 'A' �� ���������� ���� ������� �� ��������� ������������� = 'D' � 'C'. ������� model
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
-- ������������ �����: ����� ������� ���� ����� ���������� ��������� ������������� = 'A' (printer & laptop & pc)
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
-- ������������ �����: ������� view � ����������� ������� (�������� count_products_by_makers) �� ������� �������������. �� view: maker, count
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
-- �� ����������� view (count_products_by_makers) ������� ������ � colab (X: maker, y: count)
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
-- ������������ �����: ������� ����� ������� printer (�������� printer_updated) � ������� �� ��� ��� �������� ������������� 'D'
create table printer_updated
as
select * 
from printer 
where model not in (select model from product where maker='D')
--task9 (lesson4)
-- ������������ �����: ������� �� ���� ������� (printer_updated) view � �������������� �������� ������������� (�������� printer_updated_with_makers)
create view printer_updated_with_makers
as
select p.*
,pr.maker
from  printer_updated p 
join product pr on p.model=pr.model 

select * from printer_updated_with_makers
--task10 (lesson4)
-- �������: ������� view c ����������� ����������� �������� � ������� ������� (�������� sunk_ships_by_classes). �� view: count, class (���� �������� ������ ���/IS NULL, �� �������� �� 0)
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
-- �������: �� ����������� view (sunk_ships_by_classes) ������� ������ � colab (X: class, Y: count)
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
-- �������: ������� ����� ������� classes (�������� classes_with_flag) � �������� � ��� flag: ���� ���������� ������ ������ ��� ����� 9 - �� 1, ����� 0
create table classes_with_flag
as
select *
,case when numguns >=9 
      then 1
      else 0
  end as flag
from classes 

--task13 (lesson4)
-- �������: ������� ������ � colab �� ������� classes � ����������� ������� �� ������� (X: country, Y: count)
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
-- �������: ������� ���������� ��������, � ������� �������� ���������� � ����� "O" ��� "M".

select count(name)
from ships 
where name like 'O%' or name like 'M%'

--task15 (lesson4)
-- �������: ������� ���������� ��������, � ������� �������� ������� �� ���� ����.

select count(name)
from ships 
where name like '% %'

--task16 (lesson4)
-- �������: ��������� ������ � ����������� ���������� �� ���� �������� � ����� ������� (X: year, Y: count)
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