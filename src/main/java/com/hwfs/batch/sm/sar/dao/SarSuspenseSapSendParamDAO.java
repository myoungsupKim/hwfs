package com.hwfs.batch.sm.sar.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * EAI호출관려 배치 sarSuspenseSapSendParamDAO DAO
 * 
 * @ClassName SarSuspenseSapSendParamDAO.java
 * @Description SarSuspenseSapSendParamDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2021.05.13   	박소영        최초생성
 * </pre>
 * @author 박소영
 * @since 2021.05.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/sm/sar/sarSuspenseSapSendParamDAO")
public class SarSuspenseSapSendParamDAO extends DefaultDAO {
	
	/**
	 * SAP전송시 필요한 값 추출
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectListSapSuspenseAltDetail(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("batch.sm.sar.sarSuspenseSapSendParamDAO.selectListSapSuspenseAltDetail", mapParam);
	}	
	
	/**
	 * 정상적으로  EAI호출시 가수금 대체 정보테이블에 업데이트 처리
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateSapSuspenseAltDetail(Map<String, Object> mapParam) throws Exception {
		return super.update("batch.sm.sar.sarSuspenseSapSendParamDAO.updateSapSuspenseAltDetail", mapParam);
	}	
	
}
