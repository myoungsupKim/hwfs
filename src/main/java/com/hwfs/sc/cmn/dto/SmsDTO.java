package com.hwfs.sc.cmn.dto;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.hwfs.cmn.defaults.DefaultDTO;

/**
 * SMS DTO
 * @ClassName SmsDTO.java
 * @Description SmsDTO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.13.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.03.13.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class SmsDTO extends DefaultDTO {

	private static final long serialVersionUID = 1L;

	private String trPhone; 		//(필수)수신할 핸드폰 번호
	private String trCallback;		//(필수)송신자 전화번호
	private String trMsg;			//(필수)전송할 메시지
	private String trSendDate; 		//전송할 일자 : null이면 현재 시간
	private String trSysId = "06"; 	//시스템구분 : 고정
	private String trDeptId;
	private String trCcId;		//전송자 부서코드 : 비밀번호변경, 개인정보파기 등은 공통 메시지는 정보기획팀, 그 외는 전송자 부서 
	private String trUserId;		//전송자 사용자ID
	private String trCustNo;		//타겟 고객번호 : CTI 고객전송이력 조회를 위해 필요
	private String trEtc1;			//기타 용도
	private String trEtc2;			//기타 용도
	private String trEtc3;			//기타 용도
	private String trEtc4;			//기타 용도
	private String trEtc5;			//기타 용도
	private String trEtc6;			//기타 용도
	
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
	 * trPhone 얻기 (수신할 핸드폰 번호)
	 *
	 * @return the trPhone
	 */
	public String getTrPhone() {
		return trPhone;
	}

	/**
	 * trPhone 설정 (수신할 핸드폰 번호)
	 *
	 * @param trPhone the trPhone to set
	 */
	public void setTrPhone(String trPhone) {
		this.trPhone = trPhone;
	}
	
	/**
	 * trCallback 얻기 (송신자 전화번호)
	 *
	 * @return the trCallback
	 */
	public String getTrCallback() {
		return trCallback;
	}

	/**
	 * trCallback 설정 (송신자 전화번호)
	 *
	 * @param trCallback the trCallback to set
	 */
	public void setTrCallback(String trCallback) {
		this.trCallback = trCallback;
	}

	/**
	 * trMsg 얻기 (전송 메시지)
	 *
	 * @return the trMsg
	 */
	public String getTrMsg() {
		return trMsg;
	}

	/**
	 * trMsg 설정 (전송 메시지)
	 *
	 * @param trMsg the trMsg to set
	 */
	public void setTrMsg(String trMsg) {
		this.trMsg = trMsg;
	}

	/**
	 * trSendDate 얻기 (전송할 일자)
	 *
	 * @return the trSendDate
	 */
	public String getTrSendDate() {
		return trSendDate;
	}

	/**
	 * trSendDate 설정 (전송할 일자)
	 *
	 * @param trSendDate the trSendDate to set
	 */
	public void setTrSendDate(String trSendDate) {
		this.trSendDate = trSendDate;
	}

	/**
	 * trSysId 얻기 (시스템 구분)
	 *
	 * @return the trSysId
	 */
	public String getTrSysId() {
		return trSysId;
	}

	/**
	 * trSysId 설정 (시스템 구분)
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
	 * trCcId 얻기 (전송자 부서)
	 *
	 * @return the trCcId
	 */
	public String getTrCcId() {
		return trCcId;
	}

	/**
	 * trCcId 설정 (전송자 부서)
	 *
	 * @param trCcId the trCcId to set
	 */
	public void setTrCcId(String trCcId) {
		this.trCcId = trCcId;
	}

	/**
	 * trUserId 얻기 (전송자 사번)
	 *
	 * @return the trUserId
	 */
	public String getTrUserId() {
		return trUserId;
	}

	/**
	 * trUserId 설정 (전송자 사번)
	 *
	 * @param trUserId the trUserId to set
	 */
	public void setTrUserId(String trUserId) {
		this.trUserId = trUserId;
	}

	/**
	 * trCustNo 얻기(타겟 고객번호 : CTI 고객전송이력 조회를 위해 필요)
	 *
	 * @return the trCustNo
	 */
	public String getTrCustNo() {
		return trCustNo;
	}

	/**
	 * trCustNo 설정(타겟 고객번호 : CTI 고객전송이력 조회를 위해 필요)
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

	/**
	 * trEtc5 얻기
	 *
	 * @return the trEtc5
	 */
	public String getTrEtc5() {
		return trEtc5;
	}

	/**
	 * trEtc5 설정
	 *
	 * @param trEtc5 the trEtc5 to set
	 */
	public void setTrEtc5(String trEtc5) {
		this.trEtc5 = trEtc5;
	}

	/**
	 * trEtc6 얻기
	 *
	 * @return the trEtc6
	 */
	public String getTrEtc6() {
		return trEtc6;
	}

	/**
	 * trEtc6 설정
	 *
	 * @param trEtc6 the trEtc6 to set
	 */
	public void setTrEtc6(String trEtc6) {
		this.trEtc6 = trEtc6;
	}
	
	
}
