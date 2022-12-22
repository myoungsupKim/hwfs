package com.hwfs.ls.lum.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

/**
 * 폐수배출 관리 Serive Class
 *
 * @ClassName DrngMgmtService.java
 * @Description DrngMgmtService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 29.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 4. 29.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface DrngMgmtService {

    /**
     * 폐수배출을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectList(Map<String, Object> parameter) throws Exception;

    /**
     * 전체 저장
     *
     * @param reagentTransListt
     * @return
     * @throws Exception
     */
    Map<String, Object> saveList(Map<String, Object> parameter, DataSetMap saveList) throws Exception;

}
