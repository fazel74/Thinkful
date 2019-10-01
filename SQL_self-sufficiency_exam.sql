-- 1) Write a query that allows you to inspect the schema of the naep table.

SELECT column_name, data_type 
FROM information_schema.columns
WHERE table_name = 'naep';

"avg_math_4_score"	"numeric"
"avg_math_8_score"	"numeric"
"avg_reading_4_score"	"numeric"
"avg_reading_8_score"	"numeric"
"id"	"character varying"
"state"	"character varying"
"year"	"integer"

-- 2) Write a query that returns the first 50 records of the naep table.

SELECT *
FROM naep
LIMIT 50;

-- 3) Write a query that returns summary statistics for avg_math_4_score by state. Make sure to sort the results 
      alphabetically by state name.

SELECT COUNT(avg_math_4_score), ROUND(AVG(avg_math_4_score), 3), MAX(avg_math_4_score), MIN(avg_math_4_score), state
FROM naep
WHERE avg_math_4_score IS NOT null
GROUP BY state
ORDER BY state;

-- 4) Write a query that alters the previous query so that it returns only the summary statistics for avg_math_4_score 
      by state with differences in max and min values that are greater than 30.

SELECT COUNT(avg_math_4_score), ROUND(AVG(avg_math_4_score), 3), MAX(avg_math_4_score), MIN(avg_math_4_score), state
, (MAX(avg_math_4_score) - MIN(avg_math_4_score)) AS differences_in_max_and_min
FROM naep
WHERE avg_math_4_score IS NOT null 
GROUP BY state
HAVING MAX(avg_math_4_score) - MIN(avg_math_4_score) > 30
ORDER BY state;
                                                                                                                                               "11"	"212.275"	"231.32"	"187.135"	"DISTRICT_OF_COLUMBIA"	"44.185"
"10"	"235.661"	"246.368"	"213.69"	"FLORIDA"	"32.678"
"11"	"224.771"	"234.282"	"204.14"	"LOUISIANA"	"30.142"
"11"	"223.237"	"234.694"	"201.828"	"MISSISSIPPI"	"32.866"
"11"	"237.487"	"244.802"	"212.884"	"NORTH_CAROLINA"	"31.918"      
                                                                                                                                                   
-- 5) Write a query that returns a field called bottom_10_states that lists the states in the bottom 10 for avg_math_4_score 
      in the year 2000.

SELECT state AS bottom_10_states
FROM naep
WHERE year = 2000
ORDER BY avg_math_4_score
LIMIT 10;
                                                                                                                                           "DISTRICT_OF_COLUMBIA"
"MISSISSIPPI"
"CALIFORNIA"
"NEW_MEXICO"
"HAWAII"
"ARKANSAS"
"ALABAMA"
"LOUISIANA"
"ARIZONA"
"GEORGIA"
                                                                                                                                                   
-- 6) Write a query that calculates the average avg_math_4_score rounded to the nearest 2 decimal places over all states in 
      the year 2000.
                                                                                                                                             
SELECT state, ROUND(avg_math_4_score, 2) AS avg_math_4_score
FROM naep
WHERE year = 2000
ORDER BY state;
                                                                                                                                            
-- 7) Write a query that returns a field called below_average_states_y2000 that lists all states with an avg_math_4_score 
      less than the average over all states in the year 2000.

SELECT state AS below_average_states_y2000, avg_math_4_score
FROM naep
WHERE year = 2000 
GROUP BY state, avg_math_4_score
HAVING avg_math_4_score < (
		SELECT AVG(avg_math_4_score)
		FROM naep
		WHERE year = 2000);
                                                                                                                                               
"NEW_MEXICO"	"213.868"
"ARIZONA"	"218.767"
"GEORGIA"	"219.557"
"ARKANSAS"	"217.063"
"TENNESSEE"	"219.836"
"HAWAII"	"215.847"
"RHODE_ISLAND"	"224.634"
"MARYLAND"	"222.31"
"MISSISSIPPI"	"210.97"
"LOUISIANA"	"217.964"
"ALABAMA"	"217.941"
"NEVADA"	"220.275"
"SOUTH_CAROLINA"	"220.417"
"CALIFORNIA"	"213.565"
"DISTRICT_OF_COLUMBIA"	"193.29"
"KENTUCKY"	"220.994"
                                                                                                                                           -- 8) Write a query that returns a field called scores_missing_y2000 that lists any states with missing values in the avg_math_4_score column of the naep data table for the year 2000.
-- 8) Write a query that returns a field called scores_missing_y2000 that lists any states with missing values in 
      the avg_math_4_score column of the naep data table for the year 2000.
                                                        
SELECT state AS scores_missing_y2000
FROM naep
WHERE year = 2000 AND avg_math_4_score IS null;

"ALASKA"
"COLORADO"
"DELAWARE"
"FLORIDA"
"NEW_HAMPSHIRE"
"NEW_JERSEY"
"PENNSYLVANIA"
"SOUTH_DAKOTA"
"WASHINGTON"
"WISCONSIN"
        
-- 9) Write a query that returns for the year 2000 the state, avg_math_4_score, and total_expenditure from the naep 
      table left outer joined with the finance table, using id as the key and ordered by total_expenditure greatest to least. 
      Be sure to round avg_math_4_score to the nearest 2 decimal places, and then filter out NULL avg_math_4_scores in order to 
      see any correlation more clearly.
                                                                                                                                           
SELECT naep.state, ROUND(avg_math_4_score, 2) AS avg_score, total_expenditure
FROM naep LEFT OUTER JOIN finance
ON naep.id = finance.id
WHERE naep.year = 2000 AND avg_math_4_score IS NOT null
ORDER BY total_expenditure DESC;                                                                                                                                          
                                                                                                                                         
