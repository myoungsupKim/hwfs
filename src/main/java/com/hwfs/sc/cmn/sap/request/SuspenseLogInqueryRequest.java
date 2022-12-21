package com.hwfs.sc.cmn.sap.request;

import java.io.Serializable;

import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.hwfs.sc.cmn.sap.EAIRequest;

/**
 * SuspenseLogInqueryRequest에 대한 설명 작성
 *
 * @ClassName SuspenseLogInqueryRequest.java
 * @Description SuspenseLogInqueryRequest Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 10.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 4. 10.
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class SuspenseLogInqueryRequest implements Serializable, EAIRequest {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	private static final long serialVersionUID = 1L;
	private String buCd = "";
	private String suspenseNum = "";

	/**
	 * getInterfaceId 설명
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @return
	 * @see com.hwfs.sc.cmn.sap.EAIRequest#getInterfaceId()
	 */
	@Override
	public String getInterfaceId() {
		return "FCM_TR_007_02";
	}

	/**
	 * getJSONObject 설명
	 *
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
			value.put("SAP_SYS_CLASS", systemCode);
			value.put("BU_CD", this.buCd);
			value.put("SAP_SUSPENSE_NUM", suspenseNum);

			item.put("ITEM01", value);
		} catch (JSONException e) {
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
	 * @param buCd
	 *            the buCd to set
	 */
	public void setBuCd(String buCd) {
		this.buCd = buCd;
	}

	/**
	 * suspenseNum 얻기
	 *
	 * @return the suspenseNum
	 */
	public String getSuspenseNum() {
		return suspenseNum;
	}

	/**
	 * suspenseNum 설정
	 *
	 * @param suspenseNum
	 *            the suspenseNum to set
	 */
	public void setSuspenseNum(String suspenseNum) {
		this.suspenseNum = suspenseNum;
	}
}
