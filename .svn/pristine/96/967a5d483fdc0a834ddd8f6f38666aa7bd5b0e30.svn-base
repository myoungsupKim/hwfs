package com.hwfs.rc.rrm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 표준레시피 상세를 관리하는 StandardRecipeDetailedMgnt DAO
 * 
 * @ClassName StandardRecipeDetailedMgntDAO.java
 * @Description StandardRecipeDetailedMgntDAO Class
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
@Repository("/rc/rrm/standardRecipeDetailedMgntDAO")
public class StandardRecipeDetailedMgntDAO extends DefaultDAO {

	/**
	 * 표준레시피 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.standardRecipeDetailedMgntDAO.selectList", mapParam);
	}

	/**
	 * 표준레시피 상세 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDtlList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.standardRecipeDetailedMgntDAO.selectDtlList", mapParam);
	}

	/**
	 * 표준레시피 상세(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeDetailedMgntDAO.insert", mapParam);
	}
	
	/**
	 * 표준레시피 상세(을)를 STD_SEQ를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int selectSeq(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("rc.rrm.standardRecipeDetailedMgntDAO.selectSeq", mapParam);
	}
	
	
	/**
	 * 표준레시피 상세(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeDetailedMgntDAO.update", mapParam);
	}
	
	/**
	 * 표준레시피 상세(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeDetailedMgntDAO.delete", mapParam);
	}
	
	/**
	 * 업장 레시피 상세(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteUpjangDetail(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeDetailedMgntDAO.deleteUpjangDetail", mapParam);
	}
	
	/**
	 * 표준레시피 상세 중복확인을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int selectExists(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("rc.rrm.standardRecipeDetailedMgntDAO.selectExists", mapParam);
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
		return super.update("rc.rrm.standardRecipeDetailedMgntDAO.updateEdate", mapParam);
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
		return super.update("rc.rrm.standardRecipeDetailedMgntDAO.updateEdatePrvsMaterial", mapParam);
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
		return super.update("rc.rrm.standardRecipeDetailedMgntDAO.updateSdate", mapParam);
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
		return super.update("rc.rrm.standardRecipeDetailedMgntDAO.updateMaterialCd", mapParam);
	}
	
	/**
	 * 복사되어 있는 레시피 조리법의 업장코드 목록 검색한다.
	 * 
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectListUpjangCd(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.standardRecipeDetailedMgntDAO.selectListUpjangCd", mapParam);
	}
	
	/**
	 * 표준레시피 상세 등록시 업장 레시피 상세에 일괄 등록한다.
	 * - 업장수정허용여부가 'N'인것만 등록
	 * @param mapParam
	 * @return
	 */
	public int insertUpjangRecipeDetail(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeDetailedMgntDAO.insertUpjangRecipeDetail", mapParam);
	}
	
	/**
	 * 표준레시피 상세 수정시 업장 레시피 상세를 일괄 수정한다.
	 * - 업장수정허용여부가 'N'인것만 수정
	 * @param mapParam
	 * @return
	 */
	public int updateUpjangRecipeDetail(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeDetailedMgntDAO.updateUpjangRecipeDetail", mapParam);
	}
	
	/**
	 * 
	 * 레서피 상세 추가시 재료순번 구하기
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int selectRecipeDtlSortOrder(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("rc.rrm.standardRecipeDetailedMgntDAO.selectRecipeDtlSortOrder", mapParam);
	}
	
	/**
	 * 
	 * 레서피 상세 추가시 재료순번 구하기
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int saveRecipeMstCnt(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeDetailedMgntDAO.saveRecipeMstCnt", mapParam);
	}
	
	/**
	 * 
	 * 레서피 상세 중복 체크
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int selectPkCnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("rc.rrm.standardRecipeDetailedMgntDAO.selectPkCnt", mapParam);
	}
	
	/**
	 * 
	 * 이미지 업로드시 레시피 MST에 업데이트.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int updateMst(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeDetailedMgntDAO.updateMst", mapParam);
	}

	/**
	 * 
	 * 이미지 업로드시 레시피 MST에 업데이트.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int updateUpjang(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeDetailedMgntDAO.updateUpjang", mapParam);
	}

	/**
	 * 반찬세트류 저장
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int setRecipeUpdateMst(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeDetailedMgntDAO.setRecipeUpdateMst", mapParam);
	}

	/**
	 * 업장 반찬세트류 저장
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int setRecipeUpdateUpjang(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeDetailedMgntDAO.setRecipeUpdateUpjang", mapParam);
	}

	/**
	 * 반찬세트류 삭제
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int setRecipeDelMst(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeDetailedMgntDAO.setRecipeDelMst", mapParam);
	}

	/**
	 * 업장 반찬세트류 삭제
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int setRecipeDelUpjang(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeDetailedMgntDAO.setRecipeDelUpjang", mapParam);
	}

	/**
	 * 대상 레시피를 사용중인 업장 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectUpjangList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rrm.standardRecipeDetailedMgntDAO.selectUpjangList", mapParam);
	}

	/**
	 * 업장레시피 상세를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int deleteUpjangRecipeDtl(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeDetailedMgntDAO.deleteUpjangRecipeDtl", mapParam);
		
	}

	/**
	 * 업장레시피 상세를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int insertUpjangRecipeDtl(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeDetailedMgntDAO.insertUpjangRecipeDtl", mapParam);
		
	}

	/**
	 * 조리법 삭제
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int deleteStdRecipeCuisine(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeDetailedMgntDAO.deleteStdRecipeCuisine", mapParam);
		
	}

	/**
	 * 복사된 레시피 원본 레시피의 조리법을 저장한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int saveStdRecipeCuisine(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeDetailedMgntDAO.saveStdRecipeCuisine", mapParam);
		
	}

	/**
	 * 복사된 레시피 원본 레시피의 사진을 저장한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int saveStdRecipePic(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rrm.standardRecipeDetailedMgntDAO.saveStdRecipePic", mapParam);
	}
}
