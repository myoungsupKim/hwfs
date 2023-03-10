package com.hwfs.sc.cmn.dto;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * Controller에서 JSP Viewer로 Report 정보를 전달하기 위한 DTO
 * @ClassName ReportViewerDTO.java
 * @Description ReportViewerDTO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 1. 23.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 1. 23.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class ReportViewerDTO implements Serializable {

	private static final long serialVersionUID = 1L;

	/** Report 명 */
	private String reportName;

	/** User ID */
	private String userId;

	/** User 사번 */
	private String sabun;

	/** User 명 */
	private String userNm;

	/** 부서 명 */
	private String deptNm;

	/** 개인정보마스크 */
	private String persInfoMask;

	/** 사용자정보 : Report 하단좌측에 표시 */
	private String userInfo;
	
	/** XLM 바인딩 여부 */
	private boolean xmlBind;

	/** Dynamic XLM 바인딩 여부- XML을 이용하여 동적으로 레포트 생성 */
	private boolean dynamicXmlBind;

	/** multi 바인딩 */
	private boolean multiBind;

	/**
	 * reportName 얻기
	 *
	 * @return the reportName
	 */
	public String getReportName() {
		return reportName;
	}

	/**
	 * reportName 설정
	 *
	 * @param reportName the reportName to set
	 */
	public void setReportName(String reportName) {
		this.reportName = reportName;
	}

	/**
	 * userId 얻기
	 *
	 * @return the userId
	 */
	public String getUserId() {
		return userId;
	}

	/**
	 * userId 설정
	 *
	 * @param userId the userId to set
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}

	/**
	 * sabun 얻기
	 *
	 * @return the sabun
	 */
	public String getSabun() {
		return sabun;
	}

	/**
	 * sabun 설정
	 *
	 * @param sabun the sabun to set
	 */
	public void setSabun(String sabun) {
		this.sabun = sabun;
	}

	/**
	 * userNm 얻기
	 *
	 * @return the userNm
	 */
	public String getUserNm() {
		return userNm;
	}

	/**
	 * userNm 설정
	 *
	 * @param userNm the userNm to set
	 */
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}

	/**
	 * deptNm 얻기
	 *
	 * @return the deptNm
	 */
	public String getDeptNm() {
		return deptNm;
	}

	/**
	 * deptNm 설정
	 *
	 * @param deptNm the deptNm to set
	 */
	public void setDeptNm(String deptNm) {
		this.deptNm = deptNm;
	}

	/**
	 * persInfoMask 얻기
	 *
	 * @return the persInfoMask
	 */
	public String getPersInfoMask() {
		return persInfoMask;
	}

	/**
	 * persInfoMask 설정
	 *
	 * @param persInfoMask the persInfoMask to set
	 */
	public void setPersInfoMask(String persInfoMask) {
		this.persInfoMask = persInfoMask;
	}

	/**
	 * userInfo 얻기
	 *
	 * @return the userInfo
	 */
	public String getUserInfo() {
		return userInfo;
	}

	/**
	 * userInfo 설정
	 *
	 * @param userInfo the userInfo to set
	 */
	public void setUserInfo(String userInfo) {
		this.userInfo = userInfo;
	}

	/**
	 * xmlBind 얻기
	 *
	 * @return the xmlBind
	 */
	public boolean isXmlBind() {
		return xmlBind;
	}

	/**
	 * xmlBind 설정
	 *
	 * @param xmlBind the xmlBind to set
	 */
	public void setXmlBind(boolean xmlBind) {
		this.xmlBind = xmlBind;
	}

	/**
	 * dynamicXmlBind 얻기
	 *
	 * @return the dynamicXmlBind
	 */
	public boolean isDynamicXmlBind() {
		return dynamicXmlBind;
	}

	/**
	 * dynamicXmlBind 설정
	 *
	 * @param dynamicXmlBind the dynamicXmlBind to set
	 */
	public void setDynamicXmlBind(boolean dynamicXmlBind) {
		this.dynamicXmlBind = dynamicXmlBind;
	}
	/**
	 * multiBind 얻기
	 *
	 * @return the multiBind
	 */
	public boolean isMultiBind() {
		return multiBind;
	}
	
	/**
	 * multiBind 설정
	 *
	 * @param multiBind the multiBind to set
	 */
	public void setMultiBind(boolean multiBind) {
		this.multiBind = multiBind;
	}
	
	/**
	 * toString override
	 *
	 * @return
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		return ToStringBuilder.reflectionToString(this);
	}
}
