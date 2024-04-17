-- --------------------------------------------------------------------------------

/*
PROCEDURES

DECLARE
    -- GLOBAL DECLARATIVE STATEMENTS
    PROCEDURE <procedure_name> ([<parameters list>]) IS
BEGIN
    EXECUTABLE STATEMENTS
EXCEPTION
    Exception Handlers
END;

BEGIN
    STATEMENTS TO CALL PROCEDURE;
END;

        parameter (SYNTAX) --> <var_name> [IN | OUT | IN OUT] datatype [{:= | DEFAULT} value]
*/



declare
 procedure proc1(n NUMBER) IS
begin
    for i in 1..n loop
        dbms_output.put_line(i);
    end loop;
end;
begin
        proc1(100);
end;



/*
FUNCTIONS

DECLARE
    -- global declarations
    FUNCTION <function_name> [( PARAMETER1 , ....... )] RETURN DATATYPE IS
        -- LOCAL VARIABLES
    BEGIN
        -- STATEMENTS
    [EXCEPTION]
        EXCEPTION HANDLER
    END [NAME];
    
BEGIN
    -- STATEMENTS
END;

*/

DECLARE
FUNCTION SQUARE(N NUMBER) RETURN NUMBER IS
    ANS NUMBER;
BEGIN
    ANS := N * N;
    RETURN ANS;
END;
BEGIN
    dbms_output.PUT_LINE(SQUARE(10));
END;

-- --------------------------------------------------------------------------------

-- CLASSROOM EXERCISE

/*
    Write a function which accepts  Account-Number and returns back the balance amount, i.e the difference between debit and credit amount. If debit is more than credit raise the error negative_balance. If the balance is more than 1,00,000 Rs., update Asset-advantage table by adding the account number and the balance to the file. The calling program is returned 'A' if balance is more than 1 lakh else if it is more than zero but less than a lakh return 'B' and return 'C' if the balance is negative.
*/

create table accounts
(
    acc_no int primary key,
    credit_amt float , 
    debit_amt float 
);

create table asset_adv 
(
    id int primary key,
    acc_no int ,
    balance float
);


INSERT INTO accounts VALUES (1, 1500, 1000); 
INSERT INTO accounts VALUES (2, 50000, 85000);
INSERT INTO accounts VALUES (3, 120000, 75000);
INSERT INTO accounts VALUES (4, 3000, 7000);
INSERT INTO accounts VALUES (5, 950000, 500000);
INSERT INTO accounts VALUES (6, 25000, 2000);
INSERT INTO accounts VALUES (7, 15200, 21000); 
INSERT INTO accounts VALUES (8, 5000, 1000);
INSERT INTO accounts VALUES (9, 680000, 8000);
INSERT INTO accounts VALUES (10, 90000, 100000);
INSERT INTO accounts VALUES (11, 11000, 3000);
INSERT INTO accounts VALUES (12, 450000, 120000);
INSERT INTO accounts VALUES (13, 18000, 35000);
INSERT INTO accounts VALUES (14, 7500, 7500); 
INSERT INTO accounts VALUES (15, 280000, 50000);
INSERT INTO accounts VALUES (16, 5500, 4000);
INSERT INTO accounts VALUES (17, 999999, 340000); 
INSERT INTO accounts VALUES (18, 34500, 89000);
INSERT INTO accounts VALUES (19, 2000, 10000);
INSERT INTO accounts VALUES (20, 600000, 600000); 



DECLARE 
  gv_bank_balance accounts.debit_amt%TYPE;
  gv_acc_no accounts.acc_no%TYPE;
  
FUNCTION get_balance(p_acc_no accounts.acc_no%TYPE) RETURN accounts.debit_amt%TYPE IS
    v_balance accounts.debit_amt%TYPE;
    e_negative_balance exception;
BEGIN
    select (credit_amt - debit_amt) into v_balance 
    from accounts where acc_no = p_acc_no; 
    
    if v_balance < 0 then      raise e_negative_balance;   end if;
     
    return v_balance;
