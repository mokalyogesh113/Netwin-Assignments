/*
WINDOW FUNCTIONS
    syntax to create window function
        select 
            column(s),
            func() over ([<partition by clause>]
                         [order by clause]
                         [row or range clause]  )
        from 
            table_name;



        func() --> aggregate functions          (sum , avg , count , min , max)
                   Ranking Functions            (row_number , rank , dense_rank , percent_rank)
                   Analytical Functions         (lead , lag, first_value , last_value)

*/

/*
    Suppose We have 

*/


create table test_data(
    new_id number,
    new_cat varchar2(100)
);

insert into test_data values(100, 'Agni');
insert into test_data values(200, 'Agni');
insert into test_data values(500, 'Dharti');
insert into test_data values(700, 'Dharti');
insert into test_data values(200, 'Vayu');
insert into test_data values(300, 'Vayu');
insert into test_data values(500, 'Vayu');



-- Aggregate Functions
select 
    new_id ,
    new_cat ,
    sum(new_id) over(partition by new_cat) as Total,
    avg(new_id) over(partition by new_cat) as Average,
    count(new_id) over(partition by new_cat) as count,
    min(new_id) over(partition by new_cat) as Minimum,
    max(new_id) over(partition by new_cat) as Maximum
from 
    test_data;


-- Ranking Functions
select new_id , 
    row_number() over(order by new_id) as ROW_NUMBER,
    rank() over(order by new_id) as RANK,
    dense_rank() over(order by new_id) as DENSE_RANK,
    percent_rank() over(order by new_id) as PERCENT_RANK
from 
    test_data;

-- Analytical Functions
select
    new_id ,
    first_value(new_id) over(order by new_id) as FIRST_VALUE,
    last_value(new_id) over(order by new_id) as LAST_VALUE,
    lead(new_id) over(order by new_id) as LEAD,
    lag(new_id) over(order by new_id) as LAG
from 
    test_data;
    