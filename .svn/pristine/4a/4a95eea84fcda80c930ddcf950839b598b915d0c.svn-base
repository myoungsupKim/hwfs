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
import com.hwfs.ls.lcm.dao.LongStorageTestArticleMappMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 장기보존여부 시험항목 관리 ServiceImple Class
 *
 * @ClassName LongStorageTestArticleMappMgmtServiceImple.java
 * @Description LongStorageTestArticleMappMgmtServiceImple Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 12.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 3. 12.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ls/lcm/longStorageTestArticleMappMgmtService")
public class LongStorageTestArticleMappMgmtServiceImpl extends DefaultServiceImpl implements
        LongStorageTestArticleMappMgmtService {

    @Resource(name = "/ls/lcm/longStorageTestArticleMappMgmtDAO")
    private LongStorageTestArticleMappMgmtDAO longStorageTestArticleMappMgmtDAO;

    /**
     * 장기보존여부 시험항목을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.LongStorageTestArticleMappMgmtService#selectList(java.util.Map)
    */
    @Override
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return longStorageTestArticleMappMgmtDAO.selectList(parameter);
    }

    /**
     * 장기보존여부 시험항목을 저장한다.
     *
     * @param searchList
     * @param saveList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.LongStorageTestArticleMappMgmtService#saveList(hone.online.xplatform.map.DataSetMap, hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveList(DataSetMap searchList, DataSetMap saveList) throws Exception {
        int procCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;
        String strChk = "0";
        String longstorageYn = LimsUtil.checkNull(searchList.get(0).get("longstorageYn"));

        // 먼저 삭제 한다.
        Map<String, Object> param = new HashMap<String, Object>();
        param.put("longstorageYn", longstorageYn);
        procCnt += longStorageTestArticleMappMgmtDAO.deleteAllList(param);
        for (int i = 0; i < saveList.size(); i++) {
            parameter = saveList.get(i);
            parameter.put("longstorageYn", longstorageYn);

            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (rowType == DataSet.ROW_TYPE_INSERTED || rowType == DataSet.ROW_TYPE_UPDATED) {
                strChk = LimsUtil.checkNull(parameter.get("chk"));
                if ("1".equals(strChk)) {
                    procCnt += longStorageTestArticleMappMgmtDAO.insertList(parameter);
                } else {
                    procCnt += longStorageTestArticleMappMgmtDAO.deleteList(parameter);
                }
            }
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);
        retVal.put("articleCd", longstorageYn);

        return retVal;
    }

    /**
     * 전체 삭제
     *
     * @param searchList
     * @param saveList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.LongStorageTestArticleMappMgmtService#saveDelAllList(hone.online.xplatform.map.DataSetMap, hone.online.xplatform.map.DataSetMap)
    */
    @Override
    public Map<String, Object> saveDelAllList(DataSetMap searchList, DataSetMap saveList) throws Exception {
        int procCnt = 0;

        String longstorageYn = LimsUtil.checkNull(searchList.get(0).get("longstorageYn"));
        Map<String, Object> parameter = new HashMap<String, Object>();
        parameter.put("longstorageYn", longstorageYn);

        procCnt += longStorageTestArticleMappMgmtDAO.deleteAllList(parameter);

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);
        retVal.put("longstorageYn", longstorageYn);

        return retVal;
    }

}
