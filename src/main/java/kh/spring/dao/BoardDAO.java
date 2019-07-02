package kh.spring.dao;

import java.util.List;

import kh.spring.dto.BoardDTO;

public interface BoardDAO {
	public int insertBoard(BoardDTO dto);
	
	public int[] getRecordPerPageBeginEnd(int currentPage);
	
	public List<BoardDTO> selectPageBoard(int start , int end);
	
	public List<String> getNavi(int currentPage , int listSize)throws Exception;
	
	public BoardDTO selectPost(int seq);
	
	public int updateViewCount(int seq);
}
