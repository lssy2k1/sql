--별칭 또는 오라클 객체명의 경우, 쌍따옴표를 사용하지 않는 경우
--기본값이 대문자로 저장/ 출력

--INNER JOIN 1:1 관계로 테이블간 연결을 통해 추가 정보를 제공하는 목적이 대부분

SELECT *
	FROM EMP e JOIN DEPT d 
		ON E.DEPTNO = D.DEPTNO 
		;
		
SELECT E1.EMPNO
	  ,E1.ENAME 
	  ,E1.MGR
	  ,E2.EMPNO = AS MGR_EMPNO
	  ,E2.ENAME = AS MGR_ENAME
FROM EMP E1 JOIN EMP E2
	ON E1.MGR = E2.EMPNO
	;
	
--SELFJOIN으로 MGR이 누군이 확인.
--KING은 MGR이 없으므로 LEFT JOIN으로 다 나오게 함.




-- sal 구간을 이용하여 해당 구간에 해당되는 직원을 

SELECT e.empno
	, e.ename
	, s.grade AS grade
	, e.job
	, e.hiredate
	, e.sal
	, e.comm
	, e.deptno
	, s.losal
	, s.hisal
 FROM emp e, salgrade s
 WHERE e.sal BETWEEN s.losal AND s.hisal
 , emp_dept AS (SELECT e.EMPNO
 				, e.ename
 				, e.job
 				, e.hiredate
 				, e.sal
 				, e.comm
 				, d.deptno
 				, d.dname
 				, d.loc
 			FROM emp e JOIN dept D
 				ON e.deptno = d.deptno)
 SELECT *
  FROM emp_sal, emp_dept
 ;
 

/*
 * self-join : 하나의 테이블에 성질이 동일한 2개 이상의 컬럼의 관계를
 * 이용하여 원하는 레코드의 관계를 산출하고 싶은 경우 사용
 * 
 * emp 테이블: empno 사번과 mgr 상사 사번(동일 사번 매칭)
 */

SELECT 
 FROM emp e1 JOIN emp e2
  	ON e1.mgr = e2.empno
 ;


-- emp, dept, salgrade, 그리고 emp self-join



SELECT *
 FROM emp e1 RIGHT JOIN dept D 	
 	ON e1.deptno = de.deptno
  LEFT JOIN SALGRADE s  



  
  
  
DROP TABLE emp_new
;


CREATE TABLE emp_new (
		empno			number(4) 
		, ename			varchar2(10)
		, job 			varchar2(9)
		, mgr 			number(4)
		, hiredate		DATE
		, sal 			number(7,2)
		, comm  		number(7, 2)
		, deptno 		number(2)
);


SELECT * FROM emp_new;

ALTER TABLE emp_new 
	ADD hp varchar(20);

ALTER TABLE emp_new
	RENAME COLUMN hp TO tel;


ALTER TABLE emp_new
 MODIFY empno number(5);

ALTER TABLE emp_new
 DROP COLUMN tel;

SELECT * FROM emp_new;

-- 컬럼명 변경
ALTER TABLE EMP_NEW 
 RENAME COLUMN tel TO mobile;

SELECT * FROM emp_new;

ALTER TABLE emp_new
 DROP COLUMN mobile;

ALTER TABLE emp_new 
 RENAME TO emp_rename;

TRUNCATE TABLE emp_temp;

SELECT * FROM emp_temp;

DROP TABLE emp_temp;


-- 시퀀스 생성
CREATE SEQUENCE seq_deptseq1
 	INCREMENT BY 1
 	START WITH 1
 	MAXVALUE 99
 	MINVALUE 1
 	nocycle nocache;
 
CREATE TABLE deptseq AS SELECT * FROM dept;

INSERT INTO deptseq(deptno, dname, loc)
VALUES (seq_deptseq.nextval, 'database', 'seoul');

INSERT INTO deptseq(deptno, dname, loc)
VALUES (seq_deptseq.nextval, 'web', 'busan');

INSERT INTO deptseq(deptno, dname, loc)
VALUES (seq_deptseq.nextval, 'mobile', 'ilsan');