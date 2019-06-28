package kh.spring.daoImpl;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import kh.spring.dto.MemberDTO;

@Repository
public class MemberDAOImpl {
	
	@Autowired
	private JdbcTemplate template;
	
	@Autowired
	private SqlSessionTemplate sst;
	
	/**
	 * 회원가입
	 * @param dto
	 * @return
	 */
	public int insertNewMember(MemberDTO dto) {
/*		String sql = "insert into member values(?,?,?,?,?, ?,?,?,sysdate,?)";
		return template.update(sql,dto.getId(),this.pwToSHA256(dto.getPw()),dto.getName(),dto.getPhone(),
								dto.getEmail(),dto.getZipcode(),dto.getAddr1(),dto.getAddr2(),dto.getProfile());*/
		
		dto.setPw(this.pwToSHA256(dto.getPw()));
		return sst.update("MemberDAO.insertNewMember",dto);
	}
	
	/**
	 * 쿼리날렸을때, 숫자얻을때..?
	 * @return
	 */
	public int selectCount() {
/*		String sql = "select count(*) as cnt from member";
		return template.queryForObject(sql, Integer.class);*/
		return sst.selectOne("MemberDAO.selectCount");
	}
	/**
	 * id중복체크
	 * @param id
	 * @return 1 : 아이디이미존재. 중복값 . 해당아이디로 가입불가 / 0 : 가입가능한 아이디
	 */
	public int idDuplCheck(String id) {
/*		String sql = "select count(*) from member where id = ?";
		int result = template.queryForObject(sql, Integer.class, id);
		System.out.println(id + "인 id중복체크 : " + result + "명 아이디 존재");
		return result;*/
		int result =  sst.selectOne("MemberDAO.idDuplCheck",id);
		System.out.println(id + "인 id중복체크 : " + result + "명 아이디 존재");
		return result;
	}
	/**
	 * 로그인 가능한 id , pw 인지 확인
	 * @param id
	 * @param pw
	 * @return
	 */
	public String isLoginOk(String id , String pw) {
/*		String sql = "select id from member where id = ? and pw = ? ";
		String loginId = null;
		try {
			loginId = template.queryForObject(sql, String.class, id, this.pwToSHA256(pw));
		}catch(Exception e) {
			e.printStackTrace();
		}
		System.out.println(loginId);
		return loginId;*/
		Map<String, String> map = new HashMap<>(); // MAP을 이용해 담기
        map.put("id", id);
        map.put("pw", this.pwToSHA256(pw));
		return sst.selectOne("MemberDAO.isLoginOk",map);
	}
	/**
	 * profile 사진 위치 알아오기.
	 * @param id
	 * @return
	 */
	public String selectProfile(String id) {
/*		String sql = "select profile from member where id = ?";
		String profile = null;
		try {
			profile = template.queryForObject(sql, String.class, id);
		}catch(Exception e) {
			e.printStackTrace();
		}
		System.out.println(profile);
		return profile;*/
		return sst.selectOne("MemberDAO.selectProfile",id);
	}
	/**
	 * 암호화 메소드
	 * @param str
	 * @return
	 */
	public String pwToSHA256(String str){//Sha256 암호화 방식 메소드
		String SHA = ""; 
		try{ 
			MessageDigest sh = MessageDigest.getInstance("SHA-256"); 
			sh.update(str.getBytes()); 
			byte byteData[] = sh.digest();
			StringBuffer sb = new StringBuffer(); 
			for(int i = 0 ; i < byteData.length ; i++){
				sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
			}
			SHA = sb.toString();
		}catch(NoSuchAlgorithmException e){
			e.printStackTrace(); 
			SHA = null; 
		}
		return SHA;
	}
	/**
	 * 마이페이지에서 띄워줄 정보 가져오는 메소드
	 * @param id
	 * @return
	 */
	public MemberDTO selectUserInfo(String id) {
		/*String sql = "select id,pw,name,nvl(phone,'-') as phone ,nvl(email,'-') as email, "
				+ "nvl(zipcode,'-') as zipcode ,nvl(addr1,'-') as addr1 ,nvl(addr2,'-') as addr2 ,joindate,profile "
				+ "from member where id = ? ";
		System.out.println(sql);
		MemberDTO userInfo = null;
		try {
			userInfo = template.query(sql, new Object[] {id}, new ResultSetExtractor<MemberDTO>() {

				@Override
				public MemberDTO extractData(ResultSet rs) throws SQLException, DataAccessException {
					// TODO Auto-generated method stub
					MemberDTO dto = new MemberDTO();
					if(rs.next()) {
						dto.setId(rs.getString("id"));
						dto.setPw(rs.getString("pw"));
						dto.setName(rs.getString("name"));
						dto.setPhone(rs.getString("phone"));
						dto.setEmail(rs.getString("email"));
						dto.setZipcode(rs.getString("zipcode"));
						dto.setAddr1(rs.getString("addr1"));
						dto.setAddr2(rs.getString("addr2"));
						dto.setJoindate(rs.getString("joindate"));
						dto.setProfile(rs.getString("profile"));
					}
					return dto;
				}
				
			});
		}catch(Exception e) {
			e.printStackTrace();
		}
		return userInfo;*/
		return sst.selectOne("MemberDAO.selectUserInfo",id);
	}
	
	public int modifyProfileImg(String id,String modifyImg) {
		Map<String, String> map = new HashMap<>(); // MAP을 이용해 담기
        map.put("id", id);
        map.put("modifyImg", modifyImg);
		return sst.update("MemberDAO.modifyProfileImg",map);
	}
}
