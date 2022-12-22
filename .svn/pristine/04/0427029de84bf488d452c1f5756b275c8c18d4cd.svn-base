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
 * @ClassName SuspenseAltRequest.java
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
public class SuspenseAltRequest implements Serializable, EAIRequest {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	private static final long serialVersionUID = -5038832093321917926L;

	private String buCd = "";
	private String suspenseNum = "";
	private String altBuCd = "";
	private String ccCd = "";
	private String currency = "";
	private BigDecimal altAmt = BigDecimal.ZERO;
	private String sabun = "";
	private String reqDate = "";

	/**
	 * EAI에서 할당 받은 인터페이스 ID
	 * </pre>
	 *
	 * @return
	 * @see com.hwfs.sc.cmn.sap.EAIRequest#getInterfaceId()
	*/
	@Override
	public String getInterfaceId() {
		return "FCM_TR_008_02";
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
			value.put("SYS_CD", systemCode);
			value.put("BU_CD", this.buCd);
			value.put("SAP_SUSPENSE_NUM", this.suspenseNum);
			value.put("ALT_BU_CD", this.altBuCd);
			value.put("CC_CD", this.ccCd);
			value.put("CURRENCY", this.currency);
			value.put("ALT_AMT", this.altAmt);
			value.put("SABUN", this.sabun);
			
			//전환신청일자 추가 20151208
			value.put("REQ_DATE", this.reqDate);
	
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
	public String getBuCd() {
		return buCd;
	}

	/**
	 * 회사코드 설정
	 *
	 * @param buCd the buCd to set
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
	 * @param suspenseNum the suspenseNum to set
	 */
	public void setSuspenseNum(String suspenseNum) {
		this.suspenseNum = suspenseNum;
	}

	/**
	 * 대체회사코드 얻기
	 *
	 * @return the altBuCd
	 */
	public String getAltBuCd() {
		return altBuCd;
	}

	/**
	 * 대체회사코드 설정
	 *
	 * @param altBuCd the altBuCd to set
	 */
	public void setAltBuCd(String altBuCd) {
		this.altBuCd = altBuCd;
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
	 * @param ccCd the ccCd to set
	 */
	public void setCcCd(String ccCd) {
		this.ccCd = ccCd;
	}

	/**
	 * 통화 얻기
	 *
	 * @return the currency
	 */
	public String getCurrency() {
		return currency;
	}

	/**
	 * 통화 설정
	 *
	 * @param currency the currency to set
	 */
	public void setCurrency(String currency) {
		this.currency = currency;
	}

	/**
	 * 대체금액 얻기
	 *
	 * @return the altAmt
	 */
	public BigDecimal getAltAmt() {
		return altAmt;
	}

	/**
	 * 대체금액 설정
	 *
	 * @param altAmt the altAmt to set
	 */
	public void setAltAmt(BigDecimal altAmt) {
		this.altAmt = altAmt;
	}

	/**
	 * 사번 얻기
	 *
	 * @return the sabun
	 */
	public String getSabun() {
		return sabun;
	}

	/**
	 * 사번 설정
	 *
	 * @param sabun the sabun to set
	 */
	public void setSabun(String sabun) {
		this.sabun = sabun;
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


	


}
