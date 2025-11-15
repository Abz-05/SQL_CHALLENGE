--Day-12:
--1)1. Find all weeks in services_weekly where no special event occurred.
select * from services_weekly where event is null;
--2. Count how many records have null or empty event values.
select count(*) as null_count from services_weekly where event is null or event = '';
--3)3. List all services that had at least one week with a special event.
select distinct service from services_weekly where event is not null;
--Daily Challenge:
---Question:Analyze the event impact by comparing weeks with events vs weeks without events. Show: event status ('With Event' or 'No Event'), count of weeks, average patient satisfaction, and average staff morale. Order by average patient satisfaction descending.
select case when event is null or lower(event) ='none' then 'No event' 
else 'With event' end as event_status, 
count(distinct week) as count_of_weeks, 
round(avg(patient_satisfaction),2) as avg_patient_satisfaction, 
round(avg(staff_morale), 2) as avg_staff_morale 
from services_weekly 
group by event_status 
order by avg_patient_satisfaction desc;
