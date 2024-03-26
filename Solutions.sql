/*1st Question
. Name the company/s which does business in more than one stream but in same country.*/
SELECT
    *
FROM
    (
        SELECT
            comt.name   company,
            cout.name   country,
            COUNT(cout.name) country_name_count
        FROM
            country_tb            cout,
            business_tb           bust,
            company_tb            comt,
            company_business_tb   cobt
        WHERE 1 = 1
            AND comt.company_id = cobt.company_id
            AND cobt.business_id = bust.business_id
            AND bust.country_id = cout.country_id
        GROUP BY
            comt.name,
            cout.name
    ) table1
WHERE
    country_name_count >= 2;

/*2nd Question
Name the youngest manager and his/her salary, grade with allowances.*/
SELECT
    employee_name,
    salary,
    grade,
    allow
FROM
    (
        SELECT
            employee_tb.name         employee_name,
            salary,
            employee_id,
            grade_tb.name            grade,
            dob,
            facility_tb.allowances   allow
        FROM
            employee_tb,
            manager_facility_tb,
            grade_tb,
            facility_tb
        WHERE
            employee_id IN (
                SELECT
                    manager_id
                FROM
                    employee_tb
            )
            AND employee_tb.manager_id = manager_facility_tb.manager_id
            AND manager_facility_tb.grade_id = grade_tb.grade_id
            AND manager_facility_tb.facility_id = facility_tb.facility_id
        ORDER BY
            dob DESC
    )
WHERE
    ROWNUM = 1;
    
/*3rd Question
-Name the employees, designation, 
department, country and their DOB who either shares the same month or same
year in their DOB.*/
Select distinct e1.name Employee_name,
designation_tb.name Designation,
departments_tb.name Department,
country_tb.name Country,
e1.dob DOB
from 
employee_tb e1,
employee_tb e2,
designation_tb,
departments_tb,
country_tb,
com_dep_tb
where (e1.employee_id!=e2.employee_id AND (EXTRACT(MONTH FROM e1.DOB) = EXTRACT(MONTH FROM e2.DOB)
       OR EXTRACT(YEAR FROM e1.DOB) = EXTRACT(YEAR FROM e2.DOB)))
and   e1.designation_id=designation_tb.designation_id
and   e1.com_dep_id=com_dep_tb.com_dep_id
and   com_dep_tb.department_id=departments_tb.department_id
and   com_dep_tb.country_id=country_tb.country_id;

/*4th Question
Name the employee, designation, grade, country and manager
who have the second best salary in the database.*/
SELECT
    sub.*,
    employee_tb.name
FROM
    (
        SELECT DISTINCT
            emt1.name             employee_name,
            emt1.salary           salary,
            emt1.manager_id,
            designation_tb.name   designation,
            grade_tb.name         grade,
            country_tb.name       country
        FROM
            employee_tb emt1,
            designation_tb,
            grade_tb,
            country_tb,
            manager_facility_tb,
            com_dep_tb
        WHERE
            emt1.salary IN (
                SELECT
                    MAX(salary)
                FROM
                    employee_tb
                WHERE
                    salary < (
                        SELECT
                            MAX(salary)
                        FROM
                            employee_tb
                    )
            )
            AND emt1.designation_id= designation_tb.designation_id
            AND emt1.manager_id = manager_facility_tb.manager_id
            AND manager_facility_tb.grade_id = grade_tb.grade_id
            AND emt1.com_dep_id = com_dep_tb.com_dep_id
            AND com_dep_tb.country_id = country_tb.country_id
    ) sub,
    employee_tb
WHERE
    sub.manager_id = employee_tb.employee_id;

/*5th Question
Name the employee/s,mail,age,department,designation, 
grade,country and manager who have two ‘e’ or two ‘y’ in their name.*/
SELECT
    sub.*,
    employee_tb.name manager
FROM
    (
        SELECT DISTINCT
            emt1.name             employee_name,
            emt1.manager_id,
            designation_tb.name   designation,
            grade_tb.name         grade,
            country_tb.name       country
        FROM
            employee_tb emt1,
            designation_tb,
            grade_tb,
            country_tb,
            manager_facility_tb,
            com_dep_tb
        WHERE
            ( length(emt1.name) - length(replace(emt1.name, 'e', '')) = 2
              OR length(emt1.name) - length(replace(emt1.name, 'y', ''))=2 )
            AND emt1.designation_id = designation_tb.designation_id
            AND emt1.manager_id = manager_facility_tb.manager_id
            AND manager_facility_tb.grade_id = grade_tb.grade_id
            AND emt1.com_dep_id = com_dep_tb.com_dep_id
            AND com_dep_tb.country_id = country_tb.country_id
    ) sub,
    employee_tb
WHERE
    sub.manager_id = employee_tb.employee_id;
    
/*6th Question
Name the employees with their salary, department,country, managers 
and total allowances given to them who have mail account in Hotmail.*/
SELECT
    sub.employee_name   employee_name,
    sub.salary          salary,
    sub.department      department,
    sub.country         country,
    employee_tb.name    manager,
    SUM(facility_tb.allowances) total_allownace
FROM
    (
        SELECT DISTINCT
            emt1.name             employee_name,
            emt1.salary           salary,
            emt1.manager_id       manager,
            departments_tb.name   department,
            country_tb.name       country
        FROM
            employee_tb emt1,
            departments_tb,
            country_tb,
            com_dep_tb
        WHERE
            mail_id LIKE '%hotmail.com'
            AND emt1.com_dep_id = com_dep_tb.com_dep_id
            AND com_dep_tb.department_id = departments_tb.department_id
            AND com_dep_tb.country_id=country_tb.country_id
    ) sub,
    employee_tb,
    manager_facility_tb,facility_tb
WHERE
    sub.manager = employee_tb.employee_id
    AND sub.manager = manager_facility_tb.manager_id
    AND manager_facility_tb.facility_id = facility_tb.facility_id
GROUP BY
    sub.employee_name,
    sub.salary,
    sub.department,
    sub.country,
    employee_tb.name;

/*7th Question
Name the company/s which has any particular department in all countries.*/
SELECT
    sub.company_name
FROM
    (
        SELECT
            company_tb.name company_name,
            departments_tb.name,
            COUNT(country_tb.name) AS country_count
        FROM
            company_tb,
            departments_tb,
            company_business_tb,
            com_dep_tb,
            country_tb
        WHERE
            company_tb.company_id = company_business_tb.company_id
            AND company_business_tb.com_bus_id = com_dep_tb.com_bus_id
            AND departments_tb.department_id = com_dep_tb.department_id
            AND com_dep_tb.country_id = country_tb.country_id
        GROUP BY
            company_tb.name,
            departments_tb.name
    ) sub
WHERE
    country_count = 4;
