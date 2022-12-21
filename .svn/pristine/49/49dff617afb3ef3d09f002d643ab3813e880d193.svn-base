package com.hwfs.rc.rrm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 업장 레시피 품목을 일괄 변경하는 RecipeBatchChange DAO
 * 
 * @ClassName RecipeBatchChangeDAO.java
 * @Description RecipeBatchChangeDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.21   	Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.04.21
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/rrm/recipeBatchChangeDAO")
public class RecipeBatchChangeDAO extends DefaultDAO {
	
	/**
	 * 업장 레시피 품목 일괄 변경 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.recipeBatchChangeDAO.selectList", mapParam);
	}

	/**
	 * 업장 레시피 자재 일괄 변경요청을 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeBatchChangeDAO.insert", mapParam);
	}
	
	/**
	 * 업장 레시피 자재 일괄 변경(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int saveNewItem(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeBatchChangeDAO.saveNewItem", mapParam);
	}
	
	/**
	 * 업장 레시피 내 변경 후 자재 삭제
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteUpjang(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeBatchChangeDAO.deleteUpjang", mapParam);
	}
		
	/**
	 * 변경된 기투입자재를 수정한다.(종료일자를 변경후자재의 시작일자 -1 일자로 변경)
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateOldItem(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeBatchChangeDAO.updateOldItem", mapParam);
	}

	/**
	 * 업장 레시피 자재 일괄 변경 이력을 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int saveLog(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeBatchChangeDAO.saveLog", mapParam);
	}
}
