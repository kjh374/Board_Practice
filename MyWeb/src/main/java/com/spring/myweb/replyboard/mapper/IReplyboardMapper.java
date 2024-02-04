package com.spring.myweb.replyboard.mapper;

import java.util.List;

import com.spring.myweb.replyboard.dto.RequestDTO;
import com.spring.myweb.replyboard.entity.Replyboard;
import com.spring.myweb.replyboard.page.Page;

public interface IReplyboardMapper {

	void regist(Replyboard replyboard);
	
	void replyRegist(Replyboard replyboard);

	List<Replyboard> getList(Page page);

	Replyboard getContent(int bno);

	String getPw(int bno);

	List<Replyboard> getReplyList(Page page);

	void updateGroupOrder(Replyboard replyboard);

}
