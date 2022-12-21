package com.hwfs.ls.ltm.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

/**
 * 시험진행 및 결과 조회 Serive Class
 *
 * @ClassName TestResultInqueryService.java
 * @Description TestResultInqueryService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 30.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 3. 30.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface TestResultInqueryService {

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
     * 시험일지 데이터를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectTestDiary(Map<String, Object> parameter) throws Exception;

    /**
     * 시험일지 시험방법 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectTestDiaryMethodList(Map<String, Object> parameter) throws Exception;

    /**
     * 시험일지를 저장 한다.
     *
     * @param param
     * @param testArticleList
     * @param testDiaryList
     * @param listFile
     * @return
     * @throws Exception
     */
    Map<String, Object> saveList(Map<String, Object> param, DataSetMap testArticleList, DataSetMap testDiaryList,
            DataSetMap listFile) throws Exception;

    /**
     * 시험결과 상신 전 검사목적,방법을 등록한다.
     *
     * @param param
     * @param testArticleList
     * @param testDiaryList
     * @param listFile
     * @return
     * @throws Exception
     */
    Map<String, Object> saveInsptPurpMtod(Map<String, Object> param) throws Exception;

    /**
     * 시험결과 상신 Master를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    Record selectReportMst(Map<String, Object> parameter) throws Exception;

    /**
     * 시험결과 상신 Detail를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectReportDetail(Map<String, Object> parameter) throws Exception;

    /**
     * 검체폐기 정보를 등록한다.
     *
     * @param param
     * @param testArticleList
     * @param testDiaryList
     * @param listFile
     * @return
     * @throws Exception
     */
    Map<String, Object> saveDisuseYn(DataSetMap saveList) throws Exception;

    /**
     * 성적서 발급여부를 변경.
     *
     * @param param
     * @param testArticleList
     * @param testDiaryList
     * @param listFile
     * @return
     * @throws Exception
     */
    Map<String, Object> saveInspectRptIssueYn(DataSetMap saveList) throws Exception;

    /**
     * 검체 폐기대상 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectSpecmDisuseList(Map<String, Object> parameter) throws Exception;

    /**
     * 검체폐기 정보를 일괄 등록한다.
     *
     * @param param
     * @param testArticleList
     * @param testDiaryList
     * @param listFile
     * @return
     * @throws Exception
     */
    Map<String, Object> saveDisuseAllYn(DataSetMap saveList) throws Exception;

    /**
     * 서버 사진을 조회한다.
     *
     * @param map
     * @return
     */
    RecordSet selectImgList(Map<String, Object> parameter) throws Exception;
    
    /**
     * 구매 수기전송 데이터를 저장한다.
     *
     * @param param
     * @param testArticleList
     * @param testDiaryList
     * @param listFile
     * @return
     * @throws Exception
     */
    Map<String, Object> insertSendItem(DataSetMap saveList) throws Exception;
    
    /**
     * 결재상신팝업 저장내역 조회
     *
     * @param map
     * @return
     * @since 20171123
     * @author 유선미
     */
    RecordSet selectGwDraftTemp(Map<String, Object> parameter) throws Exception;
    
    /**
     * 결재상신 팝업 임시저장
     *
     * @param parameter
     * @return
     * @throws Exception
     * @since 20171123
     * @author 유선미
     */
    int saveGwDraftTemp(Map<String, Object> param) throws Exception;

    /**
     * 시험진행및결과조회 시험목록을 저장한다.
     *
     * @param testArticleList
     * @return
     * @throws Exception
     */
    Map<String, Object> saveResultList(DataSetMap testArticleList) throws Exception;

}



