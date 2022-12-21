package com.hwfs.rc.rrm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 가상레시피 등록 현황을 관리하는 SmlRecipeMgnt DAO
 *
 * @ClassName SmlRecipeMgntDAO.java
 * @Description SmlRecipeMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016.08.26    백승현        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 백승현
 * @since 2016.08.26
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */

@Repository("/rc/rrm/smlRecipeMgntDAO")
public class SmlRecipeMgntDAO extends DefaultDAO
{
	/**
	 * 가상레시피 등록 현황을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception
	{
		return super.queryForRecordSet("rc.rrm.smlRecipeMgntDAO.selectList", mapParam);
	}

	/**
	 * 가상레시피를 표준레시피로 등록 요청한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateRequest(Map<String, Object> mapParam) throws Exception
	{
		return super.update("rc.rrm.smlRecipeMgntDAO.insert", mapParam);
	}

	/**
	 * 표준레시피 등록 요청을 승인 또는 취소 처리한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateStatus(Map<String, Object> mapParam) throws Exception
	{
		return super.update("rc.rrm.smlRecipeMgntDAO.updateStatus", mapParam);
	}

	/**
	 * 가상레시피를 표준레시피로 변경한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateStdRecipe(Map<String, Object> mapParam) throws Exception
	{
		return super.update("rc.rrm.smlRecipeMgntDAO.updateStdRecipe", mapParam);
	}
}