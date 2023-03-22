SELECT SUM(E.COMM)
FROM EMP e;

SELECT SUM(DISTINCT SAL)
	  ,SUM(ALL SAL)
	  ,SUM(SAL)
FROM EMP;

--REDUCE함수, 데이터베이스에선 집계함수라고 부름
SELECT SUM(E.SAL) AS SUM_OF_SAL --합계
	  ,ROUND(AVG(E.SAL), 2) AS AVG_OF_SAL --평균
FROM EMP e ;

SELECT DISTINCT E.DEPTNO 
	,E.SAL, E.EMPNO 
FROM EMP e ;


SELECT MAX(SAL) AS MAX_SAL
 	  ,MIN(SAL) AS MIN_SAL
 	  ,ROUND(MAX(SAL)/MIN(SAL),1) AS MAXMINDIV
FROM EMP
WHERE DEPTNO = 30;

SELECT COUNT(EMPNO)
	  ,COUNT(COMM)
FROM EMP;

SELECT COUNT(*)
FROM EMP
WHERE DEPTNO= 30;

SELECT COUNT(DISTINCT SAL)
	  ,COUNT(ALL SAL)
	  ,COUNT(SAL)
FROM EMP;

SELECT COUNT(ENAME)
FROM EMP
WHERE NVL(COMM, 0) > 0;


SELECT AVG(SAL), '10' AS DNO
FROM EMP
WHERE DEPTNO =10
UNION ALL
SELECT AVG(SAL), '20' AS DNO
FROM EMP
WHERE DEPTNO =20
UNION ALL
SELECT AVG(SAL), '30' AS DNO
FROM EMP
WHERE DEPTNO =30
;


SELECT AVG(SAL), DEPTNO 
FROM EMP
GROUP BY DEPTNO
;



SELECT *
FROM EMP, DEPT
ORDER BY EMPNO
;

SELECT * FROM EMP e , DEPT d 
WHERE ENAME = 'MILLER' 
ORDER BY EMPNO
;

SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO
ORDER BY EMPNO;

SELECT *
FROM EMP e JOIN DEPT d 
		   ON (E.DEPTNO = D.DEPTNO)
ORDER BY EMPNO;

SELECT *
FROM EMP E JOIN DEPT D 
		   USING (DEPTNO)
ORDER BY E.EMPNO;


SELECT E.DEPTNO
	  ,D.DEPTNO 
FROM EMP e ,DEPT d 
WHERE E.ENAME = 'SMITH'
;

SELECT *
FROM EMP E JOIN DEPT D
		 ON (E.DEPTNO = D.DEPTNO)
;


SELECT *
FROM EMP E JOIN DEPT D 
		   USING (DEPTNO)
;


--var_deptno;
--var_sql = "SELECT E.EMPNO
--			     ,E.HIREDATE
--FROM EMP E JOIN DEPT D
--			USING($var_deptno)
--;"
--
----이런식으로 사용할 수도 있으니 using을 쓸 수도 있다. 현업에서 안써.

