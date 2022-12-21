package com.hwfs.ls.lsm.service;

import java.util.Map;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

/**
 * 월간보고 관리 Serive Class
 *
 * @ClassName MonthlyRptMgmtService.java
 * @Description MonthlyRptMgmtService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 6. 01.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 6. 01.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface MonthlyRptMgmtService {

    /**
     * 월간보고 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectList(Map<String, Object> parameter) throws Exception;

    /**
     * 월간보고 합계 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectListSum(Map<String, Object> parameter) throws Exception;

    /**
     * 월간보고 검사내용 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectSpecmDescList(Map<String, Object> parameter) throws Exception;

    /**
     * 월간보고 검사내용 저장
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    Map<String, Object> saveSpecmDesc(Map<String, Object> parameter, DataSetMap saveList) throws Exception;

    /**
     * 월간보고 검사내용 삭제
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    Map<String, Object> deleteSpecmDesc(Map<String, Object> parameter) throws Exception;

    /**
     * 월간보고 검사내용 복사
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    Map<String, Object> copySpecmDesc(Map<String, Object> parameter) throws Exception;

}
