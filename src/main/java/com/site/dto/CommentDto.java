package com.site.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommentDto {
	
	private int commentNo;
	private int bid;
	private String id;
	private String commentPw;
	private String commentContent;
	private Timestamp commentDate;

}
