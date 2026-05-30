-- PROJECT  : Library Management System
-- AUTHOR   : Priyanka
-- DATE     : May 2026
-- TOOL     : SQL Server Management Studio
-- DESC     : A complete library database to
--            manage books, members, loans
--            fines and recommendations

-- STEP 1 : Create Database

create database library 

--STEP 2 : Create Tables and insert the data

-- Table 1 : books

create Table books(book_id int identity(1,1) primary key, title varchar(200), 
author varchar(100))
insert into books values
('Twisted Love','Ana Huang'),
('Vow of Deception','Rina kent'),
('God of Fury','Rina Kent'),
('The Deal','Elle Kennedy'),
('Can we be strangers again?','Shrijeet Shandilya'),
('The Love Hypothesis','Ali Hazelwood'),
('The Wrong Sister','Claire Douglas'),
('The Book Thief','Markus Zusak')
select * from books

--Table 2 : Members

Create Table Members(member_id int identity(1,1) primary key,Name varchar(30),
Email varchar(40),
phone varchar(10),Join_date Date)
select * from Members
insert into Members values
('Aman','aman232@yahoo.com','7484738393','2026-04-12'),
('Rahul','Rahul262@gmail.com','8894738393','2026-04-01'),
('Anuj','anuj232@gmail.com','9854383999','2026-03-12'),
('Rakesh','rakesh123@gmail.com','9876738393','2026-04-24'),
('Sita','Sita543@gmail.com','8765473839','2026-01-20')  

--Table 3 : loans

Create Table loans(loan_id int identity(1,1) primary key,member_id int,book_id int,
loan_date Date Default Getdate(),Return_date Date, Due_date Date, Status varchar(20) 
default 'active',
foreign key (member_id) references Members(member_id),
foreign key (book_id) references books(book_id))
insert into loans(member_id,book_id,Due_date) values
(1,1,'2026-07-23'),
(2,5,'2026-08-13'),
(4,6,'2026-10-22')
delete from loans
select * from loans

--Table 4 : fines

Create Table fines(fine_id int identity(1,1) primary key,
loan_id int,amount decimal(10,2),issued_date Date default getdate(),
paid_status varchar(20) Default 'unpaid',
foreign key (loan_id) references loans(loan_id))
insert into fines(loan_id,amount) values
(1,50.00),
(2,120.00),
(3,30.00)
select * from fines

--Table 5 : recommendations

create table recommendations(recommendation_id int identity(1,1) primary key,
member_id int,book_Id int,
rating int,review varchar(200) 
foreign key (member_id) references Members(member_id),
foreign key (book_id) references books(book_id))
insert into recommendations(member_id,book_id,rating,review) values
(1,2,4,'Interesting Read'),
(2,5,3,'Ok Ok Not Bad'),
(2,4,5,'So Perfet'),
(3,4,4,'Was fun reading'),
(5,3,5,'This book was Phenomenal...but dark')
select * from recommendations 

--Step 3 : Queries

--See all borrowed books with member names:

select m.Name,b.title,l.loan_date,l.Due_date,l.Status from loans l
join Members m on l.member_id = m.member_id
join books b on l.book_id = b.book_id

--See who has unpaid fines:

select m.Name, f.amount,f.paid_status from fines f
join loans l on f.loan_id = l.loan_id
join Members m on l.member_id = m.member_id
where f.paid_status ='unpaid'

-- See all recommendations with member and book names 

select m.Name, b.title, r.rating,r.review from recommendations r
join Members m on r.member_id=m.member_id
join books b on r.book_Id=b.book_id

--See highest rated books

select b.title,AVG(r.rating) as Average_rating
from recommendations r
join books b on r.book_Id=b.book_id
group by b.title
order by Average_rating Desc