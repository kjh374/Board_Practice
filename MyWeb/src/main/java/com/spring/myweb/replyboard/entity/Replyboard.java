package com.spring.myweb.replyboard.entity;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

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
