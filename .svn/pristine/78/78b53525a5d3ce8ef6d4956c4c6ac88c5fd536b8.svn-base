package com.hwfs.sc.cmn.sap;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * EAIListMap에 대한 설명 작성
 *
 * @ClassName EAIListMap.java
 * @Description EAIListMap Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 5. 26.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 5. 26.
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class EAIListMap implements Serializable {
	private static final long serialVersionUID = 1L;
	public final Map<String, EAIList> dataListMap = new HashMap<String, EAIList>();
	public final List<String> dataKeyList = new ArrayList<String>();

	/**
	 * 처리할 자료를 추가한다. </pre>
	 *
	 * @param key
	 * @param eaiList
	 */
	public void addEAIList(String key, EAIList eaiList) {
		dataKeyList.add(key);
		dataListMap.put(key, eaiList);
	}

	/**
	 * 처리할 자료의 Key List를 가져온다.
	 *
	 * @return
	 */
	public List<String> getDataKeyList() {
		return dataKeyList;
	}

	/**
	 * 처리할 자료를 가져온다.
	 *
	 * @return
	 */
	public Map<String, EAIList> getDataListMap() {
		return dataListMap;
	}
}
