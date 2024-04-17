/*
CREATING A PACKAGE

    syntax for package specification
        create [or replace] package <package_name>
        {IS | AS}
        PL/SQL package specification


    syntax for package body 
        create [or replace] package body <package body name>
        {IS | AS}
        PL/SQL PACKAGE BODY 


    NOTE: The name of the package body and package specification should be same

EXAMPLE 

    -- PACKAGE SPECIFICATION
    
    create or replace package emp_pack as
        procedure accept;
        procedure delete;
        function update_emp return number;
    end;


    -- PACKAGE BODY

    create or replace package body emp_pack as
        procedure accept as
        begin
            DBMS_OUTPUT.PUT_LINE('Accept');
        end;

        procedure delete as
        begin
            DBMS_OUTPUT.PUT_LINE('Delete');
        end;

        function update_emp return int is
        begin
            DBMS_OUTPUT.PUT_LINE('Update');
        return 0;
        end;
    end emp_pack;

    begin
        emp_pack.accept();    
    end;

*/

/*
-- CLASSROOM EXERCISE
    Write package for employee table
      - Write a procedure which accepts employee details as parameters and inserts in employee table.
      - Write a procedure which accepts employee code as parameter and deltes that record.
      - Write a function which accepts employee code and new basic salary for the employee and updates the record.

-- HOME ASSIGNMENT
    Add the above example a function that helps in querying the employee table. Accept a employee code as a parameter and return the employee name and department
*/

create table employee 
(
       id int , 
       name varchar(200),
       salary float
);


create or replace package emp_pack as
    procedure insert_record(p_id int , p_name varchar , p_salary float);
    procedure delete_record(p_id int);
    function update_record(p_id int , p_salary float) return boolean;
end;

create or replace package body emp_pack as

    procedure insert_record(p_id int , p_name varchar , p_salary float) as
    present int;
    ID_PRESENT EXCEPTION;
    begin

        select count(*) into present from employee where id = p_id;

        if present = 0 then
            insert into employee values(p_id , p_name, p_salary);
        else
            raise ID_PRESENT;
        END IF;

        DBMS_OUTPUT.put_line('Data inserted Successfully');
    EXCEPTION
        when ID_PRESENT then
            DBMS_OUTPUT.PUT_LINE('Item Id already present');
        when others then
            DBMS_OUTPUT.PUT_LINE('An error has occurred... ');
            DBMS_OUTPUT.PUT_LINE('Program has aborted!!.');        
    end;

    procedure delete_record(p_id int) as
    begin
        delete from employee where id = p_id;
        DBMS_OUTPUT.PUT_LINE('Record Deleted Successfully....');        
    EXCEPTION
        when NO_DATA_FOUND then
            DBMS_OUTPUT.PUT_LINE('No Record Found to delete.');        
        when others then
            DBMS_OUTPUT.PUT_LINE('An error has occurred... ');
            DBMS_OUTPUT.PUT_LINE('Program has aborted!!.');        
    end;

    function update_record(p_id int, p_salary float) return boolean is
    begin
        update employee 
        set salary = p_salary
        where id = p_id;

        DBMS_OUTPUT.PUT_LINE('Record Updated Successfully....');
        RETURN TRUE;
    EXCEPTION   
        when NO_DATA_FOUND then
            DBMS_OUTPUT.PUT_LINE('No Record Found to Update.');        
            RETURN FALSE;
        when others then
            DBMS_OUTPUT.PUT_LINE('An error has occurred... ');
            DBMS_OUTPUT.PUT_LINE('Program has aborted!!.');
            RETURN FALSE;
    end;
end emp_pack;

-- -------------------------------------------------------------------------

