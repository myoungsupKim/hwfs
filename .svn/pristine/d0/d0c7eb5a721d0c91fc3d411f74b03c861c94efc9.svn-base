package com.hwfs.ls.lcm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

/**
 * 검체유형 위험도매핑 관리 Serive Class
 *
 * @ClassName SpecmTypeDangerMappMgmtService.java
 * @Description SpecmTypeDangerMappMgmtService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3.12.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 3.12.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface SpecmTypeDangerMappMgmtService {

    /**
     * 검체유형 위험도매핑을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectSpecmDangerMappList(Map<String, Object> parameter) throws Exception;

    /**
     * 검체유형 위험도매핑을 저장한다.
     *
     * @param specmDangerMappListt
     * @return
     * @throws Exception
     */
    Map<String, Object> saveSpecmDangerMappList(DataSetMap search, DataSetMap specmDangerMappListt) throws Exception;

    /**
     * 전체 저장
     *
     * @param specmDangerMappListt
     * @return
     * @throws Exception
     */
    Map<String, Object> saveList(DataSetMap search, DataSetMap specmDangerMappListt) throws Exception;

    /**
     * 전체 삭제
     *
     * @param search
     * @param specmTypeArticleList
     * @return
     * @throws Exception
     */
    Map<String, Object> saveDelAllList(DataSetMap search, DataSetMap specmTypeArticleList) throws Exception;

}
