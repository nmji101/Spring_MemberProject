package kh.spring.practice;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kh.spring.daoImpl.MemberDAOImpl;
import kh.spring.dto.MemberDTO;

@Controller
public class MemberController {
	@Autowired
	private MemberDAOImpl dao;
	@Autowired
	private HttpSession session;
	@Autowired
	private ModelAndView mav;

	@RequestMapping("/")
	public String main() {
		return "member/main";
	}
	@RequestMapping("/joinForm")
	public String toJoinForm() {
		return "member/joinForm";
	}
	@RequestMapping("/inputProc")
	public ModelAndView inputProc(MemberDTO dto, MultipartFile profileImg) {
		ModelAndView mav = this.mav;
		String realPath = session.getServletContext().getRealPath("/");
		String resourcePath = realPath + "resources";
		System.out.println(resourcePath);
		String contentType = profileImg.getContentType().replaceAll("image/", "");
		System.out.println("타입:"+contentType);
		try {
			String savePath = resourcePath+"/"+dto.getId()+"/"+"profileImg."+contentType;
			File profile = new File(savePath);
			FileUtils.writeByteArrayToFile(profile, profileImg.getBytes());
			dto.setProfile(savePath.substring(resourcePath.length()));
			System.out.println(dto.getProfile());
			int result = dao.insertNewMember(dto);
			System.out.println(result + "명 가입처리 완료");
			mav.addObject("result",result);
		}catch(Exception e) {
			e.printStackTrace();
			mav.setViewName("error");
		}
		mav.setViewName("member/joinResultView");
		return mav;
	}
	@RequestMapping("/loginProc")
	public ModelAndView loginProc(String id , String pw) {
		ModelAndView mav = this.mav;
		String loginId = dao.isLoginOk(id, pw);
		System.out.println("존재여부 -> " + loginId);
		if(loginId!=null) {
			session.setAttribute("loginId", loginId);
			String profile = dao.selectProfile(id);
			session.setAttribute("profile", profile);
		}
		mav.setViewName("member/main");
		return mav;
	}
	@RequestMapping("/IdDuplCheck")
	public ModelAndView idDuplCheck(String id) {
		ModelAndView mav = this.mav;
		System.out.println(id);
		int result =  dao.idDuplCheck(id);
		mav.addObject("result", result);
		mav.setViewName("member/idDuplCheckView");
		return mav;
	}

	@ResponseBody
	@RequestMapping("/IdDuplCheck.ajax")
	public String IdDuplCheckAjax(String id) {
		System.out.println(id);
		int result =  dao.idDuplCheck(id);
		System.out.println(result+"명 가입중");
		return result+"";
	}

	@RequestMapping("/logout")
	public String logout() {
		session.invalidate();
		return "member/main";
	}

	@RequestMapping("/myPageProc")
	public ModelAndView licMyPage(HttpServletRequest request) {
		ModelAndView mav = this.mav;
		MemberDTO userInfo = dao.selectUserInfo((String) session.getAttribute("loginId"));
		mav.addObject("userInfo", userInfo);
		mav.setViewName("member/myPageView");
		return mav;
	}
	@RequestMapping("/profileModify")
	public String profileModify() {
		return "member/profileModifyView";
	}
	
	@ResponseBody
	@RequestMapping("/modifyProfile")
	public String modifyProfile(MultipartFile newProfileImg) {
		System.out.println("modifyProfile!!!");
		String realPath = session.getServletContext().getRealPath("/");
		String resourcePath = realPath + "resources";
		System.out.println(resourcePath);
		String contentType = newProfileImg.getContentType().replaceAll("image/", "");
		System.out.println("타입:"+contentType);
		String modifyProfileImg = null;
		try {
		String id = (String)session.getAttribute("loginId");
		String savePath = resourcePath+"/"+id+"/"+"profileImg."+contentType;
		File profile = new File(savePath);
		FileUtils.writeByteArrayToFile(profile, newProfileImg.getBytes());
		modifyProfileImg = savePath.substring(resourcePath.length());
		System.out.println(modifyProfileImg);
			int result = dao.modifyProfileImg(id, modifyProfileImg);
			System.out.println(result + "명 프로필사진 업데이트 완료");
		}catch(Exception e) {
			e.printStackTrace();
			return "error";
		}
		return modifyProfileImg;
	}
	
	@RequestMapping("modifyInfo")
	public ModelAndView licToModifyInfo(HttpServletRequest request) {
		ModelAndView mav = this.mav;
		MemberDTO userInfo = dao.selectUserInfo((String) session.getAttribute("loginId"));
		mav.addObject("userInfo", userInfo);
		mav.setViewName("member/modifyInfo");
		return mav;
	}
	
	@RequestMapping("ModifyInfoProc")
	public ModelAndView ModifyInfoProc(MemberDTO dto) {
		ModelAndView mav = this.mav;
		
		return mav;
	}
	
//	@RequestMapping("pwCheck")
//	public ModelAndView pwCheck() {
//		String id = (String) session.getAttribute("loginId");
//		
//		
//	}
}
