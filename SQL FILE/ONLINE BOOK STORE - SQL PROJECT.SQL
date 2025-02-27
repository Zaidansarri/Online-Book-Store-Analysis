---------------------------------------------------------------------------------------------------------------------------------------
# BASIC QUERIES
---------------------------------------------------------------------------------------------------------------------------------------
-- QUESTION 01) RETRIEVE ALL BOOKS IN THE "FICTION" GENRE:
SELECT 
    *
FROM
    Books
WHERE
    Genre = 'Fiction';
---------------------------------------------------------------------------------------------------------------------------------------
-- QUESTION 02) FIND BOOKS PUBLISHED AFTER THE YEAR 1950:
SELECT 
    *
FROM
    Books
WHERE
    Published_year > 1950;
---------------------------------------------------------------------------------------------------------------------------------------
-- QUESTION 03) LIST ALL CUSTOMERS FROM THE CANADA:
SELECT 
    *
FROM
    Customers
WHERE
    country = 'Canada';
---------------------------------------------------------------------------------------------------------------------------------------
-- QUESTION 04) SHOW ORDERS PLACED IN NOVEMBER 2023:
SELECT 
    *
FROM
    Orders
WHERE
    order_date BETWEEN '2023-11-01' AND '2023-11-30';
---------------------------------------------------------------------------------------------------------------------------------------
-- QUESTION 05) RETRIEVE THE TOTAL STOCK OF BOOKS AVAILABLE:
SELECT 
    SUM(stock) AS Total_Stock
FROM
    Books;
---------------------------------------------------------------------------------------------------------------------------------------
-- QUESTION 06) FIND THE DETAILS OF THE MOST EXPENSIVE BOOK:
SELECT 
    *
FROM
    Books
ORDER BY Price DESC
LIMIT 1;
---------------------------------------------------------------------------------------------------------------------------------------
-- QUESTION 07) SHOW ALL CUSTOMERS WHO ORDERED MORE THAN 1 QUANTITY OF A BOOK:
SELECT 
    *
FROM
    Orders
WHERE
    quantity > 1;
---------------------------------------------------------------------------------------------------------------------------------------
-- QUESTION 08) RETRIEVE ALL ORDERS WHERE THE TOTAL AMOUNT EXCEEDS $20:
SELECT 
    *
FROM
    Orders
WHERE
    total_amount > 20;
---------------------------------------------------------------------------------------------------------------------------------------
-- QUESTION 09) LIST ALL GENRES AVAILABLE IN THE BOOKS TABLE:
SELECT DISTINCT
    genre
FROM
    Books;
---------------------------------------------------------------------------------------------------------------------------------------
-- QUESTION 10) FIND THE BOOK WITH THE LOWEST STOCK:
SELECT 
    *
FROM
    Books
ORDER BY stock
LIMIT 1;
---------------------------------------------------------------------------------------------------------------------------------------
-- QUESTION 11) CALCULATE THE TOTAL REVENUE GENERATED FROM ALL ORDERS:
SELECT 
    SUM(total_amount) AS Revenue
FROM
    Orders;

---------------------------------------------------------------------------------------------------------------------------------------
# ADVANCE QUERIES : 
---------------------------------------------------------------------------------------------------------------------------------------
-- QUESTION 01) RETRIEVE THE TOTAL NUMBER OF BOOKS SOLD FOR EACH GENRE:
SELECT 
    b.Genre, SUM(o.Quantity) AS Total_Books_sold
FROM
    Orders o
        JOIN
    Books b ON o.book_id = b.book_id
GROUP BY b.Genre;
---------------------------------------------------------------------------------------------------------------------------------------
-- QUESTION 02) FIND THE AVERAGE PRICE OF BOOKS IN THE "FANTASY" GENRE:
SELECT 
    AVG(price) AS Average_Price
FROM
    Books
WHERE
    Genre = 'Fantasy';
---------------------------------------------------------------------------------------------------------------------------------------
-- QUESTION 03) LIST CUSTOMERS WHO HAVE PLACED AT LEAST 2 ORDERS:
SELECT 
    o.customer_id, c.name, COUNT(o.Order_id) AS ORDER_COUNT
FROM
    orders o
        JOIN
    customers c ON o.customer_id = c.customer_id
GROUP BY o.customer_id , c.name
HAVING COUNT(Order_id) >= 2;
---------------------------------------------------------------------------------------------------------------------------------------
-- QUESTION 04) FIND THE MOST FREQUENTLY ORDERED BOOK:
SELECT 
    o.Book_id, b.title, COUNT(o.order_id) AS ORDER_COUNT
FROM
    orders o
        JOIN
    books b ON o.book_id = b.book_id
GROUP BY o.book_id , b.title
ORDER BY ORDER_COUNT DESC
LIMIT 1;
---------------------------------------------------------------------------------------------------------------------------------------
-- QUESTION 05) SHOW THE TOP 3 MOST EXPENSIVE BOOKS OF 'FANTASY' GENRE :
SELECT 
    *
FROM
    books
WHERE
    genre = 'Fantasy'
ORDER BY price DESC
LIMIT 3;
---------------------------------------------------------------------------------------------------------------------------------------
-- QUESTION 06) RETRIEVE THE TOTAL QUANTITY OF BOOKS SOLD BY EACH AUTHOR:
SELECT 
    b.author, SUM(o.quantity) AS Total_Books_Sold
FROM
    orders o
        JOIN
    books b ON o.book_id = b.book_id
GROUP BY b.Author;
---------------------------------------------------------------------------------------------------------------------------------------
-- QUESTION 07) LIST THE CITIES WHERE CUSTOMERS WHO SPENT OVER $30 ARE LOCATED:
SELECT DISTINCT
    c.city, total_amount
FROM
    orders o
        JOIN
    customers c ON o.customer_id = c.customer_id
WHERE
    o.total_amount > 30;
---------------------------------------------------------------------------------------------------------------------------------------
-- QUESTION 08) FIND THE CUSTOMER WHO SPENT THE MOST ON ORDERS:
SELECT 
    c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent
FROM
    orders o
        JOIN
    customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id , c.name
ORDER BY Total_spent DESC
LIMIT 1;
---------------------------------------------------------------------------------------------------------------------------------------
-- QUESTION 09) CALCULATE THE STOCK REMAINING AFTER FULFILLING ALL ORDERS:
SELECT 
    b.book_id,
    b.title,
    b.stock,
    COALESCE(SUM(o.quantity), 0) AS Order_quantity,
    b.stock - COALESCE(SUM(o.quantity), 0) AS Remaining_Quantity
FROM
    books b
        LEFT JOIN
    orders o ON b.book_id = o.book_id
GROUP BY b.book_id
ORDER BY b.book_id;

