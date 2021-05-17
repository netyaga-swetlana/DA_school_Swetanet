--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1  (lesson6, дополнительно)
-- SQL: Создайте таблицу с синтетическими данными (10000 строк, 3 колонки, все типы int) и заполните ее случайными данными от 0 до 1 000 000. Проведите EXPLAIN операции и сравните базовые операции.
CREATE TABLE test_table_random (column_id smallint,
								column2 SMALLINT,
							    column3 SMALLINT);

DECLARE Var SMALLINT;
DECLARE Test_Count SMALLINT = 10000;

WHILE Test_Count > 0
BEGIN

    SET Var = (SELECT FLOOR(RAND() * (1000000)) + 1);
    INSERT INTO test_table_random (column_id) VALUES (Var);
    SET Var = (SELECT FLOOR(RAND() * (1000000)) + 1);
    INSERT INTO test_table_random (column2) VALUES (Var);
    SET Var = (SELECT FLOOR(RAND() * (1000000)) + 1);
    INSERT INTO test_table_random (column3) VALUES (Var);
    SET Test_Count -= 1;
END

SELECT *
FROM test_table_random

--task2 (lesson6, дополнительно)
-- GCP (Google Cloud Platform): Через GCP загрузите данные csv в базу PSQL по личным реквизитам (используя только bash и интерфейс bash) 
