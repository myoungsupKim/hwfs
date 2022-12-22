package com.hwfs.ls.lrm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ls.lrm.dao.TestInfoRegDAO;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 접수정보 등록 ServiceImple Class
 *
 * @ClassName TestInfoRegServiceImple.java
 * @Description TestInfoRegServiceImple Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 23.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 3. 23.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ls/lrm/testInfoRegService")
public class TestInfoRegServiceImpl extends DefaultServiceImpl implements TestInfoRegService {

    /** LogService */
    private final Logger logger = LoggerFactory.getLogger (this.getClass());

    @Resource(name = "/ls/lrm/testInfoRegDAO")
    private TestInfoRegDAO testInfoRegDAO;

    /**
     * 시험항목목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.TestInfoRegService#selectTestArticleList(java.util.Map)
    */
    @Override
    public RecordSet selectTestArticleList(Map<String, Object> parameter) throws Exception {
        return testInfoRegDAO.selectTestArticleList(parameter);
    }

    /**
     * 사업장목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.TestInfoRegService#selectUpjangList(java.util.Map)
    */
    @Override
    public RecordSet selectUpjangList(Map<String, Object> parameter) throws Exception {
        return testInfoRegDAO.selectUpjangList(parameter);
    }

    /**
     * 의뢰정보를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.TestInfoRegService#selectTestReqAcceptList(java.util.Map)
    */
    @Override
    public RecordSet selectTestReqAcceptList(Map<String, Object> parameter) throws Exception {
        return testInfoRegDAO.selectTestReqAcceptList(parameter);
    }

    /**
     * 접수정보를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.TestInfoRegService#selectTestReqAcceptList(java.util.Map)
    */
    @Override
    public RecordSet selectSpecmInfoList(Map<String, Object> parameter) throws Exception {
        return testInfoRegDAO.selectSpecmInfoList(parameter);
    }

    /**
     * 시험정보를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.TestInfoRegService#selectAcceptSpecmList(java.util.Map)
    */
    @Override
    public RecordSet selectTestInfoList(Map<String, Object> parameter) throws Exception {
        return testInfoRegDAO.selectTestInfoList(parameter);
    }

    /**
     * 진행사항 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.TestInfoRegService#selectAcceptSpecmList(java.util.Map)
    */
    @Override
    public RecordSet selectTestInfoProgressList(Map<String, Object> parameter) throws Exception {
        return testInfoRegDAO.selectTestInfoProgressList(parameter);
    }

