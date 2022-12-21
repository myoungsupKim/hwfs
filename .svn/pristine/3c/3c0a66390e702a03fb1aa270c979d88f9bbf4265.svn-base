package com.hwfs.sc.cmn.dto;

import java.io.Serializable;

import com.hwfs.cmn.defaults.DefaultDTO;

 /**
 * 첨부파일 정보 DTO
 * @ClassName FileInifoDTO.java
 * @Description FileInifoDTO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2014. 12. 8.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2014. 12. 8.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class AttachFileDTO extends DefaultDTO implements Serializable {
	private static final long serialVersionUID = -1L;

	/** 참조일련번호 */
	private String refSeq;
	
	/** 첨부일련번호 */
	private int appendSeq;

	/** 원본 파일 이름 **/
	private String orgnlFileNm;
	
	/** 저장파일명 */
	private String saveFileNm;

	/** 파일크기 */
	private long fileSize;

	/** 파일경로 상대패스 (global.fileupload.path가 제외된 경로) **/
	private String relPath;

	/** BLOB Data **/
	private byte[] blob;

	/** 파일경로(Full) **/
	private String fullPath;
	
	/** 업로드된 파일명 */
	private String fileUploadNm;

	/** 파일 콘텐츠 타입 **/
	private String fileExt;

	/** 파일 암호화 여부 */
	private boolean encYn;

	/** 추가 정보 */
	private String fileDesc;
	
	
	/**
	 * refSeq 얻기
	 *
	 * @return the refSeq
	 */
	public String getRefSeq() {
		return refSeq;
	}

	/**
	 * refSeq 설정
	 *
	 * @param refSeq the refSeq to set
	 */
	public void setRefSeq(String refSeq) {
		this.refSeq = refSeq;
	}

	/**
	 * appendSeq 얻기
	 *
	 * @return the appendSeq
	 */
	public int getAppendSeq() {
		return appendSeq;
	}

	/**
	 * appendSeq 설정
	 *
	 * @param appendSeq the appendSeq to set
	 */
	public void setAppendSeq(int appendSeq) {
		this.appendSeq = appendSeq;
	}

	/**
	 * orgnlFileNm 얻기
	 *
	 * @return the orgnlFileNm
	 */
	public String getOrgnlFileNm() {
		return orgnlFileNm;
	}

	/**
	 * orgnlFileNm 설정
	 *
	 * @param orgnlFileNm the orgnlFileNm to set
	 */
	public void setOrgnlFileNm(String orgnlFileNm) {
		this.orgnlFileNm = orgnlFileNm;
	}

	/**
	 * saveFileNm 얻기
	 *
	 * @return the saveFileNm
	 */
	public String getSaveFileNm() {
		return saveFileNm;
	}

	/**
	 * saveFileNm 설정
	 *
	 * @param saveFileNm the saveFileNm to set
	 */
	public void setSaveFileNm(String saveFileNm) {
		this.saveFileNm = saveFileNm;
	}

	/**
	 * fileSize 얻기
	 *
	 * @return the fileSize
	 */
	public long getFileSize() {
		return fileSize;
	}

	/**
	 * fileSize 설정
	 *
	 * @param fileSize the fileSize to set
	 */
	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}

	/**
	 * relPath 얻기
	 *
	 * @return the relPath
	 */
	public String getRelPath() {
		return relPath;
	}

	/**
	 * relPath 설정
	 *
	 * @param relPath the relPath to set
	 */
	public void setRelPath(String relPath) {
		this.relPath = relPath;
	}

	/**
	 * blob 얻기
	 *
	 * @return the blob
	 */
	public byte[] getBlob() {
		return this.blob.clone();
	}

	/**
	 * blob 설정
	 *
	 * @param blob the blob to set
	 */
	public void setBlob(byte[] blob) {
		this.blob =  blob.clone();
	}

	/**
	 * fullPath 얻기
	 *
	 * @return the fullPath
	 */
	public String getFullPath() {
		return fullPath;
	}

	/**
	 * fullPath 설정
	 *
	 * @param fullPath the fullPath to set
	 */
	public void setFullPath(String fullPath) {
		this.fullPath = fullPath;
	}

	/**
	 * fileUploadNm 얻기
	 *
	 * @return the fileUploadNm
	 */
	public String getFileUploadNm() {
		return fileUploadNm;
	}

	/**
	 * fileUploadNm 설정
	 *
	 * @param fileUploadNm the fileUploadNm to set
	 */
	public void setFileUploadNm(String fileUploadNm) {
		this.fileUploadNm = fileUploadNm;
	}

	/**
	 * fileExt 얻기
	 *
	 * @return the fileExt
	 */
	public String getFileExt() {
		return fileExt;
	}

	/**
	 * fileExt 설정
	 *
	 * @param fileExt the fileExt to set
	 */
	public void setFileExt(String fileExt) {
		this.fileExt = fileExt;
	}

	/**
	 * encYn 얻기
	 *
	 * @return the encYn
	 */
	public boolean getEncYn() {
		return encYn;
	}

	/**
	 * encYn 설정
	 *
	 * @param encYn the encYn to set
	 */
	public void setEncYn(boolean encYn) {
		this.encYn = encYn;
	}

	/**
	 * fileDesc 얻기
	 *
	 * @return the fileDesc
	 */
	public String getFileDesc() {
		return fileDesc;
	}

	/**
	 * fileDesc 설정
	 *
	 * @param fileDesc the fileDesc to set
	 */
	public void setFileDesc(String fileDesc) {
		this.fileDesc = fileDesc;
	}
}
