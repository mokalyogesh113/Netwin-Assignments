-- =========== SYNONYM ========== 

syntax
create synonym <synonym_name> for <object> 


-- PRACTICE
create synonym tmp for item;
insert into tmp values(10 , 'sdf', 1);
select * from tmp;
delete from item where itemid = 10;
select * from tmp;

-- RENAME SYNONYM
rename tmp to tmp12;
select * from tmp12;

-- DROP SYNONYM
drop synonym tmp12;
select * from tmp;


-- =========== INDEXES ========== 

syntax
create index <index_name> on <table>(
    <column>[ASC | DESC],
    <column>[ASC | DESC].....
);


create index idx_tmp on item(itemname);

-- DROP INDEX
drop index idx_tmp;



-- =========== SEQUENCE ========== 
create sequence seq_tmp
increment by 1
start with 1
nomaxvalue
nocycle
cache 15;


