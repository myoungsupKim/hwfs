package com.hwfs.sc.scc.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 전송 Parameter에 대한 로그를 기록하는 ParameterLog DAO
 * 
 * @ClassName ParameterLogDAO.java
 * @Description ParameterLogDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.09.16   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.09.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scc/parameterLogDAO")
public class ParameterLogDAO extends DefaultDAO {
	
	/**
	 * 전송 Parameter에 대한 로그 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scc.parameterLogDAO.selectList", mapParam);
	}

	/**
	 * 전송 Parameter에 대한 로그(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scc.parameterLogDAO.insert", mapParam);
	}
	
	/**
	 * 전송 Parameter에 대한 로그(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scc.parameterLogDAO.update", mapParam);
	}
	
	/**
	 * 전송 Parameter에 대한 로그(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scc.parameterLogDAO.delete", mapParam);
	}
	
}
