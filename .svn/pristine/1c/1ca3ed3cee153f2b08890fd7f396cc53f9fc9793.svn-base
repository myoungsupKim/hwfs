package com.hwfs.sc.scp.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 개인정보 환경설정을 관리하는 PersEnvConf DAO
 * 
 * @ClassName PersEnvConfDAO.java
 * @Description PersEnvConfDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.15   	kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.05.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scp/persEnvConfDAO")
public class PersEnvConfDAO extends DefaultDAO {
	
	/**
	 * 개인정보 환경설정 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scp.persEnvConfDAO.selectList", mapParam);
	}

	/**
	 * 개인정보 환경설정(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scp.persEnvConfDAO.insert", mapParam);
	}
	
	/**
	 * 개인정보 환경설정(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scp.persEnvConfDAO.update", mapParam);
	}
	
	/**
	 * 개인정보 환경설정(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sc.scp.persEnvConfDAO.delete", mapParam);
	}
	
	/**
	 * 개인정보 환경설정에 등록할 사번이 적합한 사번인지 체크한다.
	 *
	 * @param mapParam
	 * @return 0이면 부적합
	 */
	public int checkSabun(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("sc.scp.persEnvConfDAO.checkSabun", mapParam);
	}

}
