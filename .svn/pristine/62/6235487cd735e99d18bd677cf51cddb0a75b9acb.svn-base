package com.hwfs.ls.ltm.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ls.lem.dao.InspectRptIssueInqueryDAO;
import com.hwfs.ls.lrm.dao.TestInfoRegDAO;
import com.hwfs.ls.lrm.service.TestRegInqueryService;
import com.hwfs.ls.ltm.dao.TestEndApprvDAO;
import com.tobesoft.xplatform.data.DataSet;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

/**
 * 시험완료정보 조회 ServiceImple Class
 *
 * @ClassName TestEndApprvServiceImple.java
 * @Description TestEndApprvServiceImple Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 07.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 4. 07.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ls/ltm/testEndApprvService")
public class TestEndApprvServiceImpl extends DefaultServiceImpl implements TestEndApprvService {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource(name = "/ls/ltm/testEndApprvDAO")
    private TestEndApprvDAO testEndApprvDAO;

    @Resource(name = "/ls/lrm/testInfoRegDAO")
    private TestInfoRegDAO testInfoRegDAO;

    @Resource(name = "/ls/lrm/testRegInqueryService")
    private TestRegInqueryService testRegInqueryService;

    @Resource(name = "/ls/lem/inspectRptIssueInqueryDAO")
    private InspectRptIssueInqueryDAO inspectRptIssueInqueryDAO;

    /**
     * 시험완료내역을 상태를 저장 한다. - 시험완료승인
     *
     * @param testReqAccept
     * @param specmArticleList
     * @param testArticleList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.ltm.service.SlaTestDAO#saveTestReqStatus(hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings({ "unchecked", "unused" })
    public Map<String, Object> saveTestReqStatus(DataSetMap saveList, Map<String, Object> param) throws Exception {
        int procCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;
        String strProcClass = "";
        String strReqNum = "";
        String strChk = "0";
        String strAcceptNum = "";
        String strCostClass = "";
        Map<String, Object> retProcVal = new HashMap<String, Object>();
        Map<String, Object> retProcItemVal = new HashMap<String, Object>();

        for (int i = 0; i < saveList.size(); i++) {
            parameter = saveList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_UPDATED) {
                strChk = LimsUtil.checkNull(parameter.get("chk"));
                if ("1".equals(strChk)) {
                    strProcClass = LimsUtil.checkNull(param.get("procClass"));
                    // 성적서발급승인, 재발급승인인 경우 화면에 있는 반려 사유를 삭제 한다.
                    /*if ("230".equals(strProcClass) || "270".equals(strProcClass)) {
                        parameter.put("procReason", "");
                    }*/

                    // 2015-07-13 최준열M/신현호M 요청으로 성적서 재발급 신청 시 신청 사유 등록
                    // 이에따라 성적서 발급이력 테이블을 발급신청 시 미리등록 후
                    // 발급 승인 / 성적서발급 시 데이터를 UPDATE한다.
                    // 성적서발급 정보에 승인 : 승인자정보 저장 / 반려 : 삭제
                    if ("220".equals(strProcClass) || "260".equals(strProcClass)) {	// 발급승인반려
                        // 성적서 발급 정보 삭제
                        procCnt += inspectRptIssueInqueryDAO.deleteInsptRptIssueHistoryAppr(parameter);
                    } else if ("230".equals(strProcClass) || "270".equals(strProcClass)) {	// 발급승인
                        // 성적서 발급 승인자 정보 저장
                        procCnt += inspectRptIssueInqueryDAO.saveInsptRptIssueHistoryAppr(parameter);
                    }

                    parameter.put("procClass", strProcClass);
                    procCnt += testRegInqueryService.saveStatus(parameter);
                    testInfoRegDAO.insertProcDesc(parameter); // 처리내역 저장

                    // 시험완료 승인인 경우
                    if ("200".equals(strProcClass)) {
                        strReqNum = LimsUtil.checkNull(parameter.get("reqNum"));
                        // 검체별로 부적합분류를 저장 한다.
                        procCnt += testEndApprvDAO.saveSpecmNotFitClsfi(parameter);

                        // IFIS에서 넘어와 처리 승인된 정보를 IFIS 테이블에 저장
                        procCnt += testEndApprvDAO.updateTestEndApprvIFIS(parameter);

                        // 부적합 자재 등록 - Procedure Call
                        Map<String, Object> itemProcParam = new HashMap<String, Object>();
                        itemProcParam.put("p_req_num", strReqNum);
                        itemProcParam.put("p_cuser", param.get("loginSabun")); // 처리자
                        retProcItemVal = testEndApprvDAO.updateTestEndApprvItemNotfitProcC(itemProcParam);

                        logger.debug("LTM_IF_ITEM_NOTFITINFO_PRO Procedure ==> " + retProcItemVal);

                        // /////////////////// 매출데이터 -> 통합영업 이관 - Procedure Call /////////////////////////
                        // 관리업장 정보 조회
                        RecordSet procRsUpjang = testEndApprvDAO.selectLimsSalesUpjangInfo(parameter);
                        // 매출정보 조회
                        RecordSet procRs = testEndApprvDAO.selectLimsSalesInfo(parameter);
                        // 내/외부 구분이 외부인 경우에 매출 등록을 처리한다.
                        // 업장구분이 내부인 FC(101), 호텔/리조트(103)는 제외
                        // 식재영업(102), 계열사(104), 협력업체(105)는 매출처리
                        if (LimsUtil.checkNull(procRs.get(0).get("insideExtrClass")).equals("102") &&
                            (
                             LimsUtil.checkNull(procRs.get(0).get("acceptClass")).equals("102") ||
                             LimsUtil.checkNull(procRs.get(0).get("acceptClass")).equals("104") ||
                             LimsUtil.checkNull(procRs.get(0).get("acceptClass")).equals("105")
                            )
                           ) {
                        //if (LimsUtil.checkNull(procRs.get(0).get("insideExtrClass")).equals("102")) {
                            Map<String, Object> procParam = new HashMap<String, Object>();
                            procParam.put("p_upmu", "LIMS"); // 업무구분 : LIMS(연구소), IFIS(고도화), FTP(식재도매)
                            procParam.put("p_req_num", strReqNum); // 키값
                            procParam.put("p_occur_date", LimsUtil.getDate("yyyyMMdd")); // 발생일자
                            procParam.put("p_upjang", procRsUpjang.get(0).get("upjang")); // 관리업장코드 - FC 식품분석실
                            procParam.put("p_mu_cd", procRsUpjang.get(0).get("muCd")); // 관리 MU 코드 - FC사업지원부
                            //procParam.put("p_mu_cd", ""); // 관리 MU 코드 - FC사업지원부
                            procParam.put("p_cc_cd", procRsUpjang.get(0).get("ccCd")); // 관리 CC 코드 - 식품분석실
                            procParam.put("p_custcd", procRs.get(0).get("custcd")); // 거래처번호
                            procParam.put("p_vat_gubun", "1"); // 과세 여부
                            procParam.put("p_amt", procRs.get(0).get("commTotAmt")); // 총합계 : 과세여부에 따라 procedure에서 갈라치기
                            procParam.put("p_sal_quantity", 1); // 판매 수량
                            procParam.put("p_cuser", param.get("loginSabun")); // 처리자
                            procParam.put("p_param_receipt_num", ""); // 기존 영수증 번호(마감 조정을 위한 키) - LIMS는 자동 일마감 처리 때문에 공백
                            procParam.put("p_pay_cd", "7"); // 지불코드

                            // 마감테이블에 전송
                            retProcVal = testEndApprvDAO.updateTestEndApprvSLA(procParam);

                            logger.debug("LTM_IF_SLA_SALESINFO_PRO Procedure ==> " + retProcVal);

                            // 매출 오류가 발생 시 Rollback 오류 처리
                            if (LimsUtil.checkNull(retProcVal.get("P_RET_CODE")).equals("E")) {
                                throw new BizException(LimsUtil.checkNull(retProcVal.get("P_RET_MSG")));
                            }

                            // 일마감 procedure 호출
                            // procedure내에서 호출 처리
                            //retProcIsrVal = testEndApprvDAO.updateTestEndApprvSLAISRC(parameter);
                        }
                    } else if ("190".equals(strProcClass)) { // 시험완료반려인 경우 다시 시험진행중으로 변경
                        parameter.put("procClass", "160");
                        procCnt += testRegInqueryService.saveStatus(parameter);
                        testInfoRegDAO.insertProcDesc(parameter); // 처리내역 저장
                    }
                }
            }
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);
        retVal.put("retVal", LimsUtil.checkNull(retProcVal.get("P_RET_MSG")));

        return retVal;
    }

}
