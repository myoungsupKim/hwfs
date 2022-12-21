package com.hwfs.sm.sar.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 카드 입금 일정표하는 CardReceiveCalendarMgnt DAO
 * 
 * @ClassName CardReceiveCalendarMgntDAO.java
 * @Description CardReceiveCalendarMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.14   	김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.04.14
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/sar/cardReceiveCalendarMgntDAO")
public class CardReceiveCalendarMgntDAO extends DefaultDAO {
	
	/**
	 * 카드 입금 일정표 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.cardReceiveCalendarMgntDAO.selectList", mapParam);
	}

	/**
	 * 카드 입금 일정표(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.cardReceiveCalendarMgntDAO.insert", mapParam);
	}
	
	/**
	 * 카드 입금 일정표(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.cardReceiveCalendarMgntDAO.update", mapParam);
	}
	
	/**
	 * 카드 입금 일정표(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.cardReceiveCalendarMgntDAO.delete", mapParam);
	}
	
}
