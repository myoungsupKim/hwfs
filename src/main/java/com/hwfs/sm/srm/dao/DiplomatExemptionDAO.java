package com.hwfs.sm.srm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 외교관 면세정보를 관리하는 DiplomatExemption DAO
 * 
 * @ClassName DiplomatExemptionDAO.java
 * @Description DiplomatExemptionDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.08   	Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.05.08
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/srm/diplomatExemptionDAO")
public class DiplomatExemptionDAO extends DefaultDAO {
	
	/**
	 * 외교관 면세정보 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.diplomatExemptionDAO.selectList", mapParam);
	}

	/**
	 * 외교관 면세정보(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.diplomatExemptionDAO.insert", mapParam);
	}
	
	/**
	 * 외교관 면세정보(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.diplomatExemptionDAO.update", mapParam);
	}
	
	/**
	 * 외교관 면세정보(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.diplomatExemptionDAO.delete", mapParam);
	}
	
}
