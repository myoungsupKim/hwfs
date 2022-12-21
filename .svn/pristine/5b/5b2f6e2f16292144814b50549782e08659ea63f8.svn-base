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
import com.hwfs.ls.lcm.dao.SpecmTypeArticleMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 검체유형항목 관리 ServiceImple Class
 *
 * @ClassName SpecmTypeArticleMgmtServiceImple.java
 * @Description SpecmTypeArticleMgmtServiceImple Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 3.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 3. 3.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ls/lcm/specmTypeArticleMgmtService")
public class SpecmTypeArticleMgmtServiceImpl extends DefaultServiceImpl implements SpecmTypeArticleMgmtService {

    @Resource(name = "/ls/lcm/specmTypeArticleMgmtDAO")
    private SpecmTypeArticleMgmtDAO specmTypeArticleMgmtDAO;

    /**
     * 검체유형항목을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.SpecmTypeArticleMgmtService#selectList(java.util.Map)
    */
    @Override
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return specmTypeArticleMgmtDAO.selectList(parameter);
    }

    /**
     * 대분류를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.SpecmTypeArticleMgmtService#selectMgrpList(java.util.Map)
    */
    @Override
    public RecordSet selectMgrpList(Map<String, Object> parameter) throws Exception {
        return specmTypeArticleMgmtDAO.selectMgrpList(parameter);
    }

    /**
     * 중분류를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.SpecmTypeArticleMgmtService#selectMcalssList(java.util.Map)
    */
    @Override
    public RecordSet selectMcalssList(Map<String, Object> parameter) throws Exception {
        return specmTypeArticleMgmtDAO.selectMcalssList(parameter);
    }

    /**
     * 소분류를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.SpecmTypeArticleMgmtService#selectSclassList(java.util.Map)
    */
    @Override
    public RecordSet selectSclassList(Map<String, Object> parameter) throws Exception {
        return specmTypeArticleMgmtDAO.selectSclassList(parameter);
    }

    /**
     * 검체항목유형을 저장한다.
     *
     * @param searchList
     * @param specmTypeArticleList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.SpecmTypeArticleMgmtService#saveList(hone.online.xplatform.map.DataSetMap, hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveList(DataSetMap searchList, DataSetMap specmTypeArticleList) throws Exception {
        int specmTypeArticleProcCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;
        String mgrpCd = "";
        String mcalssCd = "";
        String sclassCd = "";
        String tmpMgrpNm = "";
        String tmpMcalssNm = "";

        String specmType = LimsUtil.checkNull(searchList.get(0).get("specmType"));

        for (int i = 0; i < specmTypeArticleList.size(); i++) {
            parameter = specmTypeArticleList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            parameter.put("specmType", specmType);

            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                if (!tmpMgrpNm.equals(LimsUtil.checkNull(parameter.get("mgrpNm")))) {
                    mgrpCd = specmTypeArticleMgmtDAO.selectMgrpCd(parameter);
                    parameter.put("mgrpCd", mgrpCd);
                    specmTypeArticleProcCnt += specmTypeArticleMgmtDAO.insertMgrpList(parameter);
                    tmpMgrpNm = LimsUtil.checkNull(parameter.get("mgrpNm"));
                } else {
                    parameter.put("mgrpCd", mgrpCd);
                }

                if (!tmpMcalssNm.equals(LimsUtil.checkNull(parameter.get("mgrpNm"))
                        + LimsUtil.checkNull(parameter.get("mcalssNm")))) {
                    mcalssCd = specmTypeArticleMgmtDAO.selectMcalssCd(parameter);
                    parameter.put("mcalssCd", mcalssCd);
                    specmTypeArticleProcCnt += specmTypeArticleMgmtDAO.insertMcalssList(parameter);
                    tmpMcalssNm = LimsUtil.checkNull(parameter.get("mgrpNm")) + LimsUtil.checkNull(parameter.get("mcalssNm"));
                } else {
                    parameter.put("mcalssCd", mcalssCd);
                }

                sclassCd = specmTypeArticleMgmtDAO.selectSclassCd(parameter);
                parameter.put("sclassCd", sclassCd);
                specmTypeArticleProcCnt += specmTypeArticleMgmtDAO.insertSclassList(parameter);
            }
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", specmTypeArticleProcCnt);
        retVal.put("articleCd", mgrpCd);

        return retVal;
    }

    /**
     * 대분류를 저장한다.
     *
     * @param specmTypeArticleList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.SpecmTypeArticleMgmtService#saveMgrpList(hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveMgrpList(DataSetMap specmTypeArticleList) throws Exception {
        int specmTypeArticleProcCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;
        String mgrpCd = "";

        // 삭제가 있으면 먼저 삭제 한다.
        // 화면단에서 체크된 row 삭제
        for (int i = 0; i < specmTypeArticleList.size(); i++) {
            parameter = specmTypeArticleList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_DELETED) {
                specmTypeArticleProcCnt += specmTypeArticleMgmtDAO.deleteMgrpList(parameter);
                // 중분류삭제
                parameter.put("mcalss", "");
                specmTypeArticleProcCnt += specmTypeArticleMgmtDAO.deleteMcalssList(parameter);
                // 소분류삭제
                parameter.put("sclass", "");
                specmTypeArticleProcCnt += specmTypeArticleMgmtDAO.deleteSclassList(parameter);
            }
        }

        for (int i = 0; i < specmTypeArticleList.size(); i++) {
            parameter = specmTypeArticleList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                mgrpCd = specmTypeArticleMgmtDAO.selectMgrpCd(parameter);
                parameter.put("mgrpCd", mgrpCd);
                specmTypeArticleProcCnt += specmTypeArticleMgmtDAO.insertMgrpList(parameter);
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                specmTypeArticleProcCnt += specmTypeArticleMgmtDAO.updateMgrpList(parameter);
            }
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", specmTypeArticleProcCnt);
        retVal.put("articleCd", mgrpCd);

        return retVal;
    }

    /**
     * 중분류를 저장한다.
     *
     * @param specmTypeArticleList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.SpecmTypeArticleMgmtService#saveMcalssList(hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveMcalssList(DataSetMap specmTypeArticleList) throws Exception {
        int specmTypeArticleProcCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;
        String mcalssCd = "";

        // 삭제가 있으면 먼저 삭제 한다.
        // 화면단에서 체크된 row 삭제
        for (int i = 0; i < specmTypeArticleList.size(); i++) {
            parameter = specmTypeArticleList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_DELETED) {
                specmTypeArticleProcCnt += specmTypeArticleMgmtDAO.deleteMcalssList(parameter);
                // 소분류삭제
                parameter.put("sclass", "");
                specmTypeArticleProcCnt += specmTypeArticleMgmtDAO.deleteSclassList(parameter);
            }
        }

        for (int i = 0; i < specmTypeArticleList.size(); i++) {
            parameter = specmTypeArticleList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                mcalssCd = specmTypeArticleMgmtDAO.selectMcalssCd(parameter);
                parameter.put("mcalssCd", mcalssCd);
                specmTypeArticleProcCnt += specmTypeArticleMgmtDAO.insertMcalssList(parameter);
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                specmTypeArticleProcCnt += specmTypeArticleMgmtDAO.updateMcalssList(parameter);
            }
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", specmTypeArticleProcCnt);
        retVal.put("articleCd", mcalssCd);

        return retVal;
    }

    /**
     * 소분류를 저장한다.
     *
     * @param specmTypeArticleList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.SpecmTypeArticleMgmtService#saveSclassList(hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveSclassList(DataSetMap specmTypeArticleList) throws Exception {
        int specmTypeArticleProcCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;
        String sclassCd = "";

        // 삭제가 있으면 먼저 삭제 한다.
        // 화면단에서 체크된 row 삭제
        for (int i = 0; i < specmTypeArticleList.size(); i++) {
            parameter = specmTypeArticleList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_DELETED) {
                specmTypeArticleProcCnt += specmTypeArticleMgmtDAO.deleteSclassList(parameter);
            }
        }

        for (int i = 0; i < specmTypeArticleList.size(); i++) {
            parameter = specmTypeArticleList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                sclassCd = specmTypeArticleMgmtDAO.selectSclassCd(parameter);
                parameter.put("sclassCd", sclassCd);
                specmTypeArticleProcCnt += specmTypeArticleMgmtDAO.insertSclassList(parameter);
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                specmTypeArticleProcCnt += specmTypeArticleMgmtDAO.updateSclassList(parameter);
            }
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", specmTypeArticleProcCnt);
        retVal.put("articleCd", sclassCd);

        return retVal;
    }

    /**
     * 검체항목유형 전체를 삭제 한다.
     *
     * @param searchList
     * @param specmTypeArticleList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.SpecmTypeArticleMgmtService#saveDelAllList(hone.online.xplatform.map.DataSetMap, hone.online.xplatform.map.DataSetMap)
    */
    @Override
    public Map<String, Object> saveDelAllList(DataSetMap searchList, DataSetMap specmTypeArticleList) throws Exception {
        int specmTypeArticleProcCnt = 0;

        String specmType = LimsUtil.checkNull(searchList.get(0).get("specmType"));
        Map<String, Object> parameter = new HashMap<String, Object>();
        parameter.put("specmType", specmType);

        specmTypeArticleProcCnt += specmTypeArticleMgmtDAO.deleteMgrpAllList(parameter);
        specmTypeArticleProcCnt += specmTypeArticleMgmtDAO.deleteMcalssAllList(parameter);
        specmTypeArticleProcCnt += specmTypeArticleMgmtDAO.deleteSclassAllList(parameter);

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", specmTypeArticleProcCnt);
        retVal.put("articleCd", "");

        return retVal;
    }

}
