-- CLASSROOM EXERCISE

-- Write SQL statement to display student details from tables student, marks and certificate. Student table contains rollnumber and name, address. Marks table contains rollnumber and marks in english, marhs and science. Certificate table contains rollnumber and certificatedate.

-- Already have these tables with other column names so directely wrote query accordingly

select
    student.student_number,
    student_name,
    avg_marks,
    certificate_number
from
    student,
    marks,
    certificate
where
    student.student_number = marks.student_number
    and student.student_number = certificate.student_number;

-- -----------------------------------------------------------------------------------------------------

-- CLASSROOM EXERCISE

-- From the item table display all the items whose rate is same.

create table item
(
    itemid int primary key , 
    itemname varchar2(50),
    itemrate decimal(10,2)
);

insert into item values (1, 'Product A', 10.50);
insert into item values (2, 'Product B', 15.25);
insert into item values (3, 'Product C', 10.50);
insert into item values (4, 'Product D', 12.75);
insert into item values (5, 'Product E', 15.25);
insert into item values (6, 'Product F', 10.50);

select '[ ' || LISTAGG(itemname , ' , ') || ' ]' "Items with same rate" ,itemrate , count(*) from item group by itemrate; 

-- -----------------------------------------------------------------------------------------------------

-- CLASSROOM EXERCISE

-- Write statement to display data from the tables cust1 and cust2. First table contains customer code, name and address1 and address2. Second table contains columns customer code, name and address1. Display all the date from  the two tables. In case of address2 does not exist, display 'BLANK' instead. sort the result on second column.

CREATE TABLE CUST1 (
    code int,
    name varchar2(50),
    addr1 varchar2(50),
    addr2 varchar2(50)
);

CREATE TABLE CUST2 (
    code int,
    name varchar2(50),
    addr1 varchar2(50)
);

insert into cust1 values(1 , 'person-1' , 'addr1-1' , 'addr2-1');
insert into cust1 values(2 , 'person-2' , 'addr1-2' , 'addr2-2');
insert into cust1 values(3 , 'person-3' , 'addr1-3' , 'addr2-3');
insert into cust1 values(4 , 'person-4' , 'addr1-4' , 'addr2-4');
insert into cust1 values(5 , 'person-5' , 'addr1-5' , 'addr2-5');
insert into cust1 values(6 , 'person-6' , 'addr1-6' , 'addr2-6');
insert into cust1 values(7 , 'person-7' , 'addr1-7' , 'addr2-7');
insert into cust1 values(8 , 'person-8' , 'addr1-8' , 'addr2-8');
insert into cust1 values(9 , 'person-9' , 'addr1-9' , 'addr2-9');
insert into cust1 values(10 , 'person-10' , 'addr1-10' , 'addr2-10');

insert into cust2 values(1 , 'person-1' , 'addr1-1');
insert into cust2 values(2 , 'person-2' , 'addr1-2');
insert into cust2 values(3 , 'person-3' , 'addr1-3');
insert into cust2 values(4 , 'person-4' , 'addr1-4');
insert into cust2 values(5 , 'person-5' , 'addr1-5');
insert into cust2 values(6 , 'person-6' , 'addr1-6');
insert into cust2 values(7 , 'person-7' , 'addr1-7');
insert into cust2 values(8 , 'person-8' , 'addr1-8');
insert into cust2 values(9 , 'person-9' , 'addr1-9');
insert into cust2 values(10 , 'person-10' , 'addr1-10');


select code , name , addr1 , addr2 from cust1
union
select code , name , addr1, '' addr2 from cust2
order by 2;

-- -----------------------------------------------------------------------------------------------------

-- HOME ASSIGNMENT

-- Write a query to display the following data from tables mail_data_1 and mail_data_2. Both tables have following data name , address , pincode.

-- 1. All the data in both tables (avoiding duplicate data)
-- 2. Only that data which is present in both the tables.
-- 3. Those data present in one of the lists.


create table mail_data_1(
    name varchar2(50),
    address varchar2(50) , 
    pincode number(6)
);

create table mail_data_2(
    name varchar2(50),
    address varchar2(50) , 
    pincode number(6)      
);


insert into mail_data_1 values('Yogesh', 'Pachora' , 424201);
insert into mail_data_2 values('Yogesh', 'Pachora' , 424201);

insert into mail_data_1 values('Tejas' , 'Mumbai' , 400047);
insert into mail_data_2 values('Tejas' , 'Mumbai' , 400047);

insert into mail_data_1 values('Sagar' , 'Pachora' , 424201);
insert into mail_data_1 values('Rahul' , 'Nashik' , 422001);
insert into mail_data_1 values('Tanuj' , 'Malegaon' , 423203);
insert into mail_data_1 values('Shreyas' , 'Dhule' , 424001);

insert into mail_data_2 values('Rugved' , 'Jalgaon' , 414205);
insert into mail_data_2 values('Kiran' , 'Shirpur' , 425405);
insert into mail_data_2 values('Pratham' , 'Mumbai' , 400047);

-- (Total 11 Records in both tables combined.)

-- 1. All the data in both the tables (Avoiding Duplicate Data);
select * from mail_data_1
union
select * from mail_data_2;
--(9 records )


-- 2. Only that data which is present in both the tables;
select * from mail_data_1
intersect
select * from mail_data_2;
--(2 Records)

-- 3. Those data present in one of the lists
(select * from mail_data_1 minus select * from mail_data_2)
union
(select * from mail_data_2 minus select * from mail_data_1);

-- -----------------------------------------------------------------------------------------------------

-- Home Assignment
-- write a query to display the name4 of the actrors from the table film whose cost_of_production is same as that of the movie 'Jurassic Park'

select actor_name  
from film
where cost_of_production = (select cost_of_production from film where movie_name = 'Jurassic Park');

-- -----------------------------------------------------------------------------------------------------

-- CLASSROOM EXERCISE
-- write a query to display the address of all the actors who have worked in 'HIT' category film. Category and name of actor is stored in table movie_sales and the address and name of actors is stored in table actors.


-- movie_sales --> movie_category , actor_name 
-- actor --> actor_address , actor_name

select actor_address
from actor
where actor_name in ( select actor_name from movie_sales where movie_category = 'HIT' );

-- -----------------------------------------------------------------------------------------------------

-- HOME ASSIGNMENT

-- Sales_north and Sales_west table contain the following data : item_code , quantity_sold , date_of_sale & salesman_number. Usin the two tables, query following data

-- 1. All the items from sales_north whose quantity_sold is greater thean all the items present in sales_west
select * from sales_north where quantity_sold > (select max(quantity_sold) from sales_west);

-- 2. All the items from sales_north whose quantity sold is less than any of the items present in sales_west.
select * from sales_north where quantity_sold < ( select max(quantity_sold) from sales_west );

-- 3. All the items present in sales_north which are not present in sales_west and which were sold on the date 19/09/97
select * from sales_north where item_code not in (select item_code from sales_west) and date_of_sale = "19970919";


-- -----------------------------------------------------------------------------------------------------

-- From the class table display all the students who are the youngest in each section. The class table contains roll number , name , address, section & age.
-- class --> roll_number, name , address , section & age

select * from class c1 where age = (select min(age) from class c2 where c2.section = c1.section)

-- CLASSROOM EXERCISE
-- write the above query using IN operator(without correlated query)
                select name , skill from employee x 
                    where exists (select * from employee 
                        where x.name = name 
                            group by name
                                having count(skill) > 1);
-- SOLUTION TO ABOVE QUERY --> 
    select name , skill from employee where name in (select name from employee group by name having count(skill) > 1);

-- -----------------------------------------------------------------------------------------------------