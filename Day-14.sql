--Day-14:
--1)1. Show all staff members and their schedule information:
select s.staff_id,s.staff_name,s.role,ss.week,ss.present from staff s left join staff_schedule ss on s.staff_id = ss.staff_id;
--2)2. List all services from services_weekly and their corresponding staff:
select sw.service, sw.week, s.staff_name, s.role from services_weekly sw left join staff s on sw.service = s.service;
--3)Display all patients and their service's weekly statistics (if available).
select p.patient_id, p.name, p.service, sw.week, sw.patients_admitted from patients p left join services_weekly sw on p.service = sw.service;
--Daily Challenge:
---Question:Create a staff utilisation report showing all staff members (staff_id, staff_name, role, service) and the count of weeks they were present (from staff_schedule). Include staff members even if they have no schedule records. Order by weeks present descending.
select s.staff_id, s.staff_name, s.role, s.service, 
count(ss.week) as weeks_present 
from staff s 
left join staff_schedule ss on s.staff_id = ss.staff_id and ss.present = 1 
group by s.staff_id, s.staff_name, s.role, s.service order by weeks_present desc;
