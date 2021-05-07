package com.site.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.site.dto.CommentDto;

@Mapper
public interface EventMapper {

	int insertCommentWrite(CommentDto commentDto);

	CommentDto selectCommentWrite(int commentNo);

	void updateCommentUpdate(CommentDto commentDto);

	void deleteComment(int commentNo);

	ArrayList<CommentDto> selectEvent_CommentList(int bid);

	int selectEvent_CommentCount(int bid);

}
