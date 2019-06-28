package kh.spring.aspect;

import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

@Controller
@Aspect
public class LoginCheckAdvice {
	@Autowired
	private HttpSession session;
	//lic : login ID Check
	@Around("execution(* kh.spring.practice.MemberController.lic*(..))")
	public Object loginCheck(ProceedingJoinPoint pjp) {
		ModelAndView mav = new ModelAndView();
		long startTime = System.currentTimeMillis();
		System.out.println(Arrays.toString(pjp.getArgs()));
		HttpServletRequest request = (HttpServletRequest)pjp.getArgs()[0];
//		HttpServletRequest request = null;
//		for (Object obj : pjp.getArgs()) {
//            if (obj instanceof HttpServletRequest || obj instanceof MultipartHttpServletRequest) {
//                request = (HttpServletRequest) obj;
//                // Doing...
//            }
//        }
		
		Object retVal = null;
		if(session.getAttribute("loginId")==null) {
			request.setAttribute("error", "마이페이지 에러입니다!");
			mav.setViewName("error");
			return mav;
		}
		System.out.println("로그인아이디->"+session.getAttribute("loginId"));
		try {
			retVal = pjp.proceed();
		} catch (Throwable e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		long endTime = System.currentTimeMillis();

		String methodName = pjp.getSignature().getName();
		System.out.println((endTime - startTime)/1000.0 + "초 동안 "+ methodName + " 작업수행");
		return retVal;
	}
}
