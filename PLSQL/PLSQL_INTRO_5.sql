/*
CREATING A TRIGGER
    
    CREATE [OR REPLACE] TRIGGER <trigger_name>  
    {BEFORE | AFTER } {INSERT | DELETE | UPDATE[OF COLUMN...]} ON <table_name>  
    [FOR EACH ROW]
    [WHEN (CONDITION)]
    [BEGIN
        -- PL/SQL BLOCK
    END;]

EXAMPLE

    CREATE OR REPLACE TRIGGER Upd
        AFTER INSERT ON SALE
        FOR EACH ROW

    BEGIN
        UPDATE item 
        SET qoh = qoh - :new.qty
        WHERE item_code = :new.code;
    END;

*/  


/*
CLASSROOM EXERCISE

    1. Write a trigger on the table item so that whenever there is an insertion, updation or deletion on the table, the trigger is fired. The trigger should insert into a table called audit_table the item code inserted,updated or deleted, the username and the transaction type {I,D,U} depending on the transaction. The audit_table contains the field code , username , type.
*/
create table audit_item(
    code int , 
    username varchar(20),
    type char
);

-- INSERT
CREATE OR REPLACE TRIGGER item_insert
AFTER INSERT ON ITEM
FOR EACH ROW
BEGIN
    INSERT INTO audit_item 
    values(:new.itemid , USER , 'I');
END;

-- UPDATE
CREATE OR REPLACE TRIGGER item_update
AFTER UPDATE ON ITEM
FOR EACH ROW
BEGIN
    INSERT INTO audit_item 
    values(:new.itemid , USER , 'U');
END;

-- DELETE
CREATE OR REPLACE TRIGGER item_delete
AFTER DELETE ON ITEM
FOR EACH ROW
BEGIN
    INSERT INTO audit_item 
    values(:old.itemid , USER , 'D');
END;



/*
CLASSROOM EXERCISE
    2. Write a trigger on the employee table so that no insertion or updation takes place on the table, on weekends i.e Saturday and Sunday.
*/

CREATE OR REPLACE TRIGGER weekend_stop
BEFORE INSERT OR UPDATE ON employee
FOR EACH ROW
DECLARE
  current_day VARCHAR2(10);
BEGIN
  current_day := TO_CHAR(SYSDATE, 'DAY'); 

  IF UPPER(current_day) IN ('SATURDAY', 'SUNDAY') THEN 
     RAISE_APPLICATION_ERROR(-20001, 'Updates not allowed on weekends');
  END IF;
END;



/*
HOME ASSIGNMENT
    create a trigger on sales table which will ensure that the code entered in sales table is valid, that is, it exists in item table.  
*/

create trigger trig_sale_ins 
BEFORE INSERT ON sales
FOR EACH ROW
DECLARE 
    IS_PRESENT int;
BEGIN
    select count(*) into IS_PRESENT from item where itemid = :new.itemid;

    if(IS_PRESENT<1) THEN
        RAISE_APPLICATION_ERROR(-20001 , 'Item not present into item table');
    end if;
END;

-- -----------------------------------------------------------------------------------------------------
/*
-- LAB EXERCISE

1. Write a trigger which fires whenever data is inserted in the SALES-ORDER table. The trigger should not allow the record to be inserted if the total ordered quantity is more than the quantity on hand for the item in the item table.

Display appropriate messeges.

*/

CREATE OR REPLACE TRIGGER SALE_ORDER_INS1 
BEFORE INSERT ON SALES_ORDER
FOR EACH ROW
DECLARE
    IS_PRESENT INT;
BEGIN
    select count(*) into IS_PRESENT from item where itemid = :new.itemid;
    if(IS_PRESENT<1) THEN
        RAISE_APPLICATION_ERROR(-20001 , 'Item not present into item table');
    end if;
END;

/*
2. Write a trigger on the SALES-ORDER table, so that whenever an attempt is made to delete a record, a check is made to ensure that the status of the order is not pending. If it is pending the record cannot be deleted.
*/

