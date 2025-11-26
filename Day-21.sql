--Day-20:
-- 1. Calculate running total of patients admitted by week for each service.
select service, week, patients_admitted, sum(patients_admitted) over (partition by service order by week) as running_total_admissions from services_weekly order by service, week;
-- 2. Find the moving average of patient satisfaction over 4-week periods.
select service, week, patient_satisfaction, round(avg(patient_satisfaction) over ( partition by service order by week rows between 3 preceding and current row ), 2) as moving_avg_satisfaction from services_weekly;
-- 3. Show cumulative patient refusals by week across all services.
select week, sum(patients_refused) as weekly_refusals, sum(sum(patients_refused)) over (order by week) as cumulative_gloabal_refusals from services_weekly group by week order by week;
--Daily Challenge:
---Question: Create a trend analysis showing for each service and week: week number, patients_admitted, running total of patients admitted (cumulative), 3-week moving average of patient satisfaction (current week and 2 prior weeks), and the difference between current week admissions and the service average. Filter for weeks 10-20 only.
select service, week, patients_admitted, sum(patients_admitted) 
over (partition by service order by week) as cumulative_admissions, 
round(avg(patient_satisfaction) over (partition by service 
order by week rows between 2 preceding and current row), 2) as moving_avg_satisfaction, 
patients_admitted - round(avg(patients_admitted) over (partition by service), 0) as diff_from_avg
from services_weekly where week between 10 and 20 order by service, week;
