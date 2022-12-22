package com.hwfs.rc.rrm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 업장 레시피 상세를 관리하는 RecipeDetailedMgnt DAO
 * 
 * @ClassName RecipeDetailedMgntDAO.java
 * @Description RecipeDetailedMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.10   	Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.04.10
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/rrm/recipeDetailedMgntDAO")
public class RecipeDetailedMgntDAO extends DefaultDAO {
	
	/**
	 * 업장 레시피 상세 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.recipeDetailedMgntDAO.selectList", mapParam);
	}

	/**
	 * 업장 레시피 상세 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectListDtl(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.recipeDetailedMgntDAO.selectListDtl", mapParam);
	}

	/**
	 * 업장 레시피 상세(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeDetailedMgntDAO.insert", mapParam);
	}
	
	/**
	 * 업장 레시피 상세(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeDetailedMgntDAO.update", mapParam);
	}
	
	/**
	 * 업장 레시피 상세(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeDetailedMgntDAO.delete", mapParam);
	}
	
	/**
	 * 표준레시피 상세 종료일자를 수정한다.
	 * (품목이 새로 등록이 될 경우)
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int updateEdate(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeDetailedMgntDAO.updateEdate", mapParam);
	}
	
	/**
	 * 표준레시피 상세 종료일자를 수정한다.
	 * (이전 식자재코드가 있는 식자재의 시작일자를 변경했을 경우)
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int updateEdatePrvsMaterial(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeDetailedMgntDAO.updateEdatePrvsMaterial", mapParam);
	}
	
	/**
	 * 표준레시피 상세 시작일자를 수정한다.
	 *  - 식자재코드를 제외한 그 외 컬럼 포함
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int updateSdate(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeDetailedMgntDAO.updateSdate", mapParam);
	}
	
	/**
	 * 표준레시피 상세 식자재를 수정한다.
	 *  - 그 외 컬럼 포함
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int updateMaterialCd(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeDetailedMgntDAO.updateMaterialCd", mapParam);
	}
	
	
	/**
	 * 업장레시피 마스터에 반찬세트 를 업데이트 한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int updateMst(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeDetailedMgntDAO.updateMst", mapParam);
	}
	
	/**
	 * 업장레시피 상세에 반찬세트를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int setRecipeDelMst(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeDetailedMgntDAO.setRecipeDelMst", mapParam);
	}
	
	/**
	 * 업장레시피 상세에 반찬세트를 등록 한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int setRecipeUpdateMst(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.recipeDetailedMgntDAO.setRecipeUpdateMst", mapParam);
	}
	
	/**
	 * 반찬세트목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectRsr(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.recipeDetailedMgntDAO.selectRsr", mapParam);
	}
}
