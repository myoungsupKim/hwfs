package com.hwfs.rc.rrm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 업장 레시피 코드를 관리하는 RecipeMasterMgnt DAO
 * 
 * @ClassName RecipeMasterMgntDAO.java
 * @Description RecipeMasterMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.09   	Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.04.09
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/rrm/recipeMasterMgntDAO")
public class RecipeMasterMgntDAO extends DefaultDAO {
	
	/**
	 * 업장 레시피 코드 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.recipeMasterMgntDAO.selectList", mapParam);
	}

	/**
	 * 업장 레시피 코드(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeMasterMgntDAO.insert", mapParam);
	}
	
	/**
	 * 업장 레시피 코드(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeMasterMgntDAO.update", mapParam);
	}
	
	/**
	 * 업장 레시피 코드(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteMst(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeMasterMgntDAO.deleteMst", mapParam);
	}
	
	/**
	 * 업장 레시피 코드(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteDetail(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeMasterMgntDAO.deleteDetail", mapParam);
	}
	
}
