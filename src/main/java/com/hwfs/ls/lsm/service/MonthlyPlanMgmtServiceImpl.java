package com.hwfs.ls.lsm.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ls.lsm.dao.MonthlyPlanMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

/**
 * 월계획 조정 관리 ServiceImple Class
 *
 * @ClassName MonthlyPlanMgmtServiceImple.java
 * @Description MonthlyPlanMgmtServiceImple Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 9. 22.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 9. 22.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ls/lsm/monthlyPlanMgmtService")
public class MonthlyPlanMgmtServiceImpl extends DefaultServiceImpl implements MonthlyPlanMgmtService {

    @Resource(name = "/ls/lsm/monthlyPlanMgmtDAO")
    private MonthlyPlanMgmtDAO monthlyPlanMgmtDAO;

    /**
     * 월계획 조정 수립 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.MonthlyPlanMgmtService#selectItemList(java.util.Map)
    */
    @Override
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return monthlyPlanMgmtDAO.selectList(parameter);
    }

    /**
     * 공전유형 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.MonthlyPlanMgmtService#selectClassList(java.util.Map)
    */
    @Override
    public RecordSet selectClassList(Map<String, Object> parameter) throws Exception {
        return monthlyPlanMgmtDAO.selectClassList(parameter);
    }

    /**
     * 월계획 조정 조회 - 년간시료수
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.MonthlyPlanMgmtService#selectItemList(java.util.Map)
    */
    @Override
    public RecordSet selectTestCnt(Map<String, Object> parameter) throws Exception {
        return monthlyPlanMgmtDAO.selectTestCnt(parameter);
    }

    /**
     * 월계획 조정 조회 - 화학 검사 수
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.MonthlyPlanMgmtService#selectMicbioCnt(java.util.Map)
    */
    @Override
    public RecordSet selectMicbioCnt(Map<String, Object> parameter) throws Exception {
        return monthlyPlanMgmtDAO.selectMicbioCnt(parameter);
    }

    /**
     * 월계획 조정 조회 - 생물 검사 수
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.MonthlyPlanMgmtService#selectPhyChemCnt(java.util.Map)
    */
    @Override
    public RecordSet selectPhyChemCnt(Map<String, Object> parameter) throws Exception {
        return monthlyPlanMgmtDAO.selectPhyChemCnt(parameter);
    }

    /**
     * 자재 목록 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.MonthlyPlanMgmtService#selectItemList(java.util.Map)
    */
    @Override
    public RecordSet selectItemList(Map<String, Object> parameter) throws Exception {
        RecordSet rs = null;

        // 공전유형이 위생기타면 LCM_ETC_SPECM_TYPE 에서 구한다.
        if (LimsUtil.checkNull(parameter.get("specmType")).equals("103")) {
            rs = monthlyPlanMgmtDAO.selectEtcItemList(parameter);
        } else {
            rs = monthlyPlanMgmtDAO.selectItemList(parameter);
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
     * @see com.hwfs.ls.lsm.service.MonthlyPlanMgmtService#saveList(java.util.Map, hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveList(Map<String, Object> param, DataSetMap saveList) throws Exception {
        int procCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;

        // 월계획 조정 Master 생성
        procCnt += monthlyPlanMgmtDAO.insertMstList(param);

        for (int i = 0; i < saveList.size(); i++) {
            parameter = saveList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            parameter.put("planYear", param.get("planYear"));
            parameter.put("planClsfi", param.get("planClsfi"));
            parameter.put("planclass", param.get("planclass"));
            parameter.put("planMonth", param.get("planMonth"));
            parameter.put("mcalssCd", param.get("mcalssCd"));

            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                procCnt += monthlyPlanMgmtDAO.updateDtlList(parameter);
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                procCnt += monthlyPlanMgmtDAO.updateDtlList(parameter);
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
     * @see com.hwfs.ls.lsm.service.MonthlyPlanMgmtService#deleteSpecm(java.util.Map, hone.online.xplatform.map.DataSetMap)
    */
    @Override
    public Map<String, Object> deleteSpecm(Map<String, Object> parameter) throws Exception {
        int procCnt = 0;

        // 월계획 조정 삭제
        procCnt += monthlyPlanMgmtDAO.deleteMstList(parameter);
        procCnt += monthlyPlanMgmtDAO.deleteDtlList(parameter);

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);

        return retVal;
    }

    /**
     * 월계획 조정 세부 내역 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.MonthlyPlanMgmtService#selectItemDtlList(java.util.Map)
    */
    @Override
    public RecordSet selectItemDtlList(Map<String, Object> parameter) throws Exception {
        return monthlyPlanMgmtDAO.selectItemDtlList(parameter);
    }

    /**
     * 년간계획 월계획을 복사한다.
     *
     * @param param
     * @param saveList
     * @return
     * @throws Exception
     */
    @Override
    public Map<String, Object> saveYearPlanMigration(Map<String, Object> param) throws Exception {
        int procCnt = 0;

        // 년간계획 대비 삭제 데이터 월계획 조정 삭제
        procCnt += monthlyPlanMgmtDAO.deleteYearPlanMstMigration(param);
        procCnt += monthlyPlanMgmtDAO.deleteYearPlanDtlMigration(param);

        // 월계획 조정 Master 생성
        procCnt += monthlyPlanMgmtDAO.saveYearPlanMstMigration(param);
        procCnt += monthlyPlanMgmtDAO.saveYearPlanDtlMigration(param);

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);

        return retVal;
    }

    /**
     * 시험결과 부적합 이력조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.MonthlyPlanMgmtService#selectDetailList(java.util.Map)
    */
    @Override
    public RecordSet selectDetailList(Map<String, Object> parameter) throws Exception {
        return monthlyPlanMgmtDAO.selectDetailList(parameter);
    }

}