    /**
     * 접수시험정보를 저장한다.
     *
     * @param testReqAccept
     * @param specmArticleList
     * @param testArticleList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lrm.service.TestInfoRegService#saveList(hone.online.xplatform.map.DataSetMap, hone.online.xplatform.map.DataSetMap, hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveList(DataSetMap testReqAccept, DataSetMap specmArticleList, DataSetMap testArticleList,
            DataSetMap paramValue) throws Exception {
        Map<String, Object> parameter = null;

        String reqNum = "";
        String tempSeq = "";	//임시저장 master table pk
        
        int procCnt = 0;
        int rowType = 0;

        for (int i = 0; i < testReqAccept.size(); i++) {
            parameter = testReqAccept.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            reqNum = LimsUtil.checkNull(parameter.get("reqNum"));
            tempSeq = LimsUtil.checkNull(parameter.get("tempSeq"));

            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                reqNum = testInfoRegDAO.selectCreateReqNum(parameter);
                parameter.put("reqNum", reqNum);
                procCnt += testInfoRegDAO.insertTestReqAcceptList(parameter); // 의뢰정보

                parameter.put("procClass", "110"); // 접수중
                testInfoRegDAO.insertProcDesc(parameter); // 처리내역

                //procCnt += saveSpecmArticleList(parameter, specmArticleList, testArticleList); // 검체정보
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                procCnt += testInfoRegDAO.updateTestReqAcceptList(parameter);
            }
            procCnt += saveSpecmArticleList(parameter, specmArticleList, testArticleList); // 검체정보
            // 접수승인반려인 경우 수정이 발생하면 다시 접수중으로 변경 한다.
            // 사용안함 **********
            if (LimsUtil.checkNull(parameter.get("progressStatus")).equals("140")) {
                parameter.put("procClass", "110"); // 접수중
                testInfoRegDAO.insertProcDesc(parameter); // 처리내역
            }

            // 임시저장 마스터테이블에 SAVE_YN 과 REQ_NUM update (20171107 유선미) 
            if(!tempSeq.equals("")){
            	testInfoRegDAO.updateLrmTestTempMst(parameter); 
            }
        }

        // 타 모듈에서 등록시 타 모듈에 값을 세팅 한다.
        String acceptClass = "";
        for (int i = 0; i < paramValue.size(); i++) {
            parameter = paramValue.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                acceptClass = LimsUtil.checkNull(parameter.get("str1"));
                if ("IFIS".equals(acceptClass)) {
                    parameter.put("reqNum", reqNum);
                    procCnt += testInfoRegDAO.updateTestReqIFIS(parameter);
                }
            }
        }
        
        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);
        retVal.put("reqNum", reqNum);

        return retVal;
    }

    /**
     * 검체정보 등록
     *
     * @param param
     * @param specmArticleList
     * @param testArticleList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lrm.service.TestInfoRegService#saveSpecmArticleList(java.util.Map, hone.online.xplatform.map.DataSetMap, hone.online.xplatform.map.DataSetMap)
    */
    @SuppressWarnings("unchecked")
    public int saveSpecmArticleList(Map<String, Object> param, DataSetMap specmArticleList, DataSetMap testArticleList)
            throws Exception {
        int procCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;
        String acceptNum = "";
        String tmpSeqNum = "";
        //20220401094 - 1
        String approvalClass = ""; //상신유형
        
        // 삭제가 있으면 먼저 삭제 한다.
        // 화면단에서 체크된 row 삭제
        for (int i = 0; i < specmArticleList.size(); i++) {
            parameter = specmArticleList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            parameter.put("reqNum", LimsUtil.checkNull(param.get("reqNum"))); // 의뢰번호

            if (rowType == DataSet.ROW_TYPE_DELETED) {
                procCnt += testInfoRegDAO.deleteSpecmInfoList(parameter);

                // 같은 seqNum 시험정보 저장
                tmpSeqNum = LimsUtil.checkNull(parameter.get("seqNum"));
                procCnt += saveTestArticleList(tmpSeqNum, parameter, testArticleList);
            }
        }

        for (int i = 0; i < specmArticleList.size(); i++) {
            parameter = specmArticleList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            parameter.put("reqNum", LimsUtil.checkNull(param.get("reqNum"))); // 의뢰번호

            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                approvalClass = LimsUtil.checkNull(param.get("approvalClass")); //상신유형
                logger.info( "approvalClass :"+approvalClass);
                // 상신유형코드 '103'인 경우 접수번호 'K'채번
                if (approvalClass.equals("103")) {
                    acceptNum = testInfoRegDAO.selectCreateAcceptNumK(parameter); // 접수번호
                }
                else
                {
                    acceptNum = testInfoRegDAO.selectCreateAcceptNum(parameter); // 접수번호
                }
                parameter.put("acceptNum", acceptNum);
                procCnt += testInfoRegDAO.insertSpecmInfoList(parameter); // 검체정보
            } else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                procCnt += testInfoRegDAO.updateSpecmInfoList(parameter);
            }

