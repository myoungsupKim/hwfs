package com.hwfs.fm.fmc.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 클레임처리하는 ClaimProc DAO
 * 
 * @ClassName ClaimProcDAO.java
 * @Description ClaimProcDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.21   	최영준        최초생성
 *  2021.08.17    DEV02         [PJT]주문채널통합
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015.05.21
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmc/claimProcDAO")
public class ClaimProcDAO extends DefaultDAO {
	
	/**
	 * 클레임처리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmc.claimProcDAO.selectList", mapParam);
	}
	
	/**
	 * 클레임처리 목록을 조회한다.
	 * [PJT]주문채널통합
	 * 
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectBrandList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmc.claimProcDAO.selectBrandList", mapParam);
	}

	/**
	 * 클레임처리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmc.claimProcDAO.insert", mapParam);
	}
	
	/**
	 * 클레임처리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmc.claimProcDAO.update", mapParam);
	}
	
	/**
	 * 클레임처리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmc.claimProcDAO.delete", mapParam);
	}
	
	/**
	 * 자재 목록을 조회한다.
	 *
	 * @return
	 */
	public RecordSet returnItemSearch(Map <String, Object> parm) throws Exception {
		return super.queryForRecordSet("fm.fmc.claimProcDAO.returnItemSearch", parm);
	}
	
	/**
	 * 클레임처리상태 조회한다.
	 *
	 * @return
	 */
	public RecordSet selectPrcsStatus(Map <String, Object> parm) throws Exception {
		return super.queryForRecordSet("fm.fmc.claimProcDAO.selectPrcsStatus", parm);
	}
	/**
	 * 클레임처리 구매 프로시저 호출
	 *
	 * @param mapParam
	 * @return
	 */
	public Map<String, Object> pk_excute(Map<String, Object> parameter) throws Exception {
		//전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
    		new SqlParameter("P_PO_NO",      	Types.VARCHAR),
            new SqlParameter("P_PO_LNO",      	Types.VARCHAR),
            new SqlParameter("P_TRANS_DATE",  	Types.VARCHAR),			
            //new SqlParameter("P_TRANS_QTY",  	Types.INTEGER),
            new SqlParameter("P_TRANS_QTY",  	Types.VARCHAR),		// 2015-10-05 (문자열로 반영)
            new SqlParameter("P_ITEM_CD",       Types.VARCHAR),
            new SqlParameter("P_WH_CD",    		Types.VARCHAR),
            new SqlParameter("P_CLAIM_ID",    	Types.VARCHAR),
            
            new SqlParameter("P_PROG_CLAIM",    	Types.VARCHAR),
            new SqlParameter("P_COMP_CLAIM",    	Types.VARCHAR),
            new SqlParameter("P_RESP_CLAIM",    	Types.VARCHAR),
            new SqlParameter("P_REQ_CONT",    	Types.VARCHAR),
            new SqlParameter("P_DTL_CONT",    	Types.VARCHAR),
            new SqlParameter("P_ETC_CONT",    	Types.VARCHAR),
            new SqlParameter("P_PROG_DTL_CONT",    	Types.VARCHAR),
            
            new SqlOutParameter("O_RTN_MG_NO",  	Types.VARCHAR),
            new SqlOutParameter("O_RTN_MOVEMENT",  	Types.VARCHAR),
            
            new SqlOutParameter("O_RTN_CD",  	Types.VARCHAR),
            new SqlOutParameter("O_RTN_MSG",   	Types.VARCHAR)
        };
        /*
			     P_PO_NO       IN ESPPODT.LEGCY_REQ_NO%TYPE,       --요청번호
			     P_PO_LNO      IN ESPPODT.LEGCY_REQ_LNO%TYPE,      --요청항번
			     P_TRANS_DATE   IN ESIMGDT.MG_DATE%TYPE,            --클레임일자
			     P_TRANS_QTY    IN ESIMGDT.GR_QTY%TYPE,             --클레임수량
			     P_ITEM_CD      IN ESIMGDT.ITEM_CD%TYPE,            --자재코드
			     P_WH_CD        IN ESIMGDT.WH_CD%TYPE,              --창고코드
			     P_CLAIM_ID     IN ESIMGDT.REG_ID%TYPE,             --클레임확정자ID
			     P_PROG_CLAIM   IN ESICRDT.PROG_CLAIM_TYP%TYPE,     --처리클레임유형
			     P_COMP_CLAIM   IN ESICRDT.COMP_CLAIM_TYP%TYPE,     --확정클레임유형
			     P_RESP_CLAIM   IN ESICRDT.RESP_CLAIM_TYP%TYPE,     --책임소재클레임유형
			     P_REQ_CONT     IN ESICRDT.REQ_CONT%TYPE,           --요청 사항
			     P_DTL_CONT     IN ESICRDT.CLAIM_DTL_CONT%TYPE,     --클레임상세내역
			     P_ETC_CONT     IN ESICRDT.ETC_CONT%TYPE,           --기타사항
			     
			     O_RTN_MG_NO    OUT VARCHAR2,
     			 O_RTN_MOVEMENT OUT VARCHAR2,
			     
			     O_RTN_CD       OUT VARCHAR2,
			     O_RTN_MSG      OUT VARCHAR2
			     
         */
        // procedure 호출
        return callProcedure("EPROCUSR", "PK_IF_FCUS_CLAIM_EXCUTE", "PK_EXCUTE", sqlParameter, parameter);
	}
	
	/**
	 * 클레임처리 급식 식권 프로시저 호출.
	 *
	 * @param mapParam
	 * @return
	 */
	public Map<String, Object> sp_fs_claim_ticket_del(Map<String, Object> parameter) throws Exception {
		//전달 순서대로 설정
		logger.debug("parameter : " + parameter);
        SqlParameter[] sqlParameter = new SqlParameter[] {
    		new SqlParameter("P_UPJANG",      	Types.VARCHAR),
            new SqlParameter("P_ITEM_CODE",     Types.VARCHAR),
            new SqlOutParameter("O_RTN_CD",  	Types.VARCHAR),
            new SqlOutParameter("O_RTN_MSG",   	Types.VARCHAR)
        };
        /*
			P_UPJANG	IN VARCHAR2,
			P_ITEM_CODE	IN VARCHAR2,
		   	O_RTN_CD           OUT VARCHAR2,
		   	O_RTN_MSG        OUT VARCHAR2
			     
         */
        // procedure 호출
        return callProcedure("SP_FS_CLAIM_TICKET_DEL", sqlParameter, parameter);
	}
	
	/**
	 * 클레임처리 [처리취소] 처리된 클레임을 다시 요청상태로 변경한다.  - 교환 처리된 클레임만 가능.
	 *
	 * @param mapParam
	 * @return
	 */
	public int cancelUpdate(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmc.claimProcDAO.cancelUpdate", mapParam);
	}
	
	/**
	 * 클레임처리 [요청] 처리된 클레임을 삭제 HIST 테이블에 저장한다. [요청취소] 상태가 된다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int reqCancelUpdate(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmc.claimProcDAO.claimHistorySave", mapParam);
	}
	
	/**
	 * 클레임처리시 회계일자 항목을 판매단가 테이블의 trans_date2 컬럼에 업데이트
	 *
	 * @param mapParam
	 * @return
	 */
	public int transDate2Update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmc.claimProcDAO.transDate2Update", mapParam);
	}
	
	/**
	 * 클레임 리조트IF 결과 update
	 */
	public int updateInterfaceClaim(Map<String, Object> mapParam) throws Exception{
		return super.update("fm.fmc.claimProcDAO.updateInterfaceClaim", mapParam);
	}
	
}
