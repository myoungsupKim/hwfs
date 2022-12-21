package com.hwfs.fm.fmo.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 주문결의하는 OrderDecision DAO
 * 
 * @ClassName OrderDecisionDAO.java
 * @Description OrderDecisionDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.23   	손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.06.23
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmo/orderDecisionDAO")
public class OrderDecisionDAO extends DefaultDAO {
	
	/**
	 * 주문결의 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderDecisionDAO.selectList", mapParam);
	}

	/**
	 * 주문결의 목록을 체크한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCheckList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderDecisionDAO.selectCheckList", mapParam);
	}
	
	
	
	/**
	 * 주문결의 상세목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSub(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderDecisionDAO.selectSub", mapParam);
	}
	
	/**
	 * 주문결의 입고예정일 변경전 통제여부 확인.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSubFlag(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderDecisionDAO.selectSubFlag", mapParam);
	}

	/**
	 * 주문결의 PO_NUM을 생성한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public String poNumseq(Map<String, Object> mapParam) throws Exception {
		return (String)super.queryForObject("fm.fmo.orderDecisionDAO.poNumseq", mapParam , null);
	}
	
	/**
	 * 주문결의(을)를 항목을 결의한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int saveResol(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderDecisionDAO.saveResol", mapParam);
	}
	
	/**
	 * 구매 IF 실패시 확정된 데이터 원복.
	 *
	 * @param mapParam
	 * @return
	 */
	public int returnResol(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderDecisionDAO.returnResol", mapParam);
	}
	
	
	
	/**
	 * 주문결의(을)를 입고일자 변경한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int needupdate(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderDecisionDAO.needupdate", mapParam);
	}
	
	/**
	 * 주문결의(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderDecisionDAO.update", mapParam);
	}

	/**
	 * 주문결의(을)를 신청비고 항목을 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateRemark(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderDecisionDAO.updateRemark", mapParam);
	}
	
	
	/**
	 * 주문결의(을)를 반려한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int returnUpdate(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderDecisionDAO.returnUpdate", mapParam);
	}
	
	/**
	 * 주문결의(을)를 반려 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet returnList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderDecisionDAO.returnList", mapParam);
	}
	
	
	
	/**
	 * 주문결의 결의 생성 규칙에 따라 업장과 업체를 분류 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPrGroup(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderDecisionDAO.selectPrGroup", mapParam);
	}
	
	/**
	 * 주문결의 결의전 아이템별 발주제한을 체크한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet savechk(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderDecisionDAO.savechk", mapParam);
	}
	
	/**
	 * 주문결의 결의전 아이템별 발주제한을 체크한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet saveItemChk(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderDecisionDAO.saveItemChk", mapParam);
	}
	
	
	
	
	
	/**
	 * 주문확정 후 구매 프로시저 호출.
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
	 * 구매결의 시 신청(비고) 항목 수정 구매 프로시저 호출.
	 *
	 * @param mapParam
	 * @return
	 */
	public Map<String, Object> sp_if_sales_remarks(Map<String, Object> parameter) throws Exception {
		//전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlParameter("I_SYS_ID",      	Types.VARCHAR),
            new SqlParameter("I_COMP_CD",      	Types.VARCHAR),
            new SqlParameter("I_LEGCY_REQ_NO",    Types.VARCHAR),
            new SqlParameter("I_LEGCY_REQ_LNO",    Types.VARCHAR),
            new SqlParameter("I_PR_REM",    Types.VARCHAR),
            new SqlOutParameter("O_RTN_CD",  	Types.VARCHAR),
            new SqlOutParameter("O_RTN_MSG",   	Types.VARCHAR)
        };
        /*
        - I_SYS_ID      IN VARCHAR2  : 시스템 아이디 ('100')
        - I_COMP_CD     IN VARCHAR2  : 회사 코드 ('HFC')
        - I_LEGCY_REQ_NO  IN VARCHAR2  : 요청번호 - SO_PR의 PR_NUM (HLDC_PO_PO의 PO_NUM)
        - I_LEGCY_REQ_LNO  IN VARCHAR2  : 요청아이디 - SO_PR의 PR_ID (HLDC_PO_PO의 PO_ID)
        - I_PR_REM     IN VARCHAR2  : 신청 비고(SO_PR의 PR_REMARK)
        - O_RTN_CD     OUT VARCHAR2  : 처리 결과 코드 [S000: 정상, E901~E999: 에러]
        - O_RTN_MSG    OUT VARCHAR2  : 처리 결과 에러 메세지
         */
        String procedureName = "SP_IF_SALES_REMARKS";
        // procedure 호출
        return callProcedure("EPROCUSR", null, procedureName, sqlParameter, parameter);
	}
	
	
	/**
	 * 주문확정수정(을)를 프로시저 호출전 PO_PO 상태값을 다시 확인한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int poPoCnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("fm.fmo.orderRequestConfirmModifyDAO.poPoCnt", mapParam);
	}
	
	/**
	 * 주문신청(을)서를 주문번호 생성 규칙에 따라 PR_NUM을 업데이트한다. (업장,거래처,입고일)
	 *
	 * @param mapParam
	 * @return
	 */
	public int prNumUpdate(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderDecisionDAO.prNumUpdate", mapParam);
	}
	
	/**
	 * 구매신청번호를 GET
	 * @return 구매신청번호
	 * @exception Exception
	 */
	public String selectPrNum(Map<String, Object> mapParam) throws Exception {
		return (String)queryForObject("fm.fmo.orderRequestDAO.selectPrNum", mapParam, null);
	}
	
	/**
	 * 주문결의(을)를 프로시저 호출전 PO_PO 상태값을 다시 확인한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public String poStatusSelect(Map<String, Object> mapParam) throws Exception {
		return (String)super.queryForObject("fm.fmo.orderRequestConfirmModifyDAO.lineStatusSelect", mapParam , null);
	}
	
	/**
	 * 주문결의(을)를 I/F 결과를 저장한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int ifReturnUpdateId(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderDecisionDAO.ifReturnUpdateId", mapParam);
	}
	
	public int ifReturnUpdateNum(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderDecisionDAO.ifReturnUpdateNum", mapParam);
	}
	
// [속도개선 Project 시작] 2017. 7. 20. 최범주 주문결의 반려 시 CS담당자 연락처로 송신자번호 셋팅
	/**
	 * CS담당자연락처정보 조회
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCsChgAcaInfo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderDecisionDAO.selectCsChgAcaInfo", mapParam);
	}
// [속도개선 Project   끝] 2017. 7. 20. 최범주

// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	/**
	 * 판매금액 조회
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSellAmt(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderDecisionDAO.selectSellAmt", mapParam);
	}
// [속도개선 Project   끝] 2017. 8. 4. 최범주
}
