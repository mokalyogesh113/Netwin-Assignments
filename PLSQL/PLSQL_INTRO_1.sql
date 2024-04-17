
/*
PLSQL LANGUAGE ELEMENTS

1. OPERATORS

    ARITHEMATIC OPERATORS
        + , - , * , / 
    
    EXPRESSION OPERATORS
        :=  assignment operator    a := 5
        ..  defines range          4..10  
        ||  concatenation

    RELATIONAL OPERATORS
        = , != ,  <> , < , > , <= , >= 

    PUNCTUATIONS
        ()  combines expressions
        ;   end of statement
        ''  string literal 
        ''  named identifier
        --  single comment 
        /*   */ Multiple line comment

    OTHER OPERATORS
        IS NULL
        LIKE
        BETWEEN
        IN

2. IDENTIFIERS
    used to give names to variables , constants, exception , procedures , cursors , functions

3. LITERALS
    NUMERIC LITERALS        10 , 3 , 2.111222 , 10.3
    CHARACTER LITERALS      'A' , '.' , 'B' 
    STRING LITERALS         'ABC' , 'sfdfas' 
    BOOLEAN LITERALS        TRUE , FALSE

4. COMMENTS
    --          single line comment
    /* */       multi line comment

5. EXPRESSION AND COMPARISONS
    OPERATOR PRECEDENCE
        **, NOT
        + , -                           # IDENTITY , NEGATION
        * , /
        + , -, ||                       # ADDITION , SUBTRACTION
        = , != , < , > , <> , IS NULL , LIKE , BETWEEEN , IN 
        AND
        OR

6. DATATYPE AND DECLARATIONS

    CATEGORY : NUMERIC
        1. BINARY_INTEGER          
            used to store signed integers ranging from -2^31 to (2^31)-1
        2. NUMBER
            DEC
            DECIMAL
            DOBLE PRECISION
            FLOAT
            INTGER 
            INT
            NUMERIC 
            REAL
            SMALL INT

    CATEGORY : CHARACTER
        1. CHAR
            maximum length : 32767
            if length is not specified the default length is 1
            - CHARACTER AND STRING are subtypes having same range of values as char
        2. VARCHAR2
            store varible size data
            max length 32767
    
    CATEGORY : BOOLEAN
        1. BOOLEAN
    
    CATEGORY : DATE
        1. DATE
    
    CATEGORY : RAW
        1. RAW 
        2. LONG RAW

7. VARIABLE AND CONSTANTS
    syntax to declare variable and constant
        <VARIABLE_NAME> <DATA_TYPE> [NOT NULL] [:= EXPRESSION | VALUE]
        <CONSTANT_NAME> CONSTANT <DATA_TYPE> [NOT NULL] := < EXPRESSION | VALUE >

    naming variable and constants
        NOT CASE SENSETIVE
    scope and visibility
        var and const declred in block are local to that block and global to its subblock   

    TO access the global variable / constant use
        outer.identifier

*/


-- --------------------------------------------------------------------------------
-- PRACTICE
create create table tmp
(
    a int , b int
);

insert into tmp values(1 , 2);
insert into tmp values(22 , 2);
insert into tmp values(43 , 2);
insert into tmp values(3 , 5);
insert into tmp values(4 , 23);


SELECT a , b , a+b , a - b , a*b , a/b , a || ' , ' || b FROM tmp;

-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------

-- CLASSROOM EXERCISE
/*
    Write PL/SQL statements to calculate value of sale for the item no 100 and store in a variable sale_value. The quantity sold is present in table "sales_tran" and the rate in the table "item_master". Value of sale is calculatd as product of quantity and rate.
*/


/*
    TABLE SCHEMA
        sale_tran  ==> transaction_id , item_id ,  quantity_sold 
        item_master ==> item_id , item_name, item_rate
*/


create table item_master(
    item_id int primary key,
    item_name varchar2(100) , 
    item_rate int
)

create table sale_tran
(
    transaction_id int primary key,
    item_id int ,
    quantity_sold int,
    foreign key(item_id) references item_master(item_id)
)

insert into item_master values (1 , 'Item-1' , 120);
insert into item_master values (2 , 'Item-2' , 150);
insert into item_master values (3 , 'Item-3' , 325);
insert into item_master values (4 , 'Item-4' , 22);
insert into item_master values (5 , 'Item-5' , 57);
insert into item_master values (6 , 'Item-6' , 65);
insert into item_master values (7 , 'Item-7' , 77);


