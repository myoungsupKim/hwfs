package com.hwfs.sm.ssi.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 카드처리 유형을 관리하는 CardProcTypeMgnt DAO
 * 
 * @ClassName CardProcTypeMgntDAO.java
 * @Description CardProcTypeMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.24   	김예진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.03.24
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/ssi/cardProcTypeMgntDAO")
public class CardProcTypeMgntDAO extends DefaultDAO {
	
	/**
	 * 카드처리 유형 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList() throws Exception {
		return super.queryForRecordSet("sm.ssi.cardProcTypeMgntDAO.selectList", "");
	}

	/**
	 * 카드처리 유형(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.ssi.cardProcTypeMgntDAO.insert", mapParam);
	}
	
	/**
	 * 카드처리 유형(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.ssi.cardProcTypeMgntDAO.update", mapParam);
	}
	
	/**
	 * 카드처리 유형(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.ssi.cardProcTypeMgntDAO.delete", mapParam);
	}
	
}
