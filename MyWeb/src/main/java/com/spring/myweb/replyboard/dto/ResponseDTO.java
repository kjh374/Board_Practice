package com.spring.myweb.replyboard.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import com.spring.myweb.replyboard.entity.Replyboard;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Builder
@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
public class ResponseDTO {

	private int bno;
	private int rno;
	private int parentNo;
	private int groupOrder;
	private int boardLevel;
	private String title;
	private String writer;
	private String content;
	private String date;
	
	public ResponseDTO(Replyboard board) {
		this.bno = board.getBno();
		this.rno = board.getRno();
		this.parentNo = board.getParentNo();
		this.groupOrder = board.getGroupOrder();
		this.boardLevel = board.getBoardLevel();
		this.title = board.getTitle();
		this.writer = board.getWriter();
		this.content = board.getContent();
		this.date = makePrettierDateString(board.getRegDate());
	}
	
	static String makePrettierDateString(LocalDateTime regDate) {
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		return dtf.format(regDate);
	}
	
}
