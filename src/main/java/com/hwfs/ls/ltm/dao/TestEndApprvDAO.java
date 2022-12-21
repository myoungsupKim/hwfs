package com.hwfs.ls.ltm.dao;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;
import com.hwfs.ls.cmn.util.LimsUtil;

import hone.core.util.record.RecordSet;

/**
 * 시험완료정보 조회 Dao Class
 *
 * @ClassName TestEndApprvDAO.java
 * @Description TestEndApprvDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 07.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 4. 07.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ls/ltm/testEndApprvDAO")
public class TestEndApprvDAO extends DefaultDAO {

    /**
     * 검체별로 부적합분류를 저장 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int saveSpecmNotFitClsfi(Map<String, Object> parameter) throws Exception {
        return super.update("ls.ltm.testEndApprvDAO.saveSpecmNotFitClsfi", parameter);
    }

    /**
     * 시험완료내역을 상태를 저장 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int saveTestReqStatus(Map<String, Object> parameter) throws Exception {
        return super.update("ls.ltm.testEndApprvDAO.saveTestReqStatus", parameter);
    }

    /**
     * IFIS에서 넘어와 처리 승인된 정보를 IFIS 테이블에 저장
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int updateTestEndApprvIFIS(Map<String, Object> parameter) throws Exception {
        return super.update("ls.ltm.testEndApprvDAO.updateTestEndApprvIFIS", parameter);
    }

    /**
     * 매출 데이터를 통합영업에 전송한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> updateTestEndApprvSLA(Map<String, Object> parameter) throws Exception {

        if (!LimsUtil.checkNull(parameter.get("p_upmu")).equals("IFIS") &&
            !LimsUtil.checkNull(parameter.get("p_upmu")).equals("SPEC")) {
            parameter.put("p_uprice", 0);
        }

        if (!LimsUtil.checkNull(parameter.get("p_upmu")).equals("SPEC") &&
            !LimsUtil.checkNull(parameter.get("p_upmu")).equals("FTPC") &&
            !LimsUtil.checkNull(parameter.get("p_upmu")).equals("FTPCD")) {
            parameter.put("p_gamang_cd", "");
            parameter.put("p_card_gubun", "");
        }

        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlParameter("P_UPMU",              Types.VARCHAR),
            new SqlParameter("P_REQ_NUM",           Types.VARCHAR),
            new SqlParameter("P_OCCUR_DATE",        Types.VARCHAR),
            new SqlParameter("P_UPJANG",            Types.VARCHAR),
            new SqlParameter("P_MU_CD",             Types.VARCHAR),
            new SqlParameter("P_CC_CD",             Types.VARCHAR),

            new SqlParameter("P_CUSTCD",            Types.VARCHAR),
            new SqlParameter("P_VAT_GUBUN",         Types.VARCHAR),
            new SqlParameter("P_UPRICE",            Types.INTEGER),
            new SqlParameter("P_AMT",               Types.INTEGER),
            new SqlParameter("P_SAL_QUANTITY",      Types.INTEGER),

            new SqlParameter("P_CUSER",             Types.VARCHAR),
            new SqlParameter("P_PARAM_RECEIPT_NUM", Types.VARCHAR),
            new SqlParameter("P_PAY_CD",            Types.VARCHAR),

            new SqlParameter("P_GAMANG_CD",         Types.VARCHAR),
            new SqlParameter("P_CARD_GUBUN",        Types.VARCHAR),

            new SqlOutParameter("P_RET_CODE",       Types.VARCHAR),
            new SqlOutParameter("P_RET_MSG",        Types.VARCHAR),
            new SqlOutParameter("P_RECEIPT_NUM",    Types.VARCHAR)
        };

        String procedureName = "LTM_IF_SLA_SALESINFO_PRO";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
    }

    /**
     * 통합영업의 일마감을 호출한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> updateTestEndApprvSLAISRC(Map<String, Object> parameter) throws Exception {
        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlParameter("P_OCCUR_DATE",  Types.VARCHAR),
            new SqlParameter("P_SYS_CLASS",   Types.VARCHAR),
            new SqlParameter("P_UPJANG_CD",   Types.VARCHAR),
            new SqlOutParameter("O_RTN",      Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG",   Types.VARCHAR)
        };

        String procedureName = "SP_SLA_SALS_POS_MAGAM_PROC";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
    }

    /**
     * 부적합 자재에 대한 구매/자재 QStop Procedure를 호출한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> updateTestEndApprvItemNotfitProcC(Map<String, Object> parameter) throws Exception {
        //전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
            new SqlParameter("P_REQ_NUM",      Types.VARCHAR),
            new SqlParameter("P_CUSER",        Types.VARCHAR),
            new SqlOutParameter("P_RET_CODE",  Types.VARCHAR),
            new SqlOutParameter("P_RET_MSG",   Types.VARCHAR)
        };

        String procedureName = "LTM_IF_ITEM_NOTFITINFO_PRO";

        // procedure 호출
        return callProcedure(procedureName, sqlParameter, parameter);
    }

    /**
     * 검체목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectSpecmList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.ltm.testEndApprvDAO.selectSpecmList", parameter);
    }

    /**
     * LIMS 매출정보를 조회 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectLimsSalesInfo(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.ltm.testEndApprvDAO.selectLimsSalesInfo", parameter);
    }

    /**
     * LIMS 매출관리 MU_CD, CC_CD, UPJANG을 조회 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectLimsSalesUpjangInfo(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.ltm.testEndApprvDAO.selectLimsSalesUpjangInfo", parameter);
    }

}
