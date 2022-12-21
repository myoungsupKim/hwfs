package com.hwfs.ls.lcm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ls.lcm.dao.TestArticleMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 시험항목 관리 ServiceImple Class
 *
 * @ClassName TestArticleMgmtServiceImple.java
 * @Description TestArticleMgmtServiceImple Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 2. 9.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 2. 9.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ls/lcm/testArticleMgmtService")
public class TestArticleMgmtServiceImpl extends DefaultServiceImpl implements TestArticleMgmtService {

    @Resource(name = "/ls/lcm/testArticleMgmtDAO")
    private TestArticleMgmtDAO testArticleMgmtDAO;

    /**
     * 시험항목을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.TestArticleMgmtService#selectTestArticleList(java.util.Map)
    */
    @Override
    public RecordSet selectTestArticleList(Map<String, Object> parameter) throws Exception {
        return testArticleMgmtDAO.selectTestArticleList(parameter);
    }

    /**
     * 시험항목을 저장한다.
     *
     * @param testArticleList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.TestArticleMgmtService#saveTestArticleList(hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveTestArticleList(DataSetMap testArticleList) throws Exception {
        int testArticleProcCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;
        String articleCd = "";
        String strChk = "0";

        // 삭제가 있으면 먼저 삭제 한다.
        // 화면단에서 체크된 row 삭제
        for (int i = 0; i < testArticleList.size(); i++) {
            parameter = testArticleList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            strChk = LimsUtil.checkNull(parameter.get("chk"));
            if (rowType == DataSet.ROW_TYPE_DELETED) {
                testArticleProcCnt += testArticleMgmtDAO.deleteTestArticleList(parameter);
            }
        }

        for (int i = 0; i < testArticleList.size(); i++) {
            parameter = testArticleList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                strChk = LimsUtil.checkNull(parameter.get("chk"));
                if ("1".equals(strChk)) {
                    articleCd = testArticleMgmtDAO.selectTestArticleCd(parameter);
                    parameter.put("articleCd", articleCd);
                    testArticleProcCnt += testArticleMgmtDAO.insertTestArticleList(parameter);
                }
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                strChk = LimsUtil.checkNull(parameter.get("chk"));
                if ("1".equals(strChk)) {
                    testArticleProcCnt += testArticleMgmtDAO.updateTestArticleList(parameter);
                }
            }
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", testArticleProcCnt);
        retVal.put("articleCd", articleCd);

        return retVal;
    }

    /**
     * 전체 저장
     *
     * @param testArticleList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.TestArticleMgmtService#saveTestArticleList(hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveList(DataSetMap testArticleList) throws Exception {
        int testArticleProcCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;
        String articleCd = "";

        for (int i = 0; i < testArticleList.size(); i++) {
            parameter = testArticleList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                articleCd = testArticleMgmtDAO.selectTestArticleCd(parameter);
                parameter.put("articleCd", articleCd);
                testArticleProcCnt += testArticleMgmtDAO.insertTestArticleAllList(parameter);
            }
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", testArticleProcCnt);
        retVal.put("articleCd", articleCd);

        return retVal;
    }

    /**
     * 전체 삭제
     *
     * @param searchList
     * @param specmTypeArticleList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.SpecmTypeArticleMgmtService#saveDelAllList(hone.online.xplatform.map.DataSetMap, hone.online.xplatform.map.DataSetMap)
    */
    @Override
    public Map<String, Object> saveDelAllList(DataSetMap searchList, DataSetMap testArticleList) throws Exception {
        int testArticleProcCnt = 0;

        String specmType = LimsUtil.checkNull(searchList.get(0).get("specmType"));
        Map<String, Object> parameter = new HashMap<String, Object>();
        parameter.put("specmType", specmType);

        testArticleProcCnt += testArticleMgmtDAO.deleteAllList(parameter);

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", testArticleProcCnt);
        retVal.put("articleCd", "");

        return retVal;
    }

}
