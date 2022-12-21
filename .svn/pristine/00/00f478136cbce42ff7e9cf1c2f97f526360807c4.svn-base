package com.hwfs.sm.sar.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 입금관리하는 ReceiveMgnt DAO
 * 
 * @ClassName ReceiveMgntDAO.java
 * @Description ReceiveMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.16   	김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.04.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/sar/receiveMgntDAO")
public class ReceiveMgntDAO extends DefaultDAO {
	
	/**
	 * 입금관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.receiveMgntDAO.selectList", mapParam);
	}
	
	/**
	 * 상계/대체 처리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectBTList01(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.receiveMgntDAO.selectBTList01", mapParam);
	}

	public RecordSet selectBTList02(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.receiveMgntDAO.selectBTList02", mapParam);
	}
	
	//전표처리개수
	public RecordSet selectJcnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.receiveMgntDAO.selectJcnt", mapParam);
	}	
	public RecordSet selectJcnt2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.receiveMgntDAO.selectJcnt2", mapParam);
	}	

	//월마감 확인
	public RecordSet chkClose(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.receiveMgntDAO.chkClose", mapParam);
	}
	
	/**
	 * 입금관리상세 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDetailList1(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.receiveMgntDAO.selectDetailList1", mapParam);
	}

	public RecordSet selectDetailList2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.receiveMgntDAO.selectDetailList2", mapParam);
	}

	public RecordSet selectDetailList3(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.sar.receiveMgntDAO.selectDetailList3", mapParam);
	}

	/**
	 * 입금관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveMgntDAO.insert", mapParam);
	}
	
	/**
	 * 입금관리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveMgntDAO.update", mapParam);
	}
	
	/**
	 * 입금관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveMgntDAO.delete", mapParam);
	}
	
	/**
     * 마이너스 상계 처리(팀 코드 포함)
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> batchst1Pro(Map<String, Object> parameter) throws Exception {
        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlOutParameter("O_RTN",         Types.VARCHAR),
            new SqlOutParameter("O_CNT",         Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG",        Types.VARCHAR)          
        };

        String procedureName = "SP_SLA_AR_REV_ADVANCE_PROC_ST1";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
    }
    
    /**
     * 마이너스 상계 처리(팀 코드 제외)
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> batchst1aPro(Map<String, Object> parameter) throws Exception {
        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlOutParameter("O_RTN",         Types.VARCHAR),
            new SqlOutParameter("O_CNT",         Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG",        Types.VARCHAR)          
        };

        String procedureName = "SP_SLA_AR_REV_ADVANCE_ST1A";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
    }
    
    /**
	 * 마이너스 상계(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int batchDelete1(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveMgntDAO.batchDelete1", mapParam);
	}

	public int batchDelete2(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveMgntDAO.batchDelete2", mapParam);
	}

	public int batchDelete3(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveMgntDAO.batchDelete3", mapParam);
	}	

	public int batchUpdate(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveMgntDAO.batchUpdate", mapParam);
	}
	
	/**
     * 플러스채권 대체 처리(팀 코드 포함)
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> batchst2Pro(Map<String, Object> parameter) throws Exception {
        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlOutParameter("O_RTN",         Types.VARCHAR),
            new SqlOutParameter("O_CNT",         Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG",        Types.VARCHAR)          
        };

        String procedureName = "SP_SLA_AR_REV_ADVANCE_PROC_ST2";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
    }
    
    /**
     * 플러스채권 대체 처리(팀 코드 제외)
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> batchst2aPro(Map<String, Object> parameter) throws Exception {
        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlOutParameter("O_RTN",         Types.VARCHAR),
            new SqlOutParameter("O_CNT",         Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG",        Types.VARCHAR)          
        };

        String procedureName = "SP_SLA_AR_REV_ADVANCE_ST2A";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
    }
	
    /**
	 * 플러스채권 대체(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int batchDelete5(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveMgntDAO.batchDelete5", mapParam);
	}

	public int batchDelete6(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveMgntDAO.batchDelete6", mapParam);
	}

	public int batchDelete7(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveMgntDAO.batchDelete7", mapParam);
	}	

	public int batchDelete8(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveMgntDAO.batchDelete8", mapParam);
	}

	public int batchDelete9(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveMgntDAO.batchDelete9", mapParam);
	}	

	public int batchUpdate2(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveMgntDAO.batchUpdate2", mapParam);
	}
	public int batchUpdate3(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.sar.receiveMgntDAO.batchUpdate3", mapParam);
	}
	
	
    
}
