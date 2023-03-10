package com.hwfs.sc.app.dao;

import java.sql.Types;
import java.util.Map;

import hone.core.util.record.RecordSet;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 식재앱 주문 인터페이스용  DAO 개체
 * @ClassName OrderDAO.java
 * @Description  OrderDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.06.20.   김명섭        최초생성
 * </pre>
 * @author 푸디스트
 * @since 2022.06.20.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by 한화시스템ICT CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/app/orderDAO")
public class OrderDAO extends DefaultDAO {
	
	/**
	 * 영업장 마스터를 조회한다.
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectTest(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.orderDAO.selectTest", parameter);
	}

	/**
	 * 자재이미지 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectImgInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.orderDAO.selectImgInfo", parameter);
	}

	/**
	 * 즐겨찾기 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectFavInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.orderDAO.selectFavInfo", parameter);
	}

	/**
	 * 즐겨찾기 그룹조회(업장기준)
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectFavGrpInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.orderDAO.selectFavGrpInfo", parameter);
	}
	
	/**
	 * 즐겨찾기 상품조회(업장기준)
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectFavItemInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.orderDAO.selectFavItemInfo", parameter);
	}

	/**
	 * 즐겨찾기 상품조회 페이징 적용
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectFavItemInfoPage(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.orderDAO.selectFavItemInfoPage", parameter);
	}
	
	/**
	 * 즐겨찾기그룹코드채번
	 *
	 * @param mapParam
	 * @return
	 */
	public String favgrpNextval(Map<String, Object> parameter) throws Exception {
        return (String) super.queryForObject("sc.app.orderDAO.favgrpNextval", parameter, null);
	}
	
	/**
	 * 즐겨찾기 그룹 등록
	 *
	 * @param mapParam
	 * @return
	 */
	public int favgrpProc(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.orderDAO.favgrpProc", parameter);
	}

	/**
	 * 즐겨찾기 그룹상품 등록
	 *
	 * @param mapParam
	 * @return
	 */
	public int favgrpItemProc(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.orderDAO.favgrpItemProc", parameter);
	}
	
	/**
	 * 지난발주상품 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectPreOrder(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.orderDAO.selectPreOrder", parameter);
	}

	/**
	 * 발주가능금액 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectCtrlAmt(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.orderDAO.selectCtrlAmt", parameter);
	}

	/**
	 * 발주가능금액 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectSubinvCtrlAmt(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.orderDAO.selectSubinvCtrlAmt", parameter);
	}
	
	/**
	 * 발주내역조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectOrderInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.orderDAO.selectOrderInfo", parameter);
	}

	/**
	 * 신규주문번호채번
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectPrSeq(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.orderDAO.selectPrSeq", parameter);
	}

	/**
	 * 신규주문상세번호채번
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectPrIdSeq(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.orderDAO.selectPrIdSeq", parameter);
	}
	
	/**
	 * 주문번호별 발주금액 합계
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectGdsGnvTot(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.orderDAO.selectGdsGnvTot", parameter);
	}
	
	/**
	 * 주문저장
	 *
	 * @param parameter
	 * @return
	 */
	public int saveOrderInfo(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.orderDAO.saveOrderInfo", parameter);
	}	
	
	/**
	 * 공급업체주문저장
	 *
	 * @param parameter
	 * @return
	 */
	public int saveOtcustOrderInfo(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.orderDAO.saveOtcustOrderInfo", parameter);
	}

	/**
	 * 주문수정
	 *
	 * @param parameter
	 * @return
	 */
	public int updateOrderInfo(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.orderDAO.updateOrderInfo", parameter);
	}
	
	/**
	 * 공급업체주문수정
	 *
	 * @param parameter
	 * @return
	 */
	public int updateOtcustOrderInfo(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.orderDAO.updateOtcustOrderInfo", parameter);
	}
	
	/**
	 * 유효성 체크용 임시테이블저장
	 *
	 * @param parameter
	 * @return
	 */
	public int saveOrderTempInfo(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.orderDAO.saveOrderTempInfo", parameter);
	}

	/**
	 * 모바일 장바구니 담기 전 수발주 유효성 체크
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet saveOrderPreChk(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.orderDAO.saveOrderPreChk", parameter);
	}

	/**
	 * 저장전 발주상태 변경여부 체크
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet saveOrderPreChk2(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.orderDAO.saveOrderPreChk2", parameter);
	}	
	
	/**
	 * 수발주 스케쥴에 따른 유효성 체크
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectValidChk1(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.orderDAO.selectValidChk1", parameter);
	}
	
	/**
	 * 구매 자재신청 유효성 체크
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectValidChk2(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.orderDAO.selectValidChk2", parameter);
	}
	
	/**
	 * 임시테이블 데이터 삭제
	 *
	 * @param parameter
	 * @return
	 */
	public int deleteOrderTempInfo(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.orderDAO.deleteOrderTempInfo", parameter);
	}
	
