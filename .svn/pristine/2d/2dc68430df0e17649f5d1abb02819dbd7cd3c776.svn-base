package com.hwfs.sc.cmn.sap.request;

import java.io.Serializable;
import java.math.BigDecimal;

import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.hwfs.sc.cmn.sap.EAIRequest;

 /**
 * SuspenseAltRequest에 대한 설명 작성
 * @ClassName CancelSuspenseAltRequest.java
 * @Description SuspenseAltRequest Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 5. 15.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 5. 15.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class CancelSuspenseAltRequest implements Serializable, EAIRequest {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	private static final long serialVersionUID = -5038832093321917926L;

	private String buCd = "";
	private String sapSuspenseNum = "";
	private String chgBuCd = "";
	private String ccCd = "";
	private String currency = "";
	private BigDecimal altAmt = BigDecimal.ZERO;
	private String empNo = "";


	/**
	 * EAI에서 할당 받은 인터페이스 ID
	 * </pre>
	 *
	 * @return
	 * @see com.hwfs.sc.cmn.sap.EAIRequest#getInterfaceId()
	*/
	@Override
	public String getInterfaceId() {
		return "FCM_TR_022_01";
	}

	/**
	 * setter로 통해 할당 받은 값을 EAI와 통신에 맞는 형태의 JSONObject로 반환한다.
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
			value.put("BUKRS", this.buCd);
			value.put("SUS_NO", this.sapSuspenseNum);
			value.put("TO_BUKRS", this.chgBuCd);
			value.put("TO_KOSTL", this.ccCd);
			value.put("WAERS", this.currency);
			value.put("WRBTR", this.altAmt);
			value.put("PERNR", this.empNo);
			
			item.put("ITEM01", value);
		}
		catch (JSONException e) {
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
	public String getBUKRS() {
		return buCd;
	}

	/**
	 * 회사코드 설정
	 *
	 * @param buCd the buCd to set
	 */
	public void setBUKRS(String buCd) {
		this.buCd = buCd;
	}

	/**
	 * 가수금번호 얻기
	 *
	 * @return the suspenseNum
	 */
	public String getSUS_NO() {
		return sapSuspenseNum;
	}

	/**
	 * 가수금번호 설정
	 *
	 * @param suspenseNum the suspenseNum to set
	 */
	public void setSUS_NO(String sapSuspenseNum) {
		this.sapSuspenseNum = sapSuspenseNum;
	}

	/**
	 * 대체회사코드 얻기
	 *
	 * @return the altBuCd
	 */
	public String getTO_BUKRS() {
		return chgBuCd;
	}

	/**
	 * 대체회사코드 설정
	 *
	 * @param altBuCd the altBuCd to set
	 */
	public void setTO_BUKRS(String chgBuCd) {
		this.chgBuCd = chgBuCd;
	}

	/**
	 * CC코드 얻기
	 *
	 * @return the ccCd
	 */
	public String getTO_KOSTL() {
		return ccCd;
	}

	/**
	 * CC코드 설정
	 *
	 * @param ccCd the ccCd to set
	 */
	public void setTO_KOSTL(String ccCd) {
		this.ccCd = ccCd;
	}

	/**
	 * 통화 얻기
	 *
	 * @return the currency
	 */
	public String getWAERS() {
		return currency;
	}

	/**
	 * 통화 설정
	 *
	 * @param currency the currency to set
	 */
	public void setWAERS(String currency) {
		this.currency = currency;
	}

	/**
	 * 대체금액 얻기
	 *
	 * @return the altAmt
	 */
	public BigDecimal getWRBTR() {
		return altAmt;
	}

	/**
	 * 대체금액 설정
	 *
	 * @param altAmt the altAmt to set
	 */
	public void setWRBTR(BigDecimal altAmt) {
		this.altAmt = altAmt;
	}


	/**
	 * empNo 얻기
	 *
	 * @return the empNo
	 */
	public String getPERNR() {
		return empNo;
	}

	/**
	 * empNo 설정
	 *
	 * @param empNo the empNo to set
	 */
	public void setPERNR(String empNo) {
		this.empNo = empNo;
	}


}
