package com.hwfs.sm.ssi.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 카드 반송사유 코드를 관리하는 CardBackReasonCd DAO
 * 
 * @ClassName CardBackReasonCdDAO.java
 * @Description CardBackReasonCdDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.30   	Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.04.30
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/ssi/cardBackReasonCdDAO")
public class CardBackReasonCdDAO extends DefaultDAO {
	
	/**
	 * 카드 반송사유 코드 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.ssi.cardBackReasonCdDAO.selectList", mapParam);
	}
	
	/**
	 * 카드 반송사유 코드 중복체크를 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int selectExists(Map<String, Object> mapParam) throws Exception{
		return super.queryForInt("sm.ssi.cardBackReasonCdDAO.selectExists", mapParam);
	}

	/**
	 * 카드 반송사유 코드(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.ssi.cardBackReasonCdDAO.insert", mapParam);
	}
	
	/**
	 * 카드 반송사유 코드(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.ssi.cardBackReasonCdDAO.update", mapParam);
	}
	
	/**
	 * 카드 반송사유 코드(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.ssi.cardBackReasonCdDAO.delete", mapParam);
	}
	
}
