create database project5; #데이터베이스 생성

use project5; #데이터베이스 사용

############################################## 테이블 생성 ################################

DROP TABLE IF EXISTS `member`; 

CREATE TABLE `member` (
	`member_no`	int	NOT NULL	AUTO_INCREMENT	PRIMARY KEY,
	`member_email`	varchar(50)	NOT NULL,
	`member_name`	varchar(10)	NOT NULL,
	`member_password`	varchar(20)	NOT NULL,
	`member_joindate`	datetime	NOT NULL	DEFAULT now()	COMMENT '가입일',
	`admin_flag`	tinyint	NOT NULL	DEFAULT 0	COMMENT '0-일반사용자, 1-관리자',
	`member_status`	tinyint	NOT NULL	DEFAULT 0	COMMENT '0-승인대기중 ,1-정상회원 (, 2-탈퇴회원)'
);

DROP TABLE IF EXISTS `tag`;

CREATE TABLE `tag` (
	`tag_id`	int	NOT NULL auto_increment PRIMARY KEY,
	`tag_name`	varchar(20)	NOT NULL
);

DROP TABLE IF EXISTS `algorithm`;

CREATE TABLE `algorithm` (
	`algo_no`	int	NOT NULL	AUTO_INCREMENT	PRIMARY KEY	COMMENT '문제 식별자',
	`algo_update`	datetime	NOT NULL	DEFAULT now(),
	`algo_title`	varchar(50)	NOT NULL,
	`algo_detail`	longtext	NOT NULL,
	`member_no`	int	NOT NULL,
    `tag_id` int NOT NULL
);


DROP TABLE IF EXISTS `solution`;

CREATE TABLE `solution` (
	`sol_no`	int	NOT NULL	AUTO_INCREMENT	COMMENT '풀이식별자',
	`algo_no`	int	NOT NULL	COMMENT '문제 식별자',
	`sol_detail`	longtext	NOT NULL,
	`sol_like`	int	NOT NULL	DEFAULT 0,
	`member_no`	int	NOT NULL,
    
    PRIMARY KEY(`sol_no`, `algo_no`)
);

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
	`comment_no`	int	NOT NULL	AUTO_INCREMENT	COMMENT '댓글식별자',
	`sol_no`	int	NOT NULL	COMMENT '풀이식별자',
	`algo_no`	int	NOT NULL	COMMENT '문제 식별자',
	`comment_detail`	longtext	NOT NULL,
	`member_no`	int	NOT NULL,
    
    PRIMARY KEY(`comment_no`, `sol_no`, `algo_no`)
);

DROP TABLE IF EXISTS `file`;

CREATE TABLE `file` (
	`file_no`	int	NOT NULL	AUTO_INCREMENT	PRIMARY KEY,
	`file_name`	varchar(50)	NOT NULL,
	`file_date`	datetime	NOT NULL	DEFAULT now(),
	`file_volume`	bigint	NOT NULL,
	`file_root`	varchar(1000)	NOT NULL,
	`member_no`	int	NOT NULL
);


DROP TABLE IF EXISTS `likes`;

CREATE TABLE `likes` (
	`likes_no`	int	NOT NULL	AUTO_INCREMENT	COMMENT '식별자',
	`sol_no`	int	NOT NULL	COMMENT '풀이식별자',
	`algo_no`	int	NOT NULL	COMMENT '문제 식별자',
	`member_no`	int	NOT NULL,
    
    PRIMARY KEY(`likes_no`, `sol_no`, `algo_no`, `member_no`)
);

DROP TABLE IF EXISTS `algorithm_image`;

CREATE TABLE `algorithm_image` (
	`image_no`	int	NOT NULL	AUTO_INCREMENT	COMMENT '파일 식별자',
	`algo_no`	int	NOT NULL	COMMENT '문제 식별자',
	`image_root`	varchar(1000)	NOT NULL,
	`image_name`	varchar(1000)	NOT NULL,
    
    PRIMARY KEY(`image_no`, `algo_no`)
);

DROP TABLE IF EXISTS `file_list`;

CREATE TABLE `file_list` (
	`file_file`	int	NOT NULL	AUTO_INCREMENT,
	`file_no`	int	NOT NULL,
	`file_root`	varchar(1000)	NOT NULL,
	`file_name`	varchar(1000)	NOT NULL,
    
    PRIMARY KEY(`file_file`, `file_no`)
);

############################################################# 더미데이터 삽입 ##################################
select * from member;
select * from solution;
select * from algorithm;
select * from comment;
select * from file;
select * from algorithm_image;
select * from file_list;

-- 프로시저 삭제 코드
DROP PROCEDURE IF EXISTS loopInsert_member;
DROP PROCEDURE IF EXISTS loopInsert_sol;
DROP PROCEDURE IF EXISTS loopInsert_algo;
DROP PROCEDURE IF EXISTS loopInsert_cmt;
DROP PROCEDURE IF EXISTS loopInsert_file;
DROP PROCEDURE IF EXISTS loopInsert_img;
DROP PROCEDURE IF EXISTS loopInsert_filelist;
DROP PROCEDURE IF EXISTS loopInsert_likes;

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

DELIMITER $$
 

CREATE PROCEDURE loopInsert_tag()
BEGIN
    DECLARE i INT DEFAULT 1;
        
    WHILE i <= 50 DO
        INSERT INTO tag(tag_name)
          VALUES(i);
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
        INSERT INTO algorithm(algo_update, algo_title , algo_detail, member_no, tag_id)
          VALUES(now(), concat('제목',i), concat('내용',i), i/2, i);
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
        INSERT INTO comment(sol_no, algo_no, comment_detail, member_no)
          VALUES(i, i, concat('내용',i), i);
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
          VALUES(concat(i), concat('이미지경로',i), concat('이미지',i));
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
        INSERT INTO file_list(file_no, file_root, file_name)
          VALUES(concat(i), concat('파일경로',i), concat('파일글제목',i));
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE loopInsert_likes()
BEGIN
    DECLARE i INT DEFAULT 1;
        
    WHILE i <= 50 DO
        INSERT INTO likes(sol_no, algo_no, member_no)
          VALUES(concat(i), concat(i), concat(i));
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
CALL loopInsert_likes;
call loopInsert_tag;

select * from member;
select * from algorithm;
select * from solution;
select * from file;
select * from file_list;
select * from comment;
select * from likes;

############################################### cascade 적용 ####################################

ALTER TABLE `algorithm` ADD CONSTRAINT `FK_member_TO_algorithm_1` FOREIGN KEY (
	`member_no`
)
REFERENCES `member` (
	`member_no`
)on delete cascade;

ALTER TABLE `algorithm` ADD CONSTRAINT `FK_tag_TO_algorithm_1` FOREIGN KEY (
	`tag_id`
)
REFERENCES `tag` (
	`tag_id`
)on delete cascade;

ALTER TABLE `solution` ADD CONSTRAINT `FK_algorithm_TO_solution_1` FOREIGN KEY (
	`algo_no`
)
REFERENCES `algorithm` (
	`algo_no`
)on delete cascade;

ALTER TABLE `solution` ADD CONSTRAINT `FK_member_TO_solution_1` FOREIGN KEY (
	`member_no`
)
REFERENCES `member` (
	`member_no`
)on delete cascade;

ALTER TABLE `comment` ADD CONSTRAINT `FK_solution_TO_comment_1` FOREIGN KEY (
	`sol_no`
)
REFERENCES `solution` (
	`sol_no`
)on delete cascade;

ALTER TABLE `comment` ADD CONSTRAINT `FK_solution_TO_comment_2` FOREIGN KEY (
	`algo_no`
)
REFERENCES `solution` (
	`algo_no`
)on delete cascade;

ALTER TABLE `comment` ADD CONSTRAINT `FK_member_TO_comment_1` FOREIGN KEY (
	`member_no`
)
REFERENCES `member` (
	`member_no`
)on delete cascade;

ALTER TABLE `file` ADD CONSTRAINT `FK_member_TO_file_1` FOREIGN KEY (
	`member_no`
)
REFERENCES `member` (
	`member_no`
)on delete cascade;


ALTER TABLE `likes` ADD CONSTRAINT `FK_solution_TO_likes_1` FOREIGN KEY (
	`sol_no`
)
REFERENCES `solution` (
	`sol_no`
)on delete cascade;

ALTER TABLE `likes` ADD CONSTRAINT `FK_solution_TO_likes_2` FOREIGN KEY (
	`algo_no`
)
REFERENCES `solution` (
	`algo_no`
)on delete cascade;

ALTER TABLE `likes` ADD CONSTRAINT `FK_member_TO_likes_1` FOREIGN KEY (
	`member_no`
)
REFERENCES `member` (
	`member_no`
)on delete cascade;

ALTER TABLE `algorithm_image` ADD CONSTRAINT `FK_algorithm_TO_algorithm_image_1` FOREIGN KEY (
	`algo_no`
)
REFERENCES `algorithm` (
	`algo_no`
)on delete cascade;

ALTER TABLE `file_list` ADD CONSTRAINT `FK_file_TO_file_list_1` FOREIGN KEY (
	`file_no`
)
REFERENCES `file` (
	`file_no`
)on delete cascade;


# ########################################################## cascade test #######################################
select * from member;
select * from algorithm;
select * from solution;
select * from likes;
select * from file;
select * from file_list;
select * from comment;
select * from tag;

delete from tag where tag_id = 1;
delete from member where member_no = 2;
delete from member where member_no = 3;
delete from algorithm where algo_no = 1;