EXCEPTION
    when NO_DATA_FOUND then
         dbms_output.put_line('EXCEPTION HAPPENED -- NO ACCOUNT FOUND');
         return null;
    when e_negative_balance then
        dbms_output.put_line('EXCEPTION HAPPENED -- NEGATIVE BALANCE');
        return v_balance;
     when others then
          dbms_output.put_line('Some Error Occured');
END;

-- Calling Block
BEGIN
    gv_acc_no := &Enter_Account_Number;
    gv_bank_balance := get_balance(gv_acc_no);   
    
    if gv_bank_balance is null then 
       dbms_output.put_line('NULL OCCURED');
       -- goto END_PROGRAM_STMT;
    end if;

     dbms_output.put_line('Bank Balance is :- ' || gv_bank_balance);
     if gv_bank_balance >= 100000 then
       dbms_output.put_line('A');
    elsif gv_bank_balance >= 0 then
           dbms_output.put_line('B');
    else
           dbms_output.put_line('C');
    end if;
    
    -- <<END_PROGRAM_STMT>>
END;


-- select * from accounts;

-- --------------------------------------------------------------------------------


-- Home Assignment

/*
    Write a function which accepts a number and returns the square of the number if the number is positive. If the number is negative raise the error negative_number.
*/

DECLARE
FUNCTION MY_SQUARE(N NUMBER) RETURN NUMBER IS
    ANS NUMBER :=0;
    NEG_NUMBER exception;
BEGIN
    
    if N < 0 then 
        raise NEG_NUMBER;
    end if;
    
    ANS := N * N;
    return ans;
EXCEPTION
    when NEG_NUMBER then
        dbms_output.put_line('EXCEPTION OCCURED --> NEGATIVE NUMBER');
        return ans;
END;
BEGIN
    dbms_output.PUT_LINE(MY_SQUARE(&Enter_The_Number));
END;

-- --------------------------------------------------------------------------------

/*

STORED PROCEDURES
    SYNTAX FOR CREATING PROCEDURES

        CREATE [OR REPLACE] PROCEDURE <procedure_name> AS
            declarative statements
        BEGIN
            .................
            .................
        END;

example:- 
    CREATE OR REPLACE PROCEDURE CHANGE(i_code IN NUMBER , i_rate IN NUMBER) IS  
    BEGIN
        UPDATE TRY 
        SET rate = i_rate 
        WHERE code = i_code;
    END;



STORED FUNCTIONS
    SYNTAX FOR CREATING PROCEDURES
    
        CRETE [OR REPLACE] FUNCTION <function_name> RETURN DATA_TYPE AS 
            declarative statements
        BEGIN
            .................
            .................
        END;

example:-
    CREATE FUNCTION ret_balance(code NUMBER IN) IS
        balance NUMBER;
        in_balance NUMBER;
        out_balance NUMBER;
    BEGIN
        select sum(qty) into in_bal from transaction where type = 'RECEIPT';
        select sum(qty) into OUT_bal from transaction where type = 'ISSUE';
        balace := in_bal - out_bal;

        RETURN balance;
    END;


*/

-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------

-- CLASSROOM EXERCISE

/*
    Write a procedure which increases the number passed as parameter by 10% and returns it. Call the procedure from another procedure passing the rate from item table for item codes 1 to 20 and update the item table with the increased rate.
*/

create or replace function update_rate(p_num float , p_rate float) RETURN float IS
    final_result FLOAT;
BEGIN
    final_result := p_num + ((p_num * p_rate )/ 100);
    return final_result;
END;


create or replace procedure increase_rate_of_item(p_itemid number) IS
    old_rate FLOAT;
    new_rate FLOAT;
BEGIN
    select itemrate into old_rate from item where itemid = p_itemid;
    new_rate := update_rate(old_rate , 10);
    update item set itemrate = new_rate where itemid = p_itemid;

    DBMS_OUTPUT.put_line('Rate updated for the item '|| p_itemid);
    DBMS_OUTPUT.put_line('Old Rate :-  '|| old_rate);
    DBMS_OUTPUT.put_line('New Rate :-  '|| new_rate);
