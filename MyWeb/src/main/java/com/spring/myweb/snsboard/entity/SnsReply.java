package com.spring.myweb.snsboard.entity;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/*
 CREATE TABLE sns_reply (
    bno NUMBER PRIMARY KEY,
    rno NUMBER NOT NULL,
    writer VARCHAR2(50) NOT NULL,
    content VARCHAR2(50) NOT NULL,
    reg_date DATE DEFAULT sysdate,
    update_date DATE DEFAULT NULL
    
);

CREATE SEQUENCE sns_reply_seq
    NOCYCLE
    NOCACHE;
 */
@Setter @Getter @ToString
@EqualsAndHashCode
@AllArgsConstructor
@NoArgsConstructor
public class SnsReply {
	
	private int bno;
	private int rno;
	private String writer;
	private String content;
	private LocalDateTime regDate;
	private LocalDateTime updateDate;
	
}
