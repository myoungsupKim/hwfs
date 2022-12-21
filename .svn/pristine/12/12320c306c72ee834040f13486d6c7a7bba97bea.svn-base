package com.hwfs.ls.lrm.dao;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

/**
 * 접수정보 조회 Dao Class
 *
 * @ClassName TestRegInqueryDAO.java
 * @Description TestRegInqueryDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 19.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 3. 19.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ls/lrm/testRegInqueryDAO")
public class TestRegInqueryDAO extends DefaultDAO {

    /**
     * 시험접수목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lrm.testRegInqueryDAO.selectList", parameter);
    }

    /**
     * 접수검체목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectAcceptSpecmList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lrm.testRegInqueryDAO.selectAcceptSpecmList", parameter);
    }

    /**
     * 접수내역을 상태를 저장 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int saveTestReqStatus(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lrm.testRegInqueryDAO.saveTestReqStatus", parameter);
    }

    /**
     * 검체내역을 상태를 저장 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int saveSpecmInfoStatus(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lrm.testRegInqueryDAO.saveSpecmInfoStatus", parameter);
    }

    /**
     * 시험정보내역을 상태를 저장 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int saveTestInfoStatus(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lrm.testRegInqueryDAO.saveTestInfoStatus", parameter);
    }

    /**
     * 라벨출력 대상 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectSpecmLabelPrtList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lrm.testRegInqueryDAO.selectSpecmLabelPrtList", parameter);
    }

    /**
     * 시험결과 구매 전송 대상 목록을 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet testResultItemSendMgmtList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lrm.testRegInqueryDAO.testResultItemSendMgmtList", parameter);
    }

    /**
     * 구매자재 정보를 일괄 등록 Procedure를 호출한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> saveItemSendResult(Map<String, Object> parameter) throws Exception {
        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlParameter("P_REQ_NUM",      Types.VARCHAR),
            new SqlParameter("P_ACCEPT_NUM",   Types.VARCHAR),
            new SqlParameter("P_SPECM_CD",     Types.VARCHAR),
            new SqlParameter("P_STATUS",       Types.VARCHAR),
            new SqlParameter("P_REASON",       Types.VARCHAR),
            new SqlParameter("P_UPJANG_GBN",   Types.VARCHAR),
            new SqlParameter("P_CUSER",        Types.VARCHAR),
            new SqlOutParameter("P_RET_CODE",  Types.VARCHAR),
            new SqlOutParameter("P_RET_MSG",   Types.VARCHAR)
        };

        String procedureName = "LRM_IF_TESTRST_ITEM_SEND_PRO";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
    }

    /**
     * Q-Stop 시험결과 마스터 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Record testResultItemSendMasterList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecord("ls.lrm.testRegInqueryDAO.testResultItemSendMasterList", parameter);
    }

    /**
     * Q-Stop 검체정보 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Record testResultItemSendSpecmInfoList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecord("ls.lrm.testRegInqueryDAO.testResultItemSendSpecmInfoList", parameter);
    }

    /**
     * Q-Stop 시험정보 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet testResultItemSendTestInfoList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lrm.testRegInqueryDAO.testResultItemSendTestInfoList", parameter);
    }

    /**
     * Q-Pass 검체정보 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet testResultItemSendSpecmInfoPassList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lrm.testRegInqueryDAO.testResultItemSendSpecmInfoPassList", parameter);
    }

    /**
     * 기 접수내역 목록조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet preAcceptReqInfoList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lrm.testRegInqueryDAO.preAcceptReqInfoList", parameter);
    }

}
