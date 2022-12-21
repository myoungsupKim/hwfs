package com.hwfs.fm.fmf.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * (미)매출마감내역하는 NoSaleCloseDesc DAO
 * 
 * @ClassName NoSaleCloseDescDAO.java
 * @Description NoSaleCloseDescDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.25   	최영준        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015.06.25
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmf/noSaleCloseDescDAO")
public class NoSaleCloseDescDAO extends DefaultDAO {
	
	/**
	 * (미)매출마감내역 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.noSaleCloseDescDAO.selectList", mapParam);
	}
	
	public RecordSet selectListTest(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.noSaleCloseDescDAO.selectListTest", mapParam);
	}
	
	public RecordSet selectDetail(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.noSaleCloseDescDAO.selectDetail", mapParam);
	}

	public RecordSet selectDetailTest(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.noSaleCloseDescDAO.selectDetailTest", mapParam);
	}
	
	/**
	 * (미)매출마감내역(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmf.noSaleCloseDescDAO.insert", mapParam);
	}
	
	/**
	 * (미)매출마감내역(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmf.noSaleCloseDescDAO.update", mapParam);
	}
	
	/**
	 * (미)매출마감내역(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmf.noSaleCloseDescDAO.delete", mapParam);
	}
	
}
