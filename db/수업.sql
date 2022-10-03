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
/*
insert into book(bookid,bookname,publisher,price) values (18,'스포츠 세계','대한미디어',10000);
select * from book;
delete from book where publisher like '삼성당';
select * from book;
*/

-- 모든 도서의 이름과 가격을 검색하시오 --
select bookname, price from book;

-- 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오 --
select bookid,bookname,publisher,price from book;

-- 도서 테이블에 있는 모든 출판사 (중복없이)를 검색하시오 --
 select publisher from book;
 select distinct publisher from book;

-- 가격이 20000원 미만인 도서를 검색하시오 --
select * from book where price < 20000;

-- 가격이 10000원 이상 20000원 이하인 도서를 검색하시오 --
select * from book where price between 10000 and 20000;

-- 출판사가 굿스포츠 혹은 대한미디어 인 도서를 검색하시오 --
select * from book where publisher in('굿스포츠','대한미디어');

-- 축구의역사를 출간한 출판사를 검색하시오 --
select bookname,publisher from book where bookname like '축구의 역사';

-- 도서 이름에 '축구'가 포함된 출판사를 검색하시오 --
select bookname,publisher from book where bookname like '%축구%';

-- 도서 이름의 왼쪽에 두 번째 위치에 '구'라는 문자열을 갖는 도서를 검색하시오 --
select * from book where bookname like '_구%'; 

-- 축구에 관한 도서 중 가격이 20000원 이상인 도서를 검색하시오 --
select * from book where price >= 20000 and bookname like '%축구%';

-- 출판사가 굿스포츠 혹은 대한미디어인 도서를 검색하시오 --
select * from book where publisher like '굿스포츠' or publisher like '대한미디어';

-- 도서를 이름순으로 검색하시오 --
select * from book order by bookname;

-- 도서를 가격순으로 검색하고 가격이 같으면 이름순으로 검색하시오 --
select * from book order by price,bookname;

-- 도서를 가격의 내림차순으로 검색하시오. 만약 가격이 같다면 출판사의 오름차순으로 출력하시오 --
select * from book order by price desc , bookname desc;

-- 고객이 주문한 도서의 총 판매액을 구하시오 --
select sum(saleprice) "총 매출" from orders;

-- 2번 김연아 고색이 주문한 도서의 총 판매액을 구하시오 --
select sum(saleprice) "2번 고객의 판매액" from orders where custid = 2;

-- 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가를 구하시오 --
select sum(saleprice) "총 매출", avg(saleprice) "평균값" , min(saleprice) "최저가" , max(saleprice) "최고가" from orders;

-- 마당 서점의 도서 판매 건수를 검색하시오 --
select count(*) from book;

-- 고객별로 주문한 도서의 총 수량과 총 판매액을 구하시오 --
select custid, count(*) "도서 수량" , sum(saleprice) "총 판매액" from orders group by custid;

-- 가격 8000원 이상 도서를 구매한 고객에 대한 고객별 주문 도서의 총 수량을 구하라. 단 두 권이상 구매한 고객에 한함 --
select custid, count(*) "도서 수량" from orders where saleprice >= 8000 group by custid having count(*) >= 2 order by custid;

-- 고객과 고객의 주문에 관한 데이터를 모두 보이시오. (두 개의 테이블 합치기) --
select * from customer c , orders o where c.custid = o.custid order by c.custid;

-- 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오 --
select name "이름",saleprice"판매가격" from customer c,orders o where c.custid = o.custid;

-- 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오 --
select name, sum(saleprice) from customer c ,orders o where c.custid = o.custid group by c.name order by c.name;

-- 고객의 이름과 고객이 주문한 도서의 이름을 구하시오 --
select customer.name, book.bookname from customer, orders, book where customer.custid=orders.custid AND orders.bookid = book.bookid;
select c.name, b.bookname from customer c,orders o , book b where c.custid = o.custid and o.bookid = b.bookid;

-- 가격이 20000원인 도서를 주문한 고객의 이름과 도서 이름을 구하시오 --
select c.name , b.bookname from customer c, orders o, book b where c.custid = o.custid and b.price = 20000 and o.bookid = b.bookid;

-- 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오 -- 
select c.name , saleprice from customer c left outer join orders o on c.custid=o.custid;





