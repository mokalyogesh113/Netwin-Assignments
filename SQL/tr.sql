--Classroom Excercise
create table Student(
stud_no int,
stud_name varchar(15));

create table Marks(
stud_no int,
Avg_Marks int);

create table Certificate(
stud_no int,
cert_no int);

insert into Student values(1, 'Trupti');
insert into Student values(2, 'Somya');
insert into Student values(3, 'Kaustubh');
insert into Student values(3, 'Sanket');
select * from Student;

insert into Marks values(1, 77);
insert into Marks values(2, 88);
insert into Marks values(3, 79);
insert into Marks values(4, 89);
select * from Marks;

insert into Certificate values(1, 123);
insert into Certificate values(2, 124);
insert into Certificate values(3, 125);
insert into Certificate values(4, 126);
select * from Certificate;

create table Consolid as
select s.stud_no, s.stud_name,m.Avg_Marks, c.cert_no
from Student s, Marks m, Certificate c
where s.stud_no=m.stud_no and s.stud_no=c.stud_no;

select * from Consolid;


--Classroom Excercise
update Student
set stud_name = 'Priya'
where stud_no = 2;

select * from Student;

update Student
set stud_no = 4
where stud_name = 'Sanket';


update consolid
set stud_no = 4
where stud_name = 'Sanket';

select * from Consolid;



create table School(
teacher_name varchar(15),
class int,
section varchar(1),
building varchar(1),
school_details varchar(30));

create table Teacher(
class int,
section varchar(1),
teacher_name varchar(15));

insert into school(class, section, building, school_details) values(12, 1, 'A', 'ABC school');
insert into school(class, section, building, school_details) values(12, 2, 'B', 'XYZ school');
insert into school(class, section, building, school_details) values(10, 1, 'A', 'EFG school');

insert into Teacher values(12, 1, 'Soham Shinde');
insert into Teacher values(10, 2, 'Prachi Pawar');

update School set teacher_name = (
Select teacher_name
from Teacher 
where teacher.class = school.class
and teacher.section = School.Section);

select * from school;

DELETE FROM student 
WHERE stud_no = (SELECT MAX(stud_no) FROM student);

--Classroom Excersice
create table Address(
Lastname varchar(15),
Firstname varchar(15),
phone varchar(12));

insert into Address values(
'Bailey', 'William', '213-293-0223');

insert into Address values(
'Adams', 'Jack', '415-453-7530');

insert into Address values(
'Sep', 'Felicia', '214-522-8383');

insert into Address values(
'Casey', 'Willis', '312-684-1166');


insert into Address values(
'Zack', 'Andrew', '415-620-6842');

SELECT RPAD(Lastname || ' ' || Firstname, 25, '.') AS name,
       SUBSTR(phone, 5) AS "phone-number"
FROM Address
WHERE phone LIKE '415-%';

SELECT RPAD(Lastname || ',' || Firstname, 25, '.') AS name,
       SUBSTR(phone, 5) AS "phone-number"
FROM Address
WHERE INSTR(phone, '415-', 1, 1) = 1;

create table Comfort(
city varchar(15),
sampledate date,
noon int,
midnight int);

insert into Comfort values('San F   rancisco', '21-mar-96', 62.5, 42.3);
insert into Comfort values('San Francisco', '22-jun-96', 51.1, 71.9);
insert into Comfort(city, Sampledate,Midnight) values('San Francisco', '23-sep-96', 61.5);
insert into Comfort values('San Francisco', '22-dec-96', 52.6, 39.8);
insert into Comfort values('Keene', '21-mar-96', 39.5, -1.2);
insert into Comfort values('Keene', '22-jun-96', 85.1, 66.7);
insert into Comfort values('Keene', '23-sep-96', 99.8, 82.6);
insert into Comfort values('Keene', '22-dec-96', -7.5, -1.2);

-- INITCAP, UPPER, LOWER, RPAD, LPAD, LTRIM, RTRIM, LENGTH, SUBSTR, INSTR, SOUNDEX
SELECT INITCAP(city), UPPER(city), LOWER(city), RPAD(city, 15, '.'), LPAD(city, 15, '.'), LTRIM(city,'K'), RTRIM(city, 'o'), LENGTH(city), SUBSTR(city, 1, 3), INSTR(city, 'San'), SOUNDEX(city) FROM Comfort;

-- ABS, CEIL, FLOOR, MOD, SQRT, TRUNC, ROUND, NVL, POWER
SELECT ABS(noon), ABS(midnight), CEIL(noon), CEIL(midnight), FLOOR(noon), FLOOR(midnight), MOD(noon, 10), MOD(midnight, 10), SQRT(noon), SQRT(midnight), TRUNC(noon, 1), TRUNC(midnight, 1), ROUND(noon, 1), ROUND(midnight, 1), NVL(noon, 0), NVL(midnight, 0), POWER(noon, 2), POWER(midnight, 2) FROM Comfort;

-- AVG, COUNT, MAX, MIN, SUM, STDEV, VARIANCE
SELECT AVG(noon), AVG(midnight), COUNT(*), MAX(noon), MAX(midnight), MIN(noon), MIN(midnight), SUM(noon), SUM(midnight), STDDEV(noon), STDDEV(midnight), VARIANCE(noon), VARIANCE(midnight) FROM Comfort;

-- SYSDATE, NEXT_DAY, LAST_DAY, MONTHS_BETWEEN, DECODE, GREATEST, LEAST
SELECT SYSDATE FROM dual;

SELECT NEXT_DAY(sampledate, 'MONDAY') FROM Comfort;

SELECT LAST_DAY(sampledate) FROM Comfort;

SELECT MONTHS_BETWEEN('21-mar-96', '22-jun-96') FROM dual;

SELECT DECODE(city, 'San Francisco', 'SF', 'Keene', 'KN', 'Other') FROM Comfort;


SELECT LEAST(noon, midnight) FROM Comfort;

SELECT city, sampledate, GREATEST(noon, midnight) high, LEAST(noon, midnight)Low FROM Comfort;
    