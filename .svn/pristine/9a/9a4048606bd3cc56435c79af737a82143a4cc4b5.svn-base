package com.hwfs.sc.cmn.sap.request;

import java.io.Serializable;

import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.hwfs.sc.cmn.sap.EAIRequest;

 /**
 * SuspenseAltResult에 대한 설명 작성
 * @ClassName SuspenseAltResult.java
 * @Description SuspenseAltResult Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 5. 28.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 5. 28.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class SuspenseAltResult implements Serializable, EAIRequest {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	private static final long serialVersionUID = 1L;

	private String sabun = "";
	private String reqDateStart = "";
	private String reqDateEnd = "";
	private String sapProcStatus = "";

	/**
	 * sabun 얻기
	 *
	 * @return the sabun
	 */
	public String getSabun() {
		return sabun;
	}

	/**
	 * sabun 설정
	 *
	 * @param sabun the sabun to set
	 */
	public void setSabun(String sabun) {
		this.sabun = sabun;
	}

	/**
	 * reqDateStart 얻기
	 *
	 * @return the reqDateStart
	 */
	public String getReqDateStart() {
		return reqDateStart;
	}

	/**
	 * reqDateStart 설정
	 *
	 * @param reqDateStart the reqDateStart to set
	 */
	public void setReqDateStart(String reqDateStart) {
		this.reqDateStart = reqDateStart;
	}

	/**
	 * reqDateEnd 얻기
	 *
	 * @return the reqDateEnd
	 */
	public String getReqDateEnd() {
		return reqDateEnd;
	}

	/**
	 * reqDateEnd 설정
	 *
	 * @param reqDateEnd the reqDateEnd to set
	 */
	public void setReqDateEnd(String reqDateEnd) {
		this.reqDateEnd = reqDateEnd;
	}

	/**
	 * sapProcStatus 얻기
	 *
	 * @return the sapProcStatus
	 */
	public String getSapProcStatus() {
		return sapProcStatus;
	}

	/**
	 * sapProcStatus 설정
	 *
	 * @param sapProcStatus the sapProcStatus to set
	 */
	public void setSapProcStatus(String sapProcStatus) {
		this.sapProcStatus = sapProcStatus;
	}

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
		return "FCM_TR_016_02";
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
			value.put("SAP_SYS_CLASS", systemCode);
			value.put("EMP_NO", this.sabun);
			value.put("REQ_DATE_START", this.reqDateStart);
			value.put("REQ_DATE_END", this.reqDateEnd);
			value.put("SAP_PROC_STATUS", this.sapProcStatus);

			item.put("ITEM01", value);
		}
		catch (JSONException e) {
			logger.debug(e.getMessage());
			throw e;
		}

		return item;
	}


	public static class SapProcStatus {
		/**
		 * 전체
		 */
		public final static String ALL = "";
		/**
		 * 요청
		 */
		public final static String REQUEST = "R";
		/**
		 * 승인
		 */
		public final static String APPROVAL = "A";
		/**
		 * 요청취소
		 */
		public final static String REQUEST_CANCEL = "C";
		/**
		 * 승인취소
		 */
		public final static String APPROVAL_CALCEL = "D";
	}
}