	/**
	 * 주문정보 삭제
	 *
	 * @param parameter
	 * @return
	 */
	public int deleteOrderInfo(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.orderDAO.deleteOrderInfo", parameter);
	}
	
	/**
	 * 주문정보 삭제
	 *
	 * @param parameter
	 * @return
	 */
	public int deleteOtcustOrderInfo(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.orderDAO.deleteOtcustOrderInfo", parameter);
	}
	
	/**
	 * 발주이력조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectOrderHistInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.orderDAO.selectOrderHistInfo", parameter);
	}
	
	/**
	 * 발주이력상세조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectOrderHistItemInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.orderDAO.selectOrderHistItemInfo", parameter);
	}
	
	/**
	 * 배송이력조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectDelvHistInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.orderDAO.selectDelvHistInfo", parameter);
	}
	
	/**
	 * 배송이력상세조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectDelvHistItemInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.orderDAO.selectDelvHistItemInfo", parameter);
	}
	
	/**
	 * 구매발주 프로시져 호출
	 *
	 * @param mapParam
	 * @return
	 */
	public Map<String, Object> sp_If_Sales_Order(Map<String, Object> parameter) throws Exception {
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
	 * 여신집계 프로시져 호출
	 *
	 * @param mapParam
	 * @return
	 */
	public Map<String, Object> fms_Credit_Sum_Pro(Map<String, Object> parameter) throws Exception {
		//전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlParameter("p_upjang_cd",      	Types.VARCHAR),
            new SqlParameter("p_apply_date",      	Types.VARCHAR),
            new SqlParameter("p_occur_class",    Types.VARCHAR),
            new SqlParameter("p_occur_amt",   Types.VARCHAR),
            new SqlParameter("p_occur_amt_before",       Types.VARCHAR),
            new SqlParameter("p_class_cd",    Types.VARCHAR),
            new SqlParameter("p_occur_table",    Types.VARCHAR),
            new SqlParameter("p_key_nm",        Types.VARCHAR),
            new SqlParameter("p_key_value01",       Types.VARCHAR),
            new SqlParameter("p_key_value02",       Types.VARCHAR),
            new SqlParameter("p_key_value03",       Types.VARCHAR),
            new SqlParameter("p_key_value04",       Types.VARCHAR),
            new SqlParameter("p_key_value05",       Types.VARCHAR),
            new SqlParameter("p_occur_prg_id",       Types.VARCHAR),
            new SqlParameter("p_occur_prg_nm",       Types.VARCHAR),
            new SqlParameter("p_cuser",       Types.VARCHAR),
            new SqlOutParameter("O_RTN_CD",  	Types.VARCHAR),
            new SqlOutParameter("O_RTN_MSG",   	Types.VARCHAR)
        };
        String procedureName = "FMS_CREDIT_SUM_PRO";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
	}
	
	/**
	 * 여신 로그테이블 저장
	 *
	 * @param parameter
	 * @return
	 */
	public int saveOrderCreditLog(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.orderDAO.saveOrderCreditLog", parameter);
	}
	
	/**
	 * 반환가능업장 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectRtnOrderYn(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.orderDAO.selectRtnOrderYn", parameter);
	}

	/**
	 * 정상주문일자(반환회수일) 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectSoPrGetNeedDate(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.orderDAO.selectSoPrGetNeedDate", parameter);
	}	
	
	
	/**
	 * 반환타입 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectRtnType(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.orderDAO.selectRtnType", parameter);
	}	
	
	/**
	 * 반환발주 마감시간 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectRtnDtime(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.orderDAO.selectRtnDtime", parameter);
	}	
	
	/**
	 * 반환 신규주문번호채번
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectGetPrNum(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.orderDAO.selectGetPrNum", parameter);
	}

	/**
	 * 반환 신규주문상세번호채번
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectGetPrId(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.orderDAO.selectGetPrId", parameter);
	}
	
	
	/**
	 * 반환내역 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectRtnOrderInfo(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("sc.app.orderDAO.selectRtnOrderInfo", parameter);
	}
	
	/**
	 * 반환주문저장
	 *
	 * @param parameter
	 * @return
	 */
	public int saveRtnOrderInfo(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.orderDAO.saveRtnOrderInfo", parameter);
	}
	
	/**
	 * 반환주문수정
	 *
	 * @param parameter
	 * @return
	 */
	public int updateRtnOrderInfo(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.orderDAO.updateRtnOrderInfo", parameter);
	}
	
	/**
	 * 반환주문삭제
	 *
	 * @param parameter
	 * @return
	 */
	public int deleteRtnOrderInfo(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.orderDAO.deleteRtnOrderInfo", parameter);
	}
	
	/**
	 * 로그정보를 입력한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int logInsert(Map<String, Object> parameter) throws Exception {
		return super.update("sc.app.orderDAO.logInsert", parameter);
	}
	
}
