package com.hwfs.ls.ltm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

/**
 * 시험결과등록-검체항목별 Serive Class
 *
 * @ClassName TestResultSpecmArticleRegService.java
 * @Description TestResultSpecmArticleRegService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 04. 01.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 04. 01.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface TestResultSpecmArticleRegService {

    /**
     * 검체목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectList(Map<String, Object> parameter) throws Exception;

    /**
     * 시험항목 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectDetailList(Map<String, Object> parameter) throws Exception;

    /**
     * 시험항목 판정내역을 저장한다.
     *
     * @param param
     * @param testArticleList
     * @param testDiaryList
     * @param listFile
     * @return
     * @throws Exception
     */
    Map<String, Object> saveList(Map<String, Object> param, DataSetMap testArticleList) throws Exception;

}
