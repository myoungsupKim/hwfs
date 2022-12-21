package com.hwfs.ls.lcm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

/**
 * 검체유형 시험항목 관리 Serive Class
 *
 * @ClassName SpecmTypeTestArticleMgmtService.java
 * @Description SpecmTYpeTestArticleMgmtService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 16.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 3. 16.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface SpecmTypeTestArticleMappMgmtService {

    /**
     * 검체유형 시험항목을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectList(Map<String, Object> parameter) throws Exception;

    /**
     * 검체유형 시험항목을 저장한다.
     *
     * @param searchList
     * @param saveList
     * @return
     * @throws Exception
     */
    Map<String, Object> saveList(DataSetMap searchList, DataSetMap saveList) throws Exception;

    /**
     * 전체 삭제
     *
     * @param search
     * @param saveList
     * @return
     * @throws Exception
     */
    Map<String, Object> saveDelAllList(DataSetMap search, DataSetMap saveList) throws Exception;

    /**
     * 엑셀업로드 검체유형 시험항목을 저장한다.
     *
     * @param saveList
     * @return
     * @throws Exception
     */
    Map<String, Object> saveExlList(DataSetMap saveExlList) throws Exception;

    /**
     * 검체유형 시험항목을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectMappingList(Map<String, Object> parameter) throws Exception;
    
}
