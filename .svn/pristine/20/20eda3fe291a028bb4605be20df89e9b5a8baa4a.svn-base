package com.hwfs.sc.cmn.sap.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * EAI 호출로그를 기록하는 EAILog DAO
 *
 * @ClassName EAILogDAO.java
 * @Description EAILogDAO Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.10   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.04.10
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("EAILogDAO")
public class EAILogDAO extends DefaultDAO {

	/**
	 * 로그 건수를 반환한다. </pre>
	 *
	 * @return
	 * @throws Exception
	 */
	public int select() throws Exception {
		return super.queryForInt("sc.cmn.sap.eAILogDAO.select",
				new HashMap<String, Object>());
	}

	public void delete(Map<String, Object> parameter) throws Exception {
		super.update("sc.cmn.sap.eAILogDAO.delete", parameter);
	}

	/**
	 * EAI 호출로그(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.cmn.sap.eAILogDAO.insert", mapParam);
	}
}
