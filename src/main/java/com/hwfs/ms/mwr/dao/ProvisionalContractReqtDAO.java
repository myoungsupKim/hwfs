package com.hwfs.ms.mwr.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 가계약(연회/웨딩)등록하는 ProvisionalContractReqt DAO
 * 
 * @ClassName ProvisionalContractReqtDAO.java
 * @Description ProvisionalContractReqtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.17   	강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 현장지원_모바일 강대성
 * @since 2015.04.17
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ms/mwr/provisionalContractReqtDAO")
public class ProvisionalContractReqtDAO extends DefaultDAO {
	
	/**
	 * 가계약(연회/웨딩)등록 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mwr.provisionalContractReqtDAO.selectList", mapParam);
	}
	
	/**
	 * 예약번호 채번 YYYYMMXXXXX(11자리: 년월(6)+일련번호(5))
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectReservNum(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mwr.provisionalContractReqtDAO.selectReservNum", mapParam);
	}	

	/**
	 * 가계약(연회/웨딩)내용을 마스터 테이블에 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertMst(Map<String, Object> mapParam) throws Exception {
		return super.update("ms.mwr.provisionalContractReqtDAO.insertMst", mapParam);
	}
	
	/**
	 * 예약번호, 행사구분(연회:1, 웨딩:2, 케이터링:3)내용을 BMS_FUNCTION 테이블에 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertBmsFunction(Map<String, Object> mapParam) throws Exception {
		return super.update("ms.mwr.provisionalContractReqtDAO.insertBmsFunction", mapParam);
	}		
	
}
