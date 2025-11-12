--1. Extract the year from all patient arrival dates
select patient_id, arrival_date, extract(year from arrival_date) as arrival_year from patients;
--2. Calculate the length of stay for each patient
select patient_id, arrival_date, departure_date, (departure_date - arrival_date) as length_of_stay from patients;
--3. Find all patients who arrived in a specific month
select patient_id, name, arrival_date from patients where extract(month from arrival_date) = 10;
--Daily Challenge Query: 
---(This query calculates the average stay, 
---groups it by service, counts the patients, 
---then filters those groups to only show avg. stays > 7 days.)
select service, 
count(patient_id) as patient_count, 
round(avg(departure_date - arrival_date),2) as avg_length_of_stay 
from patients group by service 
having avg(departure_date - arrival_date) > 7 
order by avg_length_of_stay desc;
