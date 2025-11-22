--Day-17:
-- 1. Show each patient with their service's average satisfaction as an additional column.
select p.patient_id, p.name, p.service, p.satisfaction ,( select round(avg(satisfaction), 2) from patients p2 where p2.service = p.service) as service_avg_satisfaction from patients p;
-- 2. Create a derived table of service statistics and query from it.
select s.service, s.total_patients, s.avg_satisfaction from ( select service, count(*) as total_patients, round(avg(satisfaction),2) as avg_satisfaction from patients group by service) as s where s.avg_satisfaction > 85;
-- 3. Display staff with their service's total patient count as a calculated field.
select s.staff_name, s.service, (select count(*) from patients p where p.service = s.service) as total_service_patients from staff s;
--Daily Challenge:
---Question: Create a report showing each service with: service name, total patients admitted, the difference between their total admissions and the average admissions across all services, and a rank indicator ('Above Average', 'Average', 'Below Average'). Order by total patients admitted descending.
select sw.service, sw.total_admitted , 
(sw.total_admitted - overall.avg_admitted) as admission_diff, 
case when sw.total_admitted > overall.avg_admitted then 'Above Average' 
when sw.total_admitted = overall.avg_admitted then 'Average' 
else 'Below average' end as performance_rank 
from ( select service, sum(patients_admitted) as total_admitted from services_weekly
group by service) as sw 
cross join(select avg(service_total) as avg_admitted 
from ( select sum(patients_admitted) as service_total 
from services_weekly group by service) as internal_stats)as overall 
order by sw.total_admitted desc;
