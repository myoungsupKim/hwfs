package com.hwfs.guide.sample.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * SAP IF로 멀티자료 이관하는하는 SapIfMultiDataProcess DAO
 *
 * @ClassName SapIfMultiDataProcessDAO.java
 * @Description SapIfMultiDataProcessDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.22   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.05.22
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/guide/sample/sapIfMultiDataProcessDAO")
public class SapIfMultiDataProcessDAO extends DefaultDAO {

	/**
	 * SAP IF로 멀티자료 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("guide.sample.sapIfMultiDataProcessDAO.selectList", mapParam);
	}

	/**
	 * 계정별 월합계 집계내역
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectAcctMmSum(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("guide.sample.sapIfMultiDataProcessDAO.selectAcctMmSum", mapParam);
	}


	/**
	 * SAP IF로 멀티자료(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("guide.sample.sapIfMultiDataProcessDAO.insert", mapParam);
	}

	/**
	 * SAP IF로 멀티자료(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("guide.sample.sapIfMultiDataProcessDAO.update", mapParam);
	}

	/**
	 * SAP IF로 멀티자료(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("guide.sample.sapIfMultiDataProcessDAO.delete", mapParam);
	}

}
