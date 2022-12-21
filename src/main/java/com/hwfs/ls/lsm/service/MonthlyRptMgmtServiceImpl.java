package com.hwfs.ls.lsm.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ls.lsm.dao.MonthlyRptMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

/**
 * 월간보고 관리 ServiceImple Class
 *
 * @ClassName MonthlyRptMgmtServiceImple.java
 * @Description MonthlyRptMgmtServiceImple Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 6. 01.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 6. 01.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ls/lsm/monthlyRptMgmtService")
public class MonthlyRptMgmtServiceImpl extends DefaultServiceImpl implements MonthlyRptMgmtService {

    @Resource(name = "/ls/lsm/monthlyRptMgmtDAO")
    private MonthlyRptMgmtDAO monthlyRptMgmtDAO;

    /**
     * 월간보고 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.MonthlyRptMgmtService#selectList(java.util.Map)
    */
    @Override
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return monthlyRptMgmtDAO.selectList(parameter);
    }

    /**
     * 월간보고 검사내용 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.MonthlyRptMgmtService#selectSpecmDescList(java.util.Map)
    */
    @Override
    public RecordSet selectSpecmDescList(Map<String, Object> parameter) throws Exception {
        return monthlyRptMgmtDAO.selectSpecmDescList(parameter);
    }

    /**
     * 월간보고 합계 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.MonthlyRptMgmtService#selectListSum(java.util.Map)
    */
    @Override
    public RecordSet selectListSum(Map<String, Object> parameter) throws Exception {
        return monthlyRptMgmtDAO.selectListSum(parameter);
    }

    /**
     * 월간보고 검사내용 저장
     *
     * @param param
     * @param dsList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.MonthlyRptMgmtService#saveSpecmDesc(java.util.Map, hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveSpecmDesc(Map<String, Object> param, DataSetMap dsList) throws Exception {
        int procCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;

        for (int i = 0; i < dsList.size(); i++) {
            parameter = dsList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            parameter.put("yymm", param.get("yymm"));

            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                procCnt += monthlyRptMgmtDAO.insertSpecmDescList(parameter);
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                procCnt += monthlyRptMgmtDAO.insertSpecmDescList(parameter);
            } else if (rowType == DataSet.ROW_TYPE_DELETED) {
                procCnt += monthlyRptMgmtDAO.deleteSpecmDescList(parameter);
            }
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);

        return retVal;
    }

    /**
     * 월간보고 검사내용 삭제
     *
     * @param param
     * @param dsList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.MonthlyRptMgmtService#deleteSpecmDesc(java.util.Map, hone.online.xplatform.map.DataSetMap)
    */
    @Override
    public Map<String, Object> deleteSpecmDesc(Map<String, Object> parameter) throws Exception {
        int procCnt = 0;

        procCnt += monthlyRptMgmtDAO.deleteSpecmDescList(parameter);

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);

        return retVal;
    }

    /**
     * 월간보고 검사내용 복사
     *
     * @param param
     * @param dsList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.MonthlyRptMgmtService#copySpecmDesc(java.util.Map, hone.online.xplatform.map.DataSetMap)
    */
    @Override
    public Map<String, Object> copySpecmDesc(Map<String, Object> parameter) throws Exception {
        int procCnt = 0;

        procCnt += monthlyRptMgmtDAO.deleteSpecmDescList(parameter);	// 이번달 데이터 삭제
        procCnt += monthlyRptMgmtDAO.copySpecmDescList(parameter);		// 이전달 데이터 복사

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);

        return retVal;
    }

}
