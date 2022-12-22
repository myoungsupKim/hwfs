package com.hwfs.sc.scd.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * SAP 인터페이스 샘플 가이드를 설명하는 SapIfPage DAO
 * 
 * @ClassName SapIfPageDAO.java
 * @Description SapIfPageDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.11.10   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.11.10
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scd/sapIfPageDAO")
public class SapIfPageDAO extends DefaultDAO {
	
	/**
	 * SAP 인터페이스 샘플 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scd.sapIfPageDAO.selectList", mapParam);
	}

	/**
	 * SAP 인터페이스 샘플(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scd.sapIfPageDAO.insert", mapParam);
	}
	
	/**
	 * SAP 인터페이스 샘플(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scd.sapIfPageDAO.update", mapParam);
	}
	
	/**
	 * SAP 인터페이스 샘플(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scd.sapIfPageDAO.delete", mapParam);
	}
	
}
