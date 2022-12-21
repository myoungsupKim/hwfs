package com.hwfs.am.ams.service;

import java.util.Map;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

/**
 * 전산장비 요청 관리 Serive Class
 *
 * @ClassName EquipmentRequestService.java
 * @Description EquipmentRequestService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018.12.06.  김명섭       최초생성
 * </pre>
 * @author FC정보기획팀
 * @since 2018.12.06.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface EquipmentRequestService {

    /**
     * 전산장비 관리자 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
	
    RecordSet selectAdminList(Map<String, Object> mapParam) throws Exception;

    /**
     * 전산장비 요청 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
	
    RecordSet selectList(Map<String, Object> mapParam) throws Exception;

    /**
     * 전산장비 요청 정보를 저장한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */

    int saveList(DataSetMap list) throws Exception;
    
    /**
     * 전산장비 마스터를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
	
    RecordSet selectEqList(Map<String, Object> mapParam) throws Exception;
    
}