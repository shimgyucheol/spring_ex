package com.site.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.site.dto.CommentDto;
import com.site.mapper.EventMapper;

@Service
public class EventServiceImpl implements EventService {
	
	@Autowired
	EventMapper eventMapper;
	
	ArrayList<CommentDto> list;
	
	
	@Override
	public CommentDto commentWrite_check(CommentDto commentDto) {
		
		//댓글 insert
		eventMapper.insertCommentWrite(commentDto);
		//위의 commentDto와 아래의 commentDto는 다르다고 생각하면됨
		//그래서 다른 commentNo를 가져올수있게됨
		// keyProperty="commentNo" -> commentDto.getCommentNo로 읽을수 있음
		int commentNo = commentDto.getCommentNo();
		
		//저장된 insert의 commentNo로 dto를 불러옴
		CommentDto dto = eventMapper.selectCommentWrite(commentNo);
		
		return dto;
	}


	@Override
	public CommentDto commentUpdate_check(CommentDto commentDto) {
		
		eventMapper.updateCommentUpdate(commentDto);
		
		//update후 그 commentDto의 commentNo로 update된 그 내용을 가져옴
		//commentNo는 변하지 않음
		int commentNo = commentDto.getCommentNo();
		CommentDto dto = eventMapper.selectCommentWrite(commentNo);
		
		return dto;
	}


	@Override
	public void commentDelete(int commentNo) {
		eventMapper.deleteComment(commentNo);
		
	}


	@Override
	public List<CommentDto> event_CommentList(int bid) {
		list = eventMapper.selectEvent_CommentList(bid);
		System.out.println("getCommentNo() impl:"+list.get(0).getCommentNo());
		return list;
	}


	@Override
	public int event_CommentCount(int bid) {
		int count = eventMapper.selectEvent_CommentCount(bid);
		System.out.println("impl:"+count);
		return count;
	}

}
