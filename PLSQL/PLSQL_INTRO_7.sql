/*
CURSORS


    CURSOR ATTRIBUTES
        - %NOTFOUND -- is used to determine that no rows are processed
        - %FOUND    -- is used to determine if rows are processed 
        - %ROWCOUNT -- is used to determine number of rows processed
        - %ISOPEN   -- to check whether cursor is open


CREATING CURSORS
    Step 1. Declare the Cursor
        CURSOR <cursor_name> IS
            select ......
        

        example : 
            DECLARE
                dept varchar2(5):='MKT';
                CURSOR CUR1 IS
                    select code, name , department FROM employee WHERE department = dept;
                begin
                    ........
                end;            
    
    Step 2. Open the cursor
        open <cursor_name> 
        open <cursor_name>(parameters) 

    step 3. Fetch Data from the cursor
        Fetch Cursor Name into <varaible_name> ,<variable_name>...
    


    Example:-

            Declare
                e_code Number,;
                e_name varchar2(20);
                CURSOR emp_details(dept varchar2) IS(<select stmt>)
            BEGIN
                OPEN emp_details;
                LOOP
                    FETCH emp_details into e_code , e_name 
                    EXIT when emp_details%NOTFOUND
                    -- process retrieved data here;
                END LOOP;
            END;

    Step 4:- Close The Cursor
            

            Declare
                e_code Number,;
                e_name varchar2(20);
                CURSOR emp_details(dept varchar2) IS(<select stmt>)
            BEGIN
                OPEN emp_details;
                LOOP
                    FETCH emp_details into e_code , e_name 
                    EXIT when emp_details%NOTFOUND
                    -- process retrieved data here;
                END LOOP;
        -------------------------------------------
                -- Close Cursor Here
                close emp_details;
        -------------------------------------------
            END;
*/


/*
Classroom Exercise 
    Write a cursor which adds the basic salary of a particular number of employees on the basic of ascending employee code. The number is passed as a parameter to the cursor.
*/

/*
Classroom Exercise
    Write a cursor that calculates the total of all the salary (basic + hra) paid to employees in 'ACCTS' department. Also count how many employees have salaries above 7000 and how many have hra as 50% of basic.
*/


Declare
    cursor c_employee as (select emp_id , emp_basic , emp_hra 
                          from employee1 
                          where emp_dept = 'ACCTS'); 

    v_basic employee.emp_basic%type;
    v_hra employee.emp_hra%type;

    v_cnt_greater_than_7000 employee.emp_basic%type := 0;
    v_cnt_hra_50_of_basic int:= 0;
    v_total_salary int:= 0;
    
begin
    open c_employee;

        LOOP 
            fetch c_employee into v_basic,v_hra;
            EXIT when c_employee%NOTFOUND;

            v_total_salary := v_total_salary + v_basic + v_hra;
            
            if v_basic + v_hra > 7000 then
                v_cnt_greater_than_7000 := v_cnt_greater_than_7000 + 1
            end if;

            if v_hra * 2 >= v_basic then
                v_cnt_hra_50_of_basic := v_cnt_hra_50_of_basic + 1
            end if;

        END LOOP;

        DBMS_OUTPUT.PUT_LINE('Total Salary:- '|| v_total_salary);
        DBMS_OUTPUT.PUT_LINE('Count(sal>7000):- '|| v_cnt_greater_than_7000);
        DBMS_OUTPUT.PUT_LINE('count(hra 50% of basic):- '|| v_cnt_hra_50_of_basic);


    close c_employee
end;

-- =============================================================================

Declare
    cursor c_employee IS (select basic ,hra 
                          from employee1 ); 

    v_basic employee1.basic%type;
    v_hra employee1.hra%type;

    v_cnt_greater_than_7000 employee1.basic%type := 0;
    v_cnt_hra_50_of_basic int:= 0;
    v_total_salary int:= 0;
    
