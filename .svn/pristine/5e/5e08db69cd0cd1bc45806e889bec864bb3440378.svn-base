package com.hwfs.sc.cmn.sap.request;

import java.io.Serializable;
import java.math.BigDecimal;

import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.hwfs.sc.cmn.sap.EAIRequest;

 /**
 * SuspenseReceiveRequest에 대한 설명 작성
 * @ClassName SuspenseReceiveRequest.java
 * @Description SuspenseReceiveRequest Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 5. 29.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 5. 29.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class SuspenseReceiveRequest implements Serializable, EAIRequest {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	private static final long serialVersionUID = 1L;

	private String buCd = "";
	private String sapSuspenseNum = "";
	private int seq = 0;	//BigDecimal.ZERO;
	private String altProcDate = "";
	private String altProcTime = "";
	private String altProcUser = "";
	private String currency = "KRW";
	private BigDecimal amt = BigDecimal.ZERO;
	private String ccCd = "";
	private String altSlipNum = "";
	private String altDate = "";
	private String sapCustCd = "";
	private String reqType = "";

	/**
	 * getInterfaceId 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @return
	 * @see com.hwfs.sc.cmn.sap.EAIRequest#getInterfaceId()
	*/
	@Override
	public String getInterfaceId() {
		return "FCM_FI_010_01";
	}

	/**
	 * getJSONObject 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param systemCode
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.cmn.sap.EAIRequest#getJSONObject(java.lang.String)
	*/
	@Override
	public JSONObject getJSONObject(String systemCode) throws Exception {
		JSONObject value = new JSONObject();
		JSONObject item = new JSONObject();

		try {
			value.put("SYSCD", systemCode);
			value.put("BU_CD", this.buCd);
			value.put("SAP_SUSPENSE_NUM", this.sapSuspenseNum);
			value.put("SEQ", this.seq);
			value.put("ALT_PROC_DATE", this.altProcDate);
			value.put("ALT_PROC_TIME", this.altProcTime);
			value.put("ALT_PROC_USER", this.altProcUser);
			value.put("CURRENCY", this.currency);
			value.put("AMT", this.amt);
			value.put("CC_CD", this.ccCd);
			value.put("ALT_SLIP_NUM", this.altSlipNum);
			value.put("ALT_DATE", this.altDate);
			value.put("SAP_CUST_CD", this.sapCustCd);
			value.put("REQ_TYPE", this.reqType);

			item.put("ITEM01", value);
		}
		catch (JSONException e) {
			logger.debug(e.getMessage());
			throw e;
		}

		return item;
	}

	/**
	 * buCd 얻기
	 *
	 * @return the buCd
	 */
	public String getBuCd() {
		return buCd;
	}

	/**
	 * buCd 설정
	 *
	 * @param buCd the buCd to set
	 */
	public void setBuCd(String buCd) {
		this.buCd = buCd;
	}

	/**
	 * sapSuspenseNum 얻기
	 *
	 * @return the sapSuspenseNum
	 */
	public String getSapSuspenseNum() {
		return sapSuspenseNum;
	}

	/**
	 * sapSuspenseNum 설정
	 *
	 * @param sapSuspenseNum the sapSuspenseNum to set
	 */
	public void setSapSuspenseNum(String sapSuspenseNum) {
		this.sapSuspenseNum = sapSuspenseNum;
	}

	/**
	 * seq 얻기
	 *
	 * @return the seq
	 */
	public int getSeq() {	//BigDecimal getSeq() {
		return seq;
	}

	/**
	 * seq 설정
	 *
	 * @param seq the seq to set
	 */
	public void setSeq(int seq) {	//BigDecimal seq) {
		this.seq = seq;
	}

	/**
	 * altProcDate 얻기
	 *
	 * @return the altProcDate
	 */
	public String getAltProcDate() {
		return altProcDate;
	}

	/**
	 * altProcDate 설정
	 *
	 * @param altProcDate the altProcDate to set
	 */
	public void setAltProcDate(String altProcDate) {
		this.altProcDate = altProcDate;
	}

	/**
	 * altProcTime 얻기
	 *
	 * @return the altProcTime
	 */
	public String getAltProcTime() {
		return altProcTime;
	}

	/**
	 * altProcTime 설정
	 *
	 * @param altProcTime the altProcTime to set
	 */
	public void setAltProcTime(String altProcTime) {
		this.altProcTime = altProcTime;
	}

	/**
	 * altProcUser 얻기
	 *
	 * @return the altProcUser
	 */
	public String getAltProcUser() {
		return altProcUser;
	}

	/**
	 * altProcUser 설정
	 *
	 * @param altProcUser the altProcUser to set
	 */
	public void setAltProcUser(String altProcUser) {
		this.altProcUser = altProcUser;
	}

	/**
	 * currency 얻기
	 *
	 * @return the currency
	 */
	public String getCurrency() {
		return currency;
	}

	/**
	 * currency 설정
	 *
	 * @param currency the currency to set
	 */
	public void setCurrency(String currency) {
		this.currency = currency;
	}

	/**
	 * amt 얻기
	 *
	 * @return the amt
	 */
	public BigDecimal getAmt() {
		return amt;
	}

	/**
	 * amt 설정
	 *
	 * @param amt the amt to set
	 */
	public void setAmt(BigDecimal amt) {
		this.amt = amt;
	}

	/**
	 * ccCd 얻기
	 *
	 * @return the ccCd
	 */
	public String getCcCd() {
		return ccCd;
	}

	/**
	 * ccCd 설정
	 *
	 * @param ccCd the ccCd to set
	 */
	public void setCcCd(String ccCd) {
		this.ccCd = ccCd;
	}

	/**
	 * altSlipNum 얻기
	 *
	 * @return the altSlipNum
	 */
	public String getAltSlipNum() {
		return altSlipNum;
	}

	/**
	 * altSlipNum 설정
	 *
	 * @param altSlipNum the altSlipNum to set
	 */
	public void setAltSlipNum(String altSlipNum) {
		this.altSlipNum = altSlipNum;
	}

	/**
	 * altDate 얻기
	 *
	 * @return the altDate
	 */
	public String getAltDate() {
		return altDate;
	}

	/**
	 * altDate 설정
	 *
	 * @param altDate the altDate to set
	 */
	public void setAltDate(String altDate) {
		this.altDate = altDate;
	}

	/**
	 * sapCustCd 얻기
	 *
	 * @return the sapCustCd
	 */
	public String getSapCustCd() {
		return sapCustCd;
	}

	/**
	 * sapCustCd 설정
	 *
	 * @param sapCustCd the sapCustCd to set
	 */
	public void setSapCustCd(String sapCustCd) {
		this.sapCustCd = sapCustCd;
	}

	/**
	 * reqType 얻기
	 *
	 * @return the reqType
	 */
	public String getReqType() {
		return reqType;
	}

	/**
	 * reqType 설정
	 *
	 * @param reqType the reqType to set
	 */
	public void setReqType(String reqType) {
		this.reqType = reqType;
	}

}
