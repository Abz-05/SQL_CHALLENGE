--Day-13:
--1)Join patients and staff based on their common service field:
select p.patient_id, p.name as patient_name, p.service, s.staff_name, s.role as staff_role from patients p inner join staff s on p.service = s.service;
--2)Join services_weekly with staff to show weekly service data with staff information:
select sw.week, sw.service, sw.patients_admitted, s.staff_name, s.role from services_weekly sw inner join staff s on sw.service = s.service;
--3)Create a report showing patient information along with staff assigned to their service:
select p.patient_id, p.name as patient_name, p.age, p.service, s.staff_name, s.role as assigned_staff_role from patients p inner join staff s on p.service = s.service order by p.patient_id;
--Daily Challenge Query:
--- Create a comprehensive report showing patient_id, patient name, age, service, and the total number of staff members available in their service. Only include patients from services that have more than 5 staff members. Order by number of staff descending, then by patient name.
with service_staff_count as 
(select service, count(staff_id) as tot_staff_in_service 
from staff group by service having count(staff_id)>5)
select p.patient_id, p.name as patient_name, 
p.age, p.service, ssc.tot_staff_in_service 
from patients p 
inner join service_staff_count ssc on p.service = ssc.service 
order by ssc.tot_staff_in_service desc, patient_name asc;
