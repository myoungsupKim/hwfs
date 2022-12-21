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
import com.hwfs.ls.lcm.dao.SpecmTypeDangerMappMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 검체유형 위험도매핑 관리 ServiceImple Class
 *
 * @ClassName SpecmTypeDangerMappMgmtServiceImple.java
 * @Description SpecmTypeDangerMappMgmtServiceImple Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3.12.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 3.12.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ls/lcm/specmTypeDangerMappMgmtService")
public class SpecmTypeDangerMappMgmtServiceImpl extends DefaultServiceImpl implements SpecmTypeDangerMappMgmtService {

    @Resource(name = "/ls/lcm/specmTypeDangerMappMgmtDAO")
    private SpecmTypeDangerMappMgmtDAO specmTypeDangerMappMgmtDAO;

    /**
     * 검체유형 위험도매핑을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.SpecmTypeDangerMappMgmtService#selectSpecmDangerMappList(java.util.Map)
    */
    @Override
    public RecordSet selectSpecmDangerMappList(Map<String, Object> parameter) throws Exception {
        return specmTypeDangerMappMgmtDAO.selectSpecmDangerMappList(parameter);
    }

    /**
     * 검체유형 위험도매핑을 저장한다.
     *
     * @param searchList
     * @param specmDangerMappList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.SpecmTypeDangerMappMgmtService#saveSpecmDangerMappList(hone.online.xplatform.map.DataSetMap, hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveSpecmDangerMappList(DataSetMap searchList, DataSetMap specmDangerMappList) throws Exception {
        int specmDangerMappProcCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;
        String specmType = "";

        specmType = LimsUtil.checkNull(searchList.get(0).get("specmType"));
        for (int i = 0; i < specmDangerMappList.size(); i++) {
            parameter = specmDangerMappList.get(i);
            parameter.put("specmType", specmType);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                specmDangerMappProcCnt += specmTypeDangerMappMgmtDAO.updateSpecmDangerMappList(parameter);
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                specmDangerMappProcCnt += specmTypeDangerMappMgmtDAO.updateSpecmDangerMappList(parameter);
            }
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", specmDangerMappProcCnt);
        retVal.put("specmType", specmType);

        return retVal;
    }

    /**
     * 전체 저장
     *
     * @param searchList
     * @param specmDangerMappList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.SpecmTypeDangerMappMgmtService#saveList(hone.online.xplatform.map.DataSetMap, hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveList(DataSetMap searchList, DataSetMap specmDangerMappList) throws Exception {
        int specmDangerMappProcCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;
        String specmType = "";

        specmType = LimsUtil.checkNull(searchList.get(0).get("specmType"));
        for (int i = 0; i < specmDangerMappList.size(); i++) {
            parameter = specmDangerMappList.get(i);
            parameter.put("specmType", specmType);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                specmDangerMappProcCnt += specmTypeDangerMappMgmtDAO.updateSpecmDangerMappList(parameter);
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                specmDangerMappProcCnt += specmTypeDangerMappMgmtDAO.updateSpecmDangerMappList(parameter);
            }
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", specmDangerMappProcCnt);
        retVal.put("specmType", specmType);

        return retVal;
    }

    /**
     * 전체 삭제
     *
     * @param searchList
     * @param specmTypeArticleList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.SpecmTypeDangerMappMgmtService#saveDelAllList(hone.online.xplatform.map.DataSetMap, hone.online.xplatform.map.DataSetMap)
    */
    @Override
    public Map<String, Object> saveDelAllList(DataSetMap searchList, DataSetMap specmTypeArticleList) throws Exception {
        int specmDangerMappProcCnt = 0;

        String specmType = LimsUtil.checkNull(searchList.get(0).get("specmType"));
        Map<String, Object> parameter = new HashMap<String, Object>();
        parameter.put("specmType", specmType);

        specmDangerMappProcCnt += specmTypeDangerMappMgmtDAO.deleteAllList(parameter);

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", specmDangerMappProcCnt);
        retVal.put("specmType", specmType);

        return retVal;
    }

}
