-- 1. Create a table called consolid, from the tables student, marks and certificate. The new table should have the fields student number, student name from student table, student average marks from marks table and certificate number from certificate table. All the tables have student number as a common key field.
-->
create table student (
    student_number number primary key,
    student_name varchar(50)
);

-------------------------------------------
create table marks (
    student_number references student,
    avg_marks decimal
);

-------------------------------------------
create table certificate (
    student_number references student,
    certificate_number number
);
-------------------------------------------

insert into student values (1 , 'Yogesh');
insert into student values (2 , 'Tejas');
insert into student values (3 , 'Shreyas');
insert into student values (4 , 'Rugved');
insert into student values (5 , 'Tanuj');

insert into  marks values (1 , 72.5);
insert into  marks values (2 , 90.1);
insert into  marks values (3 , 88);
insert into  marks values (4 , 78);
insert into  marks values (5 , 66.00);


insert into certificate values (1 , 1 );
insert into certificate values (2 , 2 );
insert into certificate values (3 , 3 );
insert into certificate values (4 , 4 );
insert into certificate values (5 , 5 );
-----------------------------------------------


create table consolid as 
(select student.student_number , student_name , avg_marks , certificate_number
from student 
left join marks on marks.student_number = student.student_number
left join certificate on certificate.student_number = student.student_number);




-- ######################################
-- CLASSROOM ASSIGNMENT

-- Update the table column teacher_name using the table teacher which contains the columns class , section and teacher name. The table school contains columns class, section teacher_name, building_number , and other  school details. Update the school table only for section 'A' and building number 3.

-- ########################################

create table teacher (
    class int,
    section char(1),
    teacher_name varchar2(40)
);

create table school (
    class int,
    section CHAR(1),
    building int,
    teacher_name varchar2(40)
);



insert into teacher values(12 , 'A' , 'KMS');
insert into teacher values(11 , 'B' , 'BAK');
insert into teacher values(10 , 'A' , 'DPP');
insert into teacher values(10 , 'B' , 'MRS');
insert into teacher values(09 , 'A' , 'AJS');
insert into teacher values(09 , 'B' , 'KRN');
insert into teacher values(09 , 'C' , 'LIS');

insert into school(class , section , building) values(12 , 'A' ,  1);
insert into school(class , section , building) values(11 , 'A' ,  3);
insert into school(class , section , building) values(09 , 'C' ,  2);
insert into school(class , section , building) values(09 , 'A' ,  1);
insert into school(class , section , building) values(11 , 'B' ,  3);
insert into school(class , section , building) values(12 , 'B' ,  1);
insert into school(class , section , building) values(10 , 'A' ,  2);
insert into school(class , section , building) values(10 , 'B' ,  3);


update
    school
set
    teacher_name = (
        select
            teacher_name
        from
            teacher
        where
            school.class = teacher.class
            and school.section = teacher.section
    )
where
    school.section = 'B'
    and school.building = 3;




-- ######################################
-- LAB EXERCISE
-- ######################################

-- 1. Based on the relational tables already created in the previous sessions, identify the objects given below and include them as user-defined datatyypes in a new table, cust_mast_tab;






