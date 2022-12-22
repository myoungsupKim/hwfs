package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 업장품목 예외사항 관리하는 SalePriceException DAO
 * 
 * @ClassName SalePriceExceptionDAO.java
 * @Description SalePriceExceptionDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.15   	최성연        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.07.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fms/salePriceExceptionDAO")
public class SalePriceExceptionDAO extends DefaultDAO {

	/**
	 * 단가계약업장 목록 조회를 수행합니다
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectStd(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.salePriceExceptionDAO.selectStd", mapParam);
	}
	
	
	/**
	 * 업장품목 예외사항 관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.salePriceExceptionDAO.selectList", mapParam);
	}

	/**
	 * 업장품목 예외사항 관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceExceptionDAO.insert", mapParam);
	}
	public int insert2(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceExceptionDAO.insert2", mapParam);
	}
	
	/**
	 * 업장품목 예외사항 관리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceExceptionDAO.update", mapParam);
	}
	
	/**
	 * 업장품목 예외사항 관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceExceptionDAO.delete", mapParam);
	}
	public int deleteAll(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceExceptionDAO.deleteAll", mapParam);
	}
	
}
