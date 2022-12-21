package com.hwfs.sc.cmn.sap.request;

import java.io.Serializable;

import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.hwfs.sc.cmn.sap.EAIRequest;

 /**
 * BankAcctNoRequest에 대한 설명 작성
 * @ClassName BankAcctNoRequest.java
 * @Description BankAcctNoRequest Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 7. 23.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 7. 23.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class BankAcctNoRequest implements Serializable, EAIRequest {
	private static final long serialVersionUID = 1L;
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	//private String sysCd = "IPO";
	private String buCd = "2000";
	private String sapCustCd = "";

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
		return "FCM_TR_010_02";
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
			value.put("SYS_CD", "IPO");
			value.put("BU_CD", this.buCd);
			value.put("ERP_VD_CD", this.sapCustCd);

			item.put("ITEM01", value);
		}
		catch (JSONException e) {
			logger.debug(e.getMessage());
			throw e;
		}

		return item;
	}

//	/**
//	 * sysCd 얻기
//	 *
//	 * @return the sysCd
//	 */
//	public String getSysCd() {
//		return sysCd;
//	}
//
//	/**
//	 * sysCd 설정
//	 *
//	 * @param sysCd the sysCd to set
//	 */
//	public void setSysCd(String sysCd) {
//		this.sysCd = sysCd;
//	}

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



}
