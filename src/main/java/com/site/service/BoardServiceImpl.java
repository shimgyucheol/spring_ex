package com.site.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.site.dto.BoardDto;
import com.site.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardMapper boardMapper;
	
	@Autowired
	PageNumber pageNumber;
	
	Map<String, Object> map;
	
	List<BoardDto> list;
	
	BoardDto boardDto;
	
	BoardDto preDto;
	
	BoardDto nextDto;
	
	@Override
	public Map<String, Object> boardListAll(String listPage,String category,String search) {
		//Map map = new HashMap<String, Object>();
		list = new ArrayList<BoardDto>();
		int page=1; //첫페이지 초기화
		int limit=10; //한페이지에 나오는 게시글 개수:10
		
		if(listPage!=null && listPage!="") {
			page=Integer.parseInt(listPage);
		}
		
		int startrow = (page-1)*limit+1; // 시작 게시글번호 1,11,21...
		int endrow = startrow+limit-1; // 마지막 게시글번호 10,20,30...
		
		//리스트 가져오는 메소드
		if(category==null||category.equals("")) {
			list = boardMapper.selectBoardListAll(startrow,endrow);
		}else if(category.equals("title")) { //opt:title search:제목
			list = boardMapper.selectBoardListTitle(startrow,endrow,search);
		}else if(category.equals("content")) { //opt:title search:제목
			list = boardMapper.selectBoardListContent(startrow,endrow,search);
		}else if(category.equals("all")) { //opt:title search:제목
			list = boardMapper.selectBoardListSearchAll(startrow,endrow,search);
		}
		
		
		
		
		//request.getParameter(null); 데이터가 넘어올떄 -form,파라미터,등등
		//request.setAttribute(null, dao);
		//request.getAttribute(null); 이것은 setAttribute로 넣은값을 불러올떄 쓰임
		
		map = pageNumber.pageNumber(page, limit,category,search);
		map.put("list", list);
		
		return map;
	}
	
	@Override
	public Map<String, Object> boardContent_view(String bid, String page, String category, String search) {
		//조회수1증가
		boardMapper.selectUpHit(bid);
		//content 1개 가져오기
		boardDto = boardMapper.selectBoardContent_view(bid);
		
		//리스트 가져오는 메소드
		if(category==null||category.equals("")) {
			preDto = boardMapper.selectBoard_pre(bid);
			nextDto = boardMapper.selectBoard_next(bid);
		}else if(category.equals("title")) { //opt:title search:제목
			preDto = boardMapper.selectBoard_preTitle(bid,search);
			nextDto = boardMapper.selectBoard_nextTitle(bid,search);
		}else if(category.equals("content")) { //opt:title search:제목
			preDto = boardMapper.selectBoard_preContent(bid,search);
			nextDto = boardMapper.selectBoard_nextContent(bid,search);
			//list = boardMapper.selectBoardListContent(startrow,endrow,search);
		}else if(category.equals("all")) { //opt:title search:제목
			preDto = boardMapper.selectBoard_preAll(bid,search);
			nextDto = boardMapper.selectBoard_nextAll(bid,search);
			//list = boardMapper.selectBoardListSearchAll(startrow,endrow,search);
		}
		
		map.put("boardDto", boardDto);
		map.put("preDto", preDto);
		map.put("nextDto", nextDto);
		map.put("category", category);
		map.put("search", search);
		map.put("page", page);
		
		
		return map;
	}

	@Override
	public void boardWrite(BoardDto boardDto, MultipartFile file) {
		
			//원본파일이름
			String fileName = file.getOriginalFilename();
			//확장자명 가져오기
			String fileNameExtension = FilenameUtils.getExtension(fileName).toLowerCase();
			//파일 저장위치
		if(fileNameExtension!="") {
			String fileUrl ="C:/workspace/Ex0331/src/main/resources/static/upload/";
			//신규파일이름
			String uploadFileName = RandomStringUtils.randomAlphanumeric(32)+"."+fileNameExtension;
			File f = new File(fileUrl+uploadFileName);
			try {
				file.transferTo(f);
			} catch (Exception e) {
				e.printStackTrace();
			}
			//파일이름저장
			boardDto.setFileName(uploadFileName);
		}else {
			boardDto.setFileName("");
		}
		
		//mapper전달
		boardMapper.insertBoardWrite(boardDto);
		
		
	}

	@Override
	public Map<String, Object> boardModify_view(String bid, String page, String category, String search) {
		
		boardDto = boardMapper.selectBoardContent_view(bid);
		map.put("boardDto", boardDto);
		map.put("category", category);
		map.put("search", search);
		map.put("page", page);
		
		
		return map;
	}

	@Override
	public void boardModify(BoardDto boardDto, MultipartFile file) {
		
		//원본파일이름
		String orgfileName = file.getOriginalFilename();
		System.out.println("impl_org:"+orgfileName);
		if(file.getSize()!=0) { //파일사이즈가 0이 아니면
			
		//파일 저장위치
		String fileUrl ="C:/workspace/Ex0331/src/main/resources/static/upload/";
		//이름에 시간추가
		long time = System.currentTimeMillis();
		//신규파일이름
		String uploadFileName = String.format("%d_%s",time,orgfileName);
		File f = new File(fileUrl+uploadFileName);
		try {
			file.transferTo(f);
		} catch (Exception e) {
			e.printStackTrace();
		}
		//파일이름저장
		boardDto.setFileName(uploadFileName);
	}else {
		// 기존 파일이름을 그대로 저장시키면됨.
		//boardDto.setFileName("");
	}
	
	//mapper전달
	boardMapper.updateBoardModify(boardDto);
		
		
	}

	@Override
	public void boardReply(BoardDto boardDto, MultipartFile file) {
		//원본파일이름
		String orgfileName = file.getOriginalFilename();
		System.out.println("impl_org:"+orgfileName);
		if(file.getSize()!=0) { //파일사이즈가 0이 아니면
			
		//파일 저장위치
		String fileUrl ="C:/workspace/Ex0331/src/main/resources/static/upload/";
		//이름에 시간추가
		long time = System.currentTimeMillis();
		//신규파일이름
		String uploadFileName = String.format("%d_%s",time,orgfileName);
		File f = new File(fileUrl+uploadFileName);
		try {
			file.transferTo(f);
		} catch (Exception e) {
			e.printStackTrace();
		}
		//파일이름저장
		boardDto.setFileName(uploadFileName);
	}else {
		// 신규로 넣기때문에 없을경우 지워야됨
		boardDto.setFileName("");
	}
	
	//mapper전달
	boardMapper.insertBoardReply(boardDto);		
	boardMapper.insertBoardReplyPlus(boardDto);		
		
		
		
	}

	@Override
	public void boardDelete(String bid) {
		boardMapper.deleteBoardDelete(bid);
		
	}
	
}
