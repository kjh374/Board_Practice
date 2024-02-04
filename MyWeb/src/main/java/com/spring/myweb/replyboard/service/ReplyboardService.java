package com.spring.myweb.replyboard.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.spring.myweb.replyboard.dto.RequestDTO;
import com.spring.myweb.replyboard.dto.ResponseDTO;
import com.spring.myweb.replyboard.entity.Replyboard;
import com.spring.myweb.replyboard.mapper.IReplyboardMapper;
import com.spring.myweb.replyboard.page.Page;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReplyboardService implements IReplyboardService{

	private final IReplyboardMapper mapper;
	private final BCryptPasswordEncoder encoder;
	
	@Override
	public void regist(RequestDTO dto) {
		
		if(dto.getParentNo() == 0) {
			mapper.regist(Replyboard.builder()
					.title(dto.getTitle())
					.writer(dto.getWriter())
					.content(dto.getContent())
					.password(encoder.encode(dto.getPassword()))
					.build());
			
		} else {
			mapper.updateGroupOrder(Replyboard.builder()
									.parentNo(dto.getParentNo())
									.groupOrder(dto.getGroupOrder() + 1)
									.build());
			
			mapper.replyRegist(Replyboard.builder()
					.parentNo(dto.getParentNo())
					.groupOrder(dto.getGroupOrder() + 1)
					.boardLevel(dto.getBoardLevel() + 1)
					.title(dto.getTitle())
					.writer(dto.getWriter())
					.content(dto.getContent())
					.password(encoder.encode(dto.getPassword()))
					.build());
		}
		
	}

	@Override
	public List<ResponseDTO> getList(Page page) {
		List<ResponseDTO> boardList = new ArrayList<ResponseDTO>();
		for(Replyboard board : mapper.getList(page)) {
			boardList.add(new ResponseDTO(board));
		};
		
		return boardList;
	}

	@Override
	public ResponseDTO getContent(int bno) {
		return new ResponseDTO(mapper.getContent(bno));
	}

	@Override
	public boolean pwCheck(RequestDTO dto) {
		if(encoder.matches(dto.getPassword(), mapper.getPw(dto.getBno()))) return true;
		return false;
	}
	
	

}
