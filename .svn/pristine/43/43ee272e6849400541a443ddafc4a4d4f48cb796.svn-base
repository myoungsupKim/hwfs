package com.hwfs.ls.lcm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

/**
 * 담당자 관리 Serive Class
 *
 * @ClassName UserMgmtService.java
 * @Description UserMgmtService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 9.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 3. 9.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface UserMgmtService {

    /**
     * 담당자 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectUserMgmtList(Map<String, Object> parameter) throws Exception;

    /**
     * 권한별 담당자 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectUserList(Map<String, Object> parameter) throws Exception;

    /**
     * 담당자를 저장한다.
     *
     * @param userList
     * @param rparLogList
     * @return
     * @throws Exception
     */
    Map<String, Object> saveUserList(String realPath, DataSetMap userList) throws Exception;

    /**
     * 식품연구소 사원을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectHrUserList(Map<String, Object> parameter) throws Exception;

}
