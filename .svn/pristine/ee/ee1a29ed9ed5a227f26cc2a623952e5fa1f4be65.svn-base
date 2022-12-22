package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 판매단가를 강제변경하는 SalePriceStChg DAO
 * 
 * @ClassName SalePriceStChgDAO.java
 * @Description SalePriceStChgDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.24   	최성연        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.04.24
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fms/salePriceStChgDAO")
public class SalePriceStChgDAO extends DefaultDAO {
	
	/**
	 * 판매단가 강제변경 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.salePriceStChgDAO.selectList", mapParam);
	}

	/**
	 * 판매단가 강제변경(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceStChgDAO.insert", mapParam);
	}
	
	/**
	 * 판매단가 강제변경(을)를 수정한다.
	 * SO_PR = SALE_PRICE, REMARK
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceStChgDAO.update", mapParam);
	}

	/**
	 * 판매단가 강제변경(을)를 수정한다.
	 * PO_PO = SALE_PRICE, REMARK
	 * @param mapParam
	 * @return
	 */
	public int update1(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceStChgDAO.update1", mapParam);
	}
	
	/**
	 * 판매단가 강제변경(을)를 수정한다.
	 * PO_TRANSACTION = SALE_PRICE, REMARK
	 * @param mapParam
	 * @return
	 */
	public int update2(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceStChgDAO.update2", mapParam);
	}
	
	/**
	 * 판매단가 강제변경(을)를 수정한다.
	 * PO_TRANSACTION = SALE_AMOUNT
	 * @param mapParam
	 * @return
	 */
	public int update3(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceStChgDAO.update3", mapParam);
	}
	
	
	/**
	 * 판매단가 강제변경(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceStChgDAO.delete", mapParam);
	}
	
	/**
	 * 판매단가 강제변경(을)를 temp 테이블을 업데이트한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateTemp(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceStChgDAO.updateTemp", mapParam);
	}
	
	
	/**
	 * 여신 집계 프로시처 호출 용 temp 테이블 조회
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectTemp(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.salePriceStChgDAO.selectTemp", mapParam);
	}	
	

	/**
	 * 식재매출마감시 여신 집계 프로시저 호출
	 *
	 * @param mapParam
	 * @return
       
	 */
	public Map<String, Object> sp_Fms_Credit_Sum_Proc(Map<String, Object> parameter) throws Exception {
		//전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlParameter("P_UPJANG_CD",      	Types.VARCHAR),
            new SqlParameter("P_APPLY_DATE",      		Types.VARCHAR),
            new SqlParameter("P_OCCUR_CLASS",       Types.VARCHAR),
            new SqlParameter("P_OCCUR_AMT",        		Types.VARCHAR),
            new SqlParameter("P_OCCUR_AMT_BEFORE",      	Types.VARCHAR),
            new SqlParameter("P_CLASS_CD",      		Types.VARCHAR),
            new SqlParameter("P_OCCUR_TABLE",       Types.VARCHAR),
            new SqlParameter("P_KEY_NM",        		Types.VARCHAR),
            new SqlParameter("P_KEY_VALUE01",      	Types.VARCHAR),
            new SqlParameter("P_KEY_VALUE02",      		Types.VARCHAR),
            new SqlParameter("P_KEY_VALUE03",       Types.VARCHAR),
            new SqlParameter("P_KEY_VALUE04",        		Types.VARCHAR),
            new SqlParameter("P_KEY_VALUE05",      	Types.VARCHAR),
            new SqlParameter("P_OCCUR_PRG_ID",      		Types.VARCHAR),
            new SqlParameter("P_OCCUR_PRG_NM",       Types.VARCHAR),
            new SqlParameter("P_CUSER",        		Types.VARCHAR),
            new SqlOutParameter("O_RTN",  		Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG",   		Types.VARCHAR)
        };
        String procedureName = "FMS_CREDIT_SUM_PRO";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
	}
	
				
	
	
	/**
	 * 판매단가 강제변경(을)를 수정한다.
	 * SO_PR = SALE_PRICE, REMARK
	 * @param mapParam
	 * @return
	 */
	public int update_old2(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceStChgDAO.update_old2", mapParam);
	}

	/**
	 * 판매단가 강제변경(을)를 수정한다.
	 * PO_PO = SALE_PRICE, REMARK
	 * @param mapParam
	 * @return
	 */
	public int update1_old2(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceStChgDAO.update1_old2", mapParam);
	}
	
	/**
	 * 판매단가 강제변경(을)를 수정한다.
	 * PO_TRANSACTION = SALE_PRICE, REMARK
	 * @param mapParam
	 * @return
	 */
	public int update2_old2(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceStChgDAO.update2_old2", mapParam);
	}	
	
}
