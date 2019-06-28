package kh.spring.practice;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kh.spring.dao.BoardDAO;
import kh.spring.dto.BoardDTO;



@Controller
public class BoardController {
	@Autowired
	private ModelAndView mav;
	@Autowired
	private HttpSession session;
	@Autowired
	private BoardDAO dao;

	@RequestMapping("toBoard")
	public ModelAndView toBoard() {
		ModelAndView mav = this.mav;
		int currentPage=1;
		int[] startEnd = dao.getRecordPerPageBeginEnd(currentPage);
		System.out.println("start -> "+startEnd[0] + " : end->" + startEnd[1]);
		List<BoardDTO> boardList = dao.selectPageBoard(startEnd[0], startEnd[1]);
		mav.addObject("currentPage", currentPage);
		mav.addObject("boardList", boardList);
		mav.setViewName("board/mainBoard");
		return mav;
	}

	@RequestMapping("newWrite")
	public ModelAndView newWrite() {
		ModelAndView mav = this.mav;
		mav.setViewName("board/newWrite");
		return mav;
	}

	@ResponseBody
	@RequestMapping("saveImageAjax.board")
	public String saveImage(HttpServletRequest request) {
		System.out.println("request-> "+request.getRemoteAddr());
		String realPath = session.getServletContext().getRealPath("/");
		String resourcePath = realPath + "resources";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String today= sdf.format(System.currentTimeMillis());
		String savePath = resourcePath+"/"+today;
		System.out.println("파일저장할 위치 -> " + savePath);
		File uploadPath = new File(savePath);
		if(!uploadPath.exists()) {	//해당하는 이름의 폴더가 없다면
			uploadPath.mkdir();	//폴더를 만들어줘라. mkdir() : makeDirectory
		}
		//아직미완성
		int maxSize = 10 * 1024 * 1024 ; //10메가
		String fileName = null;
		try {
			MultipartRequest multi = 
					new MultipartRequest(request,savePath,maxSize,"utf-8",new DefaultFileRenamePolicy());
			File oriFile = multi.getFile("file");
			System.out.println("저장된 이름:" +oriFile.getName());
			fileName = System.currentTimeMillis()+"_"+oriFile.getName();
			boolean renameResult = oriFile.renameTo(new File(savePath+"/"+fileName));
			System.out.println("이름변경 : "+renameResult + ", 변경된이름  : "+oriFile.getName());
		} catch (IOException e) {
			e.printStackTrace();
			return "error";
		} 
		return (savePath+"/"+fileName).substring(resourcePath.length());
	}
	
	@RequestMapping("inputBoard")
	public ModelAndView inputBoard(HttpServletRequest request) {
		ModelAndView mav = this.mav;
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		title = title.replaceAll("<script>", "'script'").replaceAll("</script>", "'/script'").replaceAll("\"", "'");
		contents = contents.replaceAll("<script>", "'script'").replaceAll("</script>", "'/script'");
		System.out.println(title);
		String writer = (String)request.getSession().getAttribute("loginId");
		String ipaddr = request.getRemoteAddr();
		BoardDTO dto = new BoardDTO(0,title,contents,writer,null,0,ipaddr);
		int result = dao.insertBoard(dto);
		mav.addObject("result", result);
		mav.setViewName("redirect:/toBoard");
		return mav;
	}
}
