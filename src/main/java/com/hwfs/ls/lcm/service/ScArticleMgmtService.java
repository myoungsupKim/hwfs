package com.hwfs.ls.lcm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

/**
 * ScArticleMgmtService에 대한 설명 작성
 *
 * @ClassName ScArticleMgmtService.java
 * @Description ScArticleMgmtService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 1. 28.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 1. 28.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface ScArticleMgmtService {

    /**
     * 공통코드 그룹코드를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectGroupList(Map<String, Object> parameter) throws Exception;

    /**
     * 특정 그룹코드에 맞는 공통코드를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectCodeList(Map<String, Object> parameter) throws Exception;

    /**
     * 상세 코드 일괄 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectCodeDtlBatchList(Map<String, Object> parameter) throws Exception;

    /**
     * 그룹코드를 저장한다.
     *
     * @param groupList
     * @return
     * @throws Exception
     */
    int saveGroupList(DataSetMap groupList) throws Exception;

    /**
     * 특정 그룹코드의 코드정보를 저장 한다.
     *
     * @param codeList
     * @return
     * @throws Exception
     */
    int saveCodeList(DataSetMap codeList) throws Exception;

}
