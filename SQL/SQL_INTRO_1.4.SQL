-- CLASSROOM ASSIGNMENT

-- What command should be given to calculate the avg salary each job excluding managers?
select job , avg(salary) from emp where job!='MANAGER' group by job;


person str
amt  int
remark   overdue/ not
item item_name


create table ledger
(
    person varchar2(20) ,
    amount int,
    remark varchar2(20),
    item varchar2(20)
);

insert into ledger values('Yogesh' , 1500 , 'Overdue','XYZ');
insert into ledger values('Tejas' , 2500 , 'Not Overdue' ,'XYZ');
insert into ledger values('Rugved' , 3000 , 'Overdue' ,'XYZ');
insert into ledger values('Rahul' , 3120 , 'Not Overdue' ,'XYZ');
insert into ledger values('Tanuj' , 2205 , 'Overdue' ,'XYZ');



select person , count(item) , sum(amount) Total  
from ledger where remark = 'Overdue'  
group by person
having count(item) > 1 
order by avg(amount);