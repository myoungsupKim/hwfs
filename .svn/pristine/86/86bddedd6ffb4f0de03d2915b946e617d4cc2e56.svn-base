package com.hwfs.ls.ltm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ls.lrm.dao.TestInfoRegDAO;
import com.hwfs.ls.lrm.service.TestRegInqueryService;
import com.hwfs.ls.ltm.dao.TestResultInqueryDAO;
import com.hwfs.ls.ltm.dao.TestResultSpecmArticleRegDAO;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 시험결과등록-검체항목별 ServiceImple Class
 *
 * @ClassName TestResultSpecmArticleRegServiceImple.java
 * @Description TestResultSpecmArticleRegServiceImple Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 04. 01.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 04. 01.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ls/ltm/testResultSpecmArticleRegService")
public class TestResultSpecmArticleRegServiceImpl extends DefaultServiceImpl implements TestResultSpecmArticleRegService {

    @Resource(name = "/ls/ltm/testResultSpecmArticleRegDAO")
    private TestResultSpecmArticleRegDAO testResultSpecmArticleRegDAO;

    @Resource(name = "/ls/ltm/testResultInqueryDAO")
    private TestResultInqueryDAO testResultInqueryDAO;

    @Resource(name = "/ls/lrm/testRegInqueryService")
    private TestRegInqueryService testRegInqueryService;

    @Resource(name = "/ls/lrm/testInfoRegDAO")
    private TestInfoRegDAO testInfoRegDAO;

    /**
     * 검체목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.ltm.service.TestResultSpecmArticleRegService#selectList(java.util.Map)
    */
    @Override
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return testResultSpecmArticleRegDAO.selectList(parameter);
    }

    /**
     * 시험항목 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.ltm.service.TestResultSpecmArticleRegService#selectDetailList(java.util.Map)
    */
    @Override
    public RecordSet selectDetailList(Map<String, Object> parameter) throws Exception {
        return testResultSpecmArticleRegDAO.selectDetailList(parameter);
    }

    /**
     * 시험항목 판정내역을 저장한다.
     *
     * @param param
     * @param testArticleList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.ltm.service.TestResultSpecmArticleRegService#saveList(java.util.Map, hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveList(Map<String, Object> param, DataSetMap testArticleList) throws Exception {
        int procCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;

        for (int i = 0; i < testArticleList.size(); i++) {
            parameter = testArticleList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_UPDATED) {
                procCnt += testResultSpecmArticleRegDAO.updateTestArticleList(parameter);
            }

            // 모든시험항목과 최종판정 건수가 동일하면 자동 시험완료승인중으로 처리한다.
            String strDiaryEndYn = testResultInqueryDAO.selectTestDiaryEndYn(parameter);
            if ("Y".equals(strDiaryEndYn)) {
                Map<String, Object> procStatus = testResultInqueryDAO.selectLastProgressStatus(parameter).get(0);
                // 최종 진행상태가 시험완료승인중 체크
                if (!LimsUtil.checkNull(procStatus.get("procClass")).equals("180")) {
                    parameter.put("procClass", "180"); // 시험완료승인중
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
