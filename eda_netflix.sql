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

