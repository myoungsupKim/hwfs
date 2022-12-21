package com.hwfs.ls.lrm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

/**
 * 접수정보 조회 Serive Class
 *
 * @ClassName TestAcceptApprvService.java
 * @Description TestAcceptApprvService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 19.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 3. 19.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface TestAcceptApprvService {

    /**
     * 시험접수목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectList(Map<String, Object> parameter) throws Exception;

    /**
     * 접수내역을 상태를 저장 한다.
     *
     * @param saveList
     * @param parameter
     * @return
     * @throws Exception
     */
    Map<String, Object> saveTestReqStatus(DataSetMap saveList, Map<String, Object> parameter) throws Exception;

}
