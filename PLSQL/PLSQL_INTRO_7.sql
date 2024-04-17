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
CREATE OR REPLACE PROCEDURE AddBasicSalary (numEmployees IN NUMBER)
IS
    totalSalary NUMBER := 0;
BEGIN
    FOR emp IN (SELECT EmployeeCode, BasicSalary
                FROM Employees
                ORDER BY EmployeeCode ASC)
    LOOP
        IF numEmployees > 0 THEN
            totalSalary := totalSalary + emp.BasicSalary;
            numEmployees := numEmployees - 1;
        ELSE
            EXIT; -- Exit the loop if the specified number of employees is reached
        END IF;
    END LOOP;

    -- You can perform any action with the total salary here, for example, print it
    DBMS_OUTPUT.PUT_LINE('Total Salary of ' || numEmployees || ' employees: ' || totalSalary);
END;
