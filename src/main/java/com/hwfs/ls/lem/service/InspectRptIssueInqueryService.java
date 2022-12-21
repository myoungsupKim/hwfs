package com.hwfs.ls.lem.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

/**
 * 성적서발급 및 결과 조회 Serive Class
 *
 * @ClassName InspectRptIssueInqueryService.java
 * @Description InspectRptIssueInqueryService Class
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
public interface InspectRptIssueInqueryService {

    /**
     * 의뢰목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectList(Map<String, Object> parameter) throws Exception;

    /**
     * 검체목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectSpecmList(Map<String, Object> parameter) throws Exception;

    /**
     * 시험항목 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectDetailList(Map<String, Object> parameter) throws Exception;

    /**
     * 성적서발급이력 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectInspectRptIssueHistList(Map<String, Object> parameter) throws Exception;

    /**
     * 성적서 검체내역을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectInsptRptSpecmtList(Map<String, Object> parameter) throws Exception;

    /**
     * 성적서 시험결과 내역을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectInsptRptTestResultList(Map<String, Object> parameter) throws Exception;

    /**
     * 성적서 시험담당자 내역을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectInsptRptTestUserList(Map<String, Object> parameter) throws Exception;

    /**
     * 성적서 시험기술책임자 내역을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectInsptRptTestTechUserList(Map<String, Object> parameter) throws Exception;

    /**
     * 성적서 발급 이력을 저장 한다.
     *
     * @param saveList
     * @param parameter
     * @return
     * @throws Exception
     */
    Map<String, Object> saveInsptRptIssueHistory(Map<String, Object> parameter) throws Exception;

}
