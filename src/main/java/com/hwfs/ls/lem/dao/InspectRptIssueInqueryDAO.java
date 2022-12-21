package com.hwfs.ls.lem.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 성적서발급 및 결과 조회 Dao Class
 *
 * @ClassName InspectRptIssueInqueryDAO.java
 * @Description InspectRptIssueInqueryDAO Class
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
@Repository("/ls/lem/inspectRptIssueInqueryDAO")
public class InspectRptIssueInqueryDAO extends DefaultDAO {

    /**
     * 의뢰목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lem.inspectRptIssueInqueryDAO.selectList", parameter);
    }

    /**
     * 검체목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectSpecmList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lem.inspectRptIssueInqueryDAO.selectSpecmList", parameter);
    }

    /**
     * 시험항목 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectDetailList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lem.inspectRptIssueInqueryDAO.selectDetailList", parameter);
    }

    /**
     * 성적서발급이력 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectInspectRptIssueHistList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lem.inspectRptIssueInqueryDAO.selectInspectRptIssueHistList", parameter);
    }

    /**
     * 성적서 발급번호를 채번 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public String selectCreatePublishNum(Map<String, Object> parameter) throws Exception {
        return (String) super.queryForObject("ls.lem.inspectRptIssueInqueryDAO.selectCreatePublishNum", parameter, null);
    }

    /**
     * 성적서 검체내역을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectInsptRptSpecmtList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lem.inspectRptIssueInqueryDAO.selectInsptRptSpecmtList", parameter);
    }

    /**
     * 성적서 시험결과 내역을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectInsptRptTestResultList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lem.inspectRptIssueInqueryDAO.selectInsptRptTestResultList", parameter);
    }

    /**
     * 성적서 시험담당자 내역을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectInsptRptTestUserList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lem.inspectRptIssueInqueryDAO.selectInsptRptTestUserList", parameter);
    }

    /**
     * 성적서 시험기술책임자 내역을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectInsptRptTestTechUserList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lem.inspectRptIssueInqueryDAO.selectInsptRptTestTechUserList", parameter);
    }

    /**
     * 성적서 발급 이력을 저장 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int saveInsptRptIssueHistory(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lem.inspectRptIssueInqueryDAO.saveInsptRptIssueHistory", parameter);
    }

    /**
     * 성적서 발급 이력 승인자정보를 저장한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int saveInsptRptIssueHistoryAppr(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lem.inspectRptIssueInqueryDAO.saveInsptRptIssueHistoryAppr", parameter);
    }

    /**
     * 성적서 발급 이력 정보를 삭제한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteInsptRptIssueHistoryAppr(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lem.inspectRptIssueInqueryDAO.deleteInsptRptIssueHistoryAppr", parameter);
    }

    /**
     * 성적서 발급 이력 발급일자를 저장한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int saveInsptRptIssueHistoryPub(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lem.inspectRptIssueInqueryDAO.saveInsptRptIssueHistoryPub", parameter);
    }

}
