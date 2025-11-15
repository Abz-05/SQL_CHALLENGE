--Day-10:
--1)Categorise patients as 'High', 'Medium', or 'Low' satisfaction based on their scores.
select patient_id, name , satisfaction , case when satisfaction > 80 then 'High' when satisfaction >= 40 then 'Medium' else 'Low' end category from patients;
--2)Label staff roles as 'Medical' or 'Support' based on role type.
select staff_name, role, case when role in ('doctor','nurse') then 'Medical' else 'Support' end role_type from staff;
--3)Create age groups for patients (0-18, 19-40, 41-65, 65+).
select name, age, case when age<=18 then 'Minor' when age between 19 and 40 then 'Major' when age between 40 and 65 then 'Adult' else 'Senior citizen' end Age_category from patients;
--Daily Challenge:
---Create a service performance report showing service name, total patients admitted, and a performance category based on the following: 'Excellent' if avg satisfaction >= 85, 'Good' if >= 75, 'Fair' if >= 65, otherwise 'Needs Improvement'. Order by average satisfaction descending.
select service, sum(patients_admitted) as total_patient_admitted , round(avg(patient_satisfaction),2) as avg_satisfaction,
case when avg(patient_satisfaction) >=85 then 'Excellent'
when avg(patient_satisfaction) >=75 then 'Good'
when avg(patient_satisfaction) >=65 then 'Fair'
else 'Needs Improvement' end performance_category
from services_weekly group by service order by avg_satisfaction desc;
