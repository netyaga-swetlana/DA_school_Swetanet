--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1 (lesson5)
-- ������������ �����: ������� view (pages_all_products), � ������� ����� ������������ �������� ���� ��������� (�� ����� ���� ��������� �� ����� ��������). �����: ��� ������ �� laptop, ����� ��������, ������ ���� �������
		 select max (nm)/2
		 from (
		 select code, type, maker, price, model
		,row_number () over (order by code desc) as nm
		from (
		select p1.code, p1. price, p.type, p.maker, p.model
		from product p join pc p1 on p.model=p1.model 
		union all
		select p1.code, p1. price, p.type, p.maker, p.model
		from product p join printer p1 on p.model=p1.model 
		union all
		select p1.code, p1. price, p.type, p.maker, p.model
		from product p join laptop p1 on p.model=p1.model ) b
		) a
		
create view pages_all_products
as
SELECT model, maker, price, type
        ,NTILE(12) over (order by type) as page
 FROM (
		select p1.code, p1. price, p.type, p.maker, p.model
		from product p join pc p1 on p.model=p1.model 
		union all
		select p1.code, p1. price, p.type, p.maker, p.model
		from product p join printer p1 on p.model=p1.model 
		union all
		select p1.code, p1. price, p.type, p.maker, p.model
		from product p join laptop p1 on p.model=p1.model ) b

   
	
--task2 (lesson5)
-- ������������ �����: ������� view (distribution_by_type), � ������ �������� ����� ���������� ����������� ���� ������� �� ���� ����������. �����: �������������,
   
create view distribution_by_type
as
select a.maker, a.type 
,a.count_type*100 /sum (a.count_type) over (order by maker) as proc
from (
select *, count(*) over (partition by type, maker )  as count_type 
, count (*) over (partition by maker) as count_maker
from (
select p1.code, p1. price, p.type, p.maker, p.model
from product p join pc p1 on p.model=p1.model 
union all
select p1.code, p1. price, p.type, p.maker, p.model
from product p join printer p1 on p.model=p1.model 
union all
select p1.code, p1. price, p.type, p.maker, p.model
from product p join laptop p1 on p.model=p1.model ) b
) a
group by a.maker, a.type ,a.count_type

--task3 (lesson5)
-- ������������ �����: ������� �� ���� ����������� view ������ - �������� ���������
/***
  #join
request = """
select maker
,type as tp
,proc
from  distribution_by_type


"""
df=pd.read_sql_query(request, conn)
fig = px.pie(df, values=df.proc.to_list(), names=df.tp.to_list(), title='distribution_by_type ')
fig.show()

 ***/

--task4 (lesson5)
-- �������: ������� ����� ������� ships (ships_two_words), �� � �������� ������� ������ �������� �� ���� ����
create table ships_two_words
as
select *
from ships 
where name like '% %'
--task5 (lesson5)
-- �������: ������� ������ ��������, � ������� class ����������� (IS NULL) � �������� ���������� � ����� "S"

SELECT name 
FROM ships
where class is null 
and name like 'S%'

--task6 (lesson5)
-- ������������ �����: ������� ��� �������� ������������� = 'A' �� ���������� ���� ������� �� ��������� ������������� = 'C' � ��� ����� ������� (����� ������� �������). ������� model
select a.model
from (select *, row_number(*) over(order by price desc) as price_number
      from printer) a 
where price_number <=3


with  all_printer as 
(select p.model,p.price,pr.maker 
from printer p left join product pr on p.model=pr.model )

select model
from all_printer
where maker='A'
and price >(select avg(price) from all_printer where maker ='C')
