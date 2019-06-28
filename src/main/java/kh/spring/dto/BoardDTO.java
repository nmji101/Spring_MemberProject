package kh.spring.dto;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class BoardDTO {
	private int seq;
	private String title;
	private String contents;
	private String writer;//작성자 id
	//util.date 가 sql.date 보다 상위클래스 
	private Timestamp writerdate;
	private int viewcount;
	private String ipaddr;
	
	private String formTime;
	private String formWriterdate;
	
	public BoardDTO(int seq, String title, String contents, String writer, Timestamp writerdate, int viewcount,
			String ipaddr) {
		super();
		this.seq = seq;
		this.title = title;
		this.contents = contents;
		this.writer = writer;
		this.writerdate = writerdate;
		this.viewcount = viewcount;
		this.ipaddr = ipaddr;
		if(writerdate!=null) {
			this.formTime = this.getFormedTime();
		}
	}
	public BoardDTO() {
		super();
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Timestamp getWriterdate() {
		return writerdate;
	}
	public void setWriterdate(Timestamp writerdate) {
		this.writerdate = writerdate;
		if(writerdate!=null) {
			this.formTime = this.getFormedTime();
		}
	}
	public int getViewcount() {
		return viewcount;
	}
	public void setViewcount(int viewcount) {
		this.viewcount = viewcount;
	}
	public String getIpaddr() {
		return ipaddr;
	}
	public void setIpaddr(String ipaddr) {
		this.ipaddr = ipaddr;
	}	
	
	public String getFormTime() {
		return formTime;
	}
	
	public String getFormWriterdate() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm"); //24시간 이상되면
		this.formWriterdate = sdf.format(this.writerdate);
		return formWriterdate;
	}
	
	/**
	 * 게시글 작성 시간 세밀하게 표시하기
	 * @return
	 */
	public String getFormedTime() {
		long currentTime = System.currentTimeMillis();
		long writeTime = this.writerdate.getTime();
		
		if(currentTime - writeTime <= (1000*60)) { //초단위
			long time = currentTime - writeTime;
			return time/1000 + " 초 전";
		}else if(currentTime - writeTime < (1000* 60 * 60)) { //분단위
			long time = currentTime - writeTime;
			return time/1000/60 + " 분 전";
		}else if(currentTime - writeTime < (1000* 60 * 60* 24)) { //시간 단위
			long time = currentTime - writeTime;
			return time/1000/60/60+ " 시간 전";
		}else {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd"); //24시간 이상되면
			return sdf.format(writeTime);
		}
	}
}
