package com.hwfs.sm.saa.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

/**
 * 판매/수금 부동처 현황하는 SaleColletionList Service Interface
 *
 * @ClassName SaleColletionListService.java
 * @Description SaleColletionListService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.12    최종덕        최초생성
 *
 * </pre>
 * @author FC종합전산구축 : 통합영업 최종덕
 * @since 2015.05.12
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface SaleColletionListService {

    /**
     * 판매부동처 및 수금부동처 현황을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
    */
    RecordSet selectList(Map<String, Object> mapParam) throws Exception;

    /**
     * 판매부동처 및 수금부동처 현황(식재)을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    RecordSet selectListFms(Map<String, Object> mapParam) throws Exception;
}
