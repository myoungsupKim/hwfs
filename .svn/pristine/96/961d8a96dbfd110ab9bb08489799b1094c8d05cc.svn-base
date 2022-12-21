package com.hwfs.sm.sar.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 후불 결제 내역 관리하는 ArSettleDescMgnt DAO
 * 
 * @ClassName ArSettleDescMgntDAO.java
 * @Description ArSettleDescMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.01   	유성진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유성진
 * @since 2015.07.01
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/sar/arSettleDescMgntDAO")
public class ArSettleDescMgntDAO extends DefaultDAO {
	
	/**
	 * 후불 결제 내역 관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.arSettleDescMgntDAO.selectList", mapParam);
	}
	
	/**
	 * 후불 결제 내역 상세내역을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDetail(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.arSettleDescMgntDAO.selectDetail", mapParam);
	}

	/**
	 * 후불 결제 내역 관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.arSettleDescMgntDAO.insert", mapParam);
	}
	
	/**
	 * 후불 결제 내역 관리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.arSettleDescMgntDAO.update", mapParam);
	}
	
	/**
	 * 후불 결제 내역 관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.arSettleDescMgntDAO.delete", mapParam);
	}
	
}
