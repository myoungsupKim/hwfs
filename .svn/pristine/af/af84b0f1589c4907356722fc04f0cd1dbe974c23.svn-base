package com.hwfs.ls.lum.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

/**
 * 장비이력과 수리이력 관리 Serive Class
 *
 * @ClassName EquipMgmtService.java
 * @Description EquipMgmtService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 1. 28.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 1. 28.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface EquipMgmtService {

    /**
     * 장비이력를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectEquipLogList(Map<String, Object> parameter) throws Exception;

    /**
     * 특정 장비이력에 맞는 수리이력를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectRparLogList(Map<String, Object> parameter) throws Exception;

    /**
     * 장비이력과 수리이력을 저장한다.
     *
     * @param equipLogList
     * @param rparLogList
     * @return
     * @throws Exception
     */
    Map<String, Object> saveEquipLogList(String realPath, DataSetMap equipLogList, DataSetMap rparLogList, DataSetMap fileList)
            throws Exception;

    /**
     * 수리이력을 저장 한다.
     *
     * @param equipNum
     * @param rparLogList
     * @return
     * @throws Exception
     */
    int saveRparLogList(String equipNum, DataSetMap rparLogList) throws Exception;

    /**
     * 장비이력 첨부파일을 삭제 한다.
     *
     * @param equipNum
     * @param rparLogList
     * @return
     * @throws Exception
     */
    Map<String, Object> deleteEquipLogFileAppend(Map<String, Object> parameter) throws Exception;

    /**
     * 첨부파일 참조 순번을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    Map<String, Object> selectEquipLogRefSeq(Map<String, Object> parameter) throws Exception;

}
