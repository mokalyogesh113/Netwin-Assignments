-- 1. create a table item to store item code , description, rate and quantity on hand. Length of description column is not fixed and varies for every item. Rate can have decimal points.
create table item
(
       code int primary key,
       description varchar2(1000),
       rate decimal not null, 
       quantity int not null
);

-- 2. Write a statements to create a table invoice with following data
create table invoice
(
       invoice_number int primary key , 
       item_code char(2),
       qty_sold number,
       qty_on_hand number check ((qty_on_hand between 30 and 500)),
       sale_date date check (sale_date <=dual.SYSDATE) -- error here 
);


-- 3. Display details of all students in a batch, with theire average marks being increased by 6.5, and the column 'Gr' displayed more meaningfully. Assume all details of students are stored in a table called BATCH, which has the column name, RlNo, Address, AvgMks, Gr.
create table BATCH
(
       roll_no number primary key,
       name varchar(40),
       Address varchar(100),
       avg_marks decimal ,
       grade char(2)
);

insert into BATCH 
values
(1, 'Yogesh' , 'Pachora' , 88 , 'A+'),
(2, 'Tejas' , 'Jalgaon' , 92 , 'O');

select roll_no , name, least(100 , avg_marks + 6.5) avg_marks 
from BATCH;

-- 4. Display aall the differant features available in newspaper, with theire pricing increased by RS. 12.50 each.
create table newspaper
(
       feature varchar(30) , 
       section char(1) , 
       price decimal,
       page number
);

insert into newspaper
values
('Business' , 'E' , 68, 1),
('Weather' , 'C' , 90, 2),
('Television' , 'B' , 94, 7),
('Births' , 'F' , 87, 7),
('Classified' , 'F' , 69, 8),
('Modern Life' , 'F' , 77, 1),
('Comics' , 'B' , 59, 4),
('Movies' , 'C' , 56, 4),
('Bridge' , 'B' , 85, 2);

	1--> 
	select feature , price + 12.5 price from newspaper	
	2--> 
	select feature || page "What & Where" from newspaper;

-- 5.
	-- 5.1  What would be the output of the above command ? (select feature, section from newspaper where (section='A' or section = 'B') and page > 2;)
-- > It will return the records which have section A or section B and no_of_pages > 2;
	-- 5.2 what would be the output of the following commands ? would the output be any differant from that of the above command? If so why ?
-- > 
select feature , section , page from newspaper where section = 'A' and page > 2 or section = 'B';
	--> giving result records of section A having page>2 and all the records of the section B

	select feature, section, page from newspaper where page > 2 and section = 'B' or section = 'A';
	--> giving result records of section B having page > 2  and all the records of the section A.
