package com.hwfs.ls.lum.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ls.lum.dao.WswtMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 폐액/폐기물 관리 ServiceImple Class
 *
 * @ClassName WswtMgmtServiceImple.java
 * @Description WswtMgmtServiceImple Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 29.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 4. 29.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ls/lum/wswtMgmtService")
public class WswtMgmtServiceImpl extends DefaultServiceImpl implements WswtMgmtService {

    @Resource(name = "/ls/lum/wswtMgmtDAO")
    private WswtMgmtDAO wswtMgmtDAO;

    /**
     * 폐액/폐기물을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lum.service.WswtMgmtService#selectList(java.util.Map)
    */
    @Override
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return wswtMgmtDAO.selectList(parameter);
    }

    /**
     * 전체 저장
     *
     * @param wswtList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lum.service.WswtMgmtService#saveList(hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveList(Map<String, Object> param, DataSetMap wswtList) throws Exception {
        int wswtProcCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;

        for (int i = 0; i < wswtList.size(); i++) {
            parameter = wswtList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                wswtProcCnt += wswtMgmtDAO.insertWswtList(parameter);
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                wswtProcCnt += wswtMgmtDAO.updateWswtList(parameter);
            } else if (rowType == DataSet.ROW_TYPE_DELETED) {
                wswtProcCnt += wswtMgmtDAO.deleteWswtList(parameter);
            }
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", wswtProcCnt);

        return retVal;
    }

}
