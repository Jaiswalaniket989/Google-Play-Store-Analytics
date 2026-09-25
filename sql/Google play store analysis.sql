CREATE TABLE google_play_apps (
    app TEXT,
    category TEXT,
    rating NUMERIC,
    reviews BIGINT,
    size TEXT,
    installs BIGINT,
    type TEXT,
    price NUMERIC,
    content_rating TEXT,
    genres TEXT,
    last_updated DATE,
    current_ver TEXT,
    android_ver TEXT,
    size_mb NUMERIC,
    is_paid INTEGER,
    install_range TEXT,
    review_rate NUMERIC,
    app_age_years NUMERIC,
    price_category TEXT
);


select * from google_play_apps;

SELECT COUNT(*)
FROM google_play_apps;


SELECT *
FROM google_play_apps
LIMIT 10;

--Top categories by installs
SELECT
    category,
    COUNT(*) AS total_apps,
    SUM(installs) AS total_installs
FROM google_play_apps
GROUP BY category
ORDER BY total_installs DESC
LIMIT 10;

--Category Performance
SELECT
    category,
    COUNT(*) AS total_apps,
    SUM(installs) AS total_installs,
    SUM(reviews) AS total_reviews,
    ROUND(AVG(rating), 2) AS avg_rating
FROM google_play_apps
GROUP BY category
ORDER BY total_installs DESC;

--Free vs Paid Apps
SELECT
    type,
    COUNT(*) AS total_apps,
    ROUND(AVG(rating), 2) AS avg_rating,
    ROUND(AVG(installs), 0) AS avg_installs,
    ROUND(AVG(reviews), 0) AS avg_reviews,
    SUM(installs) AS total_installs
FROM google_play_apps
GROUP BY type
ORDER BY total_installs DESC;

--Most Installed Apps
SELECT
    app,
    category,
    rating,
    reviews,
    installs,
    type,
    price
FROM google_play_apps
ORDER BY installs DESC
LIMIT 20;

--Top Reviewed Apps
SELECT
    app,
    category,
    rating,
    reviews,
    installs,
    type
FROM google_play_apps
ORDER BY reviews DESC
LIMIT 20;

--Rating vs Installs
SELECT
    ROUND(AVG(rating), 2) AS avg_rating,
    ROUND(AVG(installs), 0) AS avg_installs
FROM google_play_apps
WHERE rating IS NOT NULL;

SELECT
    CORR(rating, installs) AS rating_install_correlation
FROM google_play_apps
WHERE rating IS NOT NULL;

--Reviews vs Installs
SELECT
    CORR(reviews, installs) AS review_install_correlation
FROM google_play_apps;

--Price vs Installs
SELECT
    price_category,
    COUNT(*) AS total_apps,
    ROUND(AVG(price), 2) AS avg_price,
    ROUND(AVG(installs), 0) AS avg_installs,
    SUM(installs) AS total_installs
FROM google_play_apps
GROUP BY price_category
ORDER BY avg_installs DESC;

--Install Range Analysis
SELECT
    install_range,
    COUNT(*) AS total_apps,
    ROUND(AVG(rating), 2) AS avg_rating,
    ROUND(AVG(reviews), 0) AS avg_reviews,
    SUM(installs) AS total_installs
FROM google_play_apps
GROUP BY install_range
ORDER BY
    CASE install_range
        WHEN 'Very High' THEN 1
        WHEN 'High' THEN 2
        WHEN 'Medium' THEN 3
        WHEN 'Low' THEN 4
    END;


--Review Engagement Rate
SELECT
    app,
    category,
    installs,
    reviews,
    ROUND(review_rate, 2) AS review_rate
FROM google_play_apps
ORDER BY review_rate DESC
LIMIT 20;

--Average Review Rate by Category
SELECT
    category,
    ROUND(AVG(review_rate), 2) AS avg_review_rate,
    COUNT(*) AS total_apps
FROM google_play_apps
WHERE review_rate IS NOT NULL
GROUP BY category
ORDER BY avg_review_rate DESC;

--Top-Rated Apps — Minimum 1,000 Reviews
SELECT
    app,
    category,
    rating,
    reviews,
    installs
FROM google_play_apps
WHERE rating IS NOT NULL
  AND reviews >= 1000
ORDER BY rating DESC, reviews DESC
LIMIT 20;

--Top Apps by Category
SELECT
    app,
    category,
    rating,
    reviews,
    installs
FROM (
    SELECT
        app,
        category,
        rating,
        reviews,
        installs,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY installs DESC
        ) AS rank
    FROM google_play_apps
) ranked
WHERE rank <= 3
ORDER BY category, rank;

--Paid Apps Analysis
SELECT
    app,
    category,
    price,
    rating,
    reviews,
    installs
FROM google_play_apps
WHERE type = 'Paid'
ORDER BY price DESC
LIMIT 20;

--Most Expensive Apps
SELECT
    app,
    category,
    price,
    rating,
    reviews,
    installs
FROM google_play_apps
WHERE price > 0
ORDER BY price DESC
LIMIT 20;

--App Freshness
SELECT
    category,
    ROUND(AVG(app_age_years), 2) AS avg_app_age_years,
    COUNT(*) AS total_apps
FROM google_play_apps
WHERE app_age_years IS NOT NULL
GROUP BY category
ORDER BY avg_app_age_years;

--Recently Updated Apps
SELECT
    app,
    category,
    last_updated,
    rating,
    reviews,
    installs
FROM google_play_apps
ORDER BY last_updated DESC
LIMIT 20;

--Apps with High Installs but Low Rating
SELECT
    app,
    category,
    rating,
    reviews,
    installs
FROM google_play_apps
WHERE rating IS NOT NULL
  AND installs >= 1000000
  AND rating < 4.0
ORDER BY installs DESC
LIMIT 20;

--Apps with High Rating and High Installs
SELECT
    app,
    category,
    rating,
    reviews,
    installs
FROM google_play_apps
WHERE rating >= 4.5
  AND installs >= 1000000
ORDER BY installs DESC;

--Category — Paid vs Free
SELECT
    category,
    type,
    COUNT(*) AS total_apps,
    ROUND(AVG(rating), 2) AS avg_rating,
    ROUND(AVG(installs), 0) AS avg_installs
FROM google_play_apps
GROUP BY category, type
ORDER BY category, type;

--Data Quality Check
SELECT
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (WHERE rating IS NULL) AS missing_rating,
    COUNT(*) FILTER (WHERE current_ver IS NULL) AS missing_current_version,
    COUNT(*) FILTER (WHERE android_ver IS NULL) AS missing_android_version,
    COUNT(*) FILTER (WHERE size_mb IS NULL) AS missing_size
FROM google_play_apps;

--Duplicate App Names
SELECT
    app,
    COUNT(*) AS occurrence_count
FROM google_play_apps
GROUP BY app
HAVING COUNT(*) > 1
ORDER BY occurrence_count DESC;

--Category Summary
SELECT
    category,
    COUNT(*) AS total_apps,
    SUM(installs) AS total_installs,
    SUM(reviews) AS total_reviews,
    ROUND(AVG(rating), 2) AS avg_rating,
    ROUND(AVG(price), 2) AS avg_price,
    ROUND(AVG(review_rate), 2) AS avg_review_rate
FROM google_play_apps
GROUP BY category
ORDER BY total_installs DESC;

--Creating a SQL View for Power BI
CREATE OR REPLACE VIEW vw_category_performance AS
SELECT
    category,
    COUNT(*) AS total_apps,
    SUM(installs) AS total_installs,
    SUM(reviews) AS total_reviews,
    ROUND(AVG(rating), 2) AS avg_rating,
    ROUND(AVG(price), 2) AS avg_price,
    ROUND(AVG(review_rate), 2) AS avg_review_rate
FROM google_play_apps
GROUP BY category;

SELECT *
FROM vw_category_performance
ORDER BY total_installs DESC;

--Create a View for App-Level Analysis
CREATE OR REPLACE VIEW vw_app_performance AS
SELECT
    app,
    category,
    rating,
    reviews,
    installs,
    type,
    price,
    install_range,
    review_rate,
    app_age_years,
    price_category,
    last_updated
FROM google_play_apps;

SELECT *
FROM vw_app_performance
LIMIT 10;


