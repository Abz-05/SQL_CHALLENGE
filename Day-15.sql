--Day-15:
--1. Join patients, staff, and staff_schedule to show patient service and staff availability.
select p.patient_id, p.name as patient_name, p.service, s.staff_name, ss.week, ss.present from patients p inner join staff s on p.service = s.service left join staff_schedule ss on s.staff_id = ss.staff_id order by p.patient_id, ss.week;
--2. Combine services_weekly with staff and staff_schedule for comprehensive service analysis.
select sw.week, sw.service, sw.patients_admitted, s.staff_name, ss.present from services_weekly sw join staff s on sw.service = s.service left join staff_schedule ss on s.staff_id = ss.staff_id and sw.week = ss.week;
--3. Create a multi-table report showing patient admissions with staff information.
select p.patient_id, p.name, p.arrival_date, p.service, s.staff_name, s.role from patients p join staff s on p.service = s.service;
--Daily Challenge Query
---Question: Create a comprehensive service analysis report for week 20 showing: service name, total patients admitted, total patients refused, average patient satisfaction, count of staff assigned, and count of staff present. Order by patients admitted descending.
select sw.service, sw.patients_admitted, sw.patients_refused, 
round(avg(sw.patient_satisfaction),2) as avg_satisfaction, 
count(distinct s.staff_id) as total_staff_assigned, 
count(distinct case when ss.present = 1 then ss.staff_id end) as total_staff_present
from services_weekly sw 
left join staff s on sw.service = s.service 
left join staff_schedule ss on s.staff_id = ss.staff_id and sw.week = ss.week 
where sw.week = 20 group by sw.service, sw.patients_admitted, sw.patients_refused 
order by sw.patients_admitted desc;