package com.hwfs.ls.lrm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ls.lem.dao.InspectRptIssueInqueryDAO;
import com.hwfs.ls.lrm.dao.TestAcceptApprvDAO;
import com.hwfs.ls.lrm.dao.TestInfoRegDAO;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 접수정보 조회 ServiceImple Class
 *
 * @ClassName TestAcceptApprvServiceImple.java
 * @Description TestAcceptApprvServiceImple Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 27.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 3. 27.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ls/lrm/testAcceptApprvService")
public class TestAcceptApprvServiceImpl extends DefaultServiceImpl implements TestAcceptApprvService {

    @Resource(name = "/ls/lrm/testAcceptApprvDAO")
    private TestAcceptApprvDAO testAcceptApprvDAO;

    @Resource(name = "/ls/lrm/testInfoRegDAO")
    private TestInfoRegDAO testInfoRegDAO;

    @Resource(name = "/ls/lrm/testRegInqueryService")
    private TestRegInqueryService testRegInqueryService;

    @Resource(name = "/ls/lem/inspectRptIssueInqueryDAO")
    private InspectRptIssueInqueryDAO inspectRptIssueInqueryDAO;

    /**
     * 시험접수목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.SlaTestService#selectList(java.util.Map)
    */
    @Override
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return testAcceptApprvDAO.selectList(parameter);
    }

    /**
     * 접수내역을 상태를 저장 한다. - 접수승인
     *
     * @param testReqAccept
     * @param specmArticleList
     * @param testArticleList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lrm.service.TestInfoRegService#saveTestReqStatus(hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveTestReqStatus(DataSetMap saveList, Map<String, Object> param) throws Exception {
        int procCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;
        String strChk = "0";
        String strProcClass = "";

        strProcClass = LimsUtil.checkNull(param.get("procClass"));

        for (int i = 0; i < saveList.size(); i++) {
            parameter = saveList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_UPDATED) {
                strChk = LimsUtil.checkNull(parameter.get("chk"));
                if ("1".equals(strChk)) {
                    parameter.put("procClass", strProcClass);
                    // 성적서발급신청, 재발급신청인 경우 화면에 있는 반려 사유를 삭제 한다.
                    if ("210".equals(strProcClass) || "250".equals(strProcClass)) {
                        parameter.put("procReason", "");

                        // 2015-07-13 최준열M/신현호M 요청으로 성적서 재발급 신청 시 신청 사유 등록
                        // 이에따라 성적서 발급이력 테이블을 발급신청 시 미리등록 후
                        // 발급 승인 / 성적서발급 시 데이터를 UPDATE한다.
                        // 성적서 발행번호 채번
                        String strPublishNum = inspectRptIssueInqueryDAO.selectCreatePublishNum(parameter);
                        parameter.put("publishNum", strPublishNum);

                        // 성적서 이력 저장
                        procCnt += inspectRptIssueInqueryDAO.saveInsptRptIssueHistory(parameter);
                    }
                    procCnt += testRegInqueryService.saveStatus(parameter);
                    testInfoRegDAO.insertProcDesc(parameter); // 처리내역 저장
                }
            }
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);

        return retVal;
    }

}
