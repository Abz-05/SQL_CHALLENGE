Day 1:
--SELECT * FROM patients LIMIT 5;

--select * from patients;

--select name, age from patients;

/*select name, age from patients 
where age >=50
order by name;

select name, age from patients 
where age >=50
order by age;*/


/*select name, age from patients 
where age >=50
order by age desc;*/

/*select name, age, service from patients 
where age >=50 and service = 'emergency'
order by age desc;*/

/*select name, age, service from patients 
where age >=50 and service = 'emergency'
order by age desc, name;*/

--1) Retrive all columns from the patients table
--select * from patients;

--2) select only patient_id, name, age columns from the patients table
--select patient_id, name, age from patients order by age desc, name;

--3) display the first 10 records fro the services_weekly table
--select * from services_weekly limit 10;

--Daily Challenge: listing unique hospital services
--select distinct service as unique_services from patients;