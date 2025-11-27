--Day-21:
-- 1. Create a CTE to calculate service statistics, then query from it.
with service_statistics as ( select service, count(patient_id) as total_patients, round(avg(satisfaction), 2) as avg_patient_satisfaction from patients group by service) select * from service_statistics where avg_patient_satisfaction > 80 order by avg_patient_satisfaction desc;
-- 2. Use multiple CTEs to break down a complex query into logical steps.
with staff_count as( select service, count(*) as total_staff from staff group by service), patient_count as (select service, count(*) as total_patients from patients group by service) select sc.service, sc.total_staff, pc.total_patients, round(pc.total_patients * 1.0 / sc.total_staff, 1) as patients_per_staff from staff_count sc
join patient_count pc on sc.service = pc.service;
-- 3. Build a CTE for staff utilization and join it with patient data.
with staff_utilization as ( select s.service, count(ss.week) as total_shifts_worked from staff s join staff_schedule ss on s.staff_id = ss.staff_id where ss.present = 1 group by s.service)
select p.name as patient_name, p.service, su.total_shifts_worked as service_staff_activity from patients p join staff_utilization su on p.service = su.service;
--Daily Challenge:
---Question: Create a comprehensive hospital performance dashboard using CTEs. Calculate: 1) Service-level metrics (total admissions, refusals, avg satisfaction), 2) Staff metrics per service (total staff, avg weeks present), 3) Patient demographics per service (avg age, count). Then combine all three CTEs to create a final report showing service name, all calculated metrics, and an overall performance score (weighted average of admission rate and satisfaction). Order by performance score descending.
with service_metrics as ( select service, sum(patients_admitted) as total_admitted, 
sum(patients_refused) as total_refused, avg (patient_satisfaction) as avg_service_satisfaction 
from services_weekly group by service),
staff_metrics as( select s.service, count(distinct s.staff_id) as total_staff,
avg(staff_weeks.weeks_present) as avg_weeks_present from staff s 
left join(select staff_id, count(*) as weeks_present from staff_schedule where present = 1 
group by staff_id) as staff_weeks on s.staff_id =staff_weeks.staff_id group by  s.service),
patient_demo as ( select service, count(*) as total_patients_recorded, avg(age) as avg_patient_age 
from patients group by service)
select sm.service,sm.total_admitted, sm.total_refused, 
round(sm.avg_service_satisfaction, 2) as satisfaction_score, stm.total_staff, 
round(stm.avg_weeks_present, 1) as avg_staff_presence, pd.avg_patient_age, 
round(((sm.total_admitted * 100.0 / nullif(sm.total_admitted + sm.total_refused, 0)) * 0.5)
+( sm.avg_service_satisfaction * 0.5), 2) as overall_performance_score
from service_metrics sm left join staff_metrics stm on sm.service = stm.service 
left join patient_demo pd on sm.service = pd.service order by overall_performance_score desc;
