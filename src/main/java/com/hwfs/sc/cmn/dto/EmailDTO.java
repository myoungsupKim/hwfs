package com.hwfs.sc.cmn.dto;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.hwfs.cmn.defaults.DefaultDTO;

/**
 * Email DTO
 * @ClassName EmailDTO.java
 * @Description EmailDTO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.19.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.03.13.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class EmailDTO extends DefaultDTO {

	//private static final long serialVersionUID = 1L;

	private String toEmail; 		//(필수)수신자 이메일
	private String toName;			//(필수)수신자 이름
	private String fromEmail; 		//(필수)발송자 이메일
	private String fromName;		//(필수)발송자 이름
	private String subject;			//(필수)제목
	private String mapContent;		//(필수)전송할 메시지
	private String sysId = "06"; 	//시스템구분 : 고정
	private String trCcId;			//전송자 부서코드 
	private String userId;			//전송자 사용자ID
	private String dmNo;			//DM 번호
	
	// 첨부파일 추가
	private String attach1;			//첨부파일1 orgName
	private String attachNm1;		//첨부파일1 reName
	private String attach2;			//첨부파일2 orgName
	private String attachNm2;		//첨부파일2 reName
	private String attach3;			//첨부파일3 orgName
	private String attachNm3;		//첨부파일4 reName
	
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

	/**
	 * toEmail 얻기
	 *
	 * @return the toEmail
	 */
	public String getToEmail() {
		return toEmail;
	}

	/**
	 * toEmail 설정
	 *
	 * @param toEmail the toEmail to set
	 */
	public void setToEmail(String toEmail) {
		this.toEmail = toEmail;
	}

	/**
	 * toName 얻기
	 *
	 * @return the toName
	 */
	public String getToName() {
		return toName;
	}

	/**
	 * toName 설정
	 *
	 * @param toName the toName to set
	 */
	public void setToName(String toName) {
		this.toName = toName;
	}

	/**
	 * fromEmail 얻기
	 *
	 * @return the fromEmail
	 */
	public String getFromEmail() {
		return fromEmail;
	}

	/**
	 * fromEmail 설정
	 *
	 * @param fromEmail the fromEmail to set
	 */
	public void setFromEmail(String fromEmail) {
		this.fromEmail = fromEmail;
	}

	/**
	 * fromName 얻기
	 *
	 * @return the fromName
	 */
	public String getFromName() {
		return fromName;
	}

	/**
	 * fromName 설정
	 *
	 * @param fromName the fromName to set
	 */
	public void setFromName(String fromName) {
		this.fromName = fromName;
	}

	/**
	 * subject 얻기
	 *
	 * @return the subject
	 */
	public String getSubject() {
		return subject;
	}

	/**
	 * subject 설정
	 *
	 * @param subject the subject to set
	 */
	public void setSubject(String subject) {
		this.subject = subject;
	}

	/**
	 * mapContent 얻기
	 *
	 * @return the mapContent
	 */
	public String getMapContent() {
		return mapContent;
	}

	/**
	 * mapContent 설정
	 *
	 * @param mapContent the mapContent to set
	 */
	public void setMapContent(String mapContent) {
		this.mapContent = mapContent;
	}

	/**
	 * sysId 얻기
	 *
	 * @return the sysId
	 */
	public String getSysId() {
		return sysId;
	}

	/**
	 * sysId 설정
	 *
	 * @param sysId the sysId to set
	 */
	public void setSysId(String sysId) {
		this.sysId = sysId;
	}

	/**
	 * trCcId 얻기
	 *
	 * @return the trCcId
	 */
	public String getTrCcId() {
		return trCcId;
	}

	/**
	 * trCcId 설정
	 *
	 * @param trCcId the trCcId to set
	 */
	public void setTrCcId(String trCcId) {
		this.trCcId = trCcId;
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
	 * dmNo 얻기
	 *
	 * @return the dmNo
	 */
	public String getDmNo() {
		return dmNo;
	}

	/**
	 * dmNo 설정
	 *
	 * @param dmNo the dmNo to set
	 */
	public void setDmNo(String dmNo) {
		this.dmNo = dmNo;
	}

	/**
	 * attach1 얻기
	 *
	 * @return the attach1
	 */
	public String getAttach1() {
		return attach1;
	}

	/**
	 * attach1 설정
	 *
	 * @param attach1 the attach1 to set
	 */
	public void setAttach1(String attach1) {
		this.attach1 = attach1;
	}

	/**
	 * attachNm1 얻기
	 *
	 * @return the attachNm1
	 */
	public String getAttachNm1() {
		return attachNm1;
	}

	/**
	 * attachNm1 설정
	 *
	 * @param attachNm1 the attachNm1 to set
	 */
	public void setAttachNm1(String attachNm1) {
		this.attachNm1 = attachNm1;
	}

	/**
	 * attach2 얻기
	 *
	 * @return the attach2
	 */
	public String getAttach2() {
		return attach2;
	}

	/**
	 * attach2 설정
	 *
	 * @param attach2 the attach2 to set
	 */
	public void setAttach2(String attach2) {
		this.attach2 = attach2;
	}

	/**
	 * attach2Nm 얻기
	 *
	 * @return the attach2Nm
	 */
	public String getAttachNm2() {
		return attachNm2;
	}

	/**
	 * attachNm2 설정
	 *
	 * @param attachNm2 the attachNm2 to set
	 */
	public void setAttachNm2(String attachNm2) {
		this.attachNm2 = attachNm2;
	}

	/**
	 * attach3 얻기
	 *
	 * @return the attach3
	 */
	public String getAttach3() {
		return attach3;
	}

	/**
	 * attach3 설정
	 *
	 * @param attach3 the attach3 to set
	 */
	public void setAttach3(String attach3) {
		this.attach3 = attach3;
	}

	/**
	 * attachNm3 얻기
	 *
	 * @return the attachNm3
	 */
	public String getAttachNm3() {
		return attachNm3;
	}

	/**
	 * attachNm3 설정
	 *
	 * @param attachNm3 the attachNm3 to set
	 */
	public void setAttachNm3(String attachNm3) {
		this.attachNm3 = attachNm3;
	}
	
	
}
