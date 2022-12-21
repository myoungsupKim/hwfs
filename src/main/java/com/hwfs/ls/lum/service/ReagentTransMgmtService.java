package com.hwfs.ls.lum.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

/**
 * 시약수불 관리 Serive Class
 *
 * @ClassName ReagentTransMgmtService.java
 * @Description ReagentTransMgmtService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 22.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 4. 22.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface ReagentTransMgmtService {

    /**
     * 시약수불을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectList(Map<String, Object> parameter) throws Exception;

    /**
     * 시약수불 내역을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectSummaryList(Map<String, Object> parameter) throws Exception;

    /**
     * 전체 저장
     *
     * @param reagentTransListt
     * @return
     * @throws Exception
     */
    Map<String, Object> saveList(Map<String, Object> parameter, DataSetMap saveList) throws Exception;

}
