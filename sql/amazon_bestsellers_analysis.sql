/*
AMAZON BOOK BESTSELLERS ANALYSIS
AUTHOR: Natalie Khor
*/

--QUESTION 1: Market Demand by Sub-Genre
--GOAL: Identify which book categories have the highest volume and reader engagement. 
SELECT 
    sub_genre, 
    COUNT(*) AS total_count, 
    SUM(reviews) AS sum_reviews, 
    ROUND(AVG(rating), 2) AS avg_rating
FROM bestsellers
GROUP BY sub_genre
ORDER BY total_count DESC;

--QUESTION 2: The Repeat Brand-Name Authors
--GOAL: Determine if the bestseller list is dominated by repeat authors.
SELECT 
    author, 
    COUNT(title) AS count_books, 
    ROUND(AVG(rating), 2) AS avg_rating, 
    ROUND(AVG(price_usd), 2) AS avg_price
FROM bestsellers
GROUP BY author
ORDER BY count_books DESC;

--QUESTION 3: Audience Expectations (Satisfaction vs. Volume)
--GOAL: Analyze the relationship between reader satisfaction and market scale.
SELECT 
    sub_genre, 
    ROUND(AVG(rating), 2) AS avg_rating_sub, 
    ROUND(AVG(reviews)) AS avg_reviews_sub
FROM bestsellers
GROUP BY sub_genre
ORDER BY avg_rating_sub ASC;

--QUESTION 4: Pricing Strategy
--GOAL: Segment books into price tiers to find the optimal pricing window.
SELECT 
    CASE 
        WHEN price_usd < 5 THEN 'Budget'
        WHEN price_usd BETWEEN 5 AND 9.99 THEN 'Mid-Range'
        WHEN price_usd BETWEEN 10.00 AND 19.99 THEN 'Premium'
        ELSE 'Luxury'
    END AS price_category, 
    COUNT(*) AS book_count, 
    ROUND(AVG(reviews)) AS avg_reviews
FROM bestsellers
GROUP BY price_category
ORDER BY avg_reviews DESC;

--QUESTION 5: Distribution Strategy
--GOAL: Map book formats (Paperback, Hardcover, Digital) across Fiction and Non-fiction.
SELECT 
    category,
    COUNT(CASE WHEN format = 'Paperback' THEN 1 END) AS paperback_count,
    COUNT(CASE WHEN format = 'Hardcover' THEN 1 END) AS hardcover_count,
    COUNT(CASE WHEN format ILIKE '%Kindle%' OR format ILIKE '%Ebook%' THEN 1 END) AS digital_count
FROM bestsellers
GROUP BY category;