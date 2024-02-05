package com.spring.myweb.freeboard.dto.response;

import lombok.ToString;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import com.spring.myweb.freeboard.entity.FreeBoard;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

// 클라이언트 측으로 게시글 목록을 줄 때의 스펙 정의.
@Getter @Setter @ToString @EqualsAndHashCode
public class FreeListResponseDTO {

	private int bno;
	private int rn;
	private String title;
	private String writer;
	private String date;
	
	private int count;
	
	public FreeListResponseDTO(FreeBoard board) {
		super();
		this.bno = board.getBno();
		this.rn = board.getRn();
		this.title = board.getTitle();
		this.writer = board.getWriter();
		this.date = makePrettierDateString(board.getRegDate());
		this.count = board.getRCount();
	}	
	
	static String makePrettierDateString(LocalDateTime regDate) {
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		return dtf.format(regDate);
	}





	
}