EXCEPTION
    when NO_DATA_FOUND then
         dbms_output.put_line('EXCEPTION HAPPENED -- NO ITEM FOUND with itemid' || p_itemid);
END;


BEGIN
    increase_rate_of_item(&Enter_the_itemid);
END;

-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------

-- LAB EXERCISE

/*
    1. Write PL/SQL statement which on the basis of the order-id input, finds out the total quantity purchased by the customer in that order from the SALE-ORDER table. 
    If the total quantity is more than 500, a special discount is given to the customer. Update the discount column for each item in that order by 5% of item value (value is calculated as  (quantity * unit price) ). Else if it is less than 50 raise VERY_SMALL_ORDER exception which displays a message that the "quantity ordered for an order was very small". also display the details of the order.

    Display appropriate message if the order-id does not exist. Handle any other unexpected error also.                                           
*/

create table ORDERS1
(
    order_id number primary key,
    cust_id number,
    order_date TIMESTAMP
);

create table order_items 
(
    order_item_id number primary key , 
    order_id  number,
    product_id number,
    quantity int , 
    unit_price float , 
    discount float
);


INSERT INTO ORDERS1 (order_id, cust_id, order_date) VALUES (1, 101, TO_TIMESTAMP('2024-04-02 10:30:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO ORDERS1 (order_id, cust_id, order_date) VALUES (2, 103, TO_TIMESTAMP('2024-04-01 16:12:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO ORDERS1 (order_id, cust_id, order_date) VALUES (3, 102, TO_TIMESTAMP('2024-03-30 08:55:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO ORDERS1 (order_id, cust_id, order_date) VALUES (4, 101, TO_TIMESTAMP('2024-04-02 15:04:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO ORDERS1 (order_id, cust_id, order_date) VALUES (5, 105, TO_TIMESTAMP('2024-03-28 21:41:00', 'YYYY-MM-DD HH24:MI:SS'));


INSERT INTO order_items VALUES (1, 1, 25, 200, 15.99, 0.10); 
INSERT INTO order_items VALUES (2, 1, 14, 350, 24.50, 0);
INSERT INTO order_items VALUES (3, 1, 11, 50, 12.99, 0); 
INSERT INTO order_items VALUES (4, 1, 3, 25, 5.99, 0);
INSERT INTO order_items VALUES (5, 2, 16, 600, 9.99, 0.05);
INSERT INTO order_items VALUES (6, 2, 32, 100, 35.00, 0);
INSERT INTO order_items VALUES (7, 2, 8, 20, 17.95, 0.0);  
INSERT INTO order_items VALUES (8, 3, 11, 10, 12.99, 0);
INSERT INTO order_items VALUES (9, 3, 32, 35, 35.00, 0.15);
INSERT INTO order_items VALUES (10, 3, 5, 10, 8.50, 0);  
INSERT INTO order_items VALUES (11, 3, 21, 5, 23.00, 0);  
INSERT INTO order_items VALUES (12, 4, 28, 20, 9.99, 0);
INSERT INTO order_items VALUES (13, 4, 7, 15, 6.50, 0);  
INSERT INTO order_items VALUES (14, 4, 18, 8, 15.75, 0);
INSERT INTO order_items VALUES (15, 5, 14, 15, 24.50, 0);
INSERT INTO order_items VALUES (16, 5, 11, 5, 12.99, 0);
INSERT INTO order_items VALUES (17, 5, 6, 12, 10.50, 0.05); 
INSERT INTO order_items VALUES (18, 5, 31, 10, 48.00, 0);

select order_id , sum(quantity) from order_items group by order_id;

-- $$$$
create or replace function get_total_quantity(p_order_id int) return int IS
    total_quantity int ;
BEGIN
    SELECT SUM(quantity) INTO total_quantity
    FROM order_items
    WHERE order_id = p_order_id
    GROUP BY order_id;
    
    return total_quantity;
EXCEPTION
    WHEN NO_DATA_FOUND then
        DBMS_OUTPUT.PUT_LINE('EXCEPTION HAPPENED -- NO DATA FOUND with order_id ');
        DBMS_OUTPUT.PUT_LINE('Returning Function with -1');
        return -1;
    WHEN OTHERS then
        DBMS_OUTPUT.PUT_LINE('EXCEPTION HAPPENED -- Exception Occured ');
        DBMS_OUTPUT.PUT_LINE('Returning Function with -1');
        return -1;
END;

-- $$$$
    
CREATE OR REPLACE PROCEDURE update_disc_and_disp_data (p_order_id IN int) IS
    v_total_quantity int;
    v_order_amount int;
    v_order_discount int;
    v_final_amount int;
    END_PROCEDURE exception;
    VERY_SMALL_ORDER exception;
BEGIN
    -- get the total quantity from the function
    v_total_quantity := get_total_quantity(p_order_id);

    -- If there is no any record found in the table exit the procedure
    if(v_total_quantity <= 0) then
        raise END_PROCEDURE;
    end if;

    -- Discount Conditions
    if(v_total_quantity > 500) then     -- Update the discount to 5% of the order value i.e quantity * price
        UPDATE order_items
        SET discount =  (quantity * unit_price * 0.05)
        where order_id = p_order_id;

        DBMS_OUTPUT.PUT_LINE('Successfully updated the discount');

    elsif(v_total_quantity < 50) then   -- raise VERY SMALL ORDER EXCEPTION
        raise VERY_SMALL_ORDER;
    end if;

    -- Display the Result
    SELECT sum(quantity * unit_price) , sum(discount) into v_order_amount , v_order_discount
    FROM order_items
    WHERE order_id = p_order_id
    GROUP BY order_id;
    v_final_amount := v_order_amount - v_order_discount;
    DBMS_OUTPUT.PUT_LINE('ORDER ID:- ' || p_order_id);
    DBMS_OUTPUT.PUT_LINE('Order Amount:- ' || v_order_amount);
    DBMS_OUTPUT.PUT_LINE('Total Discount:- ' || v_order_discount);
    DBMS_OUTPUT.PUT_LINE('Final Amount:- ' || v_final_amount);

EXCEPTION
    WHEN END_PROCEDURE then
        DBMS_OUTPUT.PUT_LINE('PROCEDURE END');
    WHEN VERY_SMALL_ORDER then
        DBMS_OUTPUT.PUT_LINE('Quantity ordered for an order was very small.');
end;

-- $$$$


begin
  update_disc_and_disp_data(&Enter_the_Order_id);
end;




/*
    2. Write a procedure for the above problem. The procedure should accept a order-id as input and return 'Y' if the total quantity is more than 500, to the calling program else return 'N'.
*/

create procedure isquantitygreaterthan500(p_order_id in int) IS
    v_total_quantity int;
    END_PROCEDURE exception;
BEGIN
    v_total_quantity := get_total_quantity(p_order_id);

    if(v_total_quantity < 0) then raise END_PROCEDURE;
    elsif(v_total_quantity > 500)   then
        DBMS_OUTPUT.PUT_LINE('Y');
    else    
        DBMS_OUTPUT.PUT_LINE('N');
    end if;
EXCEPTION  
    when END_PROCEDURE then
        DBMS_OUTPUT.PUT_LINE('PROCEDURE END');
END;


begin
  isquantitygreaterthan500(&Enter_the_Order_id);
end;


/*
    3. Write a stored procedure or function that accepts an order-id and returns the total quantity ordered for that order-id.

    --> Already Implemented that Function in the Q.1 
*/

begin
    get_total_quantity(&Enter_the_Order_id);
end;


/*
    4. Use the above procedure or function in the another procedure which accepts a order-id as parameter (same order-id is passed as parameter to the above function or procedure) and if the total quantity is more than 500 for the order then the discount column for each item in that order by 5% of the item value  and if more than 1000 then by 10%.
*/

create or replace procedure update_desc(p_order_id IN int) IS
    v_total_quantity int;
    END_PROCEDURE exception;
BEGIN
    -- get the total quantity from the function
    v_total_quantity := get_total_quantity(p_order_id);

    -- If there is no any record found in the table exit the procedure
    if(v_total_quantity <= 0) then
        raise END_PROCEDURE;
    end if;

    -- Discount Conditions
    if(v_total_quantity > 1000) then
        UPDATE order_items
        SET discount =  (quantity * unit_price * 0.10)
        where order_id = p_order_id;

        DBMS_OUTPUT.PUT_LINE('Successfully updated the discount by 10%');

    elsif(v_total_quantity > 500) then   
        UPDATE order_items
        SET discount =  (quantity * unit_price * 0.05)
        where order_id = p_order_id;

        DBMS_OUTPUT.PUT_LINE('Successfully updated the discount by 5%');
    else 
        DBMS_OUTPUT.PUT_LINE('Total Order quantity is ' || v_total_quantity || ' Which is less than 500 so no discount applied');
    end if;

EXCEPTION
    WHEN END_PROCEDURE then
        DBMS_OUTPUT.PUT_LINE('PROCEDURE END');

END;


/*
    5. Write a PL/SQL block to insert data in the ITEM table. Accept data to be inserted in the ITEM table. Write error Handler which checks for errors. In case an error occures display error code and User-defined message : An error has occurred... Program has aborted!!. 
    Check the PL/SQL statements by trying to insert a duplicate item-id.
*/

declare 
    present number :=0;
    idpresent exception;
    
procedure insertData(p_itemid number := &itemid ,p_itemname varchar := &item_name,p_itemrate float :=  &item_rate) IS    
begin
    select count(*) into present from item where itemid = p_itemid;

    if present = 0 then
        insert into item values(p_itemid , p_itemname, p_itemrate);
    else
        raise idpresent;
exception
    when idpresent then
        DBMS_OUTPUT.PUT_LINE("Item Id already present")
    when others then
        DBMS_OUTPUT.PUT_LINE("An error has occurred... ")
        DBMS_OUTPUT.PUT_LINE("Program has aborted!!.")
end;

begin
    insertData();
end;

/*
    6. Write a procedure that accepts an order-id and item-id and update the discount column of that particular item in SALES-ORDER table so that it is 10% of item value. However raise an exception if discount is more than 1500.
*/




/*
    7. Write a procedure that accepts an item-id and quantity as parameter. Update the ITEM table to add the quantity accepted as the parameter to the QOH for the item. If the item-id is invalid show appropriate message.
*/


/*
    8. Write a  function (return_total) that accepts an order-id and returns back the total value of the order (that is value of each item in the order) plus any discount given for that order. Use the function return_total in a procedure final_value to find and display the final grand value of the order i.e total value of the order minus total discount. Display the appropriate messages.
*/


CREATE OR REPLACE FUNCTION return_total(p_order_id IN int) return float IS
    p_total_amount FLOAT;
BEGIN
    select sum((quantity * unit_price) - discount) into p_total_amount
    from order_items
    where order_id = p_order_id
    group by order_id;

    return p_total_amount;
EXCEPTION
         NO_DATA_FOUND then
        dbms_output.put_line('EXCEPTION HAPPENED -- NO DATA FOUND with order_id');
        return -1;
END;

CREATE OR REPLACE PROCEDURE final_value(p_order_id IN int) IS
    p_total_amount FLOAT ; 
    END_PROCEDURE exception;
BEGIN
    p_total_amount := return_total(p_order_id);

    if(p_total_amount<0)    then 
        raise END_PROCEDURE;
    end if;

    DBMS_OUTPUT.PUT_LINE('Order ID :- '|| p_order_id);
    DBMS_OUTPUT.PUT_LINE('Grand Total :- '|| p_total_amount);
EXCEPTION
    WHEN END_PROCEDURE then
        DBMS_OUTPUT.PUT_LINE('PROCEDURE END');
end;


begin
  final_value(&Enter_the_order_id);
end;


-- --------------------------------------------------------------------------------