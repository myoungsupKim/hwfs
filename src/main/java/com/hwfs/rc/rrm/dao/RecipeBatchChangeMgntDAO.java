package com.hwfs.rc.rrm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 업장 레시피 자재 일괄 변경 이력을 관리하는 RecipeBatchChangeMgnt DAO
 * 
 * @ClassName RecipeBatchChangeMgntDAO.java
 * @Description RecipeBatchChangeMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016.07.11    백승현        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 백승현
 * @since 2016.07.11
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */

@Repository("/rc/rrm/recipeBatchChangeMgntDAO")
public class RecipeBatchChangeMgntDAO extends DefaultDAO
{
	/**
	 * 업장 레시피 자재 일괄 변경 이력을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception
	{
		return super.queryForRecordSet("rc.rrm.recipeBatchChangeMgntDAO.selectList", mapParam);
	}

	/**
	 * 업장 레시피 자재 일괄 변경 상세이력을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectDetailList(Map<String, Object> mapParam) throws Exception
	{
		return super.queryForRecordSet("rc.rrm.recipeBatchChangeMgntDAO.selectDetailList", mapParam);
	}

	/**
	 * 업장 레시피 품목 일괄 변경 요청을 승인처리한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception
	{
		return super.update("rc.rrm.recipeBatchChangeMgntDAO.insert", mapParam);
	}
	
	/**
	 * 업장 레시피 내 변경 후 자재 삭제
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteUpjang(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeBatchChangeMgntDAO.deleteUpjang", mapParam);
	}
	

	/**
	 * 변경된 기투입자재를 수정한다.(종료일자를 변경후자재의 시작일자 -1 일자로 변경)
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateEdate(Map<String, Object> mapParam) throws Exception
	{
		return super.update("rc.rrm.recipeBatchChangeMgntDAO.updateEdate", mapParam);
	}

	/**
	 * 일괄 변경된 품목들의 진행상황을 변경한다.(신규요청 -> 처리완료, 신규요청 -> 미적용)
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateStatus(Map<String, Object> mapParam) throws Exception
	{
		return super.update("rc.rrm.recipeBatchChangeMgntDAO.updateStatus", mapParam);
	}
}