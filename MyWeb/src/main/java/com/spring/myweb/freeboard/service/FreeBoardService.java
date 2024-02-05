package com.spring.myweb.freeboard.service;

import java.util.ArrayList; 
import java.util.Iterator;
import java.util.List;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.spring.myweb.freeboard.dto.page.Page;
import com.spring.myweb.freeboard.dto.request.FreeModifyRequestDTO;
import com.spring.myweb.freeboard.dto.request.FreeRegistRequestDTO;
import com.spring.myweb.freeboard.dto.response.FreeContentResponseDTO;
import com.spring.myweb.freeboard.dto.response.FreeListResponseDTO;
import com.spring.myweb.freeboard.entity.FreeBoard;
import com.spring.myweb.freeboard.mapper.IFreeBoardMapper;
import com.spring.myweb.reply.mapper.IReplyMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FreeBoardService implements IFreeBoardService {

	private final IFreeBoardMapper mapper;
	private final IReplyMapper rMapper;
	private final BCryptPasswordEncoder encoder;
	
	@Override
	public void regist(FreeRegistRequestDTO dto) {
		mapper.regist(FreeBoard.builder()
								.title(dto.getTitle())
								.writer(dto.getWriter())
								.content(dto.getContent())
								.password(encoder.encode(dto.getPassword()))
								.build());
	}

	@Override
	public List<FreeListResponseDTO> getList(Page page) {
		List<FreeListResponseDTO> dtoList = new ArrayList<FreeListResponseDTO>();
		List<FreeBoard> list = mapper.getList(page);
		for(FreeBoard board : list) {
			board.setRCount(rMapper.getTotal(board.getBno()));
			System.out.println("rCount: " + board.getRCount());
			dtoList.add(new FreeListResponseDTO(board));
		}
		
		return dtoList;
	}
	
	@Override
	public int getTotal(Page page) {
		return mapper.getTotal(page);
	}
	
	@Override
	public FreeContentResponseDTO getContent(int bno) {
		return new FreeContentResponseDTO(mapper.getContent(bno));
	}

	@Override
	public void update(FreeModifyRequestDTO dto) {
		mapper.update(FreeBoard.builder()
				.bno(dto.getBno()).title(dto.getTitle()).writer(dto.getWriter()).content(dto.getContent())
				.build());
		
	}

	@Override
	public void delete(int bno) {
		mapper.delete(bno);
	}

	@Override
	public boolean authenticate(FreeModifyRequestDTO dto) {
		if(encoder.matches(dto.getPassword(), mapper.getPassword(dto.getBno()))) {
			return true;
		}
		return false;
	}


}
