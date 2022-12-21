package com.hwfs.rc.rrm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 가상레시피 상세를 관리하는 SmlRecipeDetailedMgnt DAO
 *
 * @ClassName SmlRecipeDetailedMgntDAO.java
 * @Description SmlRecipeDetailedMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.03   	유인찬        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유인찬
 * @since 2015.04.03
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/rrm/smlRecipeDetailedMgntDAO")
public class SmlRecipeDetailedMgntDAO extends DefaultDAO
{
	/**
	 * 가상레시피 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception
	{
		return super.queryForRecordSet("rc.rrm.smlRecipeDetailedMgntDAO.selectList", mapParam);
	}

	/**
	 * 가상레시피 상세 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDtlList(Map<String, Object> mapParam) throws Exception
	{
		return super.queryForRecordSet("rc.rrm.smlRecipeDetailedMgntDAO.selectDtlList", mapParam);
	}

	/**
	 *
	 * 레서피 상세 중복 체크
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int selectPkCnt(Map<String, Object> mapParam) throws Exception
	{
		return super.queryForInt("rc.rrm.smlRecipeDetailedMgntDAO.selectPkCnt", mapParam);
	}


	/**
	 * 가상레시피 상세(을)를 STD_SEQ를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int selectSeq(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("rc.rrm.smlRecipeDetailedMgntDAO.selectSeq", mapParam);
	}

	/**
	 * 가상레시피 상세를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception
	{
		return super.update("rc.rrm.smlRecipeDetailedMgntDAO.insert", mapParam);
	}

	/**
	 * 표준레시피 상세 시작일자를 수정한다.
	 *  - 식자재코드를 제외한 그 외 컬럼 포함
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int updateSdate(Map<String, Object> mapParam) throws Exception
	{
		return super.update("rc.rrm.smlRecipeDetailedMgntDAO.updateSdate", mapParam);
	}

	/**
	 * 표준레시피 상세 종료일자를 수정한다.
	 * (이전 식자재코드가 있는 식자재의 시작일자를 변경했을 경우)
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int updateEdatePrvsMaterial(Map<String, Object> mapParam) throws Exception
	{
		return super.update("rc.rrm.smlRecipeDetailedMgntDAO.updateEdatePrvsMaterial", mapParam);
	}

	/**
	 * 표준레시피 상세 종료일자를 수정한다.
	 * (품목이 새로 등록이 될 경우)
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int updateEdate(Map<String, Object> mapParam) throws Exception
	{
		return super.update("rc.rrm.smlRecipeDetailedMgntDAO.updateEdate", mapParam);
	}

	/**
	 * 표준레시피 상세 식자재를 수정한다.
	 *  - 그 외 컬럼 포함
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int updateMaterialCd(Map<String, Object> mapParam) throws Exception
	{
		return super.update("rc.rrm.smlRecipeDetailedMgntDAO.updateMaterialCd", mapParam);
	}

	/**
	 * 표준레시피 상세(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception
	{
		return super.update("rc.rrm.smlRecipeDetailedMgntDAO.update", mapParam);
	}

	/**
	 * 표준레시피 상세(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception
	{
		return super.update("rc.rrm.smlRecipeDetailedMgntDAO.delete", mapParam);
	}

	/**
	 *
	 * 가상레시피 상세수를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int saveRecipeMstCnt(Map<String, Object> mapParam) throws Exception
	{
		return super.update("rc.rrm.smlRecipeDetailedMgntDAO.saveRecipeMstCnt", mapParam);
	}

	/**
	 * 조리법 삭제
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int deleteStdRecipeCuisine(Map<String, Object> mapParam) throws Exception
	{
		return super.update("rc.rrm.smlRecipeDetailedMgntDAO.deleteStdRecipeCuisine", mapParam);

	}

	/**
	 * 복사된 레시피 원본 레시피의 조리법을 저장한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int saveStdRecipeCuisine(Map<String, Object> mapParam) throws Exception
	{
		return super.update("rc.rrm.smlRecipeDetailedMgntDAO.saveStdRecipeCuisine", mapParam);

	}

	/**
	 * 복사된 레시피 원본 레시피의 사진을 저장한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int saveStdRecipePic(Map<String, Object> mapParam) throws Exception
	{
		return super.update("rc.rrm.smlRecipeDetailedMgntDAO.saveStdRecipePic", mapParam);
	}

	/**
	 *
	 * 이미지 업로드시 레시피 MST에 업데이트.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int updateMst(Map<String, Object> mapParam) throws Exception
	{
		return super.update("rc.rrm.smlRecipeDetailedMgntDAO.updateMst", mapParam);
	}

	/**
	 * 반찬세트류 저장
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int setRecipeUpdateMst(Map<String, Object> mapParam) throws Exception
	{
		return super.update("rc.rrm.smlRecipeDetailedMgntDAO.setRecipeUpdateMst", mapParam);
	}

	/**
	 * 반찬세트류 삭제
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int setRecipeDelMst(Map<String, Object> mapParam) throws Exception
	{
		return super.update("rc.rrm.smlRecipeDetailedMgntDAO.setRecipeDelMst", mapParam);
	}

	/**
	 * 가상레시피 여부를 체크한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet smlRecipeYn(Map<String, Object> mapParam) throws Exception
	{
		return super.queryForRecordSet("rc.rrm.smlRecipeDetailedMgntDAO.smlRecipeYn", mapParam);
	}
}