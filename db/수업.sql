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

-- 가장 비싼 도서의 이름을 보이시오 --
select bookname,price from book where price = (select max(price) from book);

-- 도서를 구매한 적이 있는 고객의 이름을 검색하시오 --
select name from customer where custid in(select custid from orders);

-- 대한미디어에서 출판한 도서를 구매한 고객의 이름을 보이시오 --
select name from customer where custid in(select custid from orders where bookid in(select bookid from book where publisher = '대한미디어'));

-- 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오 --
select b1.bookname from book b1 where b1.price > (select avg(b2.price) from book b2 where b2.publisher = b1.publisher);

-- 대한민국에서 거주하는 고객의 이름과 도서를 주문한 고색의 이름을 보이시오(union 사용) -- union all은 중복을 포함하여 구함
select name from customer where address like '대한민국%' union select name from customer where custid in( select custid from orders);

-- 주문이 있는 고객의 이름과 주소를 보이시오 --
select name , address from customer c where exists(select * from orders o where c.custid = o.custid);

-- newTable을 작성하시오 --
create table newBook(bookid integer, bookname varchar(20), publisher varchar(20), price integer, primary key (bookid));

-- newCustomer 테이블을 생성하시오 --
create table newCustomer(custid integer primary key, name varchar(40), address varchar(40), phone varchar(30));

-- newOrders 테이블을 생성하시오 --
 create table newOrders (orderid integer, custid integer not null, bookid integer not null, saleprice integer, orderdate date,
						 primary key(orderid), foreign key(custid) references newCustomer(custid) on delete cascade);
                         
-- newBook 테이블에 varchar(13)의 자료형을 가진 isbn 속성을 추가하시오 --
alter table newBook add isbn varchar(13);

-- newBook 테이블에 isbn 속성의 데이터 타입을 integer형으로 변경하시오 --
alter table newBook modify isbn integer;

-- newBook 테이블의 bookid 속성에 not null 제약조건을 적용하시오 --
alter table newBook modify bookid integer not null;

-- newBook 테이블의 bookid 속성을 기본키로 변경하시오 --
alter table newBook add primary key(bookid);

-- newBook 테이블 삭제 --
drop table newBook;

-- newCustomer 테이블 삭제 --
drop table neworders;
drop table newCustomer;

-- book 테이블에 새로운 도서 '스포츠 의학'을 삽입하시오. 스포츠 의학은 한솔의학서적에서 출간했으며 가격은 90000원이다.
insert into book(bookid,bookname,publisher,price) values(11,'스포츠 의학','한솔의학서적',90000);

-- 수입도서 목록(imported_book)을 테이블에 모두 삽입하시오 --
insert into book(bookid,bookname,price,publisher) select bookid,bookname,price,publisher from imported_book;

-- customer 테이블에서 고객전호가 5인 고객의 주소를 대한민국 부산으로 변경하시오 --
set sql_safe_updates=0;
update customer set address ='대한민국 부산' where custid = 5;

-- book 테이블에서 14번 '스포츠 의학'의 출판사를 imported book 테이블의 21번 출판사와 동일하게 변경하시오.
update book set publisher =(select publisher from imported_book where bookid = '21') where bookid ='14';

-- book 테이블에서 도서번호가 11인 도서를 삭제하시오 --
delete from book where bookid = 11;

-- 연습문제 1번 --
-- (1) 도서번호가 1인 도서의 이름
select bookname from book where book.bookid = 1; 

-- (2) 가격이 20000원 이상인 도서의 이름
select bookname from book where price >= 20000;

-- (3) 박지성의 총 구매액
select sum(saleprice) from orders where custid = (select custid from customer where name = "박지성");

-- (4) 박지성이 구매한 도서의 수
select name, count(*) from customer , orders where customer.custid = orders.custid and name = '박지성';

-- (5) 박지성이 구매한 도서의 출판사 수
select count(distinct publisher) "출판사 수" 
from book where bookid in
(select bookid from orders where custid = 
(select custid from customer where name ='박지성'));

-- (7) 박지성이 구매하지 않은 도서의 이름 --
select * from book where not exists (select bookname from orders where orders.bookid=book.bookid 
									 and orders.custid = (select custid from customer where name = '박지성'));
							
-- 연습문제 2번 --
-- (1) 마당서점 도서의 총 개수
select count(*) from book;

-- (2) 마당서점에 도서를 출고하는 출판사의 총 개수
select count(distinct publisher) from book;

-- (3) 모든 고객의 이름, 주소 
select name , address from customer;

-- (4) 2014년 7월 4일 ~ 7월 7일 사이에 주문받은 도서의 주문번호
select bookid from orders where orderdate between '20140704' and '20140707';

-- (5) 2014년 7월 4일 ~ 7월 7일 사이에 주문받은 도서를 제외한 도서의 주문번호
select bookid from orders where orderdate not between '20140704' and '20140707';

-- (6) 성이 '김'씨인 고객의 이름과 주소
select name,address from customer where name like '김%'; 

-- (7) 성이 '김'씨이고 이름이 '아'로 끝나는 고객의 이름과 주소
select name,address from customer where name like '김%아';

-- (8) 주문하지 않은 고객의 이름(부속질의 사용)
select name from customer where not exists (select custid from orders where customer.custid = orders.custid);

-- (9) 주문 금액의 총액과 주문의 평균 금액
select sum(saleprice) , round(avg(saleprice)) from orders;

-- 심화 문제 1
-- (1) 박지성이 구매한 도서의 출판사와 같은 출판사에서 도서를 구매한 고객의 이름
select distinct name from customer join orders on customer.custid = orders.custid
where bookid in (select bookid from book where customer.name not like '박지성' 
and publisher in (select publisher from orders join book on orders.bookid = book.bookid 
where orders.custid = (select custid from customer where name like '박지성')));

-- (2) 두 개 이상의 서로다른 출판사에서 도서를 구매한 고객의 이름
select name from customer c where 2 >= (select count(distinct publisher) from orders join book on orders.bookid = book.bookid 
join customer on orders.custid = customer.custid where name like c.name);

-- (3) 전체 고객의 30% 이상이 구매한 도서
select bookname from book b where (select count(book.bookid) from book join orders on book.bookid = orders.bookid 
						  where book.bookid = b.bookid ) >= 0.3 * (select count(*) from customer);
                          
-- 심화문제 2
-- (1) 새로운 도서 ('스포츠 세계','대한미디어',10000)원이 마당서점에 입고되었다.
insert into book(bookid,bookname,publisher,price) values(26,'스포츠 세계','대한미디어',10000);

-- (2) 삼성당에서 출판한 도서를 삭제해야 한다.
delete from book where publisher ='삼성당';

-- (3) 이상미디어'에서 출판한 도서를 삭제해야한다. 삭제가 안 되면 원인을 생각해보자.
-- 답 : orders에 공유 된 키가 있기 때문에 지워지지 않는다. orders에 bookid가 7,8인 경우가 없어야 삭제 가능
delete from book where publisher = "이상미디어";

-- (4) 출판사 '대한미디어'가 '대한출판사'로 이름을 바꾸었다.
update book set publisher = '대한출판사' where publisher = '대한미디어';
