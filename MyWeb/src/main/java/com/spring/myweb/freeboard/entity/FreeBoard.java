package com.spring.myweb.freeboard.entity;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/*
 

DROP TABLE freeboard;

CREATE TABLE freeboard (
    bno NUMBER PRIMARY KEY,
    group_no NUMBER DEFAULT 0,
    group_order NUMBER DEFAULT 0,
    board_level NUMBER DEFAULT 0,
    title VARCHAR2(300) NOT NULL,
    writer VARCHAR2(30) NOT NULL,
    content VARCHAR2(3000) NOT NULL,
    password VARCHAR2(100) NOT NULL,
    reg_date DATE DEFAULT sysdate,
    update_date DATE DEFAULT NULL
);

DROP SEQUENCE freeboard_seq;

CREATE SEQUENCE freeboard_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;    
    
COMMIT;

BEGIN 
    FOR i IN 1..100
    LOOP 
        INSERT INTO freeboard (bno, title, writer)
        VALUES (freeboard_seq.nextval, 'title' || freeboard_seq.nextval, 'tester');
    END LOOP;
END;    
    
    
*/

@Getter @Setter
@ToString @EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FreeBoard {

	private int bno;
	private int rn;
	private String title;
	private String writer;
	private String content;
	private String password;
	private LocalDateTime regDate;
	private LocalDateTime updateDate;
	private int rCount;
}
