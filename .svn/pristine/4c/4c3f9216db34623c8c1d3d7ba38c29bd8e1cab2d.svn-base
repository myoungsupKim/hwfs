package com.hwfs.sc.cmn.sap;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.List;

/**
 * EAIList에 대한 설명 작성
 *
 * @ClassName EAIList.java
 * @Description EAIList Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 5. 22.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 5. 22.
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface EAIList {
	/**
	 * Interfacer ID를 가져온다.
	 *
	 * @return
	 */
	String getInterfaceId();

	/**
	 * 삭제를 위한 Query Id를 가져온다.
	 *
	 * @return
	 */
	String getDeleteQueryId();

	/**
	 * 생성을 위한 Query Id를 가져온다.
	 *
	 * @return
	 */
	String getQueryId();

	/**
	 * 처리할 자료를 설정한다.
	 *
	 * @param list
	 */
	void setDataList(List<?> list);

	/**
	 * 처리할 자료를 설정한다.
	 *
	 * @param rs
	 */
	void setDataList(RecordSet rs);

	/**
	 * 처리할 자료를 설정한다.
	 *
	 * @param dsm
	 */
	void setDataList(DataSetMap dsm);


	/**
	 * 처리할 자료를 설정한다.
	 *
	 * @param dsm
	 * @param rowType
	 */
	void setDataList(DataSetMap dsm, int rowType);

	/**
	 * 처리할 자료를 가져온다.
	 *
	 * @return
	 */
	List<?> getDataList();
}
