package com.hwfs.sc.cmn.sap.table;

import java.util.HashMap;
import java.util.Map;

import com.hwfs.sc.cmn.sap.EAITable;

/**
 * CustomerRequestBuInfoTable에 대한 설명 작성
 *
 * @ClassName CustomerRequestBuInfoTable.java
 * @Description CustomerRequestBuInfoTable Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 23.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 4. 23.
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class CustomerRequestBuInfoTable implements EAITable {

	private Map<String, Object> parameter = new HashMap<String, Object>();

	/**
	 * getInterfaceId 설명
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @return
	 * @see com.hwfs.sc.cmn.sap.EAITable#getInterfaceId()
	 */
	@Override
	public String getInterfaceId() {
		return "FI-002-02";
	}

	/**
	 * getDeleteQueryId 설명
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @return
	 * @see com.hwfs.sc.cmn.sap.EAITable#getDeleteQueryId()
	 */
	@Override
	public String getDeleteQueryId() {
		return "sc.cmn.sap.eaiTableDAO.deleteCustomerRequestBuInfo";
	}

	/**
	 * getQueryId 설명
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @return
	 * @see com.hwfs.sc.cmn.sap.EAITable#getQueryId()
	 */
	@Override
	public String getQueryId() {
		return "sc.cmn.sap.eaiTableDAO.insertCustomerRequestBuInfo";
	}

	/**
	 * getData 설명
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @return
	 * @see com.hwfs.sc.cmn.sap.EAITable#getData()
	 */
	@Override
	public Object getData() {
		return this.parameter;
	}

	/**
	 * setParameter 설명
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @see com.hwfs.sc.cmn.sap.EAITable#setParameter(java.util.Map)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public void setParameter(Object parameter) {
		Map<String, Object> p = (Map<String, Object>) parameter;
		p.put("buCd", "2000");
		this.parameter = p;

	}

	/**
	 * addParameter 설명
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param key
	 * @param value
	 * @see com.hwfs.sc.cmn.sap.EAITable#addParameter(java.lang.String,
	 *      java.lang.Object)
	 */
	@Override
	public void addParameter(String key, Object value) {
		parameter.put(key, value);
	}

}
