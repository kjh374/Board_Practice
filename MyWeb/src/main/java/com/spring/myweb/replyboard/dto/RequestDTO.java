package com.spring.myweb.replyboard.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter
@ToString
public class RequestDTO {
	
	private int bno;
	private int parentNo;
	private int groupOrder;
	private int boardLevel;
	private String title;
	private String writer;
	private String content;
	private String password;
}
