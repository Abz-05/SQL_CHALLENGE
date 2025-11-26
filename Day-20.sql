--Day-19:
-- 1. Rank patients by satisfaction score within each service.
select patient_id, name, service, satisfaction, dense_rank() over (partition by service order by satisfaction desc) as satisfaction_rank from patients;
-- 2. Assign row numbers to staff ordered by their name.
select staff_id, staff_name, row_number() over (order by staff_name) as row_num from staff;
-- 3. Rank services by total patients admitted.
select service, sum(patients_admitted) as total_admitted, rank() over (order by sum(patients_admitted) desc) as admission_rank from services_weekly group by service;
--Daily Challenge:
---Question: For each service, rank the weeks by patient satisfaction score (highest first). Show service, week, patient_satisfaction, patients_admitted, and the rank. Include only the top 3 weeks per service.
select * from ( select service, week, patient_satisfaction, Patients_admitted,
rank() over (partition by service order by patient_satisfaction desc) as satisfaction_rank
from services_weekly)
as ranked_weeks
where satisfaction_rank <= 3;
