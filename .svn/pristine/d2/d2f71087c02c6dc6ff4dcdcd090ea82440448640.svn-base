package com.hwfs.rc.rrm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 표준레시피 코드를 관리하는 SmlRecipeMasterMgnt DAO
 *
 * @ClassName SmlRecipeMasterMgntDAO.java
 * @Description SmlRecipeMasterMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.30   	유인찬        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유인찬
 * @since 2015.03.30
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/rrm/smlRecipeMasterMgntDAO")
public class SmlRecipeMasterMgntDAO extends DefaultDAO
{
	/**
	 * 가상레시피 코드 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception
	{
		return super.queryForRecordSet("rc.rrm.smlRecipeMasterMgntDAO.selectList", mapParam);
	}

	/**
	 * 가상레시피 코드 max+1 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public Object selectMaxStdRecipeCd(Map<String, Object> mapParam) throws Exception
	{
		return super.queryForObject("rc.rrm.smlRecipeMasterMgntDAO.selectMaxStdRecipeCd", mapParam, null);
	}

	/**
	 * 가상레시피 코드를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception
	{
		return super.update("rc.rrm.smlRecipeMasterMgntDAO.insert", mapParam);
	}

	/**
	 * 가상레시피 코드를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertMgmt(Map<String, Object> mapParam) throws Exception
	{
		return super.update("rc.rrm.smlRecipeMasterMgntDAO.insertMgmt", mapParam);
	}

	/**
	 * 가상레시피 코드를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception
	{
		return super.update("rc.rrm.smlRecipeMasterMgntDAO.update", mapParam);
	}

	/**
	 * 가상레시피 관리코드를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteMgmt(Map<String, Object> mapParam) throws Exception
	{
		return super.update("rc.rrm.smlRecipeMasterMgntDAO.deleteMgmt", mapParam);
	}

	/**
	 * 가상레시피 코드를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteMst(Map<String, Object> mapParam) throws Exception
	{
		return super.update("rc.rrm.smlRecipeMasterMgntDAO.deleteMst", mapParam);
	}

	/**
	 * 가상레시피 상세를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteDetail(Map<String, Object> mapParam) throws Exception
	{
		return super.update("rc.rrm.smlRecipeMasterMgntDAO.deleteDetail", mapParam);
	}

	/**
	 * 가상레시피 조리법을 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteCuisine(Map<String, Object> mapParam) throws Exception
	{
		return super.update("rc.rrm.smlRecipeMasterMgntDAO.deleteCuisine", mapParam);
	}

	/**
	 * 반찬 세트류 Combo 데이터 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectRsr(Map<String, Object> mapParam) throws Exception
	{
		return super.queryForRecordSet("rc.rrm.smlRecipeMasterMgntDAO.selectRsr", mapParam);
	}

	/**
	 * 가상레시피 여부를 체크한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet smlRecipeYn(Map<String, Object> mapParam) throws Exception
	{
		return super.queryForRecordSet("rc.rrm.smlRecipeMasterMgntDAO.smlRecipeYn", mapParam);
	}
}