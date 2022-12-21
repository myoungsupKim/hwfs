package com.hwfs.ls.lem.service;

import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

/**
 * 성적서 발급 신청 Serive Class
 *
 * @ClassName InspectRptIssueReqService.java
 * @Description InspectRptIssueReqService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 08.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 4. 08.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface InspectRptIssueReqService {

    /**
     * 검체별 성적서 비고를 저장 한다.
     *
     * @param saveList
     * @param parameter
     * @return
     * @throws Exception
     */
    Map<String, Object> saveInspectRptRemark(DataSetMap saveList, Map<String, Object> parameter) throws Exception;

}
