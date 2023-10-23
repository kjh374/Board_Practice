package com.spring.myweb.snsboard.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.spring.myweb.freeboard.dto.page.Page;
import com.spring.myweb.snsboard.dto.SnsBoardRequestDTO;
import com.spring.myweb.snsboard.dto.SnsBoardResponseDTO;
import com.spring.myweb.snsboard.service.SnsBoardService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/snsboard")
@RequiredArgsConstructor
public class SnsBoardController {
	
	private final SnsBoardService service;	
	
	@GetMapping("/snsList")
	public ModelAndView snsList() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("snsboard/snsList");
//		mv.addObject("name", "value");
		return mv;
		
	}

	@PostMapping()
	public String upload(SnsBoardRequestDTO dto) {
		service.insert(dto);
		return "uploadSuccess";
	}

	@GetMapping("/{page}")
	public List<SnsBoardResponseDTO> getList(@PathVariable int page) {
		System.out.println("/snsboard/getList: GET!");
		return service.getList(page);
	}
	
	/*
    # 게시글의 이미지 파일 전송 요청
    이 요청은 img 태그의 src 속성을 통해서 요청이 들어오고 있습니다.
    snsList.jsp 페이지가 로딩되면서, 글 목록을 가져오고 있고, JS를 이용해서 화면을 꾸밀 때
    img 태그의 src에 작성된 요청 url을 통해 자동으로 요청이 들어오게 됩니다.
    요청을 받아주는 메서드를 선언하여 경로에 지정된 파일을 보낼 예정입니다.
    */
	@GetMapping("/display/{fileLoca}/{fileName}")
	public ResponseEntity<?> getImage(@PathVariable String fileLoca, @PathVariable String fileName) {
		System.out.println("fileLoca: " + fileLoca);
		System.out.println("fileName: " + fileName);
		
		File file = new File("C:/test/upload/" + fileLoca + "/" + fileName);
		System.out.println(file.toString()); // 완성된 경로.
		System.out.println(file);
		
		//응답에 대한 여러가지 정보를 전달할 수 있는 객체 ResponseEntity
		//응답 내용, 응답이 성공했는지에 대한 여부, 응답에 관련된 여러 설정들을 지원합니다.
		ResponseEntity<byte[]> result = null;
		
		HttpHeaders headers = new HttpHeaders(); //응답 헤더 객체 생성.
		
		try {
            //probeContentType: 매개값으로 전달받은 파일의 타입이 무엇인지를 문자열로 반환.
            //사용자에게 보여주고자 하는 데이터가 어떤 파일인지에 따라 응답 상태 코드를 다르게 리턴하고
            //컨텐트 타입을 제공해서 화면단에서 판단할 수 있게 처리할 수 있다.
			headers.add("Content-Type", Files.probeContentType(file.toPath()));
			headers.add("value", "hello");
			
			//ResponseEntity 객체에 전달하고자 하는 파일을 byte[]로 변환해서 전달. (파일의 손상을 막기 위해)
			//header 내용도 같이 포함, 응답 상태 코드를 원하는 형태로 전달이 가능.
			
			// 생성자를 이용하여 ResponseEntity 생성하는 법.
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), headers, HttpStatus.OK);
			
		} catch (IOException e) {
			e.printStackTrace();
			// static 메서드를 활용하여 ResponseEntity 객체를 생성하는 법.
			return ResponseEntity.badRequest().body(e.getMessage());
		}
		
		return result;
	}
	
	@GetMapping("/download/{fileLoca}/{fileName}")
	public ResponseEntity<?> download(@PathVariable String fileLoca, @PathVariable String fileName) {
		File file = new File("C:/test/upload/" + fileLoca + "/" + fileName);
		ResponseEntity<byte[]> result = null;
		
		HttpHeaders header = new HttpHeaders(); 
		
        //응답하는 본문을 브라우저가 어떻게 표시해야 할 지 알려주는 헤더 정보를 추가합니다.
        //inline인 경우 웹 페이지 화면에 표시되고, attachment인 경우 다운로드를 제공합니다.
        
        //request객체의 getHeader("User-Agent") -> 단어를 뽑아서 확인
        //ie: Mozilla/5.0 (Windows NT 6.3; WOW64; Trident/7.0; rv:11.0) like Gecko  
        //chrome: Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.101 Safari/537.36
    
        //파일명한글처리(Chrome browser) 크롬
        //header.add("Content-Disposition", "attachment; filename=" + new String(fileName.getBytes("UTF-8"), "ISO-8859-1") );
        //파일명한글처리(Edge) 엣지 
        //header.add("Content-Disposition", "attachment; filename=" + URLEncoder.encode(fileName, "UTF-8"));
        //파일명한글처리(Trident) IE
        //Header.add("Content-Disposition", "attachment; filename=" + URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", " "));
		header.add("Content-Disposition", "attachment; filename=" + fileName);
		
		try {
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
			result = new ResponseEntity<byte[]>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return result;
	}
	
	@GetMapping("/content/{bno}")
	public SnsBoardResponseDTO getDetail(@PathVariable int bno){
		return service.getDetail(bno);
	}
	
//	@GetMapping("/content/{bno}")
//	public Map<?, ?> getDetail(@PathVariable int bno){
//		SnsBoardResponseDTO dto = service.getDetail(bno);
//		File file = new File("C:/test/upload/" + dto.getFileLoca() + "/" + dto.getFileName());
//        System.out.println(file.toString());
//        System.out.println(dto.getFileLoca());
//		
//		HttpHeaders header = new HttpHeaders();
//		header.add("Content-Disposition", "inline; fileName=" + dto.getFileName());
//		ResponseEntity<byte[]> result = null;
//		try {
//			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
//		} catch (IOException e) {
//			e.printStackTrace();
//			result = new ResponseEntity<byte[]>(HttpStatus.INTERNAL_SERVER_ERROR);
//		}
//		
//		
//		Map<String, Object> map = new HashMap<>();
//		map.put("img", result);
//		map.put("content", dto);
//		
//		return map;
//		
//	}

	
}