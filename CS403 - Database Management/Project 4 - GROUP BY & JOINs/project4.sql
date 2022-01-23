/*
 *  project4.sql
 * 
 *  author: Nicholas McClellan
 *
 */
/* use the correct schema */
SET search_path TO project4; 
-- Questions
-- Statistics, aggregation, and grouping:
-- #1 How many Stanford University graduates are there?
SELECT COUNT(*)
FROM project4.pioneers
WHERE school_id IN
	(SELECT id from project4.schools WHERE name = 'Stanford University');
-- #2 What is the earliest birth year of any pioneer in our data?
SELECT MIN(birth)
FROM project4.pioneers;
-- #3 How many pioneers have no higher degrees listed?
SELECT COUNT(*)
FROM project4.pioneers
WHERE degree is NULL;
-- #4 How many pioneers have first names the same length as their last names?
SELECT COUNT(*)
FROM project4.pioneers
WHERE LENGTH(first) = LENGTH(last);
-- #5 For each level of highest degree earned by our pioneers (Doctorate, Masters, Bachelors, none), how many of our pioneers earned a degree at that level? Order by greatest number to least number.
SELECT COUNT(*)
FROM project4.pioneers
GROUP BY degree
ORDER BY COUNT(*) DESC;
-- #6 What countries listed in schools have more than 2 schools (in our data), and how many do they have? Order by the greatest number of schools first.
SELECT COUNT(*), country
FROM project4.schools
GROUP BY country
HAVING COUNT(*) > 2
ORDER BY COUNT(*) DESC;
-- #7 Give an approximate average lifespan (in years) of the deceased pioneers in our database (where birth and death are known).
SELECT AVG(death-(birth+1)) 
FROM project4.pioneers
WHERE death IS NOT NULL and birth IS NOT NULL;
-- #8 In what two years were exactly 5 of our pioneers born?
SELECT birth
FROM project4.pioneers
GROUP BY birth
HAVING COUNT(*) = 5;
-- Subqueries and/or Complex Joins
-- #9 What is the maximum number of awards won by a pioneer in our data?
SELECT MAX(counts)
FROM (SELECT COUNT(*) AS counts 
FROM pioneers
	LEFT OUTER JOIN project4.pioneers_awards_xref 
		ON (project4.pioneers_awards_xref.pioneer_id = project4.pioneers.id)
	LEFT OUTER JOIN project4.awards
		ON (project4.pioneers_awards_xref.award_id = project4.awards.id)
WHERE project4.awards.name IS NOT NULL
GROUP BY first,last) AS t;
-- #10 Who is the youngest pioneer, and what year were they born?
SELECT first, last, birth
FROM pioneers
WHERE birth = 
	(SELECT MAX(birth) FROM pioneers);
-- #11 What awards (awarding organization and award name) did Donald Knuth win?
SELECT awarded_by, name
FROM pioneers
	LEFT OUTER JOIN project4.pioneers_awards_xref 
		ON (project4.pioneers_awards_xref.pioneer_id = project4.pioneers.id)
	LEFT OUTER JOIN project4.awards
		ON (project4.pioneers_awards_xref.award_id = project4.awards.id)
WHERE project4.awards.name IS NOT NULL AND project4.pioneers.first = 'Donald' AND project4.pioneers.last = 'Knuth';
-- #12 What are the first and last names of every pioneer in our data that won the Presidential Medal of Freedom, and what were they known for? Order by year awarded
SELECT first, last, known_for
FROM pioneers
	LEFT OUTER JOIN project4.pioneers_awards_xref 
		ON (project4.pioneers_awards_xref.pioneer_id = project4.pioneers.id)
	LEFT OUTER JOIN project4.awards
		ON (project4.pioneers_awards_xref.award_id = project4.awards.id)
WHERE project4.awards.name IS NOT NULL AND project4.awards.name = 'Presidential Medal of Freedom'
ORDER BY project4.pioneers_awards_xref.year;
-- #13 Provide Lynn Conway's school name and highest degree, along with the award she won.
SELECT schools.name AS "school", degree, awards.name AS "award"
FROM pioneers
	LEFT OUTER JOIN project4.pioneers_awards_xref 
		ON (project4.pioneers_awards_xref.pioneer_id = project4.pioneers.id)
	LEFT OUTER JOIN project4.awards
		ON (project4.pioneers_awards_xref.award_id = project4.awards.id)
	LEFT OUTER JOIN project4.schools
		ON (project4.pioneers.school_id = project4.schools.id)
WHERE project4.awards.name IS NOT NULL AND project4.pioneers.first = 'Lynn' AND project4.pioneers.last = 'Conway';
-- #14 Which pioneers went to school in the same country they were from and won exactly 2 awards, and what school did they attend?
SELECT first, last, schools.name
FROM pioneers
	LEFT OUTER JOIN project4.pioneers_awards_xref 
		ON (project4.pioneers_awards_xref.pioneer_id = project4.pioneers.id)
	LEFT OUTER JOIN project4.awards
		ON (project4.pioneers_awards_xref.award_id = project4.awards.id)
	LEFT OUTER JOIN project4.schools
		ON (project4.pioneers.school_id = project4.schools.id)
WHERE project4.awards.name IS NOT NULL AND schools.country = pioneers.country
GROUP BY first,last,schools.name
HAVING COUNT(*) = 2;











