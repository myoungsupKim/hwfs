package com.hwfs.sm.ssi.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 영업유형을 관리하는 SalesTypeMgnt DAO
 * 
 * @ClassName SalesTypeMgntDAO.java
 * @Description SalesTypeMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.10   	JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.03.10
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/ssi/salesTypeMgntDAO")
public class SalesTypeMgntDAO extends DefaultDAO {
	
	/**
	 * 영업유형 그룹을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.ssi.salesTypeMgntDAO.selectList", mapParam);
	}

	/**
	 * 영업유형 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDtlList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.ssi.salesTypeMgntDAO.selectDtlList", mapParam);
	}

	/**
	 * 영업유형 중복체크
	 */
	public int selectExists(Map<String, Object> parameter) {
		return super.queryForInt("sm.ssi.salesTypeMgntDAO.selectExists", parameter);
	}
	
	/**
	 * 영업유형(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.ssi.salesTypeMgntDAO.insert", mapParam);
	}
	
	/**
	 * 영업유형(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.ssi.salesTypeMgntDAO.update", mapParam);
	}
	
	/**
	 * 영업유형(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.ssi.salesTypeMgntDAO.delete", mapParam);
	}
	
}
