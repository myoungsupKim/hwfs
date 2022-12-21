package com.hwfs.guide.sample.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 김재섭이가 테스트를 위해서 개발하는 DevXpKimJaeSeob DAO
 * 
 * @ClassName DevXpKimJaeSeobDAO.java
 * @Description DevXpKimJaeSeobDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.19   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.06.19
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/guide/sample/devXpKimJaeSeobDAO")
public class DevXpKimJaeSeobDAO extends DefaultDAO {
	
	/**
	 * 김재섭이 테스트 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("guide.sample.devXpKimJaeSeobDAO.selectList", mapParam);
	}

	/**
	 * 김재섭이 테스트(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("guide.sample.devXpKimJaeSeobDAO.insert", mapParam);
	}
	
	/**
	 * 김재섭이 테스트(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("guide.sample.devXpKimJaeSeobDAO.update", mapParam);
	}
	
	/**
	 * 김재섭이 테스트(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("guide.sample.devXpKimJaeSeobDAO.delete", mapParam);
	}
	
}
