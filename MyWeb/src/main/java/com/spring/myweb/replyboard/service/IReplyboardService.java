package com.spring.myweb.replyboard.service;

import java.util.List;

import com.spring.myweb.replyboard.dto.RequestDTO;
import com.spring.myweb.replyboard.dto.ResponseDTO;
import com.spring.myweb.replyboard.page.Page;

public interface IReplyboardService {

	void regist(RequestDTO dto);

	List<ResponseDTO> getList(Page page);

	ResponseDTO getContent(int bno);

	boolean pwCheck(RequestDTO dto);
	
}
