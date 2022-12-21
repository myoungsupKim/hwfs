package com.hwfs.ls.lrm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

/**
 * 접수정보 등록 Serive Class
 *
 * @ClassName TestInfoRegService.java
 * @Description TestInfoRegService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 23.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 3. 23.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface TestInfoRegService {

    /**
     * 시험항목목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectTestArticleList(Map<String, Object> parameter) throws Exception;

    /**
     * 사업장목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectUpjangList(Map<String, Object> parameter) throws Exception;

    /**
     * 의뢰정보를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectTestReqAcceptList(Map<String, Object> parameter) throws Exception;

    /**
     * 접수정보를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectSpecmInfoList(Map<String, Object> parameter) throws Exception;

    /**
     * 시험정보를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectTestInfoList(Map<String, Object> parameter) throws Exception;

    /**
     * 진행사항 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectTestInfoProgressList(Map<String, Object> parameter) throws Exception;

    /**
     * 접수시험정보를 저장한다.
     *
     * @param testReqAccept
     * @param specmArticleList
     * @param testArticleList
     * @return
     * @throws Exception
     */
    Map<String, Object> saveList(DataSetMap testReqAccept, DataSetMap specmArticleList, DataSetMap testArticleList,
            DataSetMap paramValue) throws Exception;

    /**
     * 검체정보를 저장한다.
     *
     * @param param
     * @param specmArticleList
     * @param testArticleList
     * @return
     * @throws Exception
     */
    int saveSpecmArticleList(Map<String, Object> param, DataSetMap specmArticleList, DataSetMap testArticleList) throws Exception;

    /**
     * 시험항목정보를 저장한다.
     *
     * @param seqNum
     * @param param
     * @param testArticleList
     * @return
     * @throws Exception
     */
    int saveTestArticleList(String seqNum, Map<String, Object> param, DataSetMap testArticleList) throws Exception;
    
    /**
     * 접수시험정보를 임시저장한다.
     *
     * @param testReqAccept
     * @param specmArticleList
     * @param testArticleList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lrm.service.TestInfoRegService#saveList(hone.online.xplatform.map.DataSetMap, hone.online.xplatform.map.DataSetMap, hone.online.xplatform.map.DataSetMap)
    */
    Map<String, Object> saveTemp(DataSetMap testReqAccept, DataSetMap specmArticleList, DataSetMap testArticleList) throws Exception;
    
    /**
     * 임시저장 불러오기 팝업 목록 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectLoadTestInfoTempList(Map<String, Object> parameter) throws Exception;

    /**
     * 의뢰정보를 조회한다.(temp table)
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectTestReqAcceptListTemp(Map<String, Object> parameter) throws Exception;

    /**
     * 접수정보를 조회한다.(temp table)
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectSpecmInfoListTemp(Map<String, Object> parameter) throws Exception;

    /**
     * 시험정보를 조회한다.(temp table)
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectTestInfoListTemp(Map<String, Object> parameter) throws Exception;

}
