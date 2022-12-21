package com.hwfs.guide.sample.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 오류 발생을 테스트하는 TestError DAO
 * 
 * @ClassName TestErrorDAO.java
 * @Description TestErrorDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.10.16   	kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.10.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/guide/sample/testErrorDAO")
public class TestErrorDAO extends DefaultDAO {
	
	/**
	 * 오류 발생 테스트
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet raiseHoneErr1(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("guide.sample.testErrorDAO.raiseHoneErr1", mapParam);
	}

	/**
	 * 오류 발생 테스트
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet raiseHoneErr2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("guide.sample.testErrorDAO.raiseHoneErr2", mapParam);
	}

}
