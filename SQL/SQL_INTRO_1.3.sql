
-- CLASSROOM ASSIGNMENT
create table dept
(
    deptno int ,
    dname varchar(20)
);


INSERT INTO dept VALUES(1 , 'Systems');
INSERT INTO dept VALUES(2 , 'Infosolutions');
INSERT INTO dept VALUES(3 , 'Fintech');

-- what will be the output of the following commands?
select LPAD(dname , 20, '*'), RPAD(deptno,20,'**') from dept;
-- **.... ON of left dname and **... on right of deptno
select LPAD(dname , 20 ), RPAD(deptno,20) from dept;


-- what will be the output of the following commands?
select RPAD(RTRIM(LTRIM(Title , '"'),'."'),47,'-^') from magazine;
--it will remove the double quotes and full stop from either sides and add -^ at right side.

-- what will be the output of the following commands?
select initcap(lower(teacher_name)) from teacher;
-- It will the column data in the Sentence-case.


create table address
(
    lastname varchar(30),
    firstname varchar(30),
    phone varchar(20)
);

INSERT into address VALUES('BAILEY', 'WILLIAM', '213-293-0223');
INSERT into address VALUES('ADAMS', 'JACK', '415-453-7530');
INSERT into address VALUES('SEP', 'FELICA', '214-522-8383');
INSERT into address VALUES('CASEY', 'WILLIS', '312-684-1166');
INSERT into address VALUES('ZACK', 'ANDREW', '415-620-6840');

-- what would be the output of the following command?

select RPAD(lastname || ',' || firstname  ,25,',') name, substr(phone,5) phonenumber from address 


-- what would be the output of the following command?
select firstname, substr(firstname , 1, instr(firstname , 'A')-1) from address;



-- HOME ASSIGNMENT
-- ex - BONHOEFFER, DIETRICH should displayed as DIETRICH BONHOEFFER
select name , substr(name, instr(name , ' ')+1) first_name   , substr(name , 1 , instr(name , ',') - 1) last_name from magazine;


-- CLASSROOM ASSIGNMENT
select 50 SALARY ,  POWER(50,2) , POWER(50 , 3) , POWER(20,5);



-- CLASSROOM ASSIGNMENT
select sysdate today , LAST_DAY(ADD_MONTHS(sysdate,6)) + 1 Review from dual;
select SYSDATE , round(sysdate , 'MONTH'), TRUNC(sysdate , 'MONTH') from dual;
SELECT translate(7671234,234567890,'BCDEFGHIJ') from dual;
SELECT TRANSLATE('HAL', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'BCDEFGHIJKLMNOPQRSTUVWXYZA') FROM DUAL;






















