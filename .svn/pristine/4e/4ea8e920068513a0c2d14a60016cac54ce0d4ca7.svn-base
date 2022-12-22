package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 전략이익률 자재를 등록 하는 StrategyGainRateItemReg DAO
 * 
 * @ClassName StrategyGainRateItemRegDAO.java
 * @Description StrategyGainRateItemRegDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.15   	최성연        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.05.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fms/strategyGainRateItemRegDAO")
public class StrategyGainRateItemRegDAO extends DefaultDAO {
	
	/**
	 * 전략이익률 자재  목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.strategyGainRateItemRegDAO.selectList", mapParam);
	}
	public RecordSet selectDate(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.strategyGainRateItemRegDAO.selectDate", mapParam);
	}
	public RecordSet upjangList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.strategyGainRateItemRegDAO.upjangList", mapParam);
	}

	/**
	 * 전략이익율 자재정보 여부를 체크한다.
	 * 중복자재 CHECK 용도, INSERT, UPDATE 처리
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 건수
	 * @exception Exception
	 */
	public int selectItemCnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("fm.fms.strategyGainRateItemRegDAO.selectItemCnt", mapParam);
	}
	
	
	
	/**
	 * 전략이익률 자재 (을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.strategyGainRateItemRegDAO.insert", mapParam);
	}
	public int insert2(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.strategyGainRateItemRegDAO.insert2", mapParam);
	}
	
	/**
	 * 전략이익률 자재 (을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.strategyGainRateItemRegDAO.update", mapParam);
	}
	public int updateMig(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.strategyGainRateItemRegDAO.updateMig", mapParam);
	}
	
	/**
	 * 전략이익률 자재 (을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.strategyGainRateItemRegDAO.delete", mapParam);
	}

	/**
	 * 전략이익률 자재 (을)를 일괄 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteAll(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.strategyGainRateItemRegDAO.deleteAll", mapParam);
	}
	
	
}
