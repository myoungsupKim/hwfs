package com.hwfs.batch.sm.sar.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * EAI호출관려 배치 SarSuspenseSapSendDAO DAO
 * 
 * @ClassName SarSuspenseSapSendDAO.java
 * @Description SarSuspenseSapSendDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016.01.18   	강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : EAI호출 배치 강대성
 * @since 2016.01.18
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/batch/sm/sar/sarSuspenseSapSendDAO")
public class SarSuspenseSapSendDAO extends DefaultDAO {
	
	/**
	 * SAP전송시 필요한 값 추출
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectListSapSuspenseAltDetail(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("batch.sm.sar.sarSuspenseSapSendDAO.selectListSapSuspenseAltDetail", mapParam);
	}	
	
	/**
	 * 정상적으로  EAI호출시 가수금 대체 정보테이블에 업데이트 처리
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateSapSuspenseAltDetail(Map<String, Object> mapParam) throws Exception {
		return super.update("batch.sm.sar.sarSuspenseSapSendDAO.updateSapSuspenseAltDetail", mapParam);
	}	
	
}
