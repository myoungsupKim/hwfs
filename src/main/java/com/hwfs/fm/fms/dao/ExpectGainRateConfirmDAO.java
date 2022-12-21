package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 예상이익율확인하는 ExpectGainRateConfirm DAO
 * 
 * @ClassName ExpectGainRateConfirmDAO.java
 * @Description ExpectGainRateConfirmDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.09.14   	손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.09.14
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fms/expectGainRateConfirmDAO")
public class ExpectGainRateConfirmDAO extends DefaultDAO {
	
	/**
	 * 예상이익율확인 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.expectGainRateConfirmDAO.selectList", mapParam);
	}

	/**
	 * 예상이익율확인(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.expectGainRateConfirmDAO.insert", mapParam);
	}
	
	/**
	 * 예상이익율확인(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.expectGainRateConfirmDAO.update", mapParam);
	}
	
	/**
	 * 예상이익율확인(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.expectGainRateConfirmDAO.delete", mapParam);
	}
	
}