begin
    open c_employee;

        LOOP 
            fetch c_employee into v_basic,v_hra;
            EXIT when c_employee%NOTFOUND;

            v_total_salary := v_total_salary + v_basic + v_hra;
            
            if v_basic + v_hra > 7000 then
                v_cnt_greater_than_7000 := v_cnt_greater_than_7000 + 1;
            end if;

            if v_hra * 2 >= v_basic then
                v_cnt_hra_50_of_basic := v_cnt_hra_50_of_basic + 1;
            end if;

        END LOOP;

        DBMS_OUTPUT.PUT_LINE('Total Salary:- '||v_total_salary);
        DBMS_OUTPUT.PUT_LINE('Count(sal>7000):- '||v_cnt_greater_than_7000);
        DBMS_OUTPUT.PUT_LINE('count(hra 50% of basic):- '||v_cnt_hra_50_of_basic);

    close c_employee;

end;


-- =============================================================================
-- LAB EXERCISE

/*
1. 
    Write a cursor which updates the unit-price of items in the ITEM table. The unit-price is increased by 5% if it is less than 20, else increased by 3% if more than 20 but less than 30 and by 2% if more than 30 but less than 50. There is no increase in price for items whose unit-price is more than 50.

    Keep Count of number of items whose unit-price was increased and the total increased amount. Display the old and the new price of the items whose price was modified. At end display the total number of items whose pice was modified as follows: 

        Number of items(with price less than 20Rs):
        Average price increased:
        
        Number of items(with price between 20-30Rs):
        Average Price increased:
*/


-- Item Table
-- Update unit price 
    -- 5% if less than 20
    -- 3% if more than 20 and less than 30
    -- 2% if more than 30 and less than 50
    -- 0% after 50

-- keep count of increased items
-- total increased amount
-- Display the old and the new price of items of modified items
-- Display total no. of items whose


DECLARE
    
    -- RECORDS
    r_item  item%rowtype;

    -- CURSORS
    cursor c_item IS select * from item;
    
    -- VARIABLES
    v_old_price item.itemrate%type;
    v_new_price item.itemrate%type;
    v_increased_cnt int := 0;

BEGIN
    OPEN c_item;
    LOOP
        FETCH c_item INTO r_item;
        EXIT WHEN c_item%NOTFOUND;

        v_old_price := r_item.itemrate;
        if v_old_price < 20 then
            v_new_price := (v_old_price + (v_old_price*0.05));
        elsif v_old_price < 30 then
            v_new_price := (v_old_price + (v_old_price*0.03));
        elsif v_old_price < 50 then
            v_new_price := (v_old_price + (v_old_price*0.02));
        else
            v_new_price := v_old_price;
        end if;

        if(v_old_price < v_new_price) then
            update item
            set itemrate = v_new_price
            where itemid = r_item.itemid;

            v_increased_cnt := v_increased_cnt + 1;

            DBMS_OUTPUT.PUT_LINE('Item Rate Updated ');
            DBMS_OUTPUT.PUT_LINE('Item ID:- ' || r_item.itemid);
            DBMS_OUTPUT.PUT_LINE('Item Name:- ' || r_item.itemname);
            DBMS_OUTPUT.PUT_LINE('Old Price:- ' || v_old_price);
            DBMS_OUTPUT.PUT_LINE('New Price:- ' || v_new_price);
            DBMS_OUTPUT.PUT_LINE('------------------------------------');

        end if;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Total Rates Increased:- ' || v_increased_cnt);
    CLOSE c_item;
END; 



/*
2.
    Write a cursor which accepts an order-id from the user and displays all the details of the order. Find out the total quantity shipped in that order and the total quantity ordered. Display the discrepancy between the two values if any.
    If the quantity ordered for any of the item is less than 10, update the quantity and set it equal to 10, as a minimum order of 10 is accepted only.
*/

-- Accept order id
-- display all the details of the order 
-- total quantity shipped in that order & total quantity ordered 
-- Display the discrepancy between those two values iif any
-- If the quantity ordered < 10 --> update quantity and set to 10 as minimum order of 10 is accepted only.

create or replace procedure proc_disp_ord_details(p_order_id) AS
    

BEGIN



END;





/*
3.
    Write a cursor which accepts a cust-id and item-id and display the total quantity ordered for that item by that customer. Also find out the total quantity of that item sold and percentage share of that particular customer in the total saled for the item.
    */
DECLARE
 
BEGIN



END;