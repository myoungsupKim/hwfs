package com.hwfs.ls.lrm.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.cmn.util.RequestContextUtil;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ls.lrm.dao.TestInfoRegDAO;
import com.hwfs.ls.lrm.dao.TestRegInqueryDAO;
import com.tobesoft.xplatform.data.DataSet;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

/**
 * 접수정보 조회 ServiceImple Class
 *
 * @ClassName TestRegInqueryServiceImple.java
 * @Description TestRegInqueryServiceImple Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 19.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 3. 19.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ls/lrm/testRegInqueryService")
public class TestRegInqueryServiceImpl extends DefaultServiceImpl implements TestRegInqueryService {

    @Resource(name = "/ls/lrm/testRegInqueryDAO")
    private TestRegInqueryDAO testRegInqueryDAO;

    @Resource(name = "/ls/lrm/testInfoRegDAO")
    private TestInfoRegDAO testInfoRegDAO;

    /**
     * 시험접수목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.TestRegInqueryService#selectList(java.util.Map)
    */
    @Override
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return testRegInqueryDAO.selectList(parameter);
    }

    /**
     * 접수목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.TestRegInqueryService#selectAcceptSpecmList(java.util.Map)
    */
    @Override
    public RecordSet selectAcceptSpecmList(Map<String, Object> parameter) throws Exception {
        return testRegInqueryDAO.selectAcceptSpecmList(parameter);
    }

    /**
     * 접수내역을 상태를 저장 한다.	- 승인요청/접수취소
     *
     * @param testReqAccept
     * @param specmArticleList
     * @param testArticleList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lrm.service.TestInfoRegService#saveTestReqStatus(hone.online.xplatform.map.DataSetMap, java.util.Map)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveTestReqStatus(DataSetMap saveList, Map<String, Object> param) throws Exception {
        int procCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;

        for (int i = 0; i < saveList.size(); i++) {
            parameter = saveList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_UPDATED) {
                parameter.put("reqNum", param.get("reqNum"));
                parameter.put("procClass", param.get("procClass"));
                procCnt += saveStatus(parameter); // 접수내역 상태 변경
                //procCnt += testRegInqueryDAO.saveTestReqStatus(parameter); // 접수내역 상태 변경
                testInfoRegDAO.insertProcDesc(parameter); // 처리내역 저장
            }
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);

        return retVal;
    }

    /**
     * 접수내역/검체내역/시험항목내역 상태를 저장 한다.
     *
     * @param testReqAccept
     * @param specmArticleList
     * @param testArticleList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lrm.service.TestInfoRegService#saveStatus(java.util.Map)
    */
    @Override
    public int saveStatus(Map<String, Object> parameter) throws Exception {
        int procCnt = 0;

        procCnt += testRegInqueryDAO.saveTestReqStatus(parameter); // 접수내역 상태 변경
        procCnt += testRegInqueryDAO.saveSpecmInfoStatus(parameter); // 검체내역 상태 변경
        procCnt += testRegInqueryDAO.saveTestInfoStatus(parameter); // 시험항목내역 상태 변경

        return procCnt;
    }

    /**
     * 라벨출력 대상 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.TestRegInqueryService#selectSpecmLabelPrtList(java.util.Map)
    */
    @Override
    public RecordSet selectSpecmLabelPrtList(Map<String, Object> parameter) throws Exception {
        return testRegInqueryDAO.selectSpecmLabelPrtList(parameter);
    }

    /**
     * 시험결과 구매 전송 대상 목록을 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.TestRegInqueryService#selectSpecmLabelPrtList(java.util.Map)
    */
    @Override
    public RecordSet testResultItemSendMgmtList(Map<String, Object> parameter) throws Exception {
        return testRegInqueryDAO.testResultItemSendMgmtList(parameter);
    }

    /**
     * 구매자재 정보를 일괄 등록한다.
     *
     * @param searchList
     * @param saveList
     * @return
     * @throws Exception
     */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveItemSendResult(DataSetMap saveList) throws Exception {
        int procCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;
        Map<String, Object> itemProcParam = new HashMap<String, Object>();
        Map<String, Object> retProcItemVal = new HashMap<String, Object>();

        for (int i = 0; i < saveList.size(); i++) {
            parameter = saveList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_UPDATED) {
                itemProcParam = new HashMap<String, Object>();
                itemProcParam.put("p_req_num", LimsUtil.checkNull(parameter.get("reqNum")));	// 의뢰번호
                itemProcParam.put("p_accept_num", LimsUtil.checkNull(parameter.get("acceptNum")));	// 접수번호
                itemProcParam.put("p_specm_cd", LimsUtil.checkNull(parameter.get("specmCd")));	// 검체코드
                itemProcParam.put("p_status", LimsUtil.checkNull(parameter.get("materialSendResult")));	// 전송상태 (S:중지, P:해제)
                itemProcParam.put("p_reason", LimsUtil.checkNull(parameter.get("insptPurp3Nm")) + " / 부적합 (" + LimsUtil.checkNull(parameter.get("notFitClsfiNm")) + ")");	// 전송사유
                itemProcParam.put("p_upjang_gbn", LimsUtil.checkNull(parameter.get("materialUpjangSendResult")));	// 업장전송상태
                itemProcParam.put("p_cuser", LimsUtil.checkNull(RequestContextUtil.get("loginSabun"))); // 처리자
                retProcItemVal = testRegInqueryDAO.saveItemSendResult(itemProcParam);

                // 전송결과 오류가 발생 시 Rollback 오류 처리
                if (LimsUtil.checkNull(retProcItemVal.get("P_RET_CODE")).equals("E")) {
                    throw new BizException(LimsUtil.checkNull(retProcItemVal.get("P_RET_MSG")));
                }

                procCnt++;
            }
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);

        return retVal;
    }

    /**
     * Q-Stop 시험결과 마스터 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.TestRegInqueryService#testResultItemSendMasterList(java.util.Map)
    */
    @Override
    public Record testResultItemSendMasterList(Map<String, Object> parameter) throws Exception {
        return testRegInqueryDAO.testResultItemSendMasterList(parameter);
    }

    /**
     * Q-Stop 검체정보 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.TestRegInqueryService#testResultItemSendSpecmInfoList(java.util.Map)
    */
    @Override
    public Record testResultItemSendSpecmInfoList(Map<String, Object> parameter) throws Exception {
        return testRegInqueryDAO.testResultItemSendSpecmInfoList(parameter);
    }

    /**
     * Q-Stop 시험정보 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.TestRegInqueryService#testResultItemSendTestInfoList(java.util.Map)
    */
    @Override
    public RecordSet testResultItemSendTestInfoList(Map<String, Object> parameter) throws Exception {
        return testRegInqueryDAO.testResultItemSendTestInfoList(parameter);
    }

    /**
     * Q-Pass 시험정보 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.TestRegInqueryService#testResultItemSendSpecmInfoPassList(java.util.Map)
    */
    @Override
    public RecordSet testResultItemSendSpecmInfoPassList(Map<String, Object> parameter) throws Exception {
        return testRegInqueryDAO.testResultItemSendSpecmInfoPassList(parameter);
    }

    /**
     * 기 접수내역 목록조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.TestRegInqueryService#preAcceptReqInfoList(java.util.Map)
    */
    @Override
    public RecordSet preAcceptReqInfoList(Map<String, Object> parameter) throws Exception {
        return testRegInqueryDAO.preAcceptReqInfoList(parameter);
    }

}
