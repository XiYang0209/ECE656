#
# Database Systems - Lab 3
#

# Modify this file to achieve the requirements listed in Part 4-1 of the Lab 3
# specifications.

# use yelp_db_small;
# ...
# DROP INDEX ...
# CREATE INDEX ...
# ...

-- Drop the index if it already exists (avoid conflicts when re-running the script)
DROP INDEX idx_review_date ON Review;

-- Run EXPLAIN to analyze the original query before optimization
EXPLAIN 
SELECT COUNT(*) AS count
FROM Review
WHERE date >= '2014-05-01' AND date < '2014-06-01';

-- Execute the original query (before optimization)
SELECT COUNT(*) AS count
FROM Review
WHERE date >= '2014-05-01' AND date < '2014-06-01';

-- Create the optimal index on the `date` column
CREATE INDEX idx_review_date ON Review(date);

-- Run EXPLAIN again to analyze the optimized query execution
EXPLAIN 
SELECT COUNT(*) AS count
FROM Review
WHERE date >= '2014-05-01' AND date < '2014-06-01';

-- Execute the optimized query after adding the index
SELECT COUNT(*) AS count
FROM Review
WHERE date >= '2014-05-01' AND date < '2014-06-01';
