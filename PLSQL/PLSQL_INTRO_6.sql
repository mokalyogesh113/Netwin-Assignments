/*
COMPOSITE DATATYPES
    A.  RECORD 
        Two Ways to create RECORD

        1. 
            <variable_name>  table_name%ROWTYPE    
            EX:
                item_recvar item%ROWTYPE

        2. USER DEFINED     

            record definition
            TYPE<type_name> IS RECORD
                (<field_name> {<datatype> | <variable>%TYPE | <Table>.<column>%TYPE | TABLE%ROWTYPE |}[NOT NULL]..........);


            record declaration
                <variable_name> <type_name>;


            EX:
                TYPE item_file IS RECORD
                (
                    i_code NUMBER,
                    desc VARCHAR(20),
                    rate NUMBER
                )

                item_rec item_file;
    
    B. TABLE DATATYPE
        TYPE <type_name> IS TABLE OF
            {<datatype> | <variable>.%TYPE | <table>.<column>%TYPE}
            [NOT NULL]
            INDEX BY BINARY_INTEGER;


        syntax to declare typer
            <variable_name> <type_name>
*/


-- practice
--------------------------------------------------------------------------
-- Using table%rowtype

declare
      rt_item_row item_master%rowtype;
      
begin
      select * into rt_item_row 
      from item_master 
      where item_id = &ENTER_ITEM_ID;
           
      dbms_output.put_line('ITEM ID :- ' ||rt_item_row.item_id);
      dbms_output.put_line('ITEM NAME :- ' ||rt_item_row.ITEM_NAME);
END;

--------------------------------------------------------------------------
-- Using cursor%rowtype

declare
      CURSOR C1 IS (select * from item_master);
      rt_item_row c1%rowtype;
      
begin
      open c1;
           
      loop
           fetch c1 into rt_item_row;
           if c1%NOTFOUND then 
              exit;
           end if;
           
           dbms_output.put_line('ITEM ID :- ' ||rt_item_row.item_id);
           dbms_output.put_line('ITEM NAME :- ' ||rt_item_row.ITEM_NAME);
           dbms_output.put_line('--------------------------------');
      end loop;
      
      close c1;
end;
      

--------------------------------------------------------------------------
-- Using User Defined RECORD TYPE



declare
      CURSOR C1 IS (select * from item_master);
      -- rt_item_row c1%rowtype;

      type item_file IS RECORD
      (
           item_id item_master.item_id%type,
           item_name item_master.item_name%type
      );
      
      item_rec item_file;

      
begin
      open c1;
           
      loop
           fetch c1 into item_rec;
           if c1%NOTFOUND then 
              exit;
           end if;
           
           dbms_output.put_line('ITEM ID :- ' ||item_rec.item_id);
           dbms_output.put_line('ITEM NAME :- ' ||item_rec.ITEM_NAME);
           dbms_output.put_line('--------------------------------');
      end loop;
      
      close c1;
end;