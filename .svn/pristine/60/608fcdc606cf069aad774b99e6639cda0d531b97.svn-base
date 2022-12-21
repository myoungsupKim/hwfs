package com.hwfs.fm.fmo.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 주문결의수정하는 OrderDecisionModify DAO
 * 
 * @ClassName OrderDecisionModifyDAO.java
 * @Description OrderDecisionModifyDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.23   	손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.07.23
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmo/orderDecisionModifyDAO")
public class OrderDecisionModifyDAO extends DefaultDAO {
	
	/**
	 * 주문결의 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderDecisionModifyDAO.selectList", mapParam);
	}
	
	/**
	 * 주문결의 상세목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSub(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderDecisionModifyDAO.selectSub", mapParam);
	}
	
	/**
	 * 주문결의 상세목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSubAll(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderDecisionModifyDAO.selectSubAll", mapParam);
	}
	
	/**
	 * 주문결의 입고예정일 변경전 통제여부 확인.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSubFlag(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderDecisionModifyDAO.selectSubFlag", mapParam);
	}

	/**
	 * 주문결의 PO_NUM을 생성한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public String poNumseq(Map<String, Object> mapParam) throws Exception {
		return (String)super.queryForObject("fm.fmo.orderDecisionModifyDAO.poNumseq", mapParam , null);
	}
	
	/**
	 * 주문결의(을)를 항목을 결의한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int saveResol(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderDecisionModifyDAO.saveResol", mapParam);
	}
	
	
	/**
	 * 주문결의(을)를 입고일자 변경한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int needupdate(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderDecisionModifyDAO.needupdate", mapParam);
	}
	
	/**
	 * 주문결의(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderDecisionModifyDAO.update", mapParam);
	}
	
	/**
	 * 주문결의(을)를 반려한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int returnUpdate(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderDecisionModifyDAO.returnUpdate", mapParam);
	}
	
	/**
	 * 주문결의(을)를 반려한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int returnFalgUpdate(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderDecisionModifyDAO.returnFalgUpdate", mapParam);
	}
	
	
	
	/**
	 * 주문결의 결의 생성 규칙에 따라 업장과 업체를 분류 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPrGroup(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderDecisionModifyDAO.selectPrGroup", mapParam);
	}
	
	
	/**
	 * 주문결의수정 구매IF 프로시저 호출.
	 *
	 * @param mapParam
	 * @return
	 */
	public Map<String, Object> sp_if_sales_order(Map<String, Object> parameter) throws Exception {
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
        /*
        - I_SYS_ID      IN VARCHAR2  : 시스템 아이디 ('100')
        - I_COMP_CD     IN VARCHAR2  : 회사 코드 ('HFC')
        - I_REQ_SYS_CD  IN VARCHAR2  : 신청 시스템 코드 [PR: 전사구매, FR: 통합영업, WR: WMS]
        - I_PURC_TYP_CD IN VARCHAR2  : 신청 시스템 구매유형 코드[MT:식자재, CT:상품, BT:일반자재(소모품),ST:일반자재(저장품),JT:일반자재(고정자산)]
        - I_SHOP_CD     IN VARCHAR2  : 신청업장 코드
        - I_REQ_USR_ID  IN VARCHAR2  : 신청자 아이디
        - I_REQ_TYP_CD  IN VARCHAR2  : 통합영업 S/O 유형코드(07)
        - I_REQ_NO      IN VARCHAR2  : Sales Order 요청 번호(PR_NUM)
        - I_REQ_CLS     IN VARCHAR2  : 요청 상태 [C-신규, U-수정, D-삭제]
        - O_RTN_CD     OUT VARCHAR2  : 처리 결과 코드 [S000: 정상, E901~E999: 에러]
        - O_RTN_MSG    OUT VARCHAR2  : 처리 결과 에러 메세지
         */
        String procedureName = "SP_IF_SALES_ORDER";
        // procedure 호출
        return callProcedure("EPROCUSR", null, procedureName, sqlParameter, parameter);
	}
	
	
	/**
	 * 주문확정수정(을)를 반려중 IF 에러 발생시 상태값을 원상복구 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateStatus(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderDecisionModifyDAO.updateStatus", mapParam);
	}
	
	/**
	 * 주문결의 결의전 아이템별 발주제한을 체크한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet saveItemChk(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderDecisionModifyDAO.saveItemChk", mapParam);
	}
	
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	/**
	 * 변경전판매금액 조회
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectChngBefSellAmt(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderDecisionModifyDAO.selectChngBefSellAmt", mapParam);
	}
// [속도개선 Project   끝] 2017. 8. 4. 최범주
}
