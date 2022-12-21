package com.hwfs.sc.cmn.sap.request;

import java.io.Serializable;

import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.hwfs.sc.cmn.sap.EAIRequest;

 /**
 * YearBudgetInqueryRequest에 대한 설명 작성
 * @ClassName YearBudgetInqueryRequest.java
 * @Description YearBudgetInqueryRequest Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 9. 18.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 9. 18.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class YearBudgetInqueryRequest implements Serializable, EAIRequest {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	private static final long serialVersionUID = 1L;
	
	//private String compCd = "2000";
	private String inqYy = "";
	private String cctrCd = "";
	private String ioCd = "";
	private String acctCd = "";
	
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
		return "FCM_CO_007_03";
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
			//value.put("COMP_CD", this.compCd);
			value.put("INQ_YY", this.inqYy);
			value.put("CCTR_CD", this.cctrCd);
			value.put("IO_CD", this.ioCd);
			value.put("ACCT_CD", this.acctCd);

			item.put("ITEM01", value);
		}
		catch (JSONException e) {
			logger.debug(e.getMessage());
			throw e;
		}

		return item;
	}

//	/**
//	 * compCd 얻기
//	 *
//	 * @return the compCd
//	 */
//	public String getCompCd() {
//		return compCd;
//	}
//
//	/**
//	 * compCd 설정
//	 *
//	 * @param compCd the compCd to set
//	 */
//	public void setCompCd(String compCd) {
//		this.compCd = compCd;
//	}

	/**
	 * inqYy 얻기
	 *
	 * @return the inqYy
	 */
	public String getInqYy() {
		return inqYy;
	}

	/**
	 * inqYy 설정
	 *
	 * @param inqYy the inqYy to set
	 */
	public void setInqYy(String inqYy) {
		this.inqYy = inqYy;
	}

	/**
	 * cctrCd 얻기
	 *
	 * @return the cctrCd
	 */
	public String getCctrCd() {
		return cctrCd;
	}

	/**
	 * cctrCd 설정
	 *
	 * @param cctrCd the cctrCd to set
	 */
	public void setCctrCd(String cctrCd) {
		this.cctrCd = cctrCd;
	}

	/**
	 * ioCd 얻기
	 *
	 * @return the ioCd
	 */
	public String getIoCd() {
		return ioCd;
	}

	/**
	 * ioCd 설정
	 *
	 * @param ioCd the ioCd to set
	 */
	public void setIoCd(String ioCd) {
		this.ioCd = ioCd;
	}

	/**
	 * acctCd 얻기
	 *
	 * @return the acctCd
	 */
	public String getAcctCd() {
		return acctCd;
	}

	/**
	 * acctCd 설정
	 *
	 * @param acctCd the acctCd to set
	 */
	public void setAcctCd(String acctCd) {
		this.acctCd = acctCd;
	}

	
}
