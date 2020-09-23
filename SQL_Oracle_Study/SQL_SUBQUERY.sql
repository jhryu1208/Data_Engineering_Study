--- 9-1
SELECT SAL
    FROM EMP
    WHERE ENAME = 'JONES';
    
--- 9-2
SELECT *
    FROM EMP
    WHERE SAL > 2975;
    
--- 9-3
SELECT *
    FROM EMP
    WHERE SAL > (SELECT SAL
                    FROM EMP
                    WHERE ENAME = 'JONES');
                    
--- 9-4
SELECT *
    FROM EMP
    WHERE HIREDATE < (SELECT HIREDATE
                        FROM EMP
                        WHERE ENAME = 'SCOTT');
                        
--- 9-5
SELECT  E.EMPNO, E.ENAME, E.JOB, E.SAL,
        D.DEPTNO, D.DNAME, D.LOC
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
        AND E.DEPTNO = 20 
        AND E.SAL > (SELECT AVG(SAL)
                        FROM EMP);

--- 9-6
SELECT *
    FROM EMP
    WHERE DEPTNO IN(20,30);

--- 9-7
SELECT *
    FROM EMP
    WHERE SAL IN(SELECT MAX(SAL)
                    FROM EMP
                    GROUP BY DEPTNO);
                    
    
--- 9-8
SELECT *
    FROM EMP
    WHERE SAL = ANY(SELECT MAX(SAL)
                        FROM EMP
                        GROUP BY DEPTNO);

--- 9-9
SELECT *
    FROM EMP
    WHERE SAL = SOME(SELECT MAX(SAL)
                        FROM EMP
                        GROUP BY DEPTNO);

--- 9-10
SELECT *
    FROM EMP
    WHERE SAL < ANY(SELECT SAL
                        FROM EMP
                        WHERE DEPTNO = 30)
    ORDER BY SAL, DEPTNO;
    
--- 9-11
SELECT SAL
    FROM EMP
    WHERE DEPTNO = 30;
    
--- 9-13
SELECT *
    FROM EMP
    WHERE SAL > ANY (SELECT SAL
                        FROM EMP
                        WHERE DEPTNO = 30);
                        
--- 9-14
SELECT *
    FROM EMP
    WHERE SAL < ALL (SELECT SAL
                        FROM EMP
                        WHERE DEPTNO = 30);

--- 9-15
SELECT *
    FROM EMP
    WHERE SAL > ALL (SELECT SAL
                        FROM EMP
                        WHERE DEPTNO = 30);

--- 9-16
SELECT *
    FROM EMP
    WHERE EXISTS(SELECT DNAME
                    FROM DEPT
                    WHERE DEPTNO = 10);
                    
--- 9-17
SELECT *
    FROM EMP
    WHERE EXISTS(SELECT DNAME
                    FROM DEPT
                    WHERE DEPTNO = 50);

--- 9-18
SELECT *
    FROM EMP
    WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL)
                                FROM EMP
                                GROUP BY DEPTNO);

--- 9-19
SELECT  E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
    FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10,
         (SELECT * FROM DEPT) D
    WHERE E10.DEPTNO = D.DEPTNO;
                                
--- 9-20
WITH
E10 AS (SELECT * FROM EMP WHERE DEPTNO = 10),
D   AS (SELECT * FROM DEPT)
SELECT  E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
    FROM E10, D
    WHERE E10.DEPTNO = D.DEPTNO;    
    
--- 9-21
SELECT  EMPNO, ENAME, JOB, SAL,
        (SELECT GRADE
            FROM SALGRADE
            WHERE E.SAL BETWEEN LOSAL AND HISAL) AS SALGRADE,
        DEPTNO,
        (SELECT DNAME
            FROM DEPT D
            WHERE E.DEPTNO = D.DEPTNO) AS DNAME
    FROM EMP E;
    