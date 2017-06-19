package com.sp.blog.post;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Board {
	private String tableName;
	private long blogSeq;
	private String blogId;
	private int groupNum, categoryNum;
	private String groupClassify, classify;
	private int themeNum;
	private String themeSubject;
	
	private int num;
	private String subject;
	private String content, created;
	private int hitCount;
	
	private int fileNum;
	private String originalFilename, saveFilename;
	private long fileSize;
	
	// 스프링에서 파일 받기
	private List<MultipartFile> upload; // <input type="file" name="upload"

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public long getBlogSeq() {
		return blogSeq;
	}

	public void setBlogSeq(long blogSeq) {
		this.blogSeq = blogSeq;
	}

	public String getBlogId() {
		return blogId;
	}

	public void setBlogId(String blogId) {
		this.blogId = blogId;
	}

	public int getGroupNum() {
		return groupNum;
	}

	public void setGroupNum(int groupNum) {
		this.groupNum = groupNum;
	}

	public int getCategoryNum() {
		return categoryNum;
	}

	public void setCategoryNum(int categoryNum) {
		this.categoryNum = categoryNum;
	}

	public String getGroupClassify() {
		return groupClassify;
	}

	public void setGroupClassify(String groupClassify) {
		this.groupClassify = groupClassify;
	}

	public String getClassify() {
		return classify;
	}

	public void setClassify(String classify) {
		this.classify = classify;
	}

	public int getThemeNum() {
		return themeNum;
	}

	public void setThemeNum(int themeNum) {
		this.themeNum = themeNum;
	}

	public String getThemeSubject() {
		return themeSubject;
	}

	public void setThemeSubject(String themeSubject) {
		this.themeSubject = themeSubject;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getCreated() {
		return created;
	}

	public void setCreated(String created) {
		this.created = created;
	}

	public int getHitCount() {
		return hitCount;
	}

	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}

	public int getFileNum() {
		return fileNum;
	}

	public void setFileNum(int fileNum) {
		this.fileNum = fileNum;
	}

	public String getOriginalFilename() {
		return originalFilename;
	}

	public void setOriginalFilename(String originalFilename) {
		this.originalFilename = originalFilename;
	}

	public String getSaveFilename() {
		return saveFilename;
	}

	public void setSaveFilename(String saveFilename) {
		this.saveFilename = saveFilename;
	}

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}

	public List<MultipartFile> getUpload() {
		return upload;
	}

	public void setUpload(List<MultipartFile> upload) {
		this.upload = upload;
	}
}
