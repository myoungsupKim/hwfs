package com.hwfs.ls.lem.service;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ls.lem.dao.InspectRptIssueInqueryDAO;
import com.hwfs.ls.lrm.dao.TestInfoRegDAO;
import com.hwfs.ls.lrm.service.TestRegInqueryService;

/**
 * 성적서발급 및 결과 조회 ServiceImple Class
 *
 * @ClassName InspectRptIssueInqueryServiceImple.java
 * @Description InspectRptIssueInqueryServiceImple Class
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
@Service("/ls/lem/inspectRptIssueInqueryService")
public class InspectRptIssueInqueryServiceImpl extends DefaultServiceImpl implements InspectRptIssueInqueryService {

    @Resource(name = "/ls/lem/inspectRptIssueInqueryDAO")
    private InspectRptIssueInqueryDAO inspectRptIssueInqueryDAO;

    @Resource(name = "/ls/lrm/testRegInqueryService")
    private TestRegInqueryService testRegInqueryService;

    @Resource(name = "/ls/lrm/testInfoRegDAO")
    private TestInfoRegDAO testInfoRegDAO;

    /**
     * 의뢰목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lem.service.InspectRptIssueInqueryService#selectList(java.util.Map)
    */
    @Override
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return inspectRptIssueInqueryDAO.selectList(parameter);
    }

    /**
     * 검체목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lem.service.InspectRptIssueInqueryService#selectSpecmList(java.util.Map)
    */
    @Override
    public RecordSet selectSpecmList(Map<String, Object> parameter) throws Exception {
        return inspectRptIssueInqueryDAO.selectSpecmList(parameter);
    }

    /**
     * 시험항목 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lem.service.InspectRptIssueInqueryService#selectDetailList(java.util.Map)
    */
    @Override
    public RecordSet selectDetailList(Map<String, Object> parameter) throws Exception {
        return inspectRptIssueInqueryDAO.selectDetailList(parameter);
    }

    /**
     * 성적서발급이력 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lem.service.InspectRptIssueInqueryService#selectInspectRptIssueHistList(java.util.Map)
    */
    @Override
    public RecordSet selectInspectRptIssueHistList(Map<String, Object> parameter) throws Exception {
        return inspectRptIssueInqueryDAO.selectInspectRptIssueHistList(parameter);
    }

    /**
     * 성적서발급이력 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lem.service.InspectRptIssueInqueryService#selectInsptRptSpecmtList(java.util.Map)
    */
    @Override
    public RecordSet selectInsptRptSpecmtList(Map<String, Object> parameter) throws Exception {
        return inspectRptIssueInqueryDAO.selectInsptRptSpecmtList(parameter);
    }

    /**
     * 성적서발급이력 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lem.service.InspectRptIssueInqueryService#selectInsptRptTestResultList(java.util.Map)
    */
    @Override
    public RecordSet selectInsptRptTestResultList(Map<String, Object> parameter) throws Exception {
        return inspectRptIssueInqueryDAO.selectInsptRptTestResultList(parameter);
    }

    /**
     * 성적서발급이력 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lem.service.InspectRptIssueInqueryService#selectInsptRptTestUserList(java.util.Map)
    */
    @Override
    public RecordSet selectInsptRptTestUserList(Map<String, Object> parameter) throws Exception {
        return inspectRptIssueInqueryDAO.selectInsptRptTestUserList(parameter);
    }

    /**
     * 성적서발급이력 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lem.service.InspectRptIssueInqueryService#selectInsptRptTestTechUserList(java.util.Map)
    */
    @Override
    public RecordSet selectInsptRptTestTechUserList(Map<String, Object> parameter) throws Exception {
        return inspectRptIssueInqueryDAO.selectInsptRptTestTechUserList(parameter);
    }

    /**
     * 성적서 발급 이력을 저장 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lem.service.InspectRptIssueInqueryService#saveInsptRptIssueHistory(java.util.Map)
    */
    @Override
    public Map<String, Object> saveInsptRptIssueHistory(Map<String, Object> parameter) throws Exception {
        int procCnt = 0;
        String strProcClass = "";	// 성적서 발급
        //String strReqClass = "";	// 성적서 여청

        // 2015-07-13 최준열M/신현호M 요청으로 성적서 재발급 신청 시 신청 사유 등록
        // 이에따라 성적서 발급이력 테이블을 발급신청 시 미리등록 후
        // 발급 승인 / 성적서발급 시 데이터를 UPDATE한다.
        if ("230".equals(LimsUtil.checkNull(parameter.get("progressStatus")))) {
            //strReqClass = "210";
            strProcClass = "240";	// 성적서 발급
        } else if ("270".equals(LimsUtil.checkNull(parameter.get("progressStatus")))) {
            //strReqClass = "250";
            strProcClass = "280";	// 성적서 재 발급
        }

        // 성적서 발급 발급일자 정보 저장
        // 2015-07-13 최준열M/신현호M 요청으로 성적서 재발급 신청 시 신청 사유 등록
        // 이에따라 성적서 발급이력 테이블을 발급신청 시 미리등록 후
        // 발급 승인 / 성적서발급 시 데이터를 UPDATE한다.
        procCnt += inspectRptIssueInqueryDAO.saveInsptRptIssueHistoryPub(parameter);

        // 성적서 발행번호 채번
        //String strPublishNum = inspectRptIssueInqueryDAO.selectCreatePublishNum(parameter);
        //parameter.put("publishNum", strPublishNum);

        // 성적서 이력 저장
        // 현 화면의 처리 상태가
        // 230(성적서발급승인) : 210(요청사항/요청자,요청일) , 230(승인사항/승인자,승인일)
        // 270(성적서재발급승인) : 250(요청사항/요청자,요청일) , 270(승인사항/승인자,승인일)
        /*parameter.put("reqClass", strReqClass);
        procCnt += inspectRptIssueInqueryDAO.saveInsptRptIssueHistory(parameter);*/

        // 성적서 발급 및 재발급에 대한 상태 저장
        if (!"".equals(strProcClass)) {
            parameter.put("procClass", strProcClass);	// 성적서발급/재발급
            procCnt += testRegInqueryService.saveStatus(parameter);
            testInfoRegDAO.insertProcDesc(parameter); // 처리내역 저장
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);

        return retVal;
    }

}
