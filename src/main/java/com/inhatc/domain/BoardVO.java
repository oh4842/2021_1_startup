package com.inhatc.domain;

import java.util.Date;

public class BoardVO {
	private  Integer bno;
	private  String title;
	private  String content;
	private  String writer;
	private  Date regdate;
	private  int viewcnt;
	
	@Override
	public String toString() {
		return "BoradVO [bno=" + bno + ", title=" + title + ", content=" + content + ", writer=" + writer + ", regdate="
				+ regdate + ", viewcnt=" + viewcnt + ", getBno()=" + getBno() + ", getTitle()=" + getTitle()
				+ ", getContent()=" + getContent() + ", getWriter()=" + getWriter() + ", getRegdate()=" + getRegdate()
				+ ", getViewcnt()=" + getViewcnt() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ ", toString()=" + super.toString() + "]";
	}
	public Integer getBno() {
		return bno;
	}
	public void setBno(Integer bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getViewcnt() {
		return viewcnt;
	}
	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}
	

}
