package kh.spring.daoImpl;

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
	public List<BoardDTO> selectPageBoard(int start, int end){
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

	
}
