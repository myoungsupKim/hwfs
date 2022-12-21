package com.hwfs.sc.cmn.dao;

import hone.core.util.record.RecordSet;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 거래처를 검색하는 CustSearch DAO
 *
 * @ClassName CustSearchDAO.java
 * @Description CustSearchDAO Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.23   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.03.23
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/custSearchDAO")
public class CustSearchDAO extends DefaultDAO {

	/**
	 * 거래처 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {

		if (mapParam.containsKey("custGubun")) {
			//String[] custGubun = mapParam.get("custGubun").toString().split(",");
			List<String> custGubun = Arrays.asList(mapParam.get("custGubun").toString().split(","));
			List<String> al = new ArrayList<String>();
			for (int i=0 ; i<custGubun.size() ; i++) {
				al.add(custGubun.get(i));
			}

			mapParam.put("custGubun", al);
		}

		return super.queryForRecordSet("sc.cmn.custSearchDAO.select"
				+ mapParam.get("qid").toString() + "List", mapParam);
	}
}
