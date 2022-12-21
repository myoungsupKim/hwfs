package com.hwfs.fm.fmp.service;

import java.util.Map;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

/**
 * 창고일괄변경 Serive Class
 *
 * @ClassName WhPackModifyService.java
 * @Description SpecmTYpeTestArticleMgmtService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 8. 5.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 8. 5.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface WhPackModifyService {

    /**
     * 창고일괄변경 목록을 조회한다
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectList(Map<String, Object> parameter) throws Exception;

    /**
     * 일자를 조회한다
     *
     * @param searchList
     * @param saveList
     * @return
     * @throws Exception
     */
    RecordSet selectDdayList(Map<String, Object> parameter) throws Exception;

    /**
     * 시간을 조회한다
     *
     * @param searchList
     * @param saveList
     * @return
     * @throws Exception
     */
    RecordSet selectDtimesList(Map<String, Object> parameter) throws Exception;

    /**
     * 일자 시간을 저장
     *
     * @param search
     * @param saveList
     * @return
     * @throws Exception
     */
    Map<String, Object> modifyList(DataSetMap saveList) throws Exception;

    /**
     * 일괄 일자 시간을 저장
     *
     * @param search
     * @param saveList
     * @return
     * @throws Exception
     */
    Map<String, Object> modifyAllList(Map<String, Object> parameter, DataSetMap saveList) throws Exception;

}
