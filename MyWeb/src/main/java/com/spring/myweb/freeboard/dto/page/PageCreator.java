package com.spring.myweb.freeboard.dto.page;

import lombok.Getter;
import lombok.ToString;

@Getter @ToString
public class PageCreator {

	//한 화면에 배치할 버튼의 개수
	private static final int BUTTON_NUM = 5;
	
	//화면 렌더링 시 페이지의 시작값과 끝값.
	private int begin, end, first, last;
	
	//이전, 다음 버튼 활성화 여부
	private boolean prev, next;
	
	//현재 요청 페이지 정보
	private Page page;
	
	//총 게시물 수
	private int articleTotalCount;
	
	// 페이징 알고리즘을 수행하기 위해 외부로부터 필요한 데이터를 전달받음.
	public PageCreator(Page page, int articleTotalCount) {
		this.page = page;
		this.articleTotalCount = articleTotalCount;
		calcDataOfPage(); //전달 완료 후 알고리즘 수행!
	}
	
	private void calcDataOfPage() {
		//끝 페이지 계산
		this.end = (int)Math.ceil(page.getPageNo()/ (double)BUTTON_NUM)*BUTTON_NUM ;
		
		//시작 페이지 계산
		this.begin = end - BUTTON_NUM + 1;

		//		this.prev = (begin == 1) ? false : true;
		this.prev = begin > 1;
		
		this.next = articleTotalCount > (end*page.getAmount()) ? true : false;
		
		if(!next) {
			this.end = (int) Math.ceil(articleTotalCount/ (double)page.getAmount()); 
		}
		
		//처음 페이지 계산
		this.first = 1;
		
		//마지막 페이지 계산
		this.last = (int) Math.ceil(articleTotalCount/ (double)page.getAmount());
	}
	
}
