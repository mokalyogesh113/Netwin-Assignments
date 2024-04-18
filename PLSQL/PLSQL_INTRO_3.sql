/*
HANDLING EXCEPTIONS
  2 types of Exceptions
    - System Defined Exceptions
        ZERO_DIVIDE
        CASE_NOT_FOUND
        VALUE_ERROR
        DUP_VAL_ON_IDX
        INVALID_CURSOR
        LOGIN_DENIED
        NO_DATA_FOUND
        NOT_LOGGED_ON
        PROGRAM_ERROR
        ROWTYPE_MISMATCH
        SELF_IS_NULL
        STORAGE_ERROR
        TOO_MANY_ROWS            
    - User-Defined Exceptions
        syntax for exception handling

            begin
                select.......
                .............
            EXCEPITON
                WHEN <exception_name> then
            end;
*/


/*
    Write a PL/SQL block to update the quantity on hand field in item file. In case quantity on hand gets more than re-order level, transaction should be rolled back and the error stored in err_msg file. Structure of item file is code, description, rate, qoh, rol.

    QOH - quantity on hand
    ROL - Re-order Level
*/


CREATE TABLE item1 (
    code VARCHAR(20) PRIMARY KEY,
    description VARCHAR(100), 
    rate DECIMAL(10,2), 
    qoh INTEGER,
    rol INTEGER
);


INSERT INTO item1 VALUES  ('ITM001', 'Widget A', 10.50, 50, 10);
INSERT INTO item1 VALUES  ('ITM002', 'Gadget 2.0', 25.99, 25, 5);
INSERT INTO item1 VALUES  ('ITM003', 'Super Tool', 5.75, 80, 20);
INSERT INTO item1 VALUES  ('ITM004', 'Thingamabob', 7.99, 45, 15);
INSERT INTO item1 VALUES  ('ITM005', 'Doohickey Deluxe', 15.25, 10, 3);
INSERT INTO item1 VALUES  ('ITM006', 'Essential Component', 3.50, 150, 40);
INSERT INTO item1 VALUES  ('ITM007', 'Basic Supply', 1.25, 300, 100);
INSERT INTO item1 VALUES  ('ITM008', 'Specialty Item', 85.00, 5, 2);
INSERT INTO item1 VALUES  ('ITM009', 'Limited Edition', 200.00, 2, 1);
INSERT INTO item1 VALUES  ('ITM010', 'Bestseller', 39.99, 35, 10);

CREATE OR REPLACE PROCEDURE update_item_qoh (p_code VARCHAR,p_quantity INTEGER) IS
  l_old_qoh INTEGER;
  l_rol INTEGER;
  err_msg VARCHAR2(200);
  
  e_exception exception;
BEGIN
  SELECT qoh,rol INTO l_old_qoh, l_rol FROM item1 WHERE code = p_code FOR UPDATE;

  IF l_old_qoh + p_quantity > l_rol THEN
     RAISE e_exception;
  END IF;

  UPDATE item1
  SET qoh = l_old_qoh + p_quantity
  WHERE code = p_code;
  
  COMMIT;

  DBMS_OUTPUT.PUT_LINE('Successfully updated quantity on hand for item ' || p_code);
EXCEPTION
  WHEN e_exception THEN
       DBMS_OUTPUT.PUT_LINE('Update failed: New qoh would exceed reorder level for item ' || p_code);
       ROLLBACK;
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error updating quantity on hand: ' || SQLERRM);
    ROLLBACK;
END;


