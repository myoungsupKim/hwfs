package com.hwfs.sm.ssi.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 카드사를 관리하는 CardComMgnt DAO
 * 
 * @ClassName CardComMgntDAO.java
 * @Description CardComMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.20   	Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.05.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/ssi/cardComMgntDAO")
public class CardComMgntDAO extends DefaultDAO {
	
	/**
	 * 카드사 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.ssi.cardComMgntDAO.selectList", mapParam);
	}
	
	/**
	 * 카드사 중복체크를 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int selectExists(Map<String, Object> mapParam) throws Exception{
		return super.queryForInt("sm.ssi.cardComMgntDAO.selectExists", mapParam);
	}

	/**
	 * 카드사(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.ssi.cardComMgntDAO.insert", mapParam);
	}
	
	/**
	 * 카드사(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.ssi.cardComMgntDAO.update", mapParam);
	}
	
	/**
	 * 카드사(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.ssi.cardComMgntDAO.delete", mapParam);
	}
	
}