--var_deptno;
--var_sql = 
--"SELECT *
--FROM EMP E JOIN DEPT D
--		 ON (E.(var_deptno) = D.(var_deptno)
--;"
----이렇게 쓸 수도 있다.


SELECT e.empno
	  ,TO_CHAR(e.hiredate, 'YYYY/MM/DD') AS HIREDATE 
	  ,e.ENAME
	  ,d.deptno
	  ,d.loc
FROM EMP E
	,DEPT D
WHERE E.DEPTNO = D.DEPTNO AND E.SAL <2000;
ORDER BY D.DEPTNO , E.EMPNO 
;

SELECT D.DNAME , E.JOB 
	  ,AVG(E.SAL)
	  ,SUM(E.SAL)
	  ,MAX(E.SAL)
	  ,MIN(E.SAL)
	  ,COUNT(E.SAL)
FROM EMP e ,DEPT d 
WHERE E.DEPTNO = D.DEPTNO AND E.SAL <2000
GROUP BY d.DNAME, E.JOB 
;

SELECT *
FROM EMP E, SALGRADE s 
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL ;


SELECT E.ENAME 
      ,S.GRADE 
      ,E.DEPTNO 
      ,E.SAL 
      ,E.JOB 
FROM EMP e , SALGRADE s 
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL ;


SELECT S.GRADE , COUNT(E.ENAME) AS EMP_CNT
FROM EMP e , SALGRADE s 
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL 
GROUP BY S.GRADE
ORDER BY EMP_CNT;


SELECT E.ENAME 
  	  ,E.DEPTNO 
  	  ,E.JOB 
  	  ,S.GRADE 
  	  ,E.SAL 
  	  ,S.LOSAL AS LOW_RNG
  	  ,S.HISAL AS HIGH_RNG
FROM EMP e ,SALGRADE s 
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL 
ORDER BY E.ENAME DESC
;

SELECT *
FROM EMP E, DEPT D -- 내가 필요한 테이블과 별칭 지정.
WHERE E.DEPTNO = D.DEPTNO  --DEPTNO 칼럼을 기준으로 조인. INNER JOIN
;

--SELF JOIN 자기 자신의 릴레이션을 이용하여 테이블 컬럼을 조작한다.
--MGR과 EMPNO의 체계는 같다.(직원번호) 이러한 릴레이션을 이용.

SELECT E.ENAME AS E1NAME
		,E.EMPNO AS E1MPNO
		,E.MGR AS E1MGR
		,E2.EMPNO  AS "MGR'S EMPNO" 
		,E2.ENAME AS "MGR'S NAME"
FROM EMP e , EMP e2 
WHERE E.MGR = E2.EMPNO(+)
ORDER BY E2.EMPNO DESC
;

SELECT E.ENAME AS E1NAME --위에와 다르게 원하는 결과를 얻지 못함.
		,E.EMPNO AS E1MPNO
		,E.MGR AS E1MGR
		,E2.EMPNO  AS "MGR'S EMPNO" 
		,E2.ENAME AS "MGR'S NAME"
FROM EMP E, EMP E2
WHERE E.EMPNO  =E2.MGR
;

--LEFT-JOIN 왼쪽 테이블 값을 모두 가져오고
--JOIN하는 테이블에서 해당 되는 값 일부만 들어오기

SELECT E.ENAME AS E1NAME
		,E.EMPNO AS E1MPNO
		,E.MGR AS E1MGR
		,E2.EMPNO  AS "MGR'S EMPNO" 
		,E2.ENAME AS "MGR'S NAME"
FROM EMP e , EMP e2
WHERE E.MGR = E2.EMPNO(+)
;

--LEFT JOIN  : 표준 SQL

SELECT E1.ENAME AS E1NAME
		,E1.EMPNO AS E1MPNO
		,E1.MGR AS E1MGR
		,E2.EMPNO  AS "MGR'S EMPNO" 
		,E2.ENAME AS "MGR'S NAME"
FROM EMP E1 LEFT OUTER JOIN EMP E2
			ON E1.MGR = E2.EMPNO 
			
--RIGHT JOIN : 오라클 SQL활용
			
SELECT E1.ENAME AS E1NAME
		,E1.EMPNO AS E1MPNO
		,E1.MGR AS E1MGR
		,E2.EMPNO  AS "MGR'S EMPNO" 
		,E2.ENAME AS "MGR'S NAME"
FROM EMP E1, EMP E2
WHERE E1.MGR(+) = E2.EMPNO


SELECT E1.ENAME AS E1NAME
		,E1.EMPNO AS E1MPNO
		,E1.MGR AS E1MGR
		,E2.EMPNO  AS "MGR'S EMPNO" 
		,E2.ENAME AS "MGR'S NAME"
FROM EMP E1 RIGHT OUTER JOIN EMP E2
		ON E1.MGR = E2.EMPNO 
;


SELECT E1.ENAME AS E1NAME
		,E1.EMPNO AS E1MPNO
		,E1.MGR AS E1MGR
		,E2.EMPNO  AS "MGR'S EMPNO" 
		,E2.ENAME AS "MGR'S NAME"
FROM EMP E1 FULL OUTER JOIN EMP E2
			ON (E1.MGR = E2.EMPNO)
ORDER BY E2.EMPNO ;


SELECT D.DEPTNO 
	  ,D.DNAME 
	  ,E.EMPNO 
	  ,E.ENAME 
	  ,E.MGR 
	  ,E.SAL 
	  ,E.DEPTNO 
	  ,S.LOSAL 
	  ,S.HISAL 
	  ,S.GRADE 
	  ,E2.EMPNO AS MGR_EMPNO
	  ,E2.ENAME AS MGR_ENAME
FROM EMP e , DEPT d ,SALGRADE s ,EMP e2 
WHERE E.DEPTNO (+) = D.DEPTNO 
AND E.SAL BETWEEN S.LOSAL(+) AND S.HISAL (+)
AND E.MGR = E2.EMPNO 
ORDER BY D.DEPTNO , E.EMPNO 
;

SELECT D.DEPTNO 
	  ,D.DNAME 
	  ,E.EMPNO 
	  ,E.ENAME 
	  ,E.MGR 
	  ,E.SAL 
	  ,E.DEPTNO 
	  ,S.LOSAL 
	  ,S.HISAL 
	  ,S.GRADE 
	  ,E2.EMPNO AS MGR_EMPNO
	  ,E2.ENAME AS MGR_ENAME
FROM EMP e RIGHT JOIN DEPT d ON (E.DEPTNO = D.DEPTNO)
LEFT OUTER JOIN SALGRADE s ON (E.SAL>=S.LOSAL AND E.SAL<=S.HISAL)
LEFT OUTER JOIN EMP E2 ON (E.MGR = E2.EMPNO)
ORDER BY D.DEPTNO, E.EMPNO ;



SELECT D.DEPTNO
	  ,D.DNAME 
	  ,E1.EMPNO 
	  ,E1.ENAME 
	  ,E1.MGR 
	  ,E1.SAL
	  ,S.LOSAL 
	  ,S.HISAL 
	  ,S.GRADE 
FROM EMP e1 , DEPT d , SALGRADE s  --,EMP e2 
WHERE E1.DEPTNO(+) = D.DEPTNO 
AND E1.SAL BETWEEN S.LOSAL (+) AND S.HISAL (+)
--AND E1.MGR = E2.EMPNO(+)


SELECT ENAME, SAL 
FROM EMP;

SELECT *
FROM EMP
WHERE SAL > 2850;

SELECT *
FROM EMP
WHERE SAL > (SELECT SAL FROM EMP
				WHERE ENAME = 'BLAKE');

SELECT *
FROM EMP
WHERE HIREDATE < (SELECT HIREDATE FROM EMP
					WHERE ENAME = 'BLAKE');

SELECT E.EMPNO ,E.ENAME ,E.JOB ,E.SAL ,D.DEPTNO ,D.DNAME ,D.LOC 
FROM EMP e , DEPT d 
WHERE E.DEPTNO = D.DEPTNO 
		AND E.DEPTNO = 20
		AND E.SAL > (SELECT AVG(SAL) FROM EMP);

SELECT DEPTNO, ENAME, SAL
FROM EMP
WHERE DEPTNO IN (10,30);

SELECT E.DEPTNO, E.ENAME , E.SAL 
FROM EMP E
WHERE SAL IN (SELECT MAX(SAL)
					FROM EMP
					GROUP BY DEPTNO)
;

SELECT *
FROM EMP
WHERE SAL = ANY(SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO)
;

SELECT SAL 
FROM EMP
WHERE DEPTNO = 30;

SELECT *
FROM EMP
WHERE SAL < ANY(SELECT SAL FROM EMP WHERE DEPTNO = 30)--30부서의 최댓값인 2850보다 작은 SAL값들
ORDER BY SAL, EMPNO;

SELECT *
FROM EMP
WHERE SAL < ALL (SELECT SAL FROM EMP WHERE DEPTNO = 30)--30부서의 최솟값인 950보다 큰 SAL값들
;


SELECT *
FROM EMP
WHERE SAL > ALL (SELECT SAL FROM EMP WHERE DEPTNO = 30)
;

SELECT DEPTNO, MAX(SAL) FROM EMP GROUP BY DEPTNO

SELECT *
FROM EMP
WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL) FROM EMP GROUP BY DEPTNO)
;

SELECT E.EMPNO
	  ,E.ENAME
	  ,E.DEPTNO
	  ,D.DNAME
	  ,D.LOC
FROM (SELECT * FROM EMP WHERE DEPTNO = 10)E, (SELECT * FROM DEPT)D
WHERE E.DEPTNO = D.DEPTNO ;


WITH E AS (SELECT * FROM EMP WHERE DEPTNO = 10), D AS (SELECT * FROM DEPT)
SELECT E.EMPNO
	  ,E.ENAME
	  ,E.DEPTNO
	  ,D.DNAME
	  ,D.LOC
FROM E,D
WHERE E.DEPTNO = D.DEPTNO;









--CREATE TABLE

CREATE TABLE DEPT_TEMP
	AS SELECT * FROM DEPT;

CREATE TABLE dept_TEMP
		AS (SELECT * FROM dept);--형식을 복사해서 새로 만들어!


COMMIT; --보통 자동커밋 가능함.











