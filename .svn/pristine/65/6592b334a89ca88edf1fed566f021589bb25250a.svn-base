package com.hwfs.ls.lrm.service;

import java.util.Map;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

/**
 * 접수정보 조회 Serive Class
 *
 * @ClassName TestRegInqueryService.java
 * @Description TestRegInqueryService Class
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
public interface TestRegInqueryService {

    /**
     * 시험접수목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectList(Map<String, Object> parameter) throws Exception;

    /**
     * 접수목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectAcceptSpecmList(Map<String, Object> parameter) throws Exception;

    /**
     * 접수내역을 상태를 저장 한다.
     *
     * @param saveList
     * @param parameter
     * @return
     * @throws Exception
     */
    Map<String, Object> saveTestReqStatus(DataSetMap saveList, Map<String, Object> parameter) throws Exception;

    /**
     * 접수내역/검체내역/시험항목내역 상태를 저장 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    int saveStatus(Map<String, Object> parameter) throws Exception;

    /**
     * 라벨출력 대상 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectSpecmLabelPrtList(Map<String, Object> parameter) throws Exception;

    /**
     * 시험결과 구매 전송 대상 목록을 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet testResultItemSendMgmtList(Map<String, Object> parameter) throws Exception;

    /**
     * 구매자재 정보를 일괄 등록한다.
     *
     * @param saveList
     * @return
     * @throws Exception
     */
    Map<String, Object> saveItemSendResult(DataSetMap saveList) throws Exception;

    /**
     * Q-Stop 시험결과 마스터 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    Record testResultItemSendMasterList(Map<String, Object> parameter) throws Exception;

    /**
     * Q-Stop 검체정보 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    Record testResultItemSendSpecmInfoList(Map<String, Object> parameter) throws Exception;

    /**
     * Q-Stop 시험정보 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet testResultItemSendTestInfoList(Map<String, Object> parameter) throws Exception;

    /**
     * Q-Pass 검체정보 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet testResultItemSendSpecmInfoPassList(Map<String, Object> parameter) throws Exception;

    /**
     * 기 접수내역 목록조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet preAcceptReqInfoList(Map<String, Object> parameter) throws Exception;

}
