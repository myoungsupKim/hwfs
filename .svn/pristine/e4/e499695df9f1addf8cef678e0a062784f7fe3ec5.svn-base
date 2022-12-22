package com.hwfs.sc.cmn.sap.request;

import java.io.Serializable;

import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.hwfs.sc.cmn.sap.EAIRequest;

 /**
 * CorpCardInqueryRequest에 대한 설명 작성
 * @ClassName CorpCardInqueryRequest.java
 * @Description CorpCardInqueryRequest Class 
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
public class CorpCardInqueryRequest implements Serializable, EAIRequest {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	private static final long serialVersionUID = 1L;

	private String iFrdat = "";
	private String iTodat = "";
	private String iCardno = "";
	private String iUseStat = "";
	
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
		return "FCM_FI_079_01";
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
			value.put("I_FRDAT", this.iFrdat);
			value.put("I_TODAT", this.iTodat);
			value.put("I_CARDNO", this.iCardno);

			item.put("ITEM01", value);
		}
		catch (JSONException e) {
			logger.debug(e.getMessage());
			throw e;
		}

		return item;
	}

	/**
	 * iFrdat 얻기
	 *
	 * @return the iFrdat
	 */
	public String getiFrdat() {
		return iFrdat;
	}

	/**
	 * iFrdat 설정
	 *
	 * @param iFrdat the iFrdat to set
	 */
	public void setiFrdat(String iFrdat) {
		this.iFrdat = iFrdat;
	}

	/**
	 * iTodat 얻기
	 *
	 * @return the iTodat
	 */
	public String getiTodat() {
		return iTodat;
	}

	/**
	 * iTodat 설정
	 *
	 * @param iTodat the iTodat to set
	 */
	public void setiTodat(String iTodat) {
		this.iTodat = iTodat;
	}

	/**
	 * iCardno 얻기
	 *
	 * @return the iCardno
	 */
	public String getiCardno() {
		return iCardno;
	}

	/**
	 * iCardno 설정
	 *
	 * @param iCardno the iCardno to set
	 */
	public void setiCardno(String iCardno) {
		this.iCardno = iCardno;
	}

	/**
	 * iUseStat 얻기
	 *
	 * @return the iUseStat
	 */
	public String getiUseStat() {
		return iUseStat;
	}

	/**
	 * iUseStat 설정
	 *
	 * @param iUseStat the iUseStat to set
	 */
	public void setiUseStat(String iUseStat) {
		this.iUseStat = iUseStat;
	}

	
}
