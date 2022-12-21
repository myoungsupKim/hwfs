package com.hwfs.fm.fmo.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 주문확정하는 OrderRequestConfirm DAO
 * 
 * @ClassName OrderRequestConfirmDAO.java
 * @Description OrderRequestConfirmDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.25   	손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.06.25
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmo/orderRequestConfirmDAO")
public class OrderRequestConfirmDAO extends DefaultDAO {
	
	/**
	 * 주문확정 [목록]을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestConfirmDAO.selectList", mapParam);
	}


	/**
	 * 주문확정 [상세목록]을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSub(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestConfirmDAO.selectSub", mapParam);
	}
	
	/**
	 * 주문확정 확정전 [통제여부]를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSubFlag(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestConfirmDAO.selectSubFlag", mapParam);
	}
	
	/**
	 * 주문확정 확정전 [PO_NUM]리스트를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet poNumList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestConfirmDAO.poNumList", mapParam);
	}
	
	
	
	/**
	 * 주문확정(을)를 [확정]한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestConfirmDAO.update002", mapParam);
	}
	
	/**
	 * 주문확정(을)를 [확정]한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectIFList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestConfirmDAO.selectIFList", mapParam);
	}
	
	
	
	/**
	 * 주문확정(을)를 [취소]한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int cnclupdate005(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestConfirmDAO.update005", mapParam);
	}
	
	/**
	 * 주문확정(을)를 프로시저 롤백 후 상태값 업데이트한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int cnclupdate007(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestConfirmDAO.update007", mapParam);
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
}
