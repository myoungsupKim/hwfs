package com.hwfs.fs.fso.service;

import java.util.Map;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

/**
 * 물건정보 특이사항 관리 Serive Class
 *
 * @ClassName RemarkPopupService.java
 * @Description RemarkPopupService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018.12.18.  김명섭       최초생성
 * </pre>
 * @author FC정보기획팀
 * @since 2018.12.18.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface RemarkPopupService {

    /**
     * 물건정보 특이사항 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
	
    RecordSet selectList(Map<String, Object> mapParam) throws Exception;

    /**
     * 물건정보 특이사항 정보를 저장한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */

    int saveList(DataSetMap list) throws Exception;
       
}