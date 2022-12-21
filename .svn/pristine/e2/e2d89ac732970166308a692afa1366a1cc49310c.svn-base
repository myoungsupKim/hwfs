package com.hwfs.fm.fmf.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 매입매출집계하는 BuySaleSum DAO
 * 
 * @ClassName BuySaleSumDAO.java
 * @Description BuySaleSumDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.18   	손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.06.18
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmf/buySaleSumDAO")
public class BuySaleSumDAO extends DefaultDAO {
	
	/**
	 * 매입매출집계 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.buySaleSumDAO.selectListTab"+mapParam.get("tabIndex"), mapParam);
	}

	/**
	 * 매입매출집계(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmf.buySaleSumDAO.insert", mapParam);
	}
	
	/**
	 * 매입매출집계(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmf.buySaleSumDAO.update", mapParam);
	}
	
	/**
	 * 매입매출집계(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmf.buySaleSumDAO.delete", mapParam);
	}
	
// [속도개선 Project 시작] 2017. 8. 24. 최범주 매출집계정보조회 기능 추가
	/**
	 * 매출집계정보 조회
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSaleTtzInfo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.buySaleSumDAO.selectSaleTtzInfo", mapParam);
	}
// [속도개선 Project   끝] 2017. 8. 24. 최범주
}
