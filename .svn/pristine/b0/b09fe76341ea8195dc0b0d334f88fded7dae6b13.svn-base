package com.hwfs.ls.lcm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

/**
 * 검체유형항목 관리 Serive Class
 *
 * @ClassName SpecmTypeArticleMgmtService.java
 * @Description SpecmTypeArticleMgmtService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 3.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 3. 3.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface SpecmTypeArticleMgmtService {

    /**
     * 검체유형항목을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectList(Map<String, Object> parameter) throws Exception;

    /**
     * 대분류를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectMgrpList(Map<String, Object> parameter) throws Exception;

    /**
     * 중분류를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectMcalssList(Map<String, Object> parameter) throws Exception;

    /**
     * 소분류를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectSclassList(Map<String, Object> parameter) throws Exception;

    /**
     * 일괄 저장한다.
     *
     * @param search
     * @param specmTypeArticleList
     * @return
     * @throws Exception
     */
    Map<String, Object> saveList(DataSetMap search, DataSetMap specmTypeArticleList) throws Exception;

    /**
     * 전체 삭제 한다.
     *
     * @param search
     * @param specmTypeArticleList
     * @return
     * @throws Exception
     */
    Map<String, Object> saveDelAllList(DataSetMap search, DataSetMap specmTypeArticleList) throws Exception;

    /**
     * 중분류를 저장한다.
     *
     * @param specmTypeArticleList
     * @return
     * @throws Exception
     */
    Map<String, Object> saveMgrpList(DataSetMap specmTypeArticleList) throws Exception;

    /**
     * 소분류를 저장한다
     *
     * @param specmTypeArticleList
     * @return
     * @throws Exception
     */
    Map<String, Object> saveMcalssList(DataSetMap specmTypeArticleList) throws Exception;

    /**
     * 검체항목유형 전체를 삭제 한다.
     *
     * @param specmTypeArticleList
     * @return
     * @throws Exception
     */
    Map<String, Object> saveSclassList(DataSetMap specmTypeArticleList) throws Exception;

}
