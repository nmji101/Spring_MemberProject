package kh.spring.daoImpl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import Statics.Statics;
import kh.spring.dao.BoardDAO;
import kh.spring.dto.BoardDTO;
@Repository
public class BoardDAOImpl implements BoardDAO{

	@Autowired
	private SqlSessionTemplate sst;

	@Override
	public int insertBoard(BoardDTO dto) {
		return sst.insert("BoardDAOImpl.insertBoard",dto);
	}


	/**
	 * 해당 페이지 게시판 글 조회
	 * @return
	 * @throws Exception
	 */
	public List<BoardDTO> selectPageBoard(int start , int end){
		//		String sql ="select row_number()over(order by seq desc) no, board.* from board where no between ? and ?";
		//		try(
		//				Connection con = this.getConnection();
		//				PreparedStatement pstat = con.prepareStatement(sql);
		//				ResultSet rs = pstat.executeQuery();
		//				){
		//			List<BoardDTO> list = new ArrayList<>();
		//
		//			int[] tmp = this.getRecordPerPageBeginEnd(currentPage);
		//			int begin = tmp[0];
		//			int end = tmp[1];
		//
		//			while(rs.next()) {
		//				if(rs.getInt(1)>=begin) {
		//					int seq = rs.getInt(2);
		//					String title = rs.getString(3);
		//					String contents = rs.getString(4);
		//					String writer = rs.getString(5);
		//					Timestamp writerDate = rs.getTimestamp(6);
		//					int viewCount = rs.getInt(7);
		//					list.add(new BoardDTO(seq,title,contents,writer,writerDate,viewCount,null));
		//				}
		//				if(rs.getInt(1)==end) {
		//					break;
		//				}
		//			}
		//			return list;
		//		}
		Map<String,Integer> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);

		return sst.selectList("BoardDAOImpl.selectBoardListByCurrnetPage", map);
	}
	/**
	 * 해당 페이지에 띄워야할 list얻기위해 begin , end
	 * @param currentPage
	 * @return
	 */
	public int[] getRecordPerPageBeginEnd(int currentPage){
		int recordCountPerPage = Statics.recordCountPerPage;

		int begin = 1 + recordCountPerPage*(currentPage-1);
		int end = recordCountPerPage*currentPage;

		return new int[] {begin,end};
	}
	
	public int updateViewCount(int seq){
		return sst.update("BoardDAOImpl.updateViewCount",seq);
	}
	
	public int getBoardCount(){
		return sst.selectOne("BoardDAOImpl.selectAllBoardCount");
	}
	/**
	 * 페이지 네비게이터
	 * @param currentPage
	 * @param listSize	 : searchPost했을때의 record 수 / -1 : 전체숫자
	 * @return
	 * @throws Exception
	 */
	public List<String> getNavi(int currentPage , int listSize) throws Exception{

		//0.현재 내가 보고있는 페이지가 몇 페이지 인지
		//int currentPage = 10;//가정

		//네비게이터 제작을 위한 3step
		//1. DB의 게시판테이블의 전체 레코드 갯수(글 갯수)가 몇개인지
		//-> select count(*) from board
		//int recordTotalCount = 253; // 일단 DB에서 직접해보는것말고 자바 코드만 짜기위해 임의로 숫자 넣어서 진행함
		int recordTotalCount=0;
		if(listSize==-1) {
			recordTotalCount = this.getBoardCount();
		}else {
			recordTotalCount = listSize;
		}

		//2. 한 페이지에 몇개의 글이 보이게 할 것 인지
		int recordCountPerPage = Statics.recordCountPerPage; //이 숫자는 임의로 정해도 괜찮지만 연산(나눗셈..등)을 위해서 10이 제일 적당함

		//3. 한 페이지에 네비게이터가 총 몇개가 보이게 할 것인지
		int naviCountPerPage = Statics.naviCountPerPage; //이것도 임의로 10으로 정해둠.

		//전체 페이지 수
		int pageTotalCount = (int)Math.ceil((double)recordTotalCount/recordCountPerPage);	

		//현재페이지 오류 검출 및 정정
		if(currentPage < 1) { //최소보다 작을경우
			currentPage = 1;	
		}else if(currentPage > pageTotalCount) { //가능한 페이지수 이상으로 넘어갈경우
			currentPage = pageTotalCount;
		}

		//현재있는 위치를 기준으로  시작페이지와 끝페이지의 정보를 얻어내야한다.
		int startNavi;	//현재있는 위치를 기준으로  시작페이지
		int endNavi;	//현재있는 위치를 기준으로 끝페이지
		startNavi = (currentPage-1)/naviCountPerPage*naviCountPerPage+1;
		endNavi = startNavi + (naviCountPerPage-1);
		if(endNavi > pageTotalCount) {
			endNavi = pageTotalCount;
		}

		//왼쪽 오른쪽 표시
		boolean needPrev = true;
		boolean needNext = true;
		if(startNavi == 1) {
			needPrev = false;
		}
		if(endNavi == pageTotalCount) {
			needNext = false;
		}

		List<String> list = new ArrayList<>();
		if(needPrev) {
			list.add("<이전");
		}
		for(int i =startNavi ; i<=endNavi; i++) {
			list.add(i+"");
		}
		if(needNext) {
			list.add("다음>");
		}
		return list;
	}


	@Override
	public BoardDTO selectPost(int seq) {
		return sst.selectOne("BoardDAOImpl.selectBoardDTOBySeq",seq);
	}
}

