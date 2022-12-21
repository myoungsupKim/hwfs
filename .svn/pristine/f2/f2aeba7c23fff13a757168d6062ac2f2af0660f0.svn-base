package com.hwfs.ls.lum.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ls.lum.dao.ReagentTransMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 시약수불 관리 ServiceImple Class
 *
 * @ClassName ReagentTransMgmtServiceImple.java
 * @Description ReagentTransMgmtServiceImple Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 22.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 4. 22.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ls/lum/reagentTransMgmtService")
public class ReagentTransMgmtServiceImpl extends DefaultServiceImpl implements ReagentTransMgmtService {

    @Resource(name = "/ls/lum/reagentTransMgmtDAO")
    private ReagentTransMgmtDAO reagentTransMgmtDAO;

    /**
     * 시약수불을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lum.service.ReagentTransMgmtService#selectList(java.util.Map)
    */
    @Override
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return reagentTransMgmtDAO.selectList(parameter);
    }

    /**
     * 시약수불 내역을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lum.service.ReagentTransMgmtService#selectSummaryList(java.util.Map)
    */
    @Override
    public RecordSet selectSummaryList(Map<String, Object> parameter) throws Exception {
        return reagentTransMgmtDAO.selectSummaryList(parameter);
    }

    /**
     * 전체 저장
     *
     * @param reagentTransList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lum.service.ReagentTransMgmtService#saveList(hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveList(Map<String, Object> param, DataSetMap reagentTransList) throws Exception {
        int reagentTransProcCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;
        String articleCd = "";
        String reagentClass = "";
        String reagentNm = "";

        // 수불관리는 코드가 없기 때문에 전체 삭제 후 저장 한다.
        reagentTransProcCnt += reagentTransMgmtDAO.deleteReagentTransList(param);

        for (int i = 0; i < reagentTransList.size(); i++) {
            parameter = reagentTransList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                // 시약구분과 시먁명이 없으면 Skip
                reagentClass = LimsUtil.checkNull(parameter.get("reagentClass"));
                reagentNm = LimsUtil.checkNull(parameter.get("reagentNm"));
                if (!"".equals(reagentClass) && !"".equals(reagentNm)) {
                    parameter.put("yymm", LimsUtil.checkNull(param.get("yymm")));
                    parameter.put("gdsClass", LimsUtil.checkNull(param.get("gdsClass")));
                    reagentTransProcCnt += reagentTransMgmtDAO.insertReagentTransList(parameter);
                }
            }
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", reagentTransProcCnt);
        retVal.put("articleCd", articleCd);

        return retVal;
    }

}
