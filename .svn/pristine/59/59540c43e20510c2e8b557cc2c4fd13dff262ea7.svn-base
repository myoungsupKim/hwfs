package com.hwfs.ei.isa.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 특판상품을 정산하는 FsspExact DAO
 * 
 * @ClassName FsspExactDAO.java
 * @Description FsspExactDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.12.07   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : 특판담당 김재섭
 * @since 2015.12.07
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ei/isa/fsspRptDAO")
public class FsspRptDAO extends DefaultDAO {
	
	/**
	 * 정산내역을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectTeam(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ei.isa.fsspRptDAO.selectTeam", mapParam);
	}

}