insert into sale_tran values(1 , 1 , 10);
insert into sale_tran values(2 , 2 , 40);
insert into sale_tran values(3 , 3 , 22);
insert into sale_tran values(4 , 1 , 23);
insert into sale_tran values(5 , 2 , 66);
insert into sale_tran values(6 , 6 , 45);
insert into sale_tran values(7 , 3 , 45);
insert into sale_tran values(8 , 7 , 33);
insert into sale_tran values(9 , 3 , 93);
insert into sale_tran values(10 , 3 , 67);
insert into sale_tran values(11 , 2 , 70);
insert into sale_tran values(12 , 4 , 70);
insert into sale_tran values(13 , 5 , 80);
insert into sale_tran values(14 , 5 , 100);
insert into sale_tran values(15 , 7 , 105);


DECLARE
  SALE_VALUE INT ;
BEGIN
  SELECT 
    SUM(item_rate * quantity_sold) INTO SALE_VALUE
  FROM
    ITEM_MASTER,
    SALE_TRAN
  WHERE
      ITEM_MASTER.item_id = SALE_TRAN.item_id
      AND SALE_TRAN.ITEM_ID =  1;
  DBMS_OUTPUT.put_line(SALE_VALUE);
END;  

-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------

-- CLASSROOM EXERCISE

/*
    Write a PL/SQL block to calculate and store the grand salary of employee whose code is 'a01'. Structure of employee table is code , name , basic , hra and conveyance and grandtotal. Grand salary is sum of basic, hra and conveyance. If there is no such code, then insert the error in a file called err_table containing a number field to store error code , and char field to store error message.
*/


/*
    TABLE SCHEMA
        EMPLOYEE  ==> code , name , basic , hra , conveyance , grand_total;
        ERR_TABLE ==> err_id  , description
*/


create table EMPLOYEE1 
(
    code varchar2(5) primary key,
    name varchar2(100) ,
    basic int , 
    hra int,
    conveyance int,
    grand_total int
);

create table err_table (
    err_id  int NOT NULL auto_increment,
    description varchar2(200)
);

INSERT INTO employee1 (code, name, basic, hra, conveyance) VALUES ('a01', 'John Smith', 20000, 5000, 1500);
INSERT INTO employee1 (code, name, basic, hra, conveyance) VALUES ('a02', 'Jane Doe', 25000, 6000, 1800);
INSERT INTO employee1 (code, name, basic, hra, conveyance) VALUES ('a03', 'Alex Johnson', 18000, 4500, 1200);
INSERT INTO employee1 (code, name, basic, hra, conveyance) VALUES ('a04', 'Sarah Miller', 30000, 7000, 2000);
INSERT INTO employee1 (code, name, basic, hra, conveyance) VALUES ('a05', 'Robert Wilson', 22000, 5500, 1600);
INSERT INTO employee1 (code, name, basic, hra, conveyance) VALUES ('a06', 'Emily Brown', 28000, 6500, 1450); 
INSERT INTO employee1 (code, name, basic, hra, conveyance) VALUES ('a07', 'David Lee', 19000, 4800, 1950);
INSERT INTO employee1 (code, name, basic, hra, conveyance) VALUES ('a08', 'Olivia Johnson', 26000, 6200, 1700);
INSERT INTO employee1 (code, name, basic, hra, conveyance) VALUES ('a09', 'William Taylor', 21000, 5200, 1300);
INSERT INTO employee1 (code, name, basic, hra, conveyance) VALUES ('a10', 'Emma Davis', 24000, 5800, 2100);
INSERT INTO employee1 (code, name, basic, hra, conveyance) VALUES ('a11', 'Noah Garcia', 17000, 4300, 1400);
INSERT INTO employee1 (code, name, basic, hra, conveyance) VALUES ('a12', 'Sophia Rodriguez', 27000, 6400, 1650);
INSERT INTO employee1 (code, name, basic, hra, conveyance) VALUES ('a13', 'Lucas Martin', 23000, 5600, 1900);
INSERT INTO employee1 (code, name, basic, hra, conveyance) VALUES ('a14', 'Isabella Perez', 19500, 4900, 1100);
INSERT INTO employee1 (code, name, basic, hra, conveyance) VALUES ('a15', 'Daniel Wilson', 20500, 5100, 1850);
INSERT INTO employee1 (code, name, basic, hra, conveyance) VALUES ('a16', 'Mia Carter', 25500, 6100, 1250);
INSERT INTO employee1 (code, name, basic, hra, conveyance) VALUES ('a17', 'Ethan Moore', 18500, 4700, 1750);
INSERT INTO employee1 (code, name, basic, hra, conveyance) VALUES ('a18', 'Ava Thompson', 29000, 6800, 1550);
INSERT INTO employee1 (code, name, basic, hra, conveyance) VALUES ('a19', 'Jacob Robinson', 21500, 5300, 2200);
INSERT INTO employee1 (code, name, basic, hra, conveyance) VALUES ('a20', 'Lily Anderson', 22500, 5700, 1350);



