package com.hwfs.ma.mas.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 전체 예산을 조회하는 SuspenseAlt DAO
 * 
 * @ClassName SuspenseAltDAO.java
 * @Description SuspenseAltDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.09.21   	박준석        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 박준석
 * @since 2015.09.21
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ma/mas/suspenseAltDAO")
public class SuspenseAltDAO extends DefaultDAO {
	
	/**
	 * 전체 예산조회 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ma.mas.suspenseAltDAO.selectList", mapParam);
	}

	/**
	 * 전체 예산조회(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("ma.mas.suspenseAltDAO.insert", mapParam);
	}
	
	/**
	 * 전체 예산조회(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("ma.mas.suspenseAltDAO.update", mapParam);
	}
	
	/**
	 * 전체 예산조회(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("ma.mas.suspenseAltDAO.delete", mapParam);
	}
	
}
