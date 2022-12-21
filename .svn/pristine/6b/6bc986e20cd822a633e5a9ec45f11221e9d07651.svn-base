package com.hwfs.sc.scc.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 개발 긴급 공지하는 DvlpUrgent DAO
 *
 * @ClassName DvlpUrgentDAO.java
 * @Description DvlpUrgentDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.18   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.03.18
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scc/dvlpUrgentDAO")
public class DvlpUrgentDAO extends DefaultDAO {

	/**
	 * 개발 긴급 공지 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scc.dvlpUrgentDAO.selectList", mapParam);
	}

	/**
	 * 개발 긴급 공지(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scc.dvlpUrgentDAO.insert", mapParam);
	}

	/**
	 * 개발 긴급 공지(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scc.dvlpUrgentDAO.update", mapParam);
	}

	/**
	 * 개발 긴급 공지(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scc.dvlpUrgentDAO.delete", mapParam);
	}

	public Object selectRead(Map<String, Object> mapParam) throws Exception {
		return super.queryForObject("sc.scc.dvlpUrgentDAO.selectRead", mapParam, String.class);
	}

	/**
	 * 개발 긴급 공지(을)를 읽기여부를 저장한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertRead(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scc.dvlpUrgentDAO.insertRead", mapParam);
	}
}
