package com.hwfs.fs.fsa.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 개인정보를 파기하는 AdoptionDelList DAO
 * 
 * @ClassName AdoptionDelListDAO.java
 * @Description AdoptionDelListDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.27   	김예진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.04.27
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsa/adoptionDelListDAO")
public class AdoptionDelListDAO extends DefaultDAO {
	
	/**
	 * 개인정보 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDelList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsa.adoptionDelListDAO.selectDelList", mapParam);
	}
	public RecordSet selectBrkdList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsa.adoptionDelListDAO.selectBrkdList", mapParam);
	}

	/**
	 * 개인정보(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsa.adoptionDelListDAO.delete", mapParam);
	}
	
}
