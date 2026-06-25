CREATE DATABASE mini_project;
CREATE TABLE T_TAB1
(
ID INT  UNIQUE,
GOODS_TYPE VARCHAR(100),
QUANTITY INT,
AMOUNT INT,
SELLER_NAME VARCHAR(50)  
);
SELECT * FROM T_TAB1;
DROP TABLE T_TAB1;

INSERT INTO T_TAB1(ID,GOODS_TYPE,QUANTITY,AMOUNT,SELLER_NAME) VALUES ('1','MOBILE PHONE','2','400000','MIKE');
INSERT INTO T_TAB1(ID,GOODS_TYPE,QUANTITY,AMOUNT,SELLER_NAME) VALUES ('2','KEYBOARD','1','10000','MIKE');
INSERT INTO T_TAB1(ID,GOODS_TYPE,QUANTITY,AMOUNT,SELLER_NAME) VALUES ('3','MOBILE PHONE','1','50000','JANE');
INSERT INTO T_TAB1(ID,GOODS_TYPE,QUANTITY,AMOUNT,SELLER_NAME) VALUES ('4','MONITOR','1','110000','JOE');
INSERT INTO T_TAB1(ID,GOODS_TYPE,QUANTITY,AMOUNT,SELLER_NAME) VALUES ('5','MONITOR','2','80000','JANE');
INSERT INTO T_TAB1(ID,GOODS_TYPE,QUANTITY,AMOUNT,SELLER_NAME) VALUES ('6','MOBILE PHONE','1','130000','JOE');
INSERT INTO T_TAB1(ID,GOODS_TYPE,QUANTITY,AMOUNT,SELLER_NAME) VALUES ('7','MOBILE PHONE','1','60000','ANNA');
INSERT INTO T_TAB1(ID,GOODS_TYPE,QUANTITY,AMOUNT,SELLER_NAME) VALUES ('8','PRINTER','1','90000','ANNA');
INSERT INTO T_TAB1(ID,GOODS_TYPE,QUANTITY,AMOUNT,SELLER_NAME) VALUES ('9','KEYBOARD','2','10000','ANNA');
INSERT INTO T_TAB1(ID,GOODS_TYPE,QUANTITY,AMOUNT,SELLER_NAME) VALUES ('10','PRINTER','1','80000','MIKE');

CREATE TABLE T_TAB2
(
ID INT UNIQUE,
NAME VARCHAR(100)  PRIMARY KEY,
SALARY INT,
AGE INT
);
SELECT * FROM T_TAB2;
DROP TABLE T_TAB2;

INSERT INTO T_TAB2(ID,NAME,SALARY,AGE) VALUES ('1','ANNA','110000','27');
INSERT INTO T_TAB2(ID,NAME,SALARY,AGE) VALUES ('2','JANE','80000','25');
INSERT INTO T_TAB2(ID,NAME,SALARY,AGE) VALUES ('3','MIKE','120000','25');
INSERT INTO T_TAB2(ID,NAME,SALARY,AGE) VALUES ('4','JOE','70000','24');
INSERT INTO T_TAB2(ID,NAME,SALARY,AGE) VALUES ('5','RITA','120000','29');

#1.	Напишите запрос, который вернёт список уникальных категорий товаров (GOODS_TYPE). Какое количество уникальных категорий товаров вернёт запрос?
SELECT COUNT(DISTINCT goods_type) AS unique_categories
FROM T_TAB1;

#2. Напишите запрос, который вернет суммарное количество и суммарную стоимость проданных мобильных телефонов. Какое суммарное количество и суммарную стоимость вернул запрос?
SELECT 
SUM(quantity) AS total_quantity,
SUM(quantity * amount) AS total_sales
FROM T_TAB1
WHERE goods_type = 'mobile phone';

#3.	Напишите запрос, который вернёт список сотрудников с заработной платой > 100000. Какое кол-во сотрудников вернул запрос?
SELECT COUNT(*) AS employee_count
FROM T_TAB2
WHERE salary > 100000;

#4. Напишите запрос, который вернёт минимальный и максимальный возраст сотрудников, а также минимальную и максимальную заработную плату.
SELECT 
MIN(age) AS min_age,
MAX(age) AS max_age,
MIN(salary) AS min_salary,
MAX(salary) AS max_salary
FROM T_TAB2;

#5.	Напишите запрос, который вернёт среднее количество проданных клавиатур и принтеров.
SELECT 
AVG(quantity) AS avg_quantity
FROM T_TAB1
WHERE goods_type IN ('KEYBOARD', 'PRINTER');    

#6.	Напишите запрос, который вернёт имя сотрудника и суммарную стоимость проданных им товаров.
SELECT seller_name, SUM(quantity*amount) AS total_sales
FROM T_TAB1
GROUP BY seller_name;

#7.	Напишите запрос, который вернёт имя сотрудника, тип товара, кол-во товара, стоимость товара, заработную плату и возраст сотрудника MIKE.
SELECT name, goods_type, quantity, amount, salary, age
FROM T_TAB1 a
JOIN T_TAB2 b ON a.ID=b.ID
WHERE name='MIKE';

#8.	Напишите запрос, который вернёт имя и возраст сотрудника, который ничего не продал. Сколько таких сотрудников?
SELECT 
    t2.NAME,
    t2.AGE
FROM T_TAB2 t2
LEFT JOIN T_TAB1 t1
ON t1.SELLER_NAME = t2.NAME
WHERE t1.ID IS NULL;

#9.	Напишите запрос, который вернёт имя сотрудника и его заработную плату с возрастом меньше 26 лет? Какое количество строк вернул запрос?
SELECT name, salary
FROM T_TAB2
WHERE age<26;

#10. Сколько строк вернёт следующий запрос:
SELECT * FROM T_TAB1 t
JOIN T_TAB2 t2 ON t2.name = t.seller_name
WHERE t2.name = 'RITA';
