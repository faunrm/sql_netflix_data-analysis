USE netflix;

SHOW TABLES;

SELECT * FROM netflix_titles
LIMIT 10;

-- Show the Percentage of Each Type --
SELECT type, COUNT(*) AS COUNT ,COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS PERCENTAGE from netflix_titles
GROUP BY type;

-- Finding Oldest TV Show in Netflix --
SELECT * FROM netflix_titles
WHERE type = 'TV Show'
ORDER BY release_year ASC
LIMIT 1;


-- Finding 10 countries with the most titles released on netflix -- 
SELECT COUNTRY,COUNT(*) AS COUNT from netflix_titles
GROUP BY country
ORDER BY COUNT(*) DESC
LIMIT 10;

-- Finding the duration that that appears the most in Movie --
SELECT duration, COUNT(*) FROM netflix_titles
WHERE Type = 'Movie'
GROUP BY duration
ORDER BY COUNT(*) DESC
LIMIT 10; 

-- Finding the duration that that appears the least in TV Show --
SELECT duration, COUNT(*) FROM netflix_titles
WHERE Type = 'TV Show'
GROUP BY duration
ORDER BY COUNT(*) ASC
LIMIT 10; 

-- Finding Top 5 Rating
SELECT rating, COUNT(*) FROM netflix_titles
GROUP BY rating
ORDER BY COUNT(*) DESC
LIMIT 5;

SELECT country, type, COUNT(*) from netflix_titles
GROUP BY country,type
ORDER BY COUNT(country) DESC
LIMIT 10;

WITH CountryTotal AS (
    SELECT
        COUNTRY,
        COUNT(*) AS TOTAL_COUNT
    FROM
        netflix_titles
    GROUP BY
        COUNTRY
),
RankedCountries AS (
    SELECT
        COUNTRY,
        TOTAL_COUNT,
        ROW_NUMBER() OVER (ORDER BY TOTAL_COUNT DESC) AS RN
    FROM
        CountryTotal
),
TopCountries AS (
    SELECT
        COUNTRY
    FROM
        RankedCountries
    WHERE
        RN <= 5
)
SELECT
    nt.COUNTRY,
    nt.TYPE,
    COUNT(*) AS COUNT
FROM
    netflix_titles nt
JOIN
    TopCountries tc ON nt.COUNTRY = tc.COUNTRY
GROUP BY
    nt.COUNTRY,
    nt.TYPE
ORDER BY
    CASE
        WHEN nt.COUNTRY = 'United States' THEN 1
        WHEN nt.COUNTRY = 'India' THEN 2
        ELSE 3
    END,
    (SELECT TOTAL_COUNT FROM RankedCountries rc WHERE rc.COUNTRY = nt.COUNTRY) DESC,
    nt.TYPE;
