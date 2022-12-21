package com.hwfs.ls.lem.service;

import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ls.lem.dao.InspectRptIssueReqDAO;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 성적서 발급 신청 ServiceImple Class
 *
 * @ClassName InspectRptIssueReqServiceImple.java
 * @Description InspectRptIssueReqServiceImple Class
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
@Service("/ls/lem/inspectRptIssueReqService")
public class InspectRptIssueReqServiceImpl extends DefaultServiceImpl implements InspectRptIssueReqService {

    @Resource(name = "/ls/lem/inspectRptIssueReqDAO")
    private InspectRptIssueReqDAO inspectRptIssueReqDAO;

    /**
     * 검체별 성적서 비고를 저장 한다.
     *
     * @param testReqAccept
     * @param specmArticleList
     * @param testArticleList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lem.service.InspectRptIssueReqServiceImpl#saveInspectRptRemark(hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveInspectRptRemark(DataSetMap saveList, Map<String, Object> param) throws Exception {
        int procCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;

        for (int i = 0; i < saveList.size(); i++) {
            parameter = saveList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_UPDATED) {
                procCnt += inspectRptIssueReqDAO.saveInspectRptRemark(parameter);
            }
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);

        return retVal;
    }

}
