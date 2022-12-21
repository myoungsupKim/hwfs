package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 전략이익율 등록하는 StrategyProfit DAO
 * 
 * @ClassName StrategyProfitDAO.java
 * @Description StrategyProfitDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.11.16   	sychoi        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 sychoi
 * @since 2015.11.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fms/strategyProfitDAO")
public class StrategyProfitDAO extends DefaultDAO {
	

	/**
	 *전략이익율 CC목록을 조회한다.
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectStd(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.strategyProfitDAO.selectStd", mapParam);
	}

	/**
	 *분류별 목록을 조회한다.
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectClass(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.strategyProfitDAO.selectClass", mapParam);
	}
	public RecordSet selectClassType(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.strategyProfitDAO.selectClassType", mapParam);
	}
	public RecordSet selectClassBef(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.strategyProfitDAO.selectClassBef", mapParam);
	}

	/**
	 *자재별 목록을 조회한다.
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectItem(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.strategyProfitDAO.selectItem", mapParam);
	}

	/**
	 *자재별 목록을 조회한다.
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectItemBef(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.strategyProfitDAO.selectItemBef", mapParam);
	}
	
	/**
	 * 전략이익율 등록 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.strategyProfitDAO.selectList", mapParam);
	}

	/**
	 * 전략이익율 등록(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.strategyProfitDAO.insert", mapParam);
	}
	public int insert2(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.strategyProfitDAO.insert2", mapParam);
	}
	public int insertClass(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.strategyProfitDAO.insertClass", mapParam);
	}
	
	/**
	 * 전략이익율 등록(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.strategyProfitDAO.update", mapParam);
	}
	
	/**
	 * 전략이익율 등록(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.strategyProfitDAO.delete", mapParam);
	}
	public int deleteClass(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.strategyProfitDAO.deleteClass", mapParam);
	}
	public int deleteItem(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.strategyProfitDAO.deleteItem", mapParam);
	}

	/**
	 * 전략이익률 자재 (을)를 일괄 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteAll(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.strategyProfitDAO.deleteAll", mapParam);
	}

	
}