CREATE OR REPLACE PROCEDURE calculate_grand_total(p_code VARCHAR2) AS
    record_present NUMBER(10,2);
BEGIN

    SELECT COUNT(*) 
    INTO   record_present 
    FROM   employee1 
    WHERE  code = p_code;

    IF (record_present > 0) THEN
        UPDATE employee1 
        SET    grand_total = basic + hra + conveyance
        WHERE  code = p_code;
        DBMS_OUTPUT.put_line('Total Updated !....');
    ELSE
        insert into err_table(description) values('CALCULATE_GRAND_TOTAL - Employee Code ' || p_code || ' Not Available in the table' );
        DBMS_OUTPUT.put_line('No record found with the code ' || p_code);
    END IF;
END;


call calculate_grand_total('a01');  -- Total Updated !....
call calculate_grand_total('a21');  -- No record found with the code a21

-- Calculating total of all records using for loop
declare 
  param varchar2(5);
begin
  for i in 1..20 loop
      
      if i<10 then
             param := 'a0' || to_char(i); 
      else  
            param := 'a' || to_char(i); 
      end if;
      dbms_output.put_line(param); 
      CALCULATE_GRAND_TOTAL(PARAM);
    end loop;
end;


-- --------------------------------------------------------------------------------

/*
CONTROL STRUCTURES
    1. CONDITIONAL CONTROL 
    2. ITERATIVE CONTROL
    3. SEQUENTIAL



1. CONDITIONAL CONTROL STRUCTURE
    1. IF THEN STATEMENT
        if <condition> then
            <statement1>;
            .....
        end if;

    2. IF THEN ELSE STATEMENT   
        if <condition> then
            <Statement1;>
            ......
        else 
            <statement1;>
            .........
        end if;
        
    3. IF THEN ELSEIF STATEMENT
        if <condition1> then
            <Statement1;>
            ......
        elseif <condition2> then
            <Statement1;>
            ......
        .
        .
        .
        else
            <Statement1;>
            ......
        end if;
2. ITERATIVE CONTROL STRUCTURE
    1. LOOP STATEMENT
        loop
            <statement1>
            ....
            EXIT;
        end loop;

    2. WHILE LOOP STATEMENT
        while <condition> loop
            <statement1>
            .....
        end loop;
    3. FOR LOOP STATEMENT
        for <counter> in <lower>..<upper> loop 
            <statement1>
            .....
        end loop;
3. SEQUENTIAL CONTROL
    1. GOTO STATEMENT
        begin
            .............
            goto <label_name>;
            ...........
            ...........
            <<label_name>>
            ...........
        end;

    2.NULL STATEMENT
        begin
            ..........
            NULL;
            ..........
        end;
*/

-- --------------------------------------------------------------------------------


-- --------------------------------------------------------------------------------

-- CLASSROOM EXERCISE

/*
    Change the above example so that if sales is more than target by 100 or more only then the incentive is given to employee

        DECLARE
            t_sales NUMBER;
            t_target NUMBER;
        BEGIN
            select sales , target into t_sale , t_target 
            from salesman
            where s_code = '1';
            if sales > target then
                update salesman
                set incentive := 10000
                where s_code = 1;
            end if;
        end;
    
    
*/


DECLARE
    t_sales NUMBER
    t_target NUMBER
BEGIN
    SELECT sales, target INTO t_sales , t_target
    FROM salesman
    WHERE code = '1';

    IF t_sales > t_target and t_sales - t_target >= 100 THEN
        UPDATE   salesman 
        set incentive  := 1000
        where code = 1;
    end IF
end;

-- --------------------------------------------------------------------------------


-- --------------------------------------------------------------------------------

-- CLASSROOM EXERCISE

