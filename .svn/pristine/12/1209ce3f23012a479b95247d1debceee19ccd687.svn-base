package com.hwfs.am.ams.service;

import java.util.Map;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

/**
 * 전산장비 등록 관리 Serive Class
 *
 * @ClassName EquipmentRegistService.java
 * @Description EquipmentRegistService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018.12.12.  김명섭       최초생성
 * </pre>
 * @author FC정보기획팀
 * @since 2018.12.12.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface EquipmentRegistService {

    /**
     * 전산장비 관리자 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
	
    RecordSet selectAdminList(Map<String, Object> mapParam) throws Exception;

    RecordSet selectBarprtList(Map<String, Object> mapParam) throws Exception;
    
    /**
     * 전산장비 등록정보를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
	
    RecordSet selectList(Map<String, Object> mapParam) throws Exception;

    /**
     * 전산장비 등록정보를 저장한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */

    int saveList(String realPath, DataSetMap list) throws Exception;
    
    /**
     * 전산장비 마스터를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
	
    RecordSet selectEqList(Map<String, Object> mapParam) throws Exception;

    /**
     * 전산장비 히스토리 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
	
    RecordSet selectHist(Map<String, Object> mapParam) throws Exception;

    /**
     * 전산장비 AS정보를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
	
    RecordSet selectAsList(Map<String, Object> mapParam) throws Exception;

    /**
     * 전산장비 AS 특이사항 정보를 저장한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */

    int saveAsList(DataSetMap list) throws Exception;

    /**
     * 전산장비 출력정보를 저장한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */

    int savePrtList(DataSetMap list) throws Exception;

    /**
     * 상세 코드 일괄 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectCodeDtlBatchList(Map<String, Object> parameter) throws Exception;
    
}