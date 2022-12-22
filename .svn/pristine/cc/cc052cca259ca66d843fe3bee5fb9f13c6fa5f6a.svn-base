package com.hwfs.sc.cmn.sap.request;

import java.io.Serializable;

import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.hwfs.sc.cmn.sap.EAIRequest;

 /**
 * FixedAssetsRequest에 대한 설명 작성
 * @ClassName FixedAssetsRequest.java
 * @Description FixedAssetsRequest Class
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
public class FixedAssetsRequest implements Serializable, EAIRequest {
	private static final long serialVersionUID = 1L;
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	private String ccCd = "";
	private String assetsKind = "";
	private String baseMonth = "";

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
		return "FCM_FI_081_01";
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
			value.put("CC_CD", this.ccCd);
			value.put("ASST_CLS", this.assetsKind);
			value.put("BASE_MONTH", this.baseMonth);

			item.put("ITEM01", value);
		}
		catch (JSONException e) {
			logger.debug(e.getMessage());
			throw e;
		}

		return item;
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
	 * assetsKind 얻기
	 *
	 * @return the assetsKind
	 */
	public String getAssetsKind() {
		return assetsKind;
	}

	/**
	 * assetsKind 설정
	 *
	 * @param assetsKind the assetsKind to set
	 */
	public void setAssetsKind(String assetsKind) {
		this.assetsKind = assetsKind;
	}

	/**
	 * baseMonth 얻기
	 *
	 * @return the baseMonth
	 */
	public String getBaseMonth() {
		return baseMonth;
	}

	/**
	 * baseMonth 설정
	 *
	 * @param baseMonth the baseMonth to set
	 */
	public void setBaseMonth(String baseMonth) {
		this.baseMonth = baseMonth;
	}
	
	
}
