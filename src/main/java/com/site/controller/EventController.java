package com.site.controller;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.site.dto.CommentDto;
import com.site.service.EventService;

@Controller
public class EventController {
	
	Map map;
	
	@Autowired
	EventService eventService;
	
	@RequestMapping("/event/event")
	public String event() {
		return "event/event";
	}
	
	@RequestMapping("/event/event_view") //댓글 list 보여주기
	public String event_view(Model model) {
		map = new HashMap<String, Object>();
		int bid=217;
		List<CommentDto> list = eventService.event_CommentList(bid);
		int count = eventService.event_CommentCount(bid);
		
		map.put("list", list);
		map.put("count", count);
		model.addAttribute("map",map);
		System.out.println("conroller count:"+count);
		System.out.println("conroller list:"+list.get(0).getCommentNo());
		return "event/event_view";
	}
	
	@RequestMapping("/event/commentWrite_check")
	@ResponseBody
	public Map<String, Object> commentWrite_check(CommentDto commentDto) {
		
		map = new HashMap<String, Object>();
		System.out.println("commentDto:"+commentDto.getId());
		
		CommentDto dto = eventService.commentWrite_check(commentDto);
		
		//DB에서 데이터를 받아올것.
		map.put("dto", dto);
		
		return map;
	}
	
	@RequestMapping("/event/commentUpdate_check")//댓글수정저장버튼클릭
	@ResponseBody
	public Map<String, Object> commentUpdate_check(CommentDto commentDto) {
		
		map = new HashMap<String, Object>();
		System.out.println("commentNo:"+commentDto.getCommentNo());
		System.out.println("commentContent:"+commentDto.getCommentContent());
		
		CommentDto dto = eventService.commentUpdate_check(commentDto);
		
		//DB에서 데이터를 받아올것.
		map.put("dto", dto);
		
		return map;
	}
	@RequestMapping("/event/commentDelete")//댓글삭제버튼클릭
	@ResponseBody
	public Map<String, Object> commentDelete(@RequestParam @Nullable int commentNo) {
		
		map = new HashMap<String, Object>();
		System.out.println("commentNo:"+commentNo);
		
		eventService.commentDelete(commentNo);
		
		//DB에서 데이터를 받아올것.
		map.put("msg", "삭제되었습니다.!");
		
		return map;
	}
	
}
