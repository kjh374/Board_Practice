package com.spring.myweb.replyboard.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.myweb.replyboard.dto.RequestDTO;
import com.spring.myweb.replyboard.page.Page;
import com.spring.myweb.replyboard.service.IReplyboardService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/replyboard")
@RequiredArgsConstructor
public class ReplyboardController {

	private final IReplyboardService service;
	
	@GetMapping("/list")
	public void getList(Model model, Page page) {
		
		 model.addAttribute("boardList", service.getList(page));
//		 model.addAttribute("replyList", service.getReplyList(page));
	} 
	
	
	@GetMapping("/regist")
	public void getRegistPage() {}
	
	@PostMapping("/regist")
	public String regist(RequestDTO dto) {
		System.out.println("dto: " + dto.getPassword());
		service.regist(dto);
		return "redirect:/replyboard/list";
	}
	
	@GetMapping("/content")
	public void getContent(boolean msg, int bno, Model model) {
		System.out.println(bno);
		model.addAttribute("board", service.getContent(bno));
		if(msg) model.addAttribute("msg", msg);
	}
		
	@PostMapping("/modPage")
	public String modPage(RequestDTO dto) {
		System.out.println("bno: fsfewfwefwefewfewfewf" + dto.getBno());
		if(service.pwCheck(dto)) return "replyboard/modify";
		return "redirect:/replyboard/content?msg=true&bno=" + dto.getBno();
	}
	
	@GetMapping("/replyRegist")
	public String getReplyRegistPage(Model model, int parentNo, int groupOrder, int boardLevel) {
		model.addAttribute("parentNo", parentNo);
		model.addAttribute("groupOrder", groupOrder);
		model.addAttribute("boardLevel", boardLevel);
		return "replyboard/regist";
	}
	
}
