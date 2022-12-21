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
import com.hwfs.ls.lcm.dao.ScArticleMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

/**
 * ScArticleMgmtServiceImple에 대한 설명 작성
 *
 * @ClassName ScArticleMgmtServiceImple.java
 * @Description ScArticleMgmtServiceImple Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 1. 28.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 1. 28.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ls/lcm/scArticleMgmtService")
public class ScArticleMgmtServiceImpl extends DefaultServiceImpl implements ScArticleMgmtService {

    @Resource(name = "/ls/lcm/scArticleMgmtDAO")
    private ScArticleMgmtDAO scArticleMgmt;

    /**
     * 공통코드 그룹코드를 조회한다.
     *
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.ScArticleMgmtService#selectGroupList()
    */
    @Override
    public RecordSet selectGroupList(Map<String, Object> parameter) throws Exception {
        return scArticleMgmt.selectGroupList(parameter);
    }

    /**
     * 특정 그룹코드에 맞는 공통코드를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.ScArticleMgmtService#selectCodeList(java.util.Map)
    */
    @Override
    public RecordSet selectCodeList(Map<String, Object> parameter) throws Exception {
        return scArticleMgmt.selectCodeList(parameter);
    }

    /**
     * 상세 코드 일괄 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.ScArticleMgmtService#selectCodeDtlBatchList(java.util.Map)
    */
    @Override
    public RecordSet selectCodeDtlBatchList(Map<String, Object> parameter) throws Exception {
        parameter.put("groupCodeList", LimsUtil.codeConvertStringToList(LimsUtil.checkNull(parameter.get("groupCodeList")), ","));
        return scArticleMgmt.selectCodeDtlBatchList(parameter);
    }

    /**
     * 그룹코드를 저장한다.
     *
     * @param groupList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.ScArticleMgmtService#saveGroupList(hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public int saveGroupList(DataSetMap groupList) throws Exception {
        int groupProcCnt = 0;
        Map<String, Object> parameter = null;
        Map<String, Object> useAllCode = null;

        for (int i = 0; i < groupList.size(); i++) {
            parameter = groupList.get(i);
            int rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                groupProcCnt += scArticleMgmt.insertGroupList(parameter);
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                groupProcCnt += scArticleMgmt.updateGroupList(parameter);

                // 특정 그룹코드의 사용여부의 값이 [사용안함] 상태인 경우에는 하위에 해당하는 공통코드의 사용상태도 [사용안함]
                // 상태로 변경한다.
                if ("0".equals(parameter.get("useYn"))) {
                    useAllCode = new HashMap<String, Object>();
                    useAllCode.put("groupCode", parameter.get("groupCode"));
                    useAllCode.put("useYn", "N");
                    scArticleMgmt.updateUseAllCode(useAllCode);
                }
            }
        }

        return groupProcCnt;
    }

    /**
     * 특정 그룹코드의 코드정보를 저장 한다.
     *
     * @param codeList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.ScArticleMgmtService#saveCodeList(hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public int saveCodeList(DataSetMap codeList) throws Exception {
        int codeProcCnt = 0;
        Map<String, Object> parameter = null;

        for (int i = 0; i < codeList.size(); i++) {
            parameter = codeList.get(i);
            int rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                codeProcCnt += scArticleMgmt.insertCodeList(parameter);
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                codeProcCnt += scArticleMgmt.updateCodeList(parameter);
            }
        }

        return codeProcCnt;
    }

}
