USE netflix;

SELECT * FROM net_title
LIMIT 10;

-- Show the Percentage of Each Type --
SELECT type, COUNT(*) AS COUNT ,COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS PERCENTAGE from net_title
GROUP BY type;

-- Finding Oldest TV Show in Netflix --
SELECT * FROM net_title
WHERE type = 'TV Show'
ORDER BY release_year ASC
LIMIT 1;


-- Finding 10 countries with the most titles released on netflix -- 
SELECT COUNTRY,COUNT(*) AS COUNT from net_title
GROUP BY country
ORDER BY COUNT(*) ASC
LIMIT 10;

-- Finding the duration that that appears the most in Movie --
SELECT duration, COUNT(*) FROM net_title
WHERE Type = 'Movie'
GROUP BY duration
ORDER BY COUNT(*) DESC
LIMIT 10; 

-- Finding the duration that that appears the least in TV Show --
SELECT duration, COUNT(*) FROM net_title
WHERE Type = 'TV Show'
GROUP BY duration
ORDER BY COUNT(*) ASC
LIMIT 10; 