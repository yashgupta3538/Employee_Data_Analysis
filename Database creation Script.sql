drop table country_tb cascade constraints;
CREATE TABLE country_tb
  (
    country_id NUMBER(20) PRIMARY KEY,
    name       VARCHAR2(25) NOT NULL
  );

INSERT ALL
INTO country_tb VALUES
  (1,'INDIA')
 INTO country_tb VALUES
  (2,'UK')
INTO country_tb VALUES
  (3,'US')
INTO country_tb VALUES
  (4,'AUS')
SELECT * FROM dual ;


drop table business_tb cascade constraints;
CREATE TABLE business_tb
  (
    business_id NUMBER(20) PRIMARY KEY,
    name        VARCHAR2(25) NOT NULL,
    country_id  NUMBER(20),
    CONSTRAINT fk_business_tb_country_id FOREIGN KEY (country_id) REFERENCES country_tb(country_id)
  );

INSERT ALL
INTO business_tb VALUES
  (1,'STEEL',1)
INTO business_tb VALUES
  (2,'OIL',2)
INTO business_tb VALUES
  (3,'IT-HARDWARE',3)
INTO business_tb VALUES
  (4,'WOOD',3)
INTO business_tb VALUES
  (5,'FOOD',4)
INTO business_tb VALUES
  (6,'IT-SOFTWARE',2)
INTO business_tb VALUES
  (7,'AUTO',2)
INTO business_tb VALUES
  (8,'GOLD',1)
SELECT * FROM dual;

drop table company_tb cascade constraints;
CREATE TABLE company_tb
  (
    company_id NUMBER(20) PRIMARY KEY,
    name       VARCHAR2(25) NOT NULL
  );

INSERT ALL
INTO company_tb VALUES
  (1,'TATA')
INTO company_tb VALUES
  (2,'RELIANCE')
INTO company_tb VALUES
  (3,'WIPRO')
INTO company_tb VALUES
  (4,'GULF')
INTO company_tb VALUES
  (5,'VOLKSWAGEN')
INTO company_tb VALUES
  (6,'ITC')
SELECT * FROM dual;

drop table company_business_tb cascade constraints;
CREATE TABLE company_business_tb
  (
    com_bus_id  NUMBER (20) PRIMARY KEY,
    company_id NUMBER (20) REFERENCES company_tb(company_id),
    business_id NUMBER (20)REFERENCES business_tb(business_id)
  );

INSERT ALL
INTO company_business_tb VALUES
  (1,1,1)
INTO company_business_tb VALUES
  (2,2,2)
INTO company_business_tb VALUES
  (3,3,3)
INTO company_business_tb VALUES
  (4,4,2)
INTO company_business_tb VALUES
  (5,5,7)
INTO company_business_tb VALUES
  (6,6,4)
INTO company_business_tb VALUES
  (7,1,6)
INTO company_business_tb VALUES
  (8,3,6)
INTO company_business_tb VALUES
  (9,6,5)
INTO company_business_tb VALUES
  (10,1,8)
SELECT * FROM dual;

drop table departments_tb cascade constraints;
CREATE TABLE departments_tb
  (
    department_id NUMBER(20) PRIMARY KEY,
    name          VARCHAR(20) NOT NULL
  );

INSERT ALL
INTO departments_tb VALUES
  (1,'HR')
INTO departments_tb VALUES
  (2,'ADMIN')
INTO departments_tb VALUES
  (3,'FINANCE')
INTO departments_tb VALUES
  (4,'IT')
SELECT * FROM dual;

drop table com_dep_tb cascade constraints;
CREATE TABLE com_dep_tb
  (
    com_dep_id    NUMBER(20) PRIMARY KEY,
    department_id NUMBER(20) REFERENCES departments_tb(department_id),
    com_bus_id    NUMBER(20) REFERENCES company_business_tb(com_bus_id),
    country_id    NUMBER (20) REFERENCES country_tb(country_id)
  );

INSERT ALL
INTO com_dep_tb VALUES
  (1,1,5,1)
INTO com_dep_tb VALUES
  (2,2,2,1)
INTO com_dep_tb VALUES
  (3,3,3,2)
INTO com_dep_tb VALUES
  (4,4,4,2)
INTO com_dep_tb VALUES
  (5,1,5,2)
INTO com_dep_tb VALUES
  (6,4,6,1)
INTO com_dep_tb VALUES
  (7,3,2,1)
INTO com_dep_tb VALUES
  (8,4,3,3)
INTO com_dep_tb VALUES
  (9,1,4,1)
INTO com_dep_tb VALUES
  (10,1,5,3)
INTO com_dep_tb VALUES
  (11,2,3,2)
INTO com_dep_tb VALUES
  (12,3,4,3)
INTO com_dep_tb VALUES
  (13,4,1,1)
