package com.spring.myweb.replyboard.page;

public class Page {
	
	private int pageNo;
	private int pageSize;
	
	public Page() {
		this.pageNo = 1;
		this.pageSize = 10;
	}
	
	private int getPageStart() {
		return (pageNo-1) * pageSize + 1;
	};
	
	private int getPageEnd() {
		return pageNo * pageSize;
	};
	

}
