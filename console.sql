-- Schema
-- customers(cid, name, city, signup_date)
-- products(pid, pname, price, category)
-- orders(oid, cid, order_date, total_amount)
-- order_items(oid, pid, quantity, price)

--EX1
SELECT
    customers.cid,
    customers.name,
    customers.city,
    customers.signup_date
FROM customers
WHERE customers.city = 'Hanoi';

--EX2
SELECT *
FROM products
WHERE products.price > 1000000;

--EX3
SELECT
    orders.oid,
    customers.name,
    orders.order_date
FROM orders
INNER JOIN customers on customers.cid = orders.cid;

--EX4
SELECT
    o.oid,
    o.cid,
    sum(oi.quantity * oi.price) as thanh_tien
FROM orders o
INNER JOIN order_items oi on oi.oid = o.oid
group by o.oid;

--EX5
SELECT
    c.cid,
    c.name,
    count(o.oid) as so_don_hang
FROM customers c
INNER JOIN orders o on o.cid = c.cid
group by c.cid
HAVING count(o.oid) > 3;

--EX6
SELECT
    p.pid,
    p.pname,
    sum(oi.quantity) as doanh_so
FROM products p
INNER JOIN order_items oi on oi.pid = p.pid
group by p.pid
HAVING sum(oi.quantity) = (
    SELECT MAX(ban_hang)
    FROM(
        SELECT sum(oi2.quantity) as ban_hang from order_items oi2 group by oi2.pid
        ) bang_phu
    );

--EX7
SELECT
    c.cid,
    c.name,
    sum(oi.quantity*oi.price) as tong_chi
FROM customers c
INNER JOIN orders o on o.cid = c.cid
INNER JOIN order_items oi on oi.oid = o.oid
group by c.cid
HAVING sum(oi.quantity *oi.price) > (
    SELECT AVG(tong_doanh_thu)
    FROM (
        SELECT
            o2.cid,
            sum(oi2.quantity * oi2.price) as tong_doanh_thu
        FROM order_items oi2
        INNER JOIN orders o2 on o2.oid = oi2.oid
        group by o2.cid
        )
    );

--EX8
SELECT
    c.cid,
    c.name
FROM customers c
         JOIN orders o ON o.cid = c.cid
         JOIN order_items oi ON oi.oid = o.oid
GROUP BY c.cid, c.name
HAVING COUNT(DISTINCT oi.pid) = 1;





















