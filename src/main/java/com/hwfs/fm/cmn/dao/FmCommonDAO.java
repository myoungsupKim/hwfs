package com.hwfs.fm.cmn.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * FM 공통 DAO
 * 
 * @ClassName FmCommonDAO.java
 * @Description FmCommonDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2021.07.07   DEV02        최초생성
 * </pre>
 * @author [PJT]주문채널통합 : DEV02
 * @since 2021.07.07
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/cmn/fmCommonDAO")
public class FmCommonDAO extends DefaultDAO {
	
	/**
	 * 자재 분류를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectItemClass(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.cnm.fmCommonDAO.selectItemClass", mapParam);
	}
	
}
