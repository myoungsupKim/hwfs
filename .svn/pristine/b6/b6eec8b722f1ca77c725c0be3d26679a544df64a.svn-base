package com.hwfs.ls.lsm.service;

import java.util.Map;

import hone.core.util.record.RecordSet;

/**
 * 검사자 검사항목 현황 Serive Class
 *
 * @ClassName TestUserSpecmArticleInqueryService.java
 * @Description TestUserSpecmArticleInqueryService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 9. 23.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 9. 23.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface TestUserSpecmArticleInqueryService {

    /**
     * 검사구분별 검사 건수
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectList(Map<String, Object> parameter) throws Exception;

    /**
     * 담당자별 검수 건수
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectList1(Map<String, Object> parameter) throws Exception;

    /**
     * 검사분야 현황 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectDetailList(Map<String, Object> parameter) throws Exception;

    /**
     * 검사분야 현황 상세 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectDetailViewList(Map<String, Object> parameter) throws Exception;

}
