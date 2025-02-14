#
# Database Systems - Lab 3
#

# Modify this file to achieve the requirements listed in Part 4-2 of the Lab 3
# specifications.

# use yelp_db_small;
# ...
# DROP INDEX ...
# CREATE INDEX ...
# ...

-- Drop the index if it already exists
DROP INDEX idx_review_user_id ON Review;

-- Run EXPLAIN to analyze the query execution plan before optimization
EXPLAIN 
SELECT u.name AS name, r.review_id, b.name AS business_name
FROM User_data u
JOIN Review r ON u.user_id = r.user_id
JOIN Business b ON r.business_id = b.business_id
WHERE r.user_id = 'KGYM_D6JOkjwnzslWO0QHg';

-- Run the original query BEFORE adding an index
SELECT u.name AS name, r.review_id, b.name AS business_name
FROM User_data u
JOIN Review r ON u.user_id = r.user_id
JOIN Business b ON r.business_id = b.business_id
WHERE r.user_id = 'KGYM_D6JOkjwnzslWO0QHg';


-- Create the optimal index on the `user_id` column in the `Review` table
CREATE INDEX idx_review_user_id ON Review(user_id);

-- Run EXPLAIN again to analyze the optimized query execution
EXPLAIN 
SELECT u.name AS name, r.review_id, b.name AS business_name
FROM User_data u
JOIN Review r ON u.user_id = r.user_id
JOIN Business b ON r.business_id = b.business_id
WHERE r.user_id = 'KGYM_D6JOkjwnzslWO0QHg';

-- Execute the optimized query after adding the index
SELECT u.name AS name, r.review_id, b.name AS business_name
FROM User_data u
JOIN Review r ON u.user_id = r.user_id
JOIN Business b ON r.business_id = b.business_id
WHERE r.user_id = 'KGYM_D6JOkjwnzslWO0QHg';
