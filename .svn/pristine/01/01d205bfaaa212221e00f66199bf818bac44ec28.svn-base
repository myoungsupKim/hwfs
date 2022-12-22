package com.hwfs.ls.lsm.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

/**
 * 통합목록 조회 Serive Class
 *
 * @ClassName IntergInqueryService.java
 * @Description IntergInqueryService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 13.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 4. 13.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface IntergInqueryService {

    /**
     * 통합목록 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectList(Map<String, Object> parameter) throws Exception;

    /**
     * 대분류를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectMgrpList(Map<String, Object> parameter) throws Exception;

    /**
     * 중분류를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectMcalssList(Map<String, Object> parameter) throws Exception;

    /**
     * 소분류를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectSclassList(Map<String, Object> parameter) throws Exception;

}
