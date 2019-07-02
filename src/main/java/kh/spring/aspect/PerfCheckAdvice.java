package kh.spring.aspect;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
@Aspect
public class PerfCheckAdvice {
	@Autowired
	private HttpSession session;
	/**
	 * 성능측정 Advice
	 * @param pjp
	 * @return
	 */
	
	@Around("(execution(* kh.spring.practice.MemberController.*(..)) && !execution(* kh.spring.practice.MemberController.lic*(..)))||"
			+ "execution(* kh.spring.practice.BoardController.*(..))")
	public Object perfCheck(ProceedingJoinPoint pjp) {
		long startTime = System.currentTimeMillis();
		Object retVal = null;
		try {
//			System.out.println("메소드이름->"+pjp.getSignature().getName());
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
