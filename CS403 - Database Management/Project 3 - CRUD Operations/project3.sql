/*
 *  project3.sql
 * 
 *  author: Nicholas McClellan
 *
 */
/* use the correct schema */
set search_path to nmcclellan;
-- Using the protip
DROP TABLE IF EXISTS schedule;
DROP TABLE IF EXISTS transcript;
-- Stage 1:
-- Step 1 Create the Table
CREATE TABLE schedule (term text, course_id text, section text, title text, instructor text, days text, begin_time time);
-- Step 2 Insert the Data
-- First row
INSERT INTO schedule (term, course_id, section, title, instructor, days, begin_time)
VALUES ('Fall', 'MATH201', 'B', 'PROBABILITY & STATISTICS','Munson, Ashlyn', 'TR', '11:00:00');
-- Remaining rows
INSERT INTO schedule (term, course_id, section, title, instructor, days, begin_time)
VALUES ('Fall', 'CSCI262', 'B', 'DATA STRUCTURES', 'Painter-Wakefield, Christopher', 'MWF', '13:30:00'),
('Fall', 'CSCI358', 'A', 'DISCRETE MATHEMATICS', NULL, 'TR', '09:30:00'),
('Fall', 'MATH225', 'C', 'DIFFERENTIAL EQUATIONS', 'Strong, Scott', 'MWF', '16:00:00');
-- Step 3 Fix Error
UPDATE schedule
SET begin_time = '13:00:00'
WHERE course_id = 'CSCI262' AND section = 'B';
-- Stage 2:
-- Step 4 Create Another Table  
CREATE TABLE transcript (term text, course_id text, title text, grade text, credits NUMERIC(4,2), quality_points NUMERIC(4,2));
-- Step 5 Add the Data (again)
-- The INSERT INTO asked for
INSERT INTO transcript(term, course_id, title)
SELECT s.term, s.course_id, s.title
FROM schedule s;
-- Step 6 Enter Grades (and Credits/QualityPoints)
-- Setting the credits to 3.0
UPDATE transcript
SET credits = '3.0';
-- Setting Grades
UPDATE transcript
SET grade = 'B', quality_points = '9.0'
WHERE title = 'DISCRETE MATHEMATICS' OR title = 'DATA STRUCTURES';
UPDATE transcript
SET grade = 'A', quality_points = '12.0'
WHERE title = 'PROBABILITY & STATISTICS';
UPDATE transcript
SET grade = 'A-', quality_points = '11.1'
WHERE title = 'DIFFERENTIAL EQUATIONS';
-- Step 7 (Optional)
-- Stage 3 Registration for Spring!
-- Step 8 Drop the old schedule
DROP TABLE IF EXISTS schedule;
-- Step 9 Recreate & Populate the New Schedule
CREATE TABLE schedule
AS (SELECT term, course_id, section, title, instructor, days, begin_time
FROM project3.catalog
WHERE crn IN(12048, 11153, 12379, 10866, 10134, 12704));
-- Step 10 Fix Errors
DELETE FROM schedule WHERE title = 'LINEAR ALGEBRA';
-- Step 11 (Optional)


