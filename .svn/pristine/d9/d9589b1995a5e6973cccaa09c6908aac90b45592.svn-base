package com.hwfs.sc.app.dao;

import java.sql.Types;
import java.util.Map;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 식재앱 자동발주 인터페이스용  DAO 개체
 * @ClassName RecipeDAO.java
 * @Description  RecipeDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.07.21.  구승모        최초생성
 * </pre>
 * @author 푸디스트
 * @since 2022.07.21.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by 한화시스템ICT CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/app/recipeDAO")
public class RecipeDAO extends DefaultDAO {
	
	/**
	 * 테스트 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectTest(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.recipeDAO.selectTest", parameter);
	}

	/**
	 * 신규 레시피 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectNewRecipeInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.recipeDAO.selectNewRecipeInfo", parameter);
	}

	
	/**
	 * 중복 자재 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectDuplRecipeItem(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.recipeDAO.selectDuplRecipeItem", parameter);
	}
	
	
	
	/**
	 * 발주 레시피 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectPrRecipeInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.recipeDAO.selectPrRecipeInfo", parameter);
	}
	
	/**
	 * 대체자재 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectReplaceItemInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.recipeDAO.selectReplaceItemInfo", parameter);
	}

	/**
	 * 양념미곡 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectSpiceItemInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.recipeDAO.selectSpiceItemInfo", parameter);
	}
	
	
	/**
	 * 발주 삭제 레시피 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectPrDelRecipeInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.recipeDAO.selectPrDelRecipeInfo", parameter);
	}
	
	/**
	 * 신규주문번호채번
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectPrSeq(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.recipeDAO.selectPrSeq", parameter);
	}

	/**
	 * 신규주문상세번호채번
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectPrIdSeq(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.recipeDAO.selectPrIdSeq", parameter);
	}

	/**
	 * 신규주문삭제자재번호채번
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectPrMenuLogIdSeq(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.recipeDAO.selectPrMenuLogIdSeq", parameter);
	}	
	
	/**
	 * 주문저장
	 *
	 * @param parameter
	 * @return
	 */
	public int saveRecipeOrderInfo(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.recipeDAO.saveRecipeOrderInfo", parameter);
	}
	
	
	/**
	 * 식단정보 업데이트
	 *
	 * @param parameter
	 * @return
	 */
	public int updateRecipeItem(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.recipeDAO.updateRecipeItem", parameter);
	}
	
	/**
	 * 자재 수정시 삭제시 식단정보 업데이트
	 *
	 * @param parameter
	 * @return
	 */
	public int updateExistRecipeItem(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.recipeDAO.updateExistRecipeItem", parameter);
	}
	
	
	/**
	 * 자재 수량 및 비고 수정건 및 임시저장건
	 *
	 * @param parameter
	 * @return
	 */
	public int updateRecipeOrderInfo(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.recipeDAO.updateRecipeOrderInfo", parameter);
	}
	
	/**
	 * 자재가 삭제되었을경우 so_pr 상태변경
	 *
	 * @param parameter
	 * @return
	 */
	public int deleteRecipeOrderInfo(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.recipeDAO.deleteRecipeOrderInfo", parameter);
	}

	/**
	 * 기존 메뉴로그 정보 삭제
	 *
	 * @param parameter
	 * @return
	 */
	public int deleteRecipeMenuLog(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.recipeDAO.deleteRecipeMenuLog", parameter);
	}
	
	/**
	 * 주문삭제저장
	 *
	 * @param parameter
	 * @return
	 */
	public int saveRecipeMenuLog(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.recipeDAO.saveRecipeMenuLog", parameter);
	}
	
	/**
	 * 사유저장 (신규이면서 주문유형이 04가 아닌경우)
	 *
	 * @param parameter
	 * @return
	 */
	public int saveRecipeOrderReason(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.recipeDAO.saveRecipeOrderReason", parameter);
	}
	
