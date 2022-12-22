package com.hwfs.fm.fmf.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.HashMap;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 매출을 보정하는 SaleModifyWork DAO
 * 
 * @ClassName SaleModifyWorkDAO.java
 * @Description SaleModifyWorkDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.20   	최성연        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.05.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmf/saleModifyWorkDAO")
public class SaleModifyWorkDAO extends DefaultDAO {
	
	/**
	 * 매출보정 매출내역 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.saleModifyWorkDAO.selectList", mapParam);
	}

	/**
	 * 매출보정 보정내역 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.saleModifyWorkDAO.selectList2", mapParam);
	}

	
	/**
	 * 최종 매출마감일자를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDate(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.saleModifyWorkDAO.selectDate", mapParam);
	}
	

	/**
	 * 매출보정 보정번호를 구한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectTrNum(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.saleModifyWorkDAO.selectTrNum", mapParam);
	}
	
	
	
	/**
	 * 매출보정(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmf.saleModifyWorkDAO.insert", mapParam);
	}
	
	/**
	 * 매출보정(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int saleInsert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmf.saleModifyWorkDAO.saleInsert", mapParam);
	}
	
	
	/**
	 * 매출보정(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmf.saleModifyWorkDAO.update", mapParam);
	}
	
	/**
	 * 매출보정(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmf.saleModifyWorkDAO.delete", mapParam);
	}
	
	/**
	 * 보정내역 입력전 마감여부를 가져온다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet searchmagam(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.saleModifyWorkDAO.searchmagam", mapParam);
	}

	/**
	 * 가용여신정보 확인
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet checkCredit(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.saleModifyWorkDAO.checkCredit", mapParam);
	}
	
	/**
	 * 품의번호(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateArNum(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmf.saleModifyWorkDAO.updateArNum", mapParam);
	}

// [속도개선 Project 시작] 2017. 6. 30. 최범주 매출보정이력 기능 추가
	/**
	 * 매출보정정보조회
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet inqrSaleCorrInfo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.saleModifyWorkDAO.inqrSaleCorrInfo", mapParam);
	}

	/**
	 * 매출보정정보이력등록
	 *
	 * @param mapParam
	 * @return
	 */
	public int regSaleCorrInfoHst(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmf.saleModifyWorkDAO.regSaleCorrInfoHst", mapParam);
	}
	
	/**
	 * 매출보정정보이력변경
	 *
	 * @param mapParam
	 * @return
	 */
	public int chngSaleCorrInfoHst(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmf.saleModifyWorkDAO.chngSaleCorrInfoHst", mapParam);
	}
	
	/**
	 *  여신금액 집계 프로시저 호출.
	 *
	 * @param mapParam
	 * @return
	 */
	public Map<String, Object> procCreditSum(Map<String, Object> procedureParam) {
		Map<String, Object> rtnProcedure = new HashMap<String, Object>();
		
		//전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
              new SqlParameter("p_upjang_cd",        Types.VARCHAR)  // 업장코드
            , new SqlParameter("p_apply_date",       Types.VARCHAR)  // 적용일자          
            , new SqlParameter("p_occur_class",      Types.VARCHAR)  // 발생구분          
            , new SqlParameter("p_occur_amt",        Types.NUMERIC)  // 발생금액          
            , new SqlParameter("p_occur_amt_before", Types.NUMERIC)  // 발생금액(전)  
            , new SqlParameter("p_class_cd",         Types.VARCHAR)  // 구분코드          
            , new SqlParameter("p_occur_table",      Types.VARCHAR)  // 발생테이블       
            , new SqlParameter("p_key_nm",           Types.VARCHAR)  // 키명              
            , new SqlParameter("p_key_value01",      Types.VARCHAR)  // 키1         
            , new SqlParameter("p_key_value02",      Types.VARCHAR)  // 키2         
            , new SqlParameter("p_key_value03",      Types.VARCHAR)  // 키3         
            , new SqlParameter("p_key_value04",      Types.VARCHAR)  // 키4         
            , new SqlParameter("p_key_value05",      Types.VARCHAR)  // 키5         
            , new SqlParameter("p_occur_prg_id",     Types.VARCHAR)  // 프로그램ID   
            , new SqlParameter("p_occur_prg_nm",     Types.VARCHAR)  // 프로그램 한글명
            , new SqlParameter("p_cuser",            Types.VARCHAR)  // 생성자            
            , new SqlOutParameter("o_rtn",           Types.VARCHAR)  // 성공여부          
            , new SqlOutParameter("o_rtnmsg",        Types.VARCHAR)  // 메세지            
        };
        
        // procedure 호출
        String procedureName = "FMS_CREDIT_SUM_PRO";
        try {
        	rtnProcedure = callProcedure(procedureName, sqlParameter, procedureParam);
        } catch(Exception e) {
        	rtnProcedure.put("o_rtn", "N");
        	rtnProcedure.put("o_rtnmsg", "시스템 오류가 발생하였습니다.\n관리자에게 문의하십시오.(통합영업)");
        }
        
		if ( logger.isDebugEnabled() ) {
			logger.debug("\n★★★★★ FCUS.FMS_CREDIT_SUM_PRO(여신금액 집계 프로시저) 인자 ★★★★★");
			logger.debug("p_upjang_cd        : [" + procedureParam.get("p_upjang_cd").toString()        + "]");
			logger.debug("p_apply_date       : [" + procedureParam.get("p_apply_date").toString()       + "]");
			logger.debug("p_occur_class      : [" + procedureParam.get("p_occur_class").toString()      + "]");
			logger.debug("p_occur_amt        : [" + procedureParam.get("p_occur_amt").toString()        + "]");
			logger.debug("p_occur_amt_before : [" + procedureParam.get("p_occur_amt_before").toString() + "]");
			logger.debug("p_class_cd         : [" + procedureParam.get("p_class_cd").toString()         + "]");
			logger.debug("p_occur_table      : [" + procedureParam.get("p_occur_table").toString()      + "]");
			logger.debug("p_key_nm           : [" + procedureParam.get("p_key_nm").toString()           + "]");
			logger.debug("p_key_value01      : [" + procedureParam.get("p_key_value01").toString()      + "]");
			logger.debug("p_key_value02      : [" + procedureParam.get("p_key_value02").toString()      + "]");
			logger.debug("p_key_value03      : [" + procedureParam.get("p_key_value03").toString()      + "]");
			logger.debug("p_key_value04      : [" + procedureParam.get("p_key_value04").toString()      + "]");
			logger.debug("p_key_value05      : [" + procedureParam.get("p_key_value05").toString()      + "]");
			logger.debug("p_occur_prg_id     : [" + procedureParam.get("p_occur_prg_id").toString()     + "]");
			logger.debug("p_occur_prg_nm     : [" + procedureParam.get("p_occur_prg_nm").toString()     + "]");
			logger.debug("p_cuser            : [" + procedureParam.get("p_cuser").toString()            + "]");
			logger.debug("o_rtn              : [" + rtnProcedure.get("o_rtn").toString()                + "]");
			logger.debug("o_rtnmsg           : [" + rtnProcedure.get("o_rtnmsg").toString()             + "]");
		}
        
        return rtnProcedure;
	}
	
// [속도개선 Project   끝] 2017. 6. 30. 최범주
}
