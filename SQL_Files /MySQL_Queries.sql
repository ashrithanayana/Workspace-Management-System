select * from user;
select * from account;
select * from workspace;
select * from building;
select * from room;
select * from booking;
select * from payment;

#1 Which company employees are using the workspace more.
SELECT u.company_name,count(b.booking_id) AS bookings FROM user u 
LEFT JOIN account a ON u.user_id = a.user_id
LEFT JOIN booking b ON a.account_id = b.account_id
GROUP BY company_name
ORDER BY bookings DESC
LIMIT 10;

#2 which room type is mostly booked 
SELECT count(bk.booking_id) AS Booked,room_type AS type_of_room
FROM room r 
LEFT JOIN building b ON r.B_Number = b.B_Number
LEFT JOIN workspace w ON b.ws_id = w.ws_id
LEFT JOIN account a ON w.account_id = a.account_id
LEFT JOIN booking bk ON bk.account_id = a.account_id
GROUP BY room_type
ORDER BY Booked DESC
LIMIT 1;

#3 find the country which adopted more number of working spaces
SELECT COUNT(ws_id) AS count,country FROM workspace
GROUP BY country 
ORDER BY count DESC
LIMIT 1;

#4 demand of workspace in what month of year
SELECT COUNT(w.ws_id) AS COUNT, month(b.date) AS Month,year(b.date) AS Year
FROM workspace w LEFT JOIN account a ON a.account_id = w.account_id
LEFT JOIN booking b on b.account_id = a.account_id
GROUP BY Month,Year
ORDER BY Month,Year
LIMIT 10;

#5 Busiest day in each month of year 2022
SELECT dayname(b.date) as day, month(b.date) AS month,max(TIMESTAMPDIFF(HOUR, b.start_time,b.end_time)) AS Hours 
FROM booking b LEFT JOIN payment p ON b.payment_id = b.payment_id
WHERE p.status = 'completed' and year(b.date) = '2022'
GROUP BY day,month
ORDER BY Hours DESC
LIMIT 5;

#6 Users with most number of bookings
SELECT u.User_id, count(b.booking_id) AS Number_of_bookings
FROM user u LEFT JOIN account a on a.user_id = u.user_id 
LEFT JOIN booking b ON a.account_id = b.account_id
GROUP BY User_id
ORDER BY Number_of_bookings DESC
LIMIT 10;

#7 Details of User with pending payment 
SELECT u.User_id, u.first_name
FROM user u LEFT JOIN account a ON a.user_id = u.user_id 
LEFT JOIN booking b ON a.account_id = b.account_id
LEFT JOIN payment p ON p.payment_id = b.payment_id
WHERE p.status='pending'
LIMIT 10;

#8 what building has more/greater number of rooms
SELECT b.b_number,b_name, count(r.room_id) AS rooms
FROM building b LEFT JOIN room r ON b.b_number = r.b_number
GROUP BY b.b_number
ORDER BY rooms DESC
LIMIT 1;

#9 list of rooms that are occupied in a building
SELECT b.b_name, b.b_number ,r.status
FROM building b LEFT JOIN room r ON r.b_number = b.b_number
WHERE status = 'Booked'
LIMIT 10;

#10 which type of payment is getting the declined the most 
SELECT payment_type,count(payment_type) AS total, status 
FROM payment 
WHERE status='pending'
GROUP BY payment_type
ORDER BY total DESC
LIMIT 1;







