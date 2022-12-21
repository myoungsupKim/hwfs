package com.hwfs.sc.cmn.sap.table;

import com.hwfs.sc.cmn.sap.EAITable;

/**
 * CustomerRequestTable에 대한 설명 작성
 *
 * @ClassName CustomerRequestTable.java
 * @Description CustomerRequestTable Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 22.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 4. 22.
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class CustomerRequestTable implements EAITable {

	private Object parameter = new Object();

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
	 * 기존 자료를 삭제하는 Query ID(단, ""이면 처리하지 않음)
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
		return "sc.cmn.sap.eaiTableDAO.deleteCustomerRequest";
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
		return "sc.cmn.sap.eaiTableDAO.insertCustomerRequest";
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
	@Override
	public void setParameter(Object parameter) {
		this.parameter = parameter;
	}

	@Override
	public void addParameter(String key, Object value) {

		// this.parameter.put(key, value);
	}
}
