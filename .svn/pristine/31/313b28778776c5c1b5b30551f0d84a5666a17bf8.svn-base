package com.hwfs.sc.cmn.sap.request;

import java.io.Serializable;

import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.hwfs.sc.cmn.sap.EAIRequest;

 /**
 * ElctnTaxShetInqueryRequest에 대한 설명 작성
 * @ClassName ElctnTaxShetInqueryRequest.java
 * @Description ElctnTaxShetInqueryRequest Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 9. 14.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 9. 14.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class ElctnTaxShetInqueryRequest implements Serializable, EAIRequest{
	private static final long serialVersionUID = 1L;
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	private String bukrs = "1000";
	private String suName = "";
	private String frDate = "";
	private String toDate = "";
	private String deptId = "";
	private String statsCd = "";
	
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
		return "FCM_FI_012_02";
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
			value.put("I_BUKRS", this.bukrs);
			value.put("I_SU_NAME", this.suName);
			value.put("I_FRDAT", this.frDate);
			value.put("I_TODAT", this.toDate);
			value.put("I_DEPT_CD", this.deptId);
			value.put("I_STATS_CD", this.statsCd);

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
	 * @return the bukrs
	 */
	public String getBukrs() {
		return bukrs;
	}

	/**
	 * 회사코드 설정
	 *
	 * @param bukrs the bukrs to set
	 */
	public void setBukrs(String bukrs) {
		this.bukrs = bukrs;
	}

	/**
	 * 공급자명 얻기
	 *
	 * @return the suName
	 */
	public String getSuName() {
		return suName;
	}

	/**
	 * 공급자명 설정
	 *
	 * @param suName the suName to set
	 */
	public void setSuName(String suName) {
		this.suName = suName;
	}

	/**
	 * 공급일자 시작일 얻기
	 *
	 * @return the frDate
	 */
	public String getFrDate() {
		return frDate;
	}

	/**
	 * 공급일자 시작일 설정
	 *
	 * @param frDate the frDate to set
	 */
	public void setFrDate(String frDate) {
		this.frDate = frDate;
	}

	/**
	 * 공급일자 종료일 얻기
	 *
	 * @return the toDate
	 */
	public String getToDate() {
		return toDate;
	}

	/**
	 * 공급일자 종료일 설정
	 *
	 * @param toDate the toDate to set
	 */
	public void setToDate(String toDate) {
		this.toDate = toDate;
	}

	/**
	 * 처리부서코드(cc_cd) 얻기
	 *
	 * @return the deptId
	 */
	public String getDeptId() {
		return deptId;
	}

	/**
	 * 처리부서코드(cc_cd) 설정
	 *
	 * @param deptId the deptId to set
	 */
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

	/**
	 * 상태코드(10 : 미처리 (uniTax 에서 처음 전송받은 상태) 20 : 처리중 (전표 저장  ~ 전표 Posting 이전 까지) 30 : 처리완료 (전표 Posting 상태) 얻기
	 *
	 * @return the statsCd
	 */
	public String getStatsCd() {
		return statsCd;
	}

	/**
	 * 상태코드(10 : 미처리 (uniTax 에서 처음 전송받은 상태) 20 : 처리중 (전표 저장  ~ 전표 Posting 이전 까지) 30 : 처리완료 (전표 Posting 상태) 설정
	 *
	 * @param statsCd the statsCd to set
	 */
	public void setStatsCd(String statsCd) {
		this.statsCd = statsCd;
	}

	
}
