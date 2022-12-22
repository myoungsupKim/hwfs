package com.hwfs.sm.srm.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * SAP 전표 전송하는 SapSlipSendRept DAO
 * 
 * @ClassName SapSlipSendReptDAO.java
 * @Description SapSlipSendReptDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.19   	JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.06.19
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/srm/sapSlipSendReptDAO")
public class SapSlipSendReptDAO extends DefaultDAO {
	
	/**
	 * SAP 전표 전송 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipSendReptDAO.selectList", mapParam);
	}

	/**
	 * SAP 전표 전송 목록을 조회한다.(자동 배치 실행용)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectAutoList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipSendReptDAO.selectAutoList", mapParam);
	}
	
	/**
	 * SAP 전표 전송 목록을 조회한다.(자동 배치 실행용)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectAutoList6B(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipSendReptDAO.selectAutoList6B", mapParam);
	}	
	
	/**
	 * 계약정보 EA 전송 목록을 조회한다.(자동 배치 실행용)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectContractAutoList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipSendReptDAO.selectContractAutoList", mapParam);
	}
	
	
	/**
	 * 그룹웨어 상신을 위한 본문을 생성하여 연동한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSilpList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipSendReptDAO.selectSilpList", mapParam);
	}
	
	/**
	 * 전자결재정보를 Update 처리한다.
	 * <pre>
	 * - Instance ID와 결재진행상태 Update
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int updateSign(Map<String, Object> parameter) throws Exception {
		return super.update("sm.srm.sapSlipSendReptDAO.updateSign", parameter);
	}
	
	/**
	 * 전자결재정보를 Update 처리한다.(계약관리)
	 * <pre>
	 * - Instance ID와 결재진행상태 Update
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int updateSign2(Map<String, Object> parameter) throws Exception {
		return super.update("sm.srm.sapSlipSendReptDAO.updateSign2", parameter);
	}
	
	/**
	 * SAP 전표전송 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet sapIfcSlipMst(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipSendReptDAO.sapIfcSlipMst", mapParam);
	}
	
	/**
	 * SAP 전표전송 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet sapIfcSlipDtl(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipSendReptDAO.sapIfcSlipDtl", mapParam);
	}	
	
	/**
	 * 계약정보 EA 전송할 마스터 정보 복사(FCUS 테이블 -> SAP_IF 테이블)
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertContract(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.sapSlipSendReptDAO.insertContract", mapParam);
	} 
	
	/**
	 * 계약정보 마스터 진행상태값 저장
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateContract(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.sapSlipSendReptDAO.updateContract", mapParam);
	} 

	/**
	 * SAP 전표전송 상태값을 저장한다.(요청)
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateSlipStatusOfSlipMst(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.sapSlipSendReptDAO.updateSlipStatusOfSlipMst", mapParam);
	}
	
	/**
	 * 계약정보 EA 전송 상태값을 저장한다.(요청)
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateContractStatus(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.sapSlipSendReptDAO.updateContractStatus", mapParam);
	}
	
	/**
	 * SAP 전표전송 상태값을 저장한다.(취소)
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateSlipCancelStatusOfSlipMst(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.sapSlipSendReptDAO.updateSlipCancelStatusOfSlipMst", mapParam);
	}
	
	/**
	 * SAP 전표취소 목록을 저장한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertSlaSapSlipCancel(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.sapSlipSendReptDAO.insertSlaSapSlipCancel", mapParam);
	}

	/**
	 * SAP 전표취소 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSlaSapSlipCancel(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipSendReptDAO.selectSlaSapSlipCancel", mapParam);
	}

	/**
	 * 전표 생성시 분개번호 UPDATE procedure 호출
	 *
	 * @param mapParam
	 * @return
	 */
	public Map<String, Object> callProcedure(Map<String, Object> inParam, String callProcName) throws Exception {
		//전달 순서대로 설정
		SqlParameter[] sqlParameter = new SqlParameter[] {
		    new SqlParameter("P_SLIP_NUM",		Types.VARCHAR),
		    new SqlParameter("P_SLIP_STATUS",	Types.VARCHAR),
            new SqlOutParameter("O_RTN",    	Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG", 	Types.VARCHAR)
		};

		// procedure 호출
		return callProcedure(callProcName, sqlParameter, inParam);
	}	
	
	//전표생성취소
	public int updateSapSlipMst(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.sapSlipSendReptDAO.updateSapSlipMst", mapParam);
	}
	
	/**
	 * 자동 배치 실행 여부를 체크한다.
	 *contractMst
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectBatchList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipSendReptDAO.selectBatchList", mapParam);
	}
	
	/**
	 * 계약정보 EA I/F 자동 배치 실행 여부를 체크한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectContractBatchList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipSendReptDAO.selectContractBatchList", mapParam);
	}	
	
	/**
	 * 계약정보 EA I/F 정보 조회
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectContractList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipSendReptDAO.selectContractList", mapParam);
	}	
	
	
	/**
	 * 자동 배치 실행 여부를 체크한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectBatchList6B(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipSendReptDAO.selectBatchList6B", mapParam);
	}		
}
