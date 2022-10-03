-- SELECT * from book where publisher IN('굿스포츠','대한미디어'); -- string 타입문은 작은 따옴표 사용
-- SELECT * from book where publisher not IN('굿스포츠','대한미디어'); 
-- select bookname,publisher from book where bookname LIKE'축구의 역사';
-- select bookname,publisher from book where bookname LIKE '%축구%';
-- select * from book where bookname LIKE '_구%';
-- select * from book where bookname LIKE '%축구%' AND price >= 20000;
-- select * from book where publisher='굿스포츠' OR publisher='대한미디어';
-- select * from book order by bookname;
-- select * from book order by price,bookname;
-- select * from book order by price DESC, publisher ASC;
/* 집계 함수와 group by : 관리자 입장에서 데이터 베이스 관리 */
-- select sum(saleprice) AS 총매출 from orders;
-- select sum(saleprice) AS 총매출 from orders where custid=2;
-- select sum(saleprice) AS Total, avg(saleprice) AS Average, MIN(saleprice) AS Minimum, MAX(saleprice) AS Maximum from orders;
-- select COUNT(*) from orders;
-- select custid, COUNT(*) AS 도서수량, sum(saleprice) AS 총액 from orders group by custid;
-- select custid, COUNT(*) AS 도서수량 from orders where saleprice >= 8000 group by custid having count(*) >= 2;
-- select * from customer,orders;
 /* 조인 예제 */
-- select * from customer, orders where customer.custid = orders.custid order by customer.custid;
-- select name,saleprice from customer, orders where customer.custid=orders.custid;
-- select name, sum(saleprice) from customer,orders where customer.custid=orders.custid group by customer.name order by customer.name;
-- select customer.name, book.bookname from customer, orders, book where customer.custid=orders.custid AND orders.bookid = book.bookid;
/* select customer.name,book.bookname from customer,orders,book where customer.custid=orders.custid AND orders.bookid = book.bookid AND
book.price = 20000; */
/*
select customer.name,saleprice from customer left outer join orders on customer.custid = orders.custid
union -- 병합
select customer.name,saleprice from customer right outer join orders on customer.custid = orders.custid;
*/
-- select bookname from book where price = (select max(price) from book);
-- select name from customer where custid in(select custid from orders);
-- select name from customer where custid in(select custid from orders where bookid in (select bookid from book where publisher='이상미디어'));
-- select b1.bookname from book b1 where b1.price >= (select avg(b2.price) from book b2 where b2.publisher=b1.publisher);
/*
select name from customer where address like '대한민국%'
union all
select name from customer where custid in (select custid from orders);
*/

-- select name from customer where address like '대한민국%' and name in (select name from customer where custid in (select custid from orders));
-- select name,address from customer cs where not exists  (select * from orders od where cs.custid=od.custid);

-- select bookname from book where bookid=1;
-- select sum(saleprice), count(*) from customer , orders where customer.custid = orders.custid and customer.name like '박지성';
-- select count(distinct publisher) from book;
-- select * from orders where orderdate not between '20140704' and '20140707';
-- select name, address from customer where name like '김%아';
/*
insert into book(bookid,bookname,publisher,price) values (15,'스포츠 의학','한솔의학서적',90000);
select * from book;
insert into book(bookid,bookname,publisher) values (14,'스포츠 의학', '한솔의학서적'); 
select * from book;
insert into book(bookname,bookid,price,publisher) values ('자료구조',13,65000,'한빛아카데미'); -- 순서 상관 없음!
select * from book;
insert into book(bookid,bookname,publisher,price) select bookid,bookname,publisher,price from imported_book; -- 대량 삽입
select * from book;
*/
/*
set sql_safe_updates=0; -- safe updates 옵션 미 해제 시 실행
update customer set address ='대한민국 부산' where custid = 5;
select * from customer;
*/

-- update book set publisher = (select publisher from imported_book where bookid = '21') where bookid = '14';
-- select * from book;
/*
delete from book where bookid = '11';
delete from customer; -- delete문은 데이터만 삭제됨 : customer 삭제 안됨 - orders에서 사용하고 있기 때문
select * from book,customer; */

/* 연습문제 1번
select distinct name from customer c , orders o , book b
where c.custid = o.custid and o.bookid = b.bookid 
and b.publisher in (select b.publisher from customer c , orders o , book b
where c.custid = o.custid and o.bookid = b.bookid and c.name = '박지성')
and c.name not like '박지성';
*/

/*-- 연습문제 2번
select name, count(distinct publisher) 
from customer c, orders o , book b
where c.custid = o.custid and o.bookid = b.bookid
group by name having count(distinct b.publisher) >= 2;
*/
/*
select name
from customer cc
where 2>=(select count(distinct publisher)
from customer, orders, book
where customer.custid = orders.custid and orders.bookid = book.bookid and (name like cc.name));
*/

insert into book(bookid,bookname,publisher,price) values (18,'스포츠 세계','대한미디어',10000);
select * from book;
delete from book where publisher like '삼성당';
select * from book;
