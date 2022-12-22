package com.hwfs.sc.cmn.sap.request;

import java.io.Serializable;

import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.hwfs.sc.cmn.sap.EAIRequest;

/**
 * 가수금 조회를 위한 Reqeust를 생성한다.
 *
 * @ClassName SuspenseInqueryDTO.java
 * @Description SuspenseInqueryDTO Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 9.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 4. 9.
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class SuspenseInqueryRequest implements Serializable, EAIRequest {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	private static final long serialVersionUID = 1L;

	private String buCd = "";
	private String suspenseNum = "";
	private String startDate = "";
	private String endDate = "";
	private String ccCd = "";
	private String muCd = "";
	private String bankAcctNo = "";
	private String receiveGuestNm = "";
	private String closeYn = "";

	/**
	 * EAI에서 할당 받은 인터페이스 ID
	 *
	 * @return
	 * @see com.hwfs.sc.cmn.sap.EAIRequest#getInterfaceId()
	 */
	@Override
	public String getInterfaceId() {
		return "FCM_TR_006_02";
	}

	/**
	 * setter로 통해 할당 받은 값을 EAI와 통신에 맞는 형태의 JSONObject로 반환한다.
	 *
	 * @param systemCode
	 *            : EAI에서 할당 받은 시스템 코드
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.cmn.sap.EAIRequest#getJSONObject(String systemCode)
	 */
	@Override
	public JSONObject getJSONObject(String systemCode) throws Exception {
		JSONObject value = new JSONObject();
		JSONObject item = new JSONObject();

		try {
			value.put("SYSCD", systemCode);
			value.put("BU_CD", this.buCd);
			value.put("SUS_NO", this.suspenseNum);
			value.put("STRDT", this.startDate);
			value.put("ENDDT", this.endDate);
			value.put("CC_CD", this.ccCd);
			value.put("MU_CD", this.muCd);
			value.put("BANK_ACCT_NO", this.bankAcctNo);
			value.put("RECEIVE_GUEST_NM", this.receiveGuestNm);
			value.put("CLOSE", this.closeYn);

			item.put("ITEM01", value);
		} catch (JSONException e) {
			logger.debug(e.getMessage());
			throw e;
		}

		return item;
	}

	/**
	 * 회사코드 얻기
	 *
	 * @return the buCd
	 */
	public String getBuCd() {
		return buCd;
	}

	/**
	 * 회사코드 설정
	 *
	 * @param buCd
	 *            the buCd to set
	 */
	public void setBuCd(String buCd) {
		this.buCd = buCd;
	}

	/**
	 * 가수금번호 얻기
	 *
	 * @return the suspenseNum
	 */
	public String getSuspenseNum() {
		return suspenseNum;
	}

	/**
	 * 가수금번호 설정
	 *
	 * @param suspenseNum
	 *            the suspenseNum to set
	 */
	public void setSuspenseNum(String suspenseNum) {
		this.suspenseNum = suspenseNum;
	}

	/**
	 * 입금-시작일자 얻기
	 *
	 * @return the startDate
	 */
	public String getStartDate() {
		return startDate;
	}

	/**
	 * 입금-시작일자 설정
	 *
	 * @param startDate
	 *            the startDate to set
	 */
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	/**
	 * 입금-종료일자 얻기
	 *
	 * @return the endDate
	 */
	public String getEndDate() {
		return endDate;
	}

	/**
	 * 입금-종료일자 설정
	 *
	 * @param endDate
	 *            the endDate to set
	 */
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	/**
	 * CC코드 얻기
	 *
	 * @return the ccCd
	 */
	public String getCcCd() {
		return ccCd;
	}

	/**
	 * CC코드 설정
	 *
	 * @param ccCd
	 *            the ccCd to set
	 */
	public void setCcCd(String ccCd) {
		this.ccCd = ccCd;
	}

	/**
	 * 사업부코드 얻기
	 *
	 * @return the muCd
	 */
	public String getMuCd() {
		return muCd;
	}

	/**
	 * 사업부코드 설정
	 *
	 * @param muCd
	 *            the muCd to set
	 */
	public void setMuCd(String muCd) {
		this.muCd = muCd;
	}

	/**
	 * 계좌번호 얻기
	 *
	 * @return the bankAcctNo
	 */
	public String getBankAcctNo() {
		return bankAcctNo;
	}

	/**
	 * 계좌번호 설정
	 *
	 * @param bankAcctNo
	 *            the bankAcctNo to set
	 */
	public void setBankAcctNo(String bankAcctNo) {
		this.bankAcctNo = bankAcctNo;
	}

	/**
	 * 입금자성명 얻기
	 *
	 * @return the receiveGuestNm
	 */
	public String getReceiveGuestNm() {
		return receiveGuestNm;
	}

	/**
	 * 입금자성명 설정
	 *
	 * @param receiveGuestNm
	 *            the receiveGuestNm to set
	 */
	public void setReceiveGuestNm(String receiveGuestNm) {
		this.receiveGuestNm = receiveGuestNm;
	}

	/**
	 * 완료여부 얻기
	 *
	 * @return the closeYn
	 */
	public String getCloseYn() {
		return closeYn;
	}

	/**
	 * 완료여부 설정
	 *
	 * @param closeYn
	 *            the closeYn to set
	 */
	public void setCloseYn(String closeYn) {
		this.closeYn = closeYn;
	}
}
