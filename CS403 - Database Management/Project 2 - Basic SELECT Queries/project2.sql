/*
 *  project2.sql
 * 
 *  author: Nicholas McClellan
 *
 */

/* don't forget to set up your search path - in psql, do: */
set search_path to project2;
/* The queries to answer each of the 14 questions */
-- #1
SELECT known_for FROM pioneers WHERE first = 'Radia' AND last = 'Perlman';;
-- #2
SELECT school, degree FROM pioneers WHERE first = 'Alan' AND last = 'Turing';
-- #3
SELECT first, last FROM pioneers WHERE birth < 1700;
-- #4
SELECT city,country FROM schools WHERE name = 'Ensimag';
-- #5
SELECT death-(birth+1) FROM pioneers WHERE first = 'Benoit' AND last = 'Mandelbrot';
-- #6 
SELECT first, last, birth, death FROM pioneers WHERE degree IS NULL;
-- #7
SELECT first || ' ' || last FROM pioneers WHERE school = 'University of Pennsylvania' ORDER BY last;
-- #8
SELECT first, last, known_for FROM pioneers WHERE last LIKE 'I%' AND first NOT LIKE 'K%';
-- #9 
SELECT name, city || ', ' || country FROM schools WHERE country <> 'US' ORDER BY country DESC;
-- #10
SELECT first, last, birth, school FROM pioneers WHERE known_for LIKE '%Lisp%' ORDER BY school, birth;
-- #11
SELECT first,last FROM pioneers WHERE school = 'Princeton University' ORDER BY first,last;
-- #12
SELECT schools.city, schools.country 
FROM pioneers,schools 
WHERE pioneers.school = schools.name AND pioneers.first = 'John' AND pioneers.last = 'Conway';
-- #13
SELECT pioneers.first, pioneers.last, pioneers.school 
FROM pioneers,schools 
WHERE pioneers.school = schools.name AND schools.country <> 'US';
-- #14
SELECT pioneers.first, pioneers.last, pioneers.birth, schools.name 
FROM pioneers,schools 
WHERE pioneers.school = schools.name AND schools.city = 'Prague';
