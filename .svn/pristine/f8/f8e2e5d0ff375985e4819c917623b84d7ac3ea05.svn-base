package com.hwfs.sc.cmn.dto;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.hwfs.cmn.defaults.DefaultDTO;

/**
 * LMS/MMS DTO
 * @ClassName LmsMmsDTO.java
 * @Description LmsMmsDTO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.09.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.03.13.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class LmsMmsDTO extends DefaultDTO {

	private static final long serialVersionUID = 1L;

	private String subject;			//(필수)전송할 제목
	private String phone; 			//(필수)수신할 핸드폰 번호
	private String callback;		//(필수)송신자 전화번호
	private String reqDate; 		//전송할 일자 : null이면 현재 시간
	private String msg;				//(필수)전송할 메시지
	private int fileCnt=0;			//(필수)전송 파일 수
	private String filePath1;		//전송파일1 위치
	private String filePath2;		//전송파일2 위치
	private String filePath3;		//전송파일3 위치
	private String filePath4;		//전송파일4 위치
	private String filePath5;		//전송파일5 위치
	private String type="0";		//0:MMS, 1:MMSURL, 7:HTML
	
	private String trSysId = "06"; 	//시스템구분 : 고정
	private String trDeptId;
	private String trCcId;			//전송자 부서코드 : 비밀번호변경, 개인정보파기 등은 공통 메시지는 정보기획팀, 그 외는 전송자 부서 
	private String trUserId;		//전송자 사용자ID
	private String trCustNo;		//타겟 고객번호 : CTI 고객전송이력 조회를 위해 필요
	private String trEtc1;			//기타 용도
	private String trEtc2;			//기타 용도
	private String trEtc3;			//기타 용도
	private String trEtc4;			//기타 용도
	
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
	 * phone 얻기
	 *
	 * @return the phone
	 */
	public String getPhone() {
		return phone;
	}

	/**
	 * phone 설정
	 *
	 * @param phone the phone to set
	 */
	public void setPhone(String phone) {
		this.phone = phone;
	}

	/**
	 * callback 얻기
	 *
	 * @return the callback
	 */
	public String getCallback() {
		return callback;
	}

	/**
	 * callback 설정
	 *
	 * @param callback the callback to set
	 */
	public void setCallback(String callback) {
		this.callback = callback;
	}

	/**
	 * reqDate 얻기
	 *
	 * @return the reqDate
	 */
	public String getReqDate() {
		return reqDate;
	}

	/**
	 * reqDate 설정
	 *
	 * @param reqDate the reqDate to set
	 */
	public void setReqDate(String reqDate) {
		this.reqDate = reqDate;
	}

	/**
	 * msg 얻기
	 *
	 * @return the msg
	 */
	public String getMsg() {
		return msg;
	}

	/**
	 * msg 설정
	 *
	 * @param msg the msg to set
	 */
	public void setMsg(String msg) {
		this.msg = msg;
	}

	/**
	 * fileCnt 얻기
	 *
	 * @return the fileCnt
	 */
	public int getFileCnt() {
		return fileCnt;
	}

	/**
	 * fileCnt 설정
	 *
	 * @param fileCnt the fileCnt to set
	 */
	public void setFileCnt(int fileCnt) {
		this.fileCnt = fileCnt;
	}

	/**
	 * filePath1 얻기
	 *
	 * @return the filePath1
	 */
	public String getFilePath1() {
		return filePath1;
	}

	/**
	 * filePath1 설정
	 *
	 * @param filePath1 the filePath1 to set
	 */
	public void setFilePath1(String filePath1) {
		this.filePath1 = filePath1;
	}

	/**
	 * filePath2 얻기
	 *
	 * @return the filePath2
	 */
	public String getFilePath2() {
		return filePath2;
	}

	/**
	 * filePath2 설정
	 *
	 * @param filePath2 the filePath2 to set
	 */
	public void setFilePath2(String filePath2) {
		this.filePath2 = filePath2;
	}

	/**
	 * filePath3 얻기
	 *
	 * @return the filePath3
	 */
	public String getFilePath3() {
		return filePath3;
	}

	/**
	 * filePath3 설정
	 *
	 * @param filePath3 the filePath3 to set
	 */
	public void setFilePath3(String filePath3) {
		this.filePath3 = filePath3;
	}

	/**
	 * filePath4 얻기
	 *
	 * @return the filePath4
	 */
	public String getFilePath4() {
		return filePath4;
	}

	/**
	 * filePath4 설정
	 *
	 * @param filePath4 the filePath4 to set
	 */
	public void setFilePath4(String filePath4) {
		this.filePath4 = filePath4;
	}

	/**
	 * filePath5 얻기
	 *
	 * @return the filePath5
	 */
	public String getFilePath5() {
		return filePath5;
	}

	/**
	 * filePath5 설정
	 *
	 * @param filePath5 the filePath5 to set
	 */
	public void setFilePath5(String filePath5) {
		this.filePath5 = filePath5;
	}

	/**
	 * type 얻기
	 *
	 * @return the type
	 */
	public String getType() {
		return type;
	}

	/**
	 * type 설정
	 *
	 * @param type the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}

	/**
	 * trSysId 얻기
	 *
	 * @return the trSysId
	 */
	public String getTrSysId() {
		return trSysId;
	}

	/**
	 * trSysId 설정
	 *
	 * @param trSysId the trSysId to set
	 */
	public void setTrSysId(String trSysId) {
		this.trSysId = trSysId;
	}

	/**
	 * trDeptId 얻기
	 *
	 * @return the trDeptId
	 */
	public String getTrDeptId() {
		return trDeptId;
	}

	/**
	 * trDeptId 설정
	 *
	 * @param trDeptId the trDeptId to set
	 */
	public void setTrDeptId(String trDeptId) {
		this.trDeptId = trDeptId;
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
	 * @param trDeptId the trCcId to set
	 */
	public void setTrCcId(String trCcId) {
		this.trCcId = trCcId;
	}

	/**
	 * trUserId 얻기
	 *
	 * @return the trUserId
	 */
	public String getTrUserId() {
		return trUserId;
	}

	/**
	 * trUserId 설정
	 *
	 * @param trUserId the trUserId to set
	 */
	public void setTrUserId(String trUserId) {
		this.trUserId = trUserId;
	}

	/**
	 * trCustNo 얻기
	 *
	 * @return the trCustNo
	 */
	public String getTrCustNo() {
		return trCustNo;
	}

	/**
	 * trCustNo 설정
	 *
	 * @param trCustNo the trCustNo to set
	 */
	public void setTrCustNo(String trCustNo) {
		this.trCustNo = trCustNo;
	}

	/**
	 * trEtc1 얻기
	 *
	 * @return the trEtc1
	 */
	public String getTrEtc1() {
		return trEtc1;
	}

	/**
	 * trEtc1 설정
	 *
	 * @param trEtc1 the trEtc1 to set
	 */
	public void setTrEtc1(String trEtc1) {
		this.trEtc1 = trEtc1;
	}

	/**
	 * trEtc2 얻기
	 *
	 * @return the trEtc2
	 */
	public String getTrEtc2() {
		return trEtc2;
	}

	/**
	 * trEtc2 설정
	 *
	 * @param trEtc2 the trEtc2 to set
	 */
	public void setTrEtc2(String trEtc2) {
		this.trEtc2 = trEtc2;
	}

	/**
	 * trEtc3 얻기
	 *
	 * @return the trEtc3
	 */
	public String getTrEtc3() {
		return trEtc3;
	}

	/**
	 * trEtc3 설정
	 *
	 * @param trEtc3 the trEtc3 to set
	 */
	public void setTrEtc3(String trEtc3) {
		this.trEtc3 = trEtc3;
	}

	/**
	 * trEtc4 얻기
	 *
	 * @return the trEtc4
	 */
	public String getTrEtc4() {
		return trEtc4;
	}

	/**
	 * trEtc4 설정
	 *
	 * @param trEtc4 the trEtc4 to set
	 */
	public void setTrEtc4(String trEtc4) {
		this.trEtc4 = trEtc4;
	}

}