	/**
	 * 신청서 수정중  결의 작업이 있었는지 점검
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectPreChk1(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.recipeDAO.selectPreChk1", parameter);
	}
	
	/**
	 * 신청서 수정중 수불마감 체크
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectPreChk2(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.recipeDAO.selectPreChk2", parameter);
	}

	/**
	 * 신청서 수정중 재고반영 체크
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectPreChk3(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.recipeDAO.selectPreChk3", parameter);
	}

	/**
	 * 신청서 수정중 배송중으로 변경 체크
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectPreChk4(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.recipeDAO.selectPreChk4", parameter);
	}
	
	/**
	 * 발주 유효성체크1 (유형별 D_DAY, D_TIME 가능한지 체크)
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectRecipeValidChk1(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.recipeDAO.selectRecipeValidChk1", parameter);
	}
	
	/**
	 * 발주 유효성체크2 (중복신청여부 최종 점검(동일한 품목/수량이 5분 안에 중복저장))
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectRecipeValidChk2(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.recipeDAO.selectRecipeValidChk2", parameter);
	}
	
	/**
	 * 발주 유효성체크3 (구매 자재신청 유효성 체크)
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectRecipeValidChk3(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.recipeDAO.selectRecipeValidChk3", parameter);
	}

	/**
	 * 발주 유효성체크4 (해당 prnum에 대해 PO에 존재하는지 체크 (중복 체크))
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectRecipeValidChk4(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.recipeDAO.selectRecipeValidChk4", parameter);
	}
	
	/**
	 * 발주전체삭제 유효성체크
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectRecipeDelValidChk(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.recipeDAO.selectRecipeDelValidChk", parameter);
	}
	
	/**
	 * 식단발주정보 삭제
	 *
	 * @param parameter
	 * @return
	 */
	public int deleteRecipeItem(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.recipeDAO.deleteRecipeItem", parameter);
	}
	
	/**
	 * 레시피발주정보 삭제
	 *
	 * @param parameter
	 * @return
	 */
	public int deletePrRecipeInfo(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.recipeDAO.deletePrRecipeInfo", parameter);
	}
	
	/**
	 * 최초주문번호에 속한 pr_num조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectRecipePrNum(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.recipeDAO.selectRecipePrNum", parameter);
	}

	/**
	 * 추가발주 필터
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectAddRecipeFilter(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.recipeDAO.selectAddRecipeFilter", parameter);
	}
	
	/**
	 * 추가발주 자재 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectAddRecipeInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.recipeDAO.selectAddRecipeInfo", parameter);
	}

	/**
	 * 추가발주 내역 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectPrAddRecipeInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.recipeDAO.selectPrAddRecipeInfo", parameter);
	}
	
	/**
	 * 구매발주 프로시져 호출
	 *
	 * @param mapParam
	 * @return
	 */
	public Map<String, Object> sp_If_Recipe_Sales_Order(Map<String, Object> parameter) throws Exception {
		//전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlParameter("I_SYS_ID",      	Types.VARCHAR),
            new SqlParameter("I_COMP_CD",      	Types.VARCHAR),
            new SqlParameter("I_REQ_SYS_CD",    Types.VARCHAR),
            new SqlParameter("I_PURC_TYP_CD",   Types.VARCHAR),
            new SqlParameter("I_SHOP_CD",       Types.VARCHAR),
            new SqlParameter("I_REQ_USR_ID",    Types.VARCHAR),
            new SqlParameter("I_REQ_TYP_CD",    Types.VARCHAR),
            new SqlParameter("I_REQ_NO",        Types.VARCHAR),
            new SqlParameter("I_REQ_CLS",       Types.VARCHAR),
            new SqlOutParameter("O_RTN_CD",  	Types.VARCHAR),
            new SqlOutParameter("O_RTN_MSG",   	Types.VARCHAR)
        };
        String procedureName = "SP_IF_SALES_ORDER";

        // procedure 호출
        return callProcedure("EPROCUSR", null, procedureName, sqlParameter, parameter);
	}
	
	/**
	 * 로그정보를 입력한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int logInsert(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.recipeDAO.logInsert", parameter);
	}
	
}
