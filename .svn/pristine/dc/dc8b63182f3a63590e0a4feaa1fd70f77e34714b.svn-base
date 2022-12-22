package com.hwfs.sm.ssi.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 팀별 영업유형을 관리하는 SalesTypeofTm DAO
 * 
 * @ClassName SalesTypeofTmDAO.java
 * @Description SalesTypeofTmDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.02   	JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.04.02
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/ssi/salesTypeofTmDAO")
public class SalesTypeofTmDAO extends DefaultDAO {
	
	/**
	 * 팀별 영업유형 관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.ssi.salesTypeofTmDAO.selectList", mapParam);
	}

	/**
	 * 팀별 영업유형 중복체크
	 */
	public int selectExists(Map<String, Object> parameter) {
		return super.queryForInt("sm.ssi.salesTypeofTmDAO.selectExists", parameter);
	}
	
	/**
	 * 팀별 영업유형 관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.ssi.salesTypeofTmDAO.insert", mapParam);
	}
	
	/**
	 * 팀별 영업유형 관리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.ssi.salesTypeofTmDAO.update", mapParam);
	}
	
	/**
	 * 팀별 영업유형 관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.ssi.salesTypeofTmDAO.delete", mapParam);
	}
	
}
