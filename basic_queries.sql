create database main(
    ID INTEGER,
    Name VARCHAR(100),
    Age INTEGER,
    gender CHAR,
    DESIGNATION VARCHAR(100)
)
-- Select database
Create table Wiley_table(
    ID INTEGER,
    Name VARCHAR(100),
    DESIGNATION VARCHAR(100)
)

create table students(
    ID INTEGER,
    Name VARCHAR(100),
    Age INTEGER,
    gender CHAR
)

Insert into Wiley_table values(001,"Karthikeya",21,"M","Software Developer");
Insert into Wiley_table values(002,"Karthik Selva",21,"M","Software Developer");
Insert into Wiley_table values(003,"Nandhini",22,"F","Software Developer");
Insert into Wiley_table values(004,"Anitha",23,"F","SQL Developer");
Insert into Wiley_table values(005,"Priya",25,"F","Java Developer");

INSERT into students values(001, "Karthikeya",21,"M");
INSERT into students values(002, "Karthik Selva",21,"M");
INSERT into students values(003, "Nandhini",22,"F");
INSERT into students values(004, "Anitha",23,"F");
INSERT into students values(005, "Priya",25,"F");

SELECT ID,Name,Age,Gender from wiley_edge, students
where wiley_edge.ID = students.ID;
Drop table Wiley_edge
drop table students

Drop database

Show tables