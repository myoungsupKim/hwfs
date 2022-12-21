package com.hwfs.fs.fse.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

/**
 * 이벤트 결과등록 관리하는 EventResultRegMgnt Service Interface
 *
 * @ClassName EventResultRegMgntService.java
 * @Description EventResultRegMgntService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.17    최종덕        최초생성
 *
 * </pre>
 * @author FC종합전산구축 : 통합영업 최종덕
 * @since 2015.04.17
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface EventResultRegMgntService {

    /**
     * 이벤트 분류 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
    */
    RecordSet selectCboList(Map<String, Object> parameter) throws Exception;

    /**
     * 이벤트 테마 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
    */
    RecordSet selectThemeList(Map<String, Object> parameter) throws Exception;

    /**
     * 이벤트 결과등록 관리 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
    */
    RecordSet selectList(Map<String, Object> parameter) throws Exception;

    /**
     * 이벤트 결과정보를 조회한다.
     *
     * @param map
     * @return
     */
    RecordSet selectResult(Map<String, Object> parameter) throws Exception;

    /**
     * 이벤트 결과등록 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
     *
     * @param form
     * @param file
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
     */
    int saveList(DataSetMap form, DataSetMap file) throws Exception;
}
