package com.hwfs.ls.lcm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

/**
 * 시험항목 관리 Serive Class
 *
 * @ClassName TestArticleMgmtService.java
 * @Description TestArticleMgmtService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 2. 9.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 2. 9.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface TestArticleMgmtService {

    /**
     * 시험항목을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectTestArticleList(Map<String, Object> parameter) throws Exception;

    /**
     * 시험항목을 저장한다.
     *
     * @param testArticleListt
     * @return
     * @throws Exception
     */
    Map<String, Object> saveTestArticleList(DataSetMap testArticleList) throws Exception;

    /**
     * 전체 저장
     *
     * @param testArticleListt
     * @return
     * @throws Exception
     */
    Map<String, Object> saveList(DataSetMap testArticleList) throws Exception;

    /**
     * 전체 삭제
     *
     * @param search
     * @param specmTypeArticleList
     * @return
     * @throws Exception
     */
    Map<String, Object> saveDelAllList(DataSetMap search, DataSetMap testArticleList) throws Exception;

}
