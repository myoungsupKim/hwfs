package com.hwfs.sm.saa.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

/**
 * 부실채권 발생처 조회하는 RiskArList Service Interface
 *
 * @ClassName RiskArListService.java
 * @Description RiskArListService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.28    남기빈        최초생성
 *
 * </pre>
 * @author FC종합전산구축 : 통합영업 남기빈
 * @since 2015.04.28
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface RiskArListService {

    /**
     * 부실채권 발생처 조회 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
    */
    RecordSet selectList(Map<String, Object> mapParam) throws Exception;

    /**
     * 부실채권 발생처 조회 목록(식재)을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    RecordSet selectListFms(Map<String, Object> mapParam) throws Exception;
}