/*
    Convert the example given for loop - end loop to a while loop statement.

DECLARE 
    ctr NUMBER := 0;
    total_qoh NUMBER := 0;
    quh NUMBER;
BEGIN
    loop
        select quantity_on_hand into qoh from item 
        where code = ctr;
        ctr := ctr + 1;
        total_qoh := total_qoh + qoh;
        if ctr = 15 then
            exit
        end if;
    end loop
END;

*/


DECLARE 
    ctr NUMBER := 0;
    total_qoh NUMBER := 0;
    quh NUMBER;
BEGIN
    while ctr < 15 loop
        select quantity_on_hand into qoh from item 
        where code = ctr;
        ctr := ctr + 1;
        total_qoh := total_qoh + qoh;
    end loop;
END;

-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------

-- CLASSROOM EXERCISE

/*
    1. How many times will the following loop execute ?
        a. 
            for counter in 1 .. 1 loop 
                ....
            end loop
        -->
            It will execute only 1 time for i = 1;
        
        b. 
            for counter in 5 .. 1 loop 
                ....
            end loop
        -->
            It will not execute at all
    
*/

/*
    2. Write a PL/SQL block that increases the basic salary of all employees of category 'A' by Rs. 1000 else by increase by Rs. 700 The Employee code is from 1 to 100.
*/          

begin
    for i in (select id , cat from employee2) loop
        if i.cat = 'A' then
            update employee2
            set salary = salary + 1000;
            where employee2.id = i.id;
        else
            update employee2
            set salary = salary + 700;
            where employee2.id = i.id;
        end if
    end loop;
end;

-- --------------------------------------------------------------------------------


-- --------------------------------------------------------------------------------

-- LAB EXERCISE

/*
    1. Create a view on the ITEM table ans SALES-ORDER table containing columns order-id, item description and order quantity. Try updating the view.
*/
    create view v1 as
    select
        item_id,
        item_name
    from
        item_master;

/*
    2. Create an object view cust_view, based on the cust_mast_tab table created in the previous session. Display details of only those customers who belong to a particular city. (Chhose a city based on existing records).


    TABLE SCHEMA
        cust_mast_table ==> id , name , address
*/
    create table cust_mast_tab 
    (
        id int primary key , 
        name varchar2(100) , 
        address varchar2(100)
    );

    insert into cust_mast_tab values(1 , 'Yogesh' , 'Pachora');
    insert into cust_mast_tab values(2 , 'Tejas' , 'Pachora');
    insert into cust_mast_tab values(3 , 'Tanuj' , 'Malegaon');
    insert into cust_mast_tab values(4 , 'Kiran' , 'Dhule');
    insert into cust_mast_tab values(5 , 'Rahul' , 'Pachora');
    insert into cust_mast_tab values(6 , 'Akshay' , 'Nashik');

    create or replace view v1 as select id , name , address from cust_mast_tab where address like '%Pachora%';

/*
    3. Insert a record into the cust_mast_tab using the constructor method used by the view.
*/    
    insert into v1 values(10 , 'Aayush' , 'Pachora');


/*
    4. Write statements which checks if the order has been shipped or not and updates the status column of SALES-ORDER tables. If the shipment date was 3 days after the order-date, status is 'Late' if whithin 3 days, status is 'ON-TIME' and if there is no shipment date entered the table the status is 'PENDING'. This status is updated on the basis of order-id and item-id entered by the user.
*/

-- ORDERS 
create table orders
(
    order_id int primary key,
    item_id int,
    order_date date,
    shipment_date date , 
    status varchar2(30)
)

