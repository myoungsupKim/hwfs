package com.hwfs.ls.lcm.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ls.lcm.dao.EtcSpecmArticleMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

/**
 * 기타검체유형 관리 ServiceImple Class
 *
 * @ClassName EtcSpecmArticleMgmtServiceImple.java
 * @Description EtcSpecmArticleMgmtServiceImple Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 17.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 3. 17.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ls/lcm/etcSpecmArticleMgmtService")
public class EtcSpecmArticleMgmtServiceImpl extends DefaultServiceImpl implements EtcSpecmArticleMgmtService {

    @Resource(name = "/ls/lcm/etcSpecmArticleMgmtDAO")
    private EtcSpecmArticleMgmtDAO etcSpecmArticleMgmtDAO;

    /**
     * 기타검체유형을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.EtcSpecmArticleMgmtService#selectList(java.util.Map)
    */
    @Override
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        RecordSet rs = null;
        String strSpecmClass = LimsUtil.checkNull(parameter.get("specmClass"));
        String inqueryYn = LimsUtil.checkNull(parameter.get("inqueryYn"));

        // 101 : 등록제품(거래중인 식재료)
        // inqueryYn : Y인 경우는 기타검체유형관리에서 조회 시 사용
        if ("101".equals(strSpecmClass) && "".equals(inqueryYn)) {
            rs = etcSpecmArticleMgmtDAO.selectItemList(parameter);
        } else {
            // 등록제품(거래중인 식재료) [접수등록/상세]를 제외한
            // 기타검체유형 조회 시는 아래 로직을 실행 한다.
            rs = etcSpecmArticleMgmtDAO.selectList(parameter);
        }
        return rs;
    }

    /**
     * 구매이력정보를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.EtcSpecmArticleMgmtService#selectTransItemList(java.util.Map)
    */
    @Override
    public RecordSet selectTransItemList(Map<String, Object> parameter) throws Exception {
        return etcSpecmArticleMgmtDAO.selectTransItemList(parameter);
    }

    /**
     * 기타검체유형을 저장한다.
     *
     * @param testArticleList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.EtcSpecmArticleMgmtService#saveList(hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveList(DataSetMap saveList) throws Exception {
        int procCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;
        String specmCd = "";
        int specmCnt = 0;

        // 삭제가 있으면 먼저 삭제 한다.
        // 화면단에서 체크된 row 삭제
        for (int i = 0; i < saveList.size(); i++) {
            parameter = saveList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (rowType == DataSet.ROW_TYPE_DELETED) {
                procCnt += etcSpecmArticleMgmtDAO.deleteList(parameter);
            }
        }

        for (int i = 0; i < saveList.size(); i++) {
            parameter = saveList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            /*specmCd = LimsUtil.checkNull(parameter.get("specmCd"));
            if ("".equals(specmCd)) {
                specmCd = etcSpecmArticleMgmtDAO.selectCreateCd(parameter);
                parameter.put("specmCd", specmCd);
                procCnt += etcSpecmArticleMgmtDAO.insertList(parameter);
            } else if (!"".equals(specmCd)) {
                procCnt += etcSpecmArticleMgmtDAO.updateList(parameter);
            }*/
            //throw processException("ls.dataChkDup"); // 중복 데이터 오류

            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                specmCd = LimsUtil.checkNull(parameter.get("specmCd"));
                if ("".equals(specmCd)) {
                    specmCd = etcSpecmArticleMgmtDAO.selectCreateCd(parameter);
                }
                parameter.put("specmCd", specmCd);

                // 중복등록 체크를 위해 건수 체크
                specmCnt = etcSpecmArticleMgmtDAO.selectSpecmCnt(parameter);
                if (specmCnt == 0) {
                    procCnt += etcSpecmArticleMgmtDAO.insertList(parameter);
                } else {
                    throw processException("ls.dataChkDup"); // 중복 데이터 오류
                }
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                procCnt += etcSpecmArticleMgmtDAO.updateList(parameter);
            }
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);
        retVal.put("specmCd", specmCd);

        return retVal;
    }

}
