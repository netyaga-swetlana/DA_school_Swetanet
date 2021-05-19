--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1  (lesson6, дополнительно)
-- SQL: Создайте таблицу с синтетическими данными (10000 строк, 3 колонки, все типы int) и заполните ее случайными данными от 0 до 1 000 000. Проведите EXPLAIN операции и сравните базовые операции.
CREATE TABLE test_random_table (col1 int, col2 int, col3 int);

DECLARE @var1 int, @var2 int, @var3 int; 
DECLARE @TestCount int; set @TestCount= 10000; 

WHILE @TestCount > 0 
begin
   SET @var1 = (SELECT FLOOR(RAND() * 1000000) + 1); 
   SET @var2 = (SELECT FLOOR(RAND() * 1000000) + 1); 
   SET @var3 = (SELECT FLOOR(RAND() * 1000000) + 1);
   INSERT INTO test_random_table (col1, col2, col3) VALUES (@var1, @var2, @var3);
   SET @TestCount -= 1;
end 

EXPLAIN SELECT * FROM TEST_RANDOM_TABLE
EXPLAIN SELECT * FROM test_random_table  WHERE col1 < 888888 AND col2 >222222
EXPLAIN SELECT col3 FROM test_random_table  WHERE col1 < 888888 AND col2 >222222

--task2 (lesson6, дополнительно)
-- GCP (Google Cloud Platform): Через GCP загрузите данные csv в базу PSQL по личным реквизитам (используя только bash и интерфейс bash) 