INTO com_dep_tb VALUES
  (14,1,1,1)
INTO com_dep_tb VALUES
  (15,4,4,3)
INTO com_dep_tb VALUES
  (16,3,3,3)
INTO com_dep_tb VALUES
  (17,4,2,1)
INTO com_dep_tb VALUES
  (18,1,5,4)
SELECT * FROM dual;


drop table designation_tb cascade constraints;
CREATE TABLE designation_tb
  (
    designation_id NUMBER(20) PRIMARY KEY,
    name           VARCHAR2(25) NOT NULL,
    role           VARCHAR2(25) NOT NULL
  );

INSERT ALL
INTO designation_tb VALUES
  (1,'AM','Single')
INTO designation_tb VALUES
  (2,'SM','Multiple')
INTO designation_tb VALUES
  (3,'ED','Multiple')
INTO designation_tb VALUES
  (4,'D','Multiple')
SELECT * FROM dual;

drop table facility_tb cascade constraints;
CREATE TABLE facility_tb
  (
    facility_id NUMBER (20) PRIMARY KEY,
    name        VARCHAR2(25) NOT NULL,
    allowances  NUMBER(20) NOT NULL
  );

INSERT ALL
INTO facility_tb VALUES
  (1,'Medical',1000)
INTO facility_tb VALUES
  (2,'Car',2000)
INTO facility_tb VALUES
  (3,'Rent',3000)
INTO facility_tb VALUES
  (4,'Telephone',500)
SELECT * FROM dual;

drop table employee_tb cascade constraints;
CREATE TABLE employee_tb
  (
    employee_id    NUMBER(20) PRIMARY KEY,
    name           VARCHAR2(25),
    salary         NUMBER(20),
    dob            DATE ,
    mail_id        VARCHAR2(30),
    com_dep_id     NUMBER(20) REFERENCES com_dep_tb(com_dep_id),
    designation_id NUMBER(20) REFERENCES designation_tb(designation_id),
    manager_id     NUMBER (20) REFERENCES employee_tb(employee_id)
  );

INSERT ALL
INTO employee_tb VALUES
  (1,'John',1000,'12-Jan-85','xyz@gmail.com',1,1,1)
INTO employee_tb VALUES
  (2,'Smith',2000,'12-Oct-84','xyz@yahoo.com',2,2,1)
INTO employee_tb VALUES
  (3,'Syndy',1500,'1-Mar-85','xyz@hotmail.com',3,1,1)
INTO employee_tb VALUES
  (4,'Alex',5000,'26-Jan-73','xyz@rediffmail.com',4,3,1)
INTO employee_tb VALUES
  (5,'Peter',2500,'17-Jun-81','xyz@gmail.com',14,2,4)
INTO employee_tb VALUES
  (6,'Bruce',8000,'10-Dec-71','xyz@yahoo.com',6,4,6)
INTO employee_tb VALUES
  (7,'Tim',3000,'18-Apr-83','xyz@gmail.com',17,2,4)
INTO employee_tb VALUES
  (8,'Frank',4000,'12-Nov-81','xyz@hotmail.com',18,2,6)
SELECT * FROM dual;

update employee_tb set manager_id=3 where employee_id=1;
update employee_tb set manager_id=4 where employee_id=2;
update employee_tb set manager_id=5 where employee_id=3;
update employee_tb set manager_id=6 where employee_id=4;

drop table grade_tb cascade constraints;
CREATE TABLE grade_tb
  (
    grade_id NUMBER (20) PRIMARY KEY,
    name     VARCHAR2(25) NOT NULL
  );

INSERT ALL 
INTO grade_tb VALUES
  (1,'M') 
INTO grade_tb VALUES
  (2,'M+')
SELECT * FROM dual;

drop table manager_facility_tb cascade constraints;
CREATE TABLE manager_facility_tb
  (
    man_fac_id  NUMBER(20) PRIMARY KEY,
    manager_id  NUMBER(20),
    grade_id    NUMBER(20) REFERENCES grade_tb(grade_id),
    facility_id NUMBER(20) REFERENCES facility_tb(facility_id)
  );

INSERT ALL
INTO manager_facility_tb VALUES
  (1,3,1,4)
INTO manager_facility_tb VALUES
  (2,4,1,1)
INTO manager_facility_tb VALUES
  (3,5,2,4)
INTO manager_facility_tb VALUES
  (4,6,2,1)
INTO manager_facility_tb VALUES
  (5,4,1,3)
INTO manager_facility_tb VALUES
  (6,6,2,2)
INTO manager_facility_tb VALUES
  (7,6,2,3)
INTO manager_facility_tb VALUES
  (8,6,2,4)
INTO manager_facility_tb VALUES
  (9,4,1,4)
SELECT * FROM dual;
