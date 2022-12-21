package com.hwfs.ls.lem.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 성적서 발급 신청 Dao Class
 *
 * @ClassName InspectRptIssueReqDAO.java
 * @Description InspectRptIssueReqDAO Class
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
@Repository("/ls/lem/inspectRptIssueReqDAO")
public class InspectRptIssueReqDAO extends DefaultDAO {

    /**
     * 검체별 성적서 비고를 저장 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int saveInspectRptRemark(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lem.inspectRptIssueReqDAO.saveInspectRptRemark", parameter);
    }

}
