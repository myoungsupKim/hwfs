package com.hwfs.ls.lcm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

/**
 * 양식서 관리 Serive Class
 *
 * @ClassName FormMgmtService.java
 * @Description FormMgmtService Class
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
public interface FormMgmtService {

    /**
     * 양식서 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectFormList(Map<String, Object> parameter) throws Exception;

    /**
     * 양식서 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    Map<String, Object> selectForm(Map<String, Object> parameter) throws Exception;

    /**
     * 양식서을 저장한다.
     *
     * @param formList
     * @return
     * @throws Exception
     */
    Map<String, Object> saveFormList(DataSetMap formList, DataSetMap fileList) throws Exception;

    /**
     * 첨부파일 삭제
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    Map<String, Object> saveFormAttachFileDelete(Map<String, Object> parameter) throws Exception;

}
