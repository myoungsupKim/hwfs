package com.hwfs.sm.ssi.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 부가세 코드를 관리하는 TaxCodeMgnt DAO
 * 
 * @ClassName TaxCodeMgntDAO.java
 * @Description TaxCodeMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.20   	김예진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.05.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/ssi/taxCodeMgntDAO")
public class TaxCodeMgntDAO extends DefaultDAO {
	
	/**
	 * 부가세 코드 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sm.ssi.taxCodeMgntDAO.selectList", parameter);
	}

	/**
	 * 부가세 코드(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.ssi.taxCodeMgntDAO.insert", mapParam);
	}
	
	/**
	 * 부가세 코드(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.ssi.taxCodeMgntDAO.update", mapParam);
	}
	
	/**
	 * 부가세 코드(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
//	public int delete(Map<String, Object> mapParam) throws Exception {
//		return super.update("sm.ssi.taxCodeMgntDAO.delete", mapParam);
//	}
	
}
