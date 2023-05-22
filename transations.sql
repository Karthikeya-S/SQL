-- use wileyclassic

SET autocommit = 0;

COMMIT;
SELECT * FROM members;
delete from members;
rollback; 