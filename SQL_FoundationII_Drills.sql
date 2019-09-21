-- 1) Write a query that returns a list of all the unique values in the 'country' field.

SELECT DISTINCT country
FROM ksprojects

-- 2) How many unique values are there for the main_category field? What about for the category field?

SELECT COUNT(main_category) AS Main_Category, COUNT(category) AS Category
FROM ksprojects

Answers: 65418, 65418

-- 3) Get a list of all the unique combinations of main_category and category fields, sorted A to Z by main_category.

SELECT main_category, category
FROM ksprojects
ORDER BY main_category

-- 4) How many unique categories are in each main_category?

SELECT main_category, COUNT(DISTINCT category)
FROM ksprojects
GROUP BY main_category
ORDER BY main_category

"Art"	"13"
"Comics"	"6"
"Crafts"	"15"
"Dance"	"5"
"Design"	"7"
"Fashion"	"9"
"Film & Video"	"20"
"Food"	"13"
"Games"	"8"
"Journalism"	"6"
"Music"	"18"
"Photography"	"7"
"Publishing"	"15"
"Technology"	"16"
"Theater"	"7"

-- 5) Write a query that returns the average number of backers per main_category, rounded to the nearest whole number and sorted from high to low.

SELECT main_category, ROUND(AVG(backers),0) AS avg_backers
FROM ksprojects
GROUP BY main_category
ORDER BY AVG(backers) DESC

"Games"	"342"
"Design"	"254"
"Technology"	"167"
"Comics"	"138"
"Fashion"	"68"
"Film & Video"	"59"
"Food"	"56"
"Publishing"	"50"
"Music"	"48"
"Theater"	"44"
"Dance"	"43"
"Art"	"40"
"Journalism"	"40"
"Photography"	"39"
"Crafts"	"25"

-- 6) Write a query that shows, for each category, how many campaigns were successful and the average difference per project between dollars pledged and the goal.

SELECT category, COUNT(*), AVG(usd_pledged - goal) AS avg_difference
FROM ksprojects
WHERE state = 'successful'
GROUP BY category

-- 7) Write a query that shows, for each main category, how many projects had zero backers for that category and the largest goal amount for that category (also for projects with zero backers).

SELECT main_category, COUNT(*) AS number_backers_0, MAX(goal) AS largest_goal
FROM ksprojects
WHERE backers=0
GROUP BY main_category;

-- 8) For each category, find the average USD per backer, and return only those results for which the average USD per backer is < $50, sorted high to low. Hint: Division by NULL is not possible, so use NULLIF to replace NULLs with 0 in the average calculation.

SELECT category, AVG(usd_pledged/NULLIF(backers,0)) AS avg_usd_per_backer
FROM ksprojects
GROUP BY category
HAVING AVG(usd_pledged/NULLIF(backers,0)) < 50
ORDER BY avg_usd_per_backer DESC;

-- 9) Write a query that shows, for each main_category, how many successful projects had between 5 and 10 backers.

SELECT main_category , COUNT(*) AS sucessp_b_5_10
FROM ksprojects
WHERE state = 'successful' AND backers BETWEEN 5 AND 10
GROUP BY main_category;


"Art"	"109"
"Fashion"	"24"
"Music"	"121"
"Crafts"	"34"
"Photography"	"32"
"Design"	"26"
"Film & Video"	"179"
"Food"	"31"
"Journalism"	"11"
"Publishing"	"75"
"Dance"	"12"
"Comics"	"10"
"Technology"	"23"
"Theater"	"48"
"Games"	"26"

-- 10) Get a total of the amount ‘pledged’ for each type of currency grouped by its respective currency. Sort by ‘pledged’ from high to low.

SELECT currency, SUM(pledged)
FROM ksprojects
GROUP BY currency
ORDER BY SUM(pledged) DESC;

"USD"	"4.88021e+08"
"GBP"	"2.53959e+07"
"EUR"	"1.84007e+07"
"CAD"	"1.61769e+07"
"SEK"	"1.20611e+07"
"AUD"	"7.02466e+06"
"DKK"	"6.93123e+06"
"NOK"	"2.8271e+06"
"HKD"	"2.23249e+06"
"NZD"	"1.78806e+06"
"CHF"	"1.16314e+06"
"SGD"	"658930"
"MXN"	"514620"

-- 11) Excluding Games and Technology records in the main_category field, return the total of all backers for successful projects by main_category where the total was more than 100,000. Sort by main_category from A to Z.

SELECT main_category, SUM(backers) AS sum_backers
FROM ksprojects
WHERE state = 'successful' AND main_category NOT IN('Games', 'Technology')
GROUP BY main_category
HAVING SUM(backers) > 100000
ORDER BY main_category;

"Art"	"164632"
"Comics"	"229174"
"Design"	"1076918"
"Fashion"	"217830"
"Film & Video"	"575922"
"Food"	"200791"
"Music"	"411750"
"Publishing"	"291245"