            if (rowType != DataSet.ROW_TYPE_DELETED) {
                // 같은 seqNum 시험정보 저장
                tmpSeqNum = LimsUtil.checkNull(parameter.get("seqNum"));
                procCnt += saveTestArticleList(tmpSeqNum, parameter, testArticleList);
            }
        }

        return procCnt;
    }

    /**
     * 시험정보 등록
     *
     * @param seqNum
     * @param param
     * @param testArticleList
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lrm.service.TestInfoRegService#saveTestArticleList(java.lang.String, java.util.Map, hone.online.xplatform.map.DataSetMap)
    */
    @SuppressWarnings("unchecked")
    public int saveTestArticleList(String seqNum, Map<String, Object> param, DataSetMap testArticleList) throws Exception {
        int procCnt = 0;
        Map<String, Object> parameter = null;
        Map<String, Object> logParam = new HashMap<String, Object>();
        int rowType = 0;
        int chkCnt = 0;

        // 삭제가 있으면 먼저 삭제 한다.
        // 화면단에서 체크된 row 삭제
        for (int i = 0; i < testArticleList.size(); i++) {
            parameter = testArticleList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            parameter.put("reqNum", LimsUtil.checkNull(param.get("reqNum"))); // 의뢰번호
            parameter.put("acceptNum", LimsUtil.checkNull(param.get("acceptNum"))); // 접수번호

            if (seqNum.equals(LimsUtil.checkNull(parameter.get("seqNum"))) && rowType == DataSet.ROW_TYPE_DELETED) {
            	testInfoRegDAO.deleteTestDialyList(parameter);
                procCnt += testInfoRegDAO.deleteTestInfoList(parameter);
            }
        }

        for (int i = 0; i < testArticleList.size(); i++) {
            parameter = testArticleList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            parameter.put("reqNum", LimsUtil.checkNull(param.get("reqNum"))); // 의뢰번호
            parameter.put("acceptNum", LimsUtil.checkNull(param.get("acceptNum"))); // 접수번호

            if (seqNum.equals(LimsUtil.checkNull(parameter.get("seqNum")))) {
                if (rowType == DataSet.ROW_TYPE_INSERTED) {
                    ////////////////////////////////////////////////////////////////////
                    // 만약 오류가 날 경우를 대비해서 시험항목 로그를 남긴다.
                    // logParam.put("reqNum", LimsUtil.checkNull(param.get("reqNum")));
                    // logParam.put("acceptNum", LimsUtil.checkNull(param.get("acceptNum")));
                    // logParam.put("jobGubun", "LRM_TEST_INFO");
                    // logParam.put("jobParam", parameter.toString());
                    // testInfoRegDAO.insertSpecmTestLog(logParam);
                    ///////////////////////////////////////////////////////////////////

                    // 중복등록 오류 방지를 위해 체크
                    chkCnt = testInfoRegDAO.selectTestInfo(parameter);
                    if (chkCnt == 0) {
                        procCnt += testInfoRegDAO.insertTestInfoList(parameter); // 시험항목정보
                    } else {
                        throw processException("ls.dataChkDup"); // 중복 데이터 오류
                    }
                } else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                    procCnt += testInfoRegDAO.updateTestInfoList(parameter);
                }
            }
        }

        return procCnt;
    }

    /**
     * 접수시험정보를 임시저장한다.
     *
     * @param testReqAccept
     * @param specmArticleList
     * @param testArticleList
     * @return
     * @throws Exception
     * @since 20171109
     * @author 유선미
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveTemp(DataSetMap testReqAccept, DataSetMap specmArticleList, DataSetMap testArticleList) throws Exception {
        Map<String, Object> retVal = new HashMap<String, Object>();
        
        int procCnt = 0;

    	Map<String, Object> param = testReqAccept.get(0);
    	
    	String tempSeq = LimsUtil.checkNull(param.get("tempSeq"));

        if (tempSeq.equals("")) {
        	tempSeq = testInfoRegDAO.selectCreateReqNumTemp(param);
			
			param.put("tempSeq", tempSeq);
			
			// 처리내역
			testInfoRegDAO.insertProcDescTemp(param); 		
    	} 

        // 의뢰정보
		procCnt += testInfoRegDAO.saveTestInfoTemp(param); 		
		
		// 검체정보, 시험정보 등록
        procCnt += saveSpecmTestInfoTemp(param, specmArticleList, testArticleList); 

        //시험접수 중간저장 마스터 테이블 save
        procCnt += testInfoRegDAO.saveLrmTestTempMst(param);
		
        retVal.put("procCnt", procCnt);
        retVal.put("tempSeq", tempSeq);

        return retVal;
    }

    /**
     * 검체정보, 시험정보 등록(temp table)
     *
     * @param param
     * @param specmArticleList
     * @param testArticleList
     * @return
     * @throws Exception
     * @since 20171109
     * @author 유선미
    */
    @SuppressWarnings("unchecked")
    public int saveSpecmTestInfoTemp(Map<String, Object> param, DataSetMap specmArticleList, DataSetMap testArticleList) throws Exception {
    	Map<String, Object> specmInfoParam = null;
    	Map<String, Object> testInfoParam = null;
        int procCnt = 0;
        String acceptNum = "";
        String tmpSeqNum = "";
        
        //검체정보, 시험정보 삭제
        procCnt += testInfoRegDAO.deleteTestInfoListTemp(param);
        procCnt += testInfoRegDAO.deleteSpecmInfoListTemp(param);
        
        for (int i = 0; i < specmArticleList.size(); i++) {
        	specmInfoParam = specmArticleList.get(i);

            tmpSeqNum = LimsUtil.checkNull(specmInfoParam.get("seqNum"));
            
        	specmInfoParam.put("tempSeq", LimsUtil.checkNull(param.get("tempSeq"))); 	// 임시저장 key
            acceptNum = testInfoRegDAO.selectCreateAcceptNumTemp(specmInfoParam); 		// 의뢰번호
            specmInfoParam.put("acceptNum", acceptNum);
            
            //검체정보 등록
            procCnt += testInfoRegDAO.insertSpecmInfoListTemp(specmInfoParam);

            for (int j = 0; j < testArticleList.size(); j++) {
            	testInfoParam = testArticleList.get(j);

                if (tmpSeqNum.equals(LimsUtil.checkNull(testInfoParam.get("seqNum")))) {
	            	testInfoParam.put("acceptNum", acceptNum);
	            	testInfoParam.put("tempSeq", LimsUtil.checkNull(param.get("tempSeq")));

	            	/* 2018.02.05 김명섭 [CH201802_00006] 임시저장 시험정보 중복체크 주석처리
                    // 중복데이터 체크
                    int dupCnt = testInfoRegDAO.selectTestInfoTemp(testInfoParam);
                    
                    if (dupCnt == 0) {
    	                //시험정보 등록
    	        		procCnt += testInfoRegDAO.insertTestInfoListTemp(testInfoParam);
                    } else {
                        throw processException("ls.dataChkDup"); 
                    }
	            	2018.02.05 김명섭 [CH201802_00006] 임시저장 시험정보 중복체크 주석처리 */
	        		procCnt += testInfoRegDAO.insertTestInfoListTemp(testInfoParam);
                }
            }
        }

        return procCnt;
    }


    /**
     * 임시저장 불러오기 팝업 목록 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @since 20171109
     * @author 유선미
     */
    public RecordSet selectLoadTestInfoTempList(Map<String, Object> parameter) throws Exception {
        return testInfoRegDAO.selectLoadTestInfoTempList(parameter);
    }

    /**
     * 의뢰정보를 조회한다.(temp table)
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.TestInfoRegService#selectTestReqAcceptList(java.util.Map)
    */
    @Override
    public RecordSet selectTestReqAcceptListTemp(Map<String, Object> parameter) throws Exception {
        return testInfoRegDAO.selectTestReqAcceptListTemp(parameter);
    }

    /**
     * 접수정보를 조회한다.(temp table)
     *
     * @param parameter
     * @return
     * @throws Exception
     * @since 20171109
     * @author 유선미
    */
    @Override
    public RecordSet selectSpecmInfoListTemp(Map<String, Object> parameter) throws Exception {
        return testInfoRegDAO.selectSpecmInfoListTemp(parameter);
    }

    /**
     * 시험정보를 조회한다.(temp table)
     *
     * @param parameter
     * @return
     * @throws Exception
     * @since 20171109
     * @author 유선미
    */
    @Override
    public RecordSet selectTestInfoListTemp(Map<String, Object> parameter) throws Exception {
        return testInfoRegDAO.selectTestInfoListTemp(parameter);
    }

}
