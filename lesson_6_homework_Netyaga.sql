--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1  (lesson6, �������������)
-- SQL: �������� ������� � �������������� ������� (10000 �����, 3 �������, ��� ���� int) � ��������� �� ���������� ������� �� 0 �� 1 000 000. ��������� EXPLAIN �������� � �������� ������� ��������.
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

--task2 (lesson6, �������������)
-- GCP (Google Cloud Platform): ����� GCP ��������� ������ csv � ���� PSQL �� ������ ���������� (��������� ������ bash � ��������� bash) 
