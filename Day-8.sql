--1)Convert all patient names to uppercase.
--select patient_id, upper(name) as Patient_name from patients order by patient_name;
--2)Find the length of each staff member's name.
--select staff_id, staff_name , length(staff_name) as Length_of_staff_name, service from staff order by Length_of_staff_name;
--3)Concatenate staff_id and staff_name with a hyphen separator.
--select service, concat_ws('_', staff_id, staff_name, role) as Staff_roles from staff order by role;
--Daily Challenge:
---Question: Create a patient summary that shows patient_id, full name in uppercase, 
--service in lowercase, age category (if age >= 65 then 'Senior', if age >= 18 
--then 'Adult', else 'Minor'), and name length. Only show patients whose name length is 
--greater than 10 characters.
select patient_id, upper(name) as patient_name, 
lower(service) as admission_type, age, length(name) as name_length, 
(case when age >= 65 then 'Senior' when age >= 18 then 'Adult' else 'Minor' end) 
as age_category 
from patients order by length(name) > 10;