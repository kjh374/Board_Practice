package com.spring.myweb.replyboard.entity;

import java.time.LocalDateTime;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/*
 
DROP TABLE replyboard;

CREATE TABLE replyboard (
    bno NUMBER PRIMARY KEY,
    parent_no NUMBER DEFAULT 0,
    group_order NUMBER DEFAULT 0,
    board_level NUMBER DEFAULT 0,
    title VARCHAR2(90) NOT NULL,
    writer VARCHAR2(30) NOT NULL,
    content VARCHAR2(3000) NOT NULL,
    password VARCHAR2(100) NOT NULL,
    reg_date DATE DEFAULT sysdate,
    update_date DATE DEFAULT NULL
);

DROP SEQUENCE replyboard_seq;

CREATE SEQUENCE replyboard_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;    
    
COMMIT;

BEGIN 
    FOR i IN 1..100
    LOOP 
        INSERT INTO replyboard (bno, title, writer)
        VALUES (replyboard_seq.nextval, 'title' || replyboard_seq.nextval, 'tester');
    END LOOP;
END;    
    
 */

@Getter @Setter
@EqualsAndHashCode
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Replyboard {
	
	private int bno;
	private int rno;
	private int parentNo;
	private int groupOrder;
	private int boardLevel;
	private String title;
	private String writer;
	private String content;
	private String password;
	private LocalDateTime regDate;
	private LocalDateTime updateDate;
}
