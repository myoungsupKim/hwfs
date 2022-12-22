package com.hwfs.ls.lsm.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ls.lsm.dao.YealyPlanMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

/**
 * 년간계획 관리 ServiceImple Class
 *
 * @ClassName YealyPlanMgmtServiceImple.java
 * @Description YealyPlanMgmtServiceImple Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 5. 15.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 5. 15.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ls/lsm/yealyPlanMgmtService")
public class YealyPlanMgmtServiceImpl extends DefaultServiceImpl implements YealyPlanMgmtService {

    @Resource(name = "/ls/lsm/yealyPlanMgmtDAO")
    private YealyPlanMgmtDAO yealyPlanMgmtDAO;

    /**
     * 년간계획 수립 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.YealyPlanMgmtService#selectItemList(java.util.Map)
    */
    @Override
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return yealyPlanMgmtDAO.selectList(parameter);
    }

    /**
     * 공전유형 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.YealyPlanMgmtService#selectClassList(java.util.Map)
    */
    @Override
    public RecordSet selectClassList(Map<String, Object> parameter) throws Exception {
        return yealyPlanMgmtDAO.selectClassList(parameter);
    }

    /**
     * 년간계획 조회 - 년간시료수
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.YealyPlanMgmtService#selectItemList(java.util.Map)
    */
    @Override
    public RecordSet selectTestCnt(Map<String, Object> parameter) throws Exception {
        return yealyPlanMgmtDAO.selectTestCnt(parameter);
    }

    /**
     * 년간계획 조회 - 화학 검사 수
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.YealyPlanMgmtService#selectMicbioCnt(java.util.Map)
    */
    @Override
    public RecordSet selectMicbioCnt(Map<String, Object> parameter) throws Exception {
        return yealyPlanMgmtDAO.selectMicbioCnt(parameter);
    }

    /**
     * 년간계획 조회 - 생물 검사 수
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.YealyPlanMgmtService#selectPhyChemCnt(java.util.Map)
    */
    @Override
    public RecordSet selectPhyChemCnt(Map<String, Object> parameter) throws Exception {
        return yealyPlanMgmtDAO.selectPhyChemCnt(parameter);
    }

    /**
     * 자재 목록 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.YealyPlanMgmtService#selectItemList(java.util.Map)
    */
    @Override
    public RecordSet selectItemList(Map<String, Object> parameter) throws Exception {
        RecordSet rs = null;

        // 공전유형이 위생기타면 LCM_ETC_SPECM_TYPE 에서 구한다.
        if (LimsUtil.checkNull(parameter.get("specmType")).equals("103")) {
            rs = yealyPlanMgmtDAO.selectEtcItemList(parameter);
        } else {
            rs = yealyPlanMgmtDAO.selectItemList(parameter);
        }

        return rs;
    }

    /**
     * 전체 저장
     *
     * @param param
     * @param wswtList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.YealyPlanMgmtService#saveList(java.util.Map, hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveList(Map<String, Object> param, DataSetMap saveList) throws Exception {
        int procCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;

        // 년간계획 Master 생성
        procCnt += yealyPlanMgmtDAO.insertMstList(param);

        for (int i = 0; i < saveList.size(); i++) {
            parameter = saveList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            parameter.put("planYear", param.get("planYear"));
            parameter.put("planClsfi", param.get("planClsfi"));
            parameter.put("planclass", param.get("planclass"));
            parameter.put("planMonth", param.get("planMonth"));
            parameter.put("mcalssCd", param.get("mcalssCd"));

            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                procCnt += yealyPlanMgmtDAO.updateDtlList(parameter);
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                procCnt += yealyPlanMgmtDAO.updateDtlList(parameter);
            }
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);

        return retVal;
    }

    /**
     * 월별 공전유형 삭제
     *
     * @param param
     * @param wswtList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.YealyPlanMgmtService#deleteSpecm(java.util.Map, hone.online.xplatform.map.DataSetMap)
    */
    @Override
    public Map<String, Object> deleteSpecm(Map<String, Object> parameter) throws Exception {
        int procCnt = 0;

        // 년간계획 삭제
        procCnt += yealyPlanMgmtDAO.deleteMstList(parameter);
        procCnt += yealyPlanMgmtDAO.deleteDtlList(parameter);

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);

        return retVal;
    }

    /**
     * 년간계획 세부 내역 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.YealyPlanMgmtService#selectItemDtlList(java.util.Map)
    */
    @Override
    public RecordSet selectItemDtlList(Map<String, Object> parameter) throws Exception {
        return yealyPlanMgmtDAO.selectItemDtlList(parameter);
    }

}