CREATE OR REPLACE TRIGGER SALE_ORDER_DEL1 
BEFORE DELETE ON SALES_ORDER
FOR EACH ROW
DECLARE
    V_STATUS INT; 
BEGIN
    select status into V_STATUS from SALE_ORDER where SALE_ID = :OLD.SALE_ID;
    IF(STATUS = "PENDING") THEN
        RAISE_APPLICATION_ERROR(-20001 , 'Pending orders cannot be deleted');
    end if;
END;


/*
3. Write a trigger on the ITEM table, so that whenever there is an insertion or updation on the table, the trigger is fired. The trigger should insert into a table called auditor the item-id and inserted or updated and transaction type I or U depending on whether the record was inserted or updated
*/

CREATE TRIGGER audit_item 
AFTER INSERT OR UPDATE ON ITEM
FOR EACH ROW
DECLARE
    insert_update VARCHAR(1);
BEGIN

  SET insert_update = IF (NEW.id IS NULL, 'I', 'U');
  INSERT INTO auditor (item_id, transaction_type)
  VALUES (NEW.id, insert_update);
END;


/*
4. Write a trigger on SALES_ORDER table which insures that the customer-id inserted exists in the CUSTOMER table and the item-id inserted exists in the ITEM table.
*/

create trigger trig_saleorder_ins5 
BEFORE INSERT ON SALES_ORDER
FOR EACH ROW
DECLARE 
    IS_PRESENT int;
BEGIN

    -- Check for customer
    select count(*) into IS_PRESENT from customers where customerid = :new.customerid;
    if(IS_PRESENT<1) THEN
        RAISE_APPLICATION_ERROR(-20001 , 'Customer not present into Customer table');
    end if;

    -- Check for Item
    select count(*) into IS_PRESENT from item where itemid = :new.itemid;
    if(IS_PRESENT<1) THEN
        RAISE_APPLICATION_ERROR(-20001 , 'Item not present into item table');
    end if;
END;

/*
5. Write a trigger which checks whenever a record is inserted in SALES-ORDER table that the shipment-date is greater than the order-date and the quantity shipped is less than or equal to the order quantity.

SHIPMENT > ORDER 

SHIPMENT_QUANTITY <= ORDER_QUANTITY
*/

create or replace sales_order_ins1
BEFORE INSERT ON SALES_ORDER 
DECLARE
    V_SHIPMENT_DATE DATE;
    V_ORDER_DATE DATE;
    V_QUANTITY_SHIPPED int;
    V_ORDER_QUANTITY INT;
BEGIN
    V_SHIPMENT_DATE := :NEW.SHIPMENT_DATE
    V_ORDER_DATE := :NEW.ORDER_DATE;

    IF(V_SHIPMENT_DATE - V_ORDER_DATE < 0 ) THEN 
        RAISE_APPLICATION_ERROR(-20001 , 'Shipment date cannot be less than the order date')
    end if;

    V_QUANTITY_SHIPPED := :NEW.QUANTITY_SHIPPED;
    V_ORDER_QUANTITY := :NEW.ORDER_QUANTITY;

    IF(V_QUANTITY_SHIPPED > V_ORDER_QUANTITY) THEN
        RAISE_APPLICATION_ERROR(-20001 , 'Shipment quantity should be less than the total order quantity');
    END IF;
END;

/*
6. Write a trigger on the CUSTOMER table which fires whenever a record is updated or deleted in CUSTOMER table to display the new data as well as the old data.
*/

create or replace trigger insert_trigger


/*
7. Write a trigger which checks whenever a record is inserted into the ORDER table that the shipment date is not on sunday.
*/





CREATE OR REPLACE TRIGGER check_shipment_date
BEFORE INSERT ON ORDER
FOR EACH ROW
DECLARE
    v_day_of_week NUMBER;
BEGIN
    SELECT TO_CHAR(:NEW.shipment_date, 'D') INTO v_day_of_week FROM dual;
    
    IF v_day_of_week = 1 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Shipment date cannot be on Sunday');
    END IF;
END;
/


/*
8. Write an instead of trigger on the cust_view created in session 5, to update the cust_mast_tab and change the address oof a customer to a new address supplied by the user.
*/