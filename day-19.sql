--Day-18:
-- 1. Combine patient names and staff names into a single list.
-- We use UNION ALL here because we generally want to keep everyone, even if a patient 
-- has the exact same name as a staff member.
select name as full_name , 'Patient' as role from patients union all select staff_name as full_name, 'Staff' as role from staff;
-- 2. Create a union of high-satisfaction (>90) and low-satisfaction (<50) patients.
-- This is useful for analyzing extremes.
select patient_id, name, satisfaction, 'High Performer' as category from patients where satisfaction > 90 union all select patient_id, name, satisfaction, 'Low Performer' as category from patients where satisfaction < 50 order by satisfaction desc;
-- 3. List all unique names from both patient and staff tables.
-- UNION (without ALL) automatically removes duplicates
select name from patients union select staff_name from staff;
--Daily Challenge:
---Question: Create a comprehensive personnel and patient list showing: identifier (patient_id or staff_id), full name, type ('Patient' or 'Staff'), and associated service. Include only those in 'surgery' or 'emergency' services. Order by type, then service, then name.
SELECT 
    CAST(patient_id AS VARCHAR) AS identifier,
    name AS full_name, 
    'Patient' AS type, 
    service
FROM patients
WHERE LOWER(service) IN ('surgery', 'emergency')
UNION ALL
SELECT 
    CAST(staff_id AS VARCHAR) AS identifier, 
    staff_name AS full_name, 
    'Staff' AS type, 
    service
FROM staff
WHERE LOWER(service) IN ('surgery', 'emergency')
ORDER BY type, service, full_name;