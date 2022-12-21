package com.hwfs.fm.fmf.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 일마감관리하는 DayCloseMngt DAO
 * 
 * @ClassName DayCloseMngtDAO.java
 * @Description DayCloseMngtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.08   	손형민        최초생성
 *  2017.03.29	  kihoon		[CH201703_00751] 미마감내역 조회 팝업 프로그램 개발
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.06.08
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmf/dayCloseMngtDAO")
public class DayCloseMngtDAO extends DefaultDAO {
	
	/**
	 * 일마감관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.dayCloseMngtDAO.selectList", mapParam);
	}
	
	/**
	 * 일마감관리 목록을 조회한다.(정상분, 조정분)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSubList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.dayCloseMngtDAO.selectSubList", mapParam);
	}
	public RecordSet selectSubList2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.dayCloseMngtDAO.selectSubList2", mapParam);
	}
	
	public RecordSet upjangList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.dayCloseMngtDAO.upjangList", mapParam);
	}
	
	/**
	 * 일마감관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public Map<String, Object> closing(Map<String, Object> parameter) throws Exception {
		//전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlParameter("P_SALE_DATE",     	Types.VARCHAR),
            new SqlParameter("P_UPJANG",      		Types.VARCHAR),
            new SqlParameter("P_SUBINV_CODE",       Types.VARCHAR),
            new SqlParameter("P_USER",        		Types.VARCHAR),
            new SqlOutParameter("O_RTN",  		Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG",   		Types.VARCHAR)
        };
        String procedureName = "SP_FM_SALE_MAGAM_PROC_1";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
	}
	
	/**
	 * 식재매출마감 자료를 읽어서 영업회계 마감테이블로 생성    [정상분]  : 여신기준 단위로 생성
	 *
	 * @param mapParam
	 * @return
       
	 */
	public Map<String, Object> pg_fm_sale_magam(Map<String, Object> parameter) throws Exception {
		//전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlParameter("P_SALE_DATE",      	Types.VARCHAR),
            new SqlParameter("P_UPJANG",      		Types.VARCHAR),
            new SqlParameter("P_SUBINV_CODE",       Types.VARCHAR),
            new SqlParameter("P_USER",        		Types.VARCHAR),
            new SqlOutParameter("O_RTN",  		Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG",   		Types.VARCHAR)
        };
        String procedureName = "SP_FM_SALE_CREDIT_SLA_IF_PROC";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
	}
	
	/**
	 * 식재매출마감 자료를 읽어서 영업회계 마감테이블로 생성    [조정분]  : 여신기준 단위로 생성
	 *
	 * @param mapParam
	 * @return
	 */
	public Map<String, Object> sp_Fm_Sale_Mod_Magam_Proc(Map<String, Object> parameter) throws Exception {
		//전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlParameter("P_SALE_DATE",      	Types.VARCHAR),
            new SqlParameter("P_UPJANG",      		Types.VARCHAR),
            new SqlParameter("P_SUBINV_CODE",       Types.VARCHAR),
            new SqlParameter("P_USER",        		Types.VARCHAR),
            new SqlOutParameter("P_RET_CODE",  		Types.VARCHAR),
            new SqlOutParameter("P_RET_MSG",   		Types.VARCHAR)
        };
        String procedureName = "SP_FM_SALE_MOD_MAGAM_PROC";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
	}
	
	/**
	 * 식재매출마감 자료를 읽어서 영업회계 마감테이블로 생성    [조정분]  : 여신기준 단위로 생성
	 *
	 * @param mapParam
	 * @return
	 */
	public Map<String, Object> Sp_Fm_Sale_Mod_Crd_Sla_If_Proc(Map<String, Object> parameter) throws Exception {
		//전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlParameter("P_SALE_DATE",      	Types.VARCHAR),
            new SqlParameter("P_UPJANG",      		Types.VARCHAR),
            new SqlParameter("P_SUBINV_CODE",       Types.VARCHAR),
            new SqlParameter("P_RECEIPT_NUM",       Types.VARCHAR),
            new SqlParameter("P_USER",        		Types.VARCHAR),
            new SqlOutParameter("P_RET_CODE",  		Types.VARCHAR),
            new SqlOutParameter("P_RET_MSG",   		Types.VARCHAR)
        };
        String procedureName = "SP_FM_SALE_MOD_CRD_SLA_IF_PROC";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
	}
	
	/**
	 * 매출집계 마감 취소 프로시저 호출.
	 *
	 * @param mapParam
	 * @return
	 */
	public Map<String, Object> sp_Fm_Sale_Cncl_Sla_If_Proc(Map<String, Object> parameter) throws Exception {
		//전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlParameter("P_RECEIPT_NUM",      	Types.VARCHAR),
            new SqlParameter("P_SUB_UPJANG_CD",     Types.VARCHAR),
            new SqlParameter("P_OCCUR_DATE",      	Types.VARCHAR),
            new SqlOutParameter("O_RTN",  			Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG",   		Types.VARCHAR)
        };
        String procedureName = "SP_FM_SALE_CNCL_SLA_TUN_PROC";
        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
	}

	/**
	 * 영업회계 마감 취소 프로시저 호출.
	 *
	 * @param mapParam
	 * @return
	 */
	public Map<String, Object> sp_Sla_Sals_Pos_Upjang_Cancel_Proc(Map<String, Object> parameter) throws Exception {
		//전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlParameter("P_OCCUR_DATE",      	Types.VARCHAR),
            new SqlParameter("P_SYS_CLASS",      	Types.VARCHAR),
            new SqlParameter("P_UPJANG_CD",      	Types.VARCHAR),
            new SqlParameter("P_SUB_UPJANG_CD", 	Types.VARCHAR),
            new SqlOutParameter("O_RTN",  			Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG",   		Types.VARCHAR)
        };
        String procedureName = "SP_SLA_SALS_POS_UPJANG_CANCEL";
        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
	}
	
	/**
	 * 마감 데이터 삭제
	 *
	 * @param mapParam
	 * @return
	 */
	public int fmssalesDelete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmf.dayCloseMngtDAO.fmssalesDelete", mapParam);
	}
	
	/**
	 * 마감 건수 조회
	 *
	 * @param mapParam
	 * @return
	 */
	public int fmsClosingCnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("fm.fmf.dayCloseMngtDAO.fmsClosingCnt", mapParam);
	}

	/**
	 * 일마감 데이터 확인.
	 *
	 * @param mapParam
	 * @return
	 */
	public int fmsCnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("fm.fmf.dayCloseMngtDAO.fmsCnt", mapParam);
	}
	
	/**
	 * 전일자 마감 데이터 확인.
	 *
	 * @param mapParam
	 * @return
	 */
	public int fmsDayCnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("fm.fmf.dayCloseMngtDAO.fmsDayCnt", mapParam);
	}
	
	/**
	 * 전일자 수불자료 데이터 확인.
	 *
	 * @param mapParam
	 * @return
	 */
	public int fmsDayTrCnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("fm.fmf.dayCloseMngtDAO.fmsDayTrCnt", mapParam);
	}

	/**
	 * 일마감관리 목록을 조회한다.
	 * 추가일자:20170323  처리자:맹수영  요청자:이혜은
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectAllClose(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.dayCloseMngtDAO.selectAllClose", mapParam);
	}
	
	/**
	 * 미일마감 목록 일자를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCheckCloseDayInfo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.dayCloseMngtDAO.selectCheckCloseDayInfo", mapParam);
	}
	
	
	/**
	 * 미일마감 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCheckClose(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.dayCloseMngtDAO.selectCheckClose", mapParam);
	}
	

	/**
	 * 여신 집계 프로시처 호출 용 temp 테이블 조회
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectTemp(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.dayCloseMngtDAO.selectTemp", mapParam);
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
        		/*
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
            */
            new SqlOutParameter("O_RTN",  		Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG",   		Types.VARCHAR)
        };
        String procedureName = "FMS_CREDIT_SUM_CLOSING";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
	}	
	
	/**
	 * 하위업장일괄마감 체크 여부에 따라 업장목록 조회
	 *
	 * @param mapParam
	 * @return RecordSet
	 * @since 20171102
	 * @author 유선미
	 */
	public RecordSet selectUpjangList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.dayCloseMngtDAO.selectUpjangList", mapParam);
	}
	
	
	/**
	 * 마감 데이터 duplicate check
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet fmssalesDupCheck(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmf.dayCloseMngtDAO.fmssalesDupCheck", mapParam);
	}
}
