--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing


--task1  (lesson6, �������������)
-- SQL: �������� ������� � �������������� ������� (10000 �����, 3 �������, ��� ���� int) � ��������� �� ���������� ������� �� 0 �� 1 000 000. ��������� EXPLAIN �������� � �������� ������� ��������.
CREATE TABLE test_random_table (col1 int, col2 int, col3 int);

insert into test_random_table
SELECT generate_series(1,10000) AS col1, 
random() * 1000000 as col2,
random() * 1000000 as col3

EXPLAIN SELECT * FROM TEST_RANDOM_TABLE

EXPLAIN SELECT * FROM test_random_table  WHERE col1 < 888888 AND col2 >222222

EXPLAIN SELECT col3 FROM test_random_table  WHERE col1 < 888888 AND col2 >222222

--task2 (lesson6, �������������)
-- GCP (Google Cloud Platform): ����� GCP ��������� ������ csv � ���� PSQL �� ������ ���������� (��������� ������ bash � ��������� bash) 




