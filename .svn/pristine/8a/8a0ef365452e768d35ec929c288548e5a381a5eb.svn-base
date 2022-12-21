package com.hwfs.ls.lcm.service;

import java.util.Map;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

/**
 * 기타검체유형 관리 Serive Class
 *
 * @ClassName EtcSpecmArticleMgmtService.java
 * @Description EtcSpecmArticleMgmtService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 17.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 3. 17.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface EtcSpecmArticleMgmtService {

    /**
     * 기타검체유형을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectList(Map<String, Object> parameter) throws Exception;

    /**
     * 구매이력정보를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectTransItemList(Map<String, Object> parameter) throws Exception;

    /**
     * 기타검체유형을 저장한다.
     *
     * @param testArticleListt
     * @return
     * @throws Exception
     */
    Map<String, Object> saveList(DataSetMap saveList) throws Exception;

}