INSERT INTO orders (order_id, item_id, order_date, shipment_date) VALUES (1, 101, TO_DATE('20240320', 'YYYYMMDD'), TO_DATE('20240323', 'YYYYMMDD')); 
INSERT INTO orders (order_id, item_id, order_date, shipment_date) VALUES (2, 205, TO_DATE('20240312', 'YYYYMMDD'), TO_DATE('20240320', 'YYYYMMDD')); 
INSERT INTO orders (order_id, item_id, order_date, shipment_date) VALUES (3, 152, TO_DATE('20240318', 'YYYYMMDD'), TO_DATE('20240322', 'YYYYMMDD')); 
INSERT INTO orders (order_id, item_id, order_date, shipment_date) VALUES (4, 302, TO_DATE('20240302', 'YYYYMMDD'), TO_DATE('20240307', 'YYYYMMDD')); 
INSERT INTO orders (order_id, item_id, order_date, shipment_date) VALUES (5, 107, TO_DATE('20240324', 'YYYYMMDD'), TO_DATE('20240329', 'YYYYMMDD')); 
INSERT INTO orders (order_id, item_id, order_date) VALUES (6, 309, TO_DATE('2024-03-01', 'YYYY-MM-DD'));
INSERT INTO orders (order_id, item_id, order_date) VALUES (7, 185, TO_DATE('2024-03-25', 'YYYY-MM-DD')); 
INSERT INTO orders (order_id, item_id, order_date) VALUES (8, 211, TO_DATE('2024-03-08', 'YYYY-MM-DD')); 
INSERT INTO orders (order_id, item_id, order_date) VALUES (9, 420, TO_DATE('2024-03-15', 'YYYY-MM-DD')); 
INSERT INTO orders (order_id, item_id, order_date) VALUES (10, 144, TO_DATE('2024-03-10', 'YYYY-MM-DD')); 
INSERT INTO orders (order_id, item_id, order_date, shipment_date) VALUES (11, 555, TO_DATE('2024-03-05', 'YYYY-MM-DD'), TO_DATE('2024-03-09', 'YYYY-MM-DD')); 
INSERT INTO orders (order_id, item_id, order_date, shipment_date) VALUES (12, 621, TO_DATE('2024-03-02', 'YYYY-MM-DD'), TO_DATE('2024-03-15', 'YYYY-MM-DD'));
INSERT INTO orders (order_id, item_id, order_date, shipment_date) VALUES (13, 113, TO_DATE('2024-02-28', 'YYYY-MM-DD'), TO_DATE('2024-03-01', 'YYYY-MM-DD')); 
INSERT INTO orders (order_id, item_id, order_date, shipment_date) VALUES (14, 400, TO_DATE('2024-03-27', 'YYYY-MM-DD'), TO_DATE('2024-03-30', 'YYYY-MM-DD')); 
INSERT INTO orders (order_id, item_id, order_date, shipment_date) VALUES (15, 765, TO_DATE('2024-03-19', 'YYYY-MM-DD'), TO_DATE('2024-03-28', 'YYYY-MM-DD')); 
INSERT INTO orders (order_id, item_id, order_date, shipment_date) VALUES (16, 272, TO_DATE('2024-03-14', 'YYYY-MM-DD'), TO_DATE('2024-03-17', 'YYYY-MM-DD')); 
INSERT INTO orders (order_id, item_id, order_date, shipment_date) VALUES (17, 911, TO_DATE('2024-03-08', 'YYYY-MM-DD'), TO_DATE('2024-03-11', 'YYYY-MM-DD')); 
INSERT INTO orders (order_id, item_id, order_date, shipment_date) VALUES (18, 359, TO_DATE('2024-03-05', 'YYYY-MM-DD'), TO_DATE('2024-03-10', 'YYYY-MM-DD')); 
INSERT INTO orders (order_id, item_id, order_date, shipment_date) VALUES (19, 148, TO_DATE('2024-02-22', 'YYYY-MM-DD'), TO_DATE('2024-02-26', 'YYYY-MM-DD')); 
INSERT INTO orders (order_id, item_id, order_date, shipment_date) VALUES (20, 833, TO_DATE('2024-03-21', 'YYYY-MM-DD'), TO_DATE('2024-03-25', 'YYYY-MM-DD')); 

update orders set status = 'PENDING' where  shipment_date is null;
update orders set status = 'LATE' where  (shipment_date - order_date) > 3;
update orders set status = 'ON-TIME' where  (shipment_date - order_date) <= 3;

select * from orders;



/*
    5. Write PL/SQL statements to update the unit-price of all the items, in ITEM table, increasing it by 5%. Display the old price and the updated price of each item along with its description. Assume that there are 15 items in the item table.
*/
    declare
    i varchar(10);
    begin
    for i in (select item_id from item_master) loop
        update item_master
        set item_rate = item_rate * 1.05 
        where item_master.item_id = i.item_id;
    end loop;
    end;

/*
    6. Write statement which check whether QOH of an item is more than 500 or not. If it is more than 500 display 'Sufficient stock' else display 'Not Sufficient stock' along with the QOH value.
*/
    select * , case when QOH > 500 then 'Sufficient Stock' else 'Not Sufficient Stock' end as 'Stock Availability' from items;


/*
    7. Write a PL/SQL block to display the only the elements of the varray column in the cust_mast_tab table created in session 4.
*/

