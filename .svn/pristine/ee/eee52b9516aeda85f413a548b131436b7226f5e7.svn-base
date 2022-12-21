package com.hwfs.fm.fmp.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 운영율 업장별 업데이트하는 UpjangOpRateUpdate DAO
 * 
 * @ClassName UpjangOpRateUpdateDAO.java
 * @Description UpjangOpRateUpdateDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.11.06   	강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재영업 강대성
 * @since 2015.11.06
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmp/upjangOpRateUpdateDAO")
public class UpjangOpRateUpdateDAO extends DefaultDAO {
	
	/**
	 * 운영율 업장별 업데이트 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmp.upjangOpRateUpdateDAO.selectList", mapParam);
	}
	
	/**
	 * 운영율 업장별 업데이트(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateFcSoPr(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmp.upjangOpRateUpdateDAO.updateFcSoPr", mapParam);
	}
	
	/**
	 * 운영율 업장별 업데이트(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateESPPODTSAL(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmp.upjangOpRateUpdateDAO.updateESPPODTSAL", mapParam);
	}
	
	/**
	 * 운영율 업장별 업데이트(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateESISALP(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmp.upjangOpRateUpdateDAO.updateESISALP", mapParam);
	}
	
	/**
	 * 운영율 변경시 변경자, 변경시간 및 변경기간 데이터를 기록 및 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateOprateModifyHis(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmp.upjangOpRateUpdateDAO.updateOprateModifyHis", mapParam);
	}
	
	
	
}
