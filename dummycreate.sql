select * from member;
select * from solution;
select * from algorithm;
select * from comment;
select * from file;
select * from algorithm_image;
select * from file_list;

DROP PROCEDURE IF EXISTS loopInsert_member;
DROP PROCEDURE IF EXISTS loopInsert_sol;
DROP PROCEDURE IF EXISTS loopInsert_algo;
DROP PROCEDURE IF EXISTS loopInsert_comment;
DROP PROCEDURE IF EXISTS loopInsert_file;
DROP PROCEDURE IF EXISTS loopInsert_img;
DROP PROCEDURE IF EXISTS loopInsert_filelist;

#멤버더미
DELIMITER $$
 
CREATE PROCEDURE loopInsert_member()
BEGIN
    DECLARE i INT DEFAULT 1;
        
    WHILE i <= 50 DO
        INSERT INTO member(member_email, member_name , member_password, member_joindate)
          VALUES(concat('이메일',i), concat('이름',i), concat('pass',i), now());
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;


#문제더미
DELIMITER $$
 
CREATE PROCEDURE loopInsert_algo()
BEGIN
    DECLARE i INT DEFAULT 1;
        
    WHILE i <= 50 DO
        INSERT INTO algorithm(algo_update, algo_title , algo_detail, member_no)
          VALUES(now(), concat('제목',i), concat('내용',i), i/2);
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;


# 풀이더미
DELIMITER $$
CREATE PROCEDURE loopInsert_sol()
BEGIN
    DECLARE i INT DEFAULT 1;
        
    WHILE i <= 50 DO
        INSERT INTO solution(algo_no, sol_detail , sol_like, member_no)
          VALUES(i, concat('내용',i), 0, i/2);
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;


# 댓글더미
DELIMITER $$
CREATE PROCEDURE loopInsert_cmt()
BEGIN
    DECLARE i INT DEFAULT 1;
        
    WHILE i <= 50 DO
        INSERT INTO comment(sol_no, algo_no, comment_detail, file_root, member_no)
          VALUES(i, i, concat('내용',i), concat('경로',i), i);
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;


# 파일더미
DELIMITER $$
CREATE PROCEDURE loopInsert_file()
BEGIN
    DECLARE i INT DEFAULT 1;
        
    WHILE i <= 50 DO
        INSERT INTO file(file_name, file_date, file_volume, file_root, member_no)
          VALUES(concat('파일글제목',i), now(), i*100000, concat('파일경로',i), i);
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;


# 이미지더미
DELIMITER $$
CREATE PROCEDURE loopInsert_img()
BEGIN
    DECLARE i INT DEFAULT 1;
        
    WHILE i <= 50 DO
        INSERT INTO algorithm_image(algo_no, image_root, image_name)
          VALUES(concat('문제번호',i), concat('이미지경로',i), concat('이미지',i));
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

# 파일리스트더미
DELIMITER $$
CREATE PROCEDURE loopInsert_filelist()
BEGIN
    DECLARE i INT DEFAULT 1;
        
    WHILE i <= 50 DO
        INSERT INTO algorithm_image(file_no, file_root, file_name)
          VALUES(concat('파일글번호',i), concat('파일경로',i), concat('파일',i));
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;




CALL loopInsert_member;
CALL loopInsert_algo;
CALL loopInsert_sol;
CALL loopInsert_cmt;
CALL loopInsert_file;
CALL loopInsert_img;
CALL loopInsert_filelist;
