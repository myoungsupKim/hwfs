package com.hwfs.ls.lrm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;
import com.hwfs.ls.cmn.util.LimsUtil;

/**
 * 접수정보 등록 Dao Class
 *
 * @ClassName TestInfoRegDAO.java
 * @Description TestInfoRegDAO Class
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
@Repository("/ls/lrm/testInfoRegDAO")
public class TestInfoRegDAO extends DefaultDAO {

    /**
     * 시험항목목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectTestArticleList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lrm.testInfoRegDAO.selectTestArticleList", parameter);
    }

    /**
     * 사업장목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectUpjangList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet(
                "ls.lrm.testInfoRegDAO.selectUpjang" + LimsUtil.checkNull(parameter.get("acceptClass"), "101") + "List",
                parameter);
    }

    /**
     * 의뢰정보를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectTestReqAcceptList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lrm.testInfoRegDAO.selectTestReqAcceptList", parameter);
    }

    /**
     * 접수정보를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectSpecmInfoList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lrm.testInfoRegDAO.selectSpecmInfoList", parameter);
    }

    /**
     * 시험정보를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectTestInfoList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lrm.testInfoRegDAO.selectTestInfoList", parameter);
    }

    /**
     * 단건 시험정보를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int selectTestInfo(Map<String, Object> parameter) throws Exception {
        return super.queryForInt("ls.lrm.testInfoRegDAO.selectTestInfo", parameter);
    }

    /**
     * 진행사항 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectTestInfoProgressList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lrm.testInfoRegDAO.selectTestInfoProgressList", parameter);
    }

    /**
     * 접수목록 번호를 채번 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public String selectCreateReqNum(Map<String, Object> parameter) throws Exception {
        return (String) super.queryForObject("ls.lrm.testInfoRegDAO.selectCreateReqNum", parameter, null);
    }

    /**
     * 접수번호를 채번 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public String selectCreateAcceptNum(Map<String, Object> parameter) throws Exception {
        return (String) super.queryForObject("ls.lrm.testInfoRegDAO.selectCreateAcceptNum", parameter, null);
    }

  //20220401094 - 1
    /**
     * 접수번호를 채번 한다.(K번호채번)
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public String selectCreateAcceptNumK(Map<String, Object> parameter) throws Exception {
        return (String) super.queryForObject("ls.lrm.testInfoRegDAO.selectCreateAcceptNumK", parameter, null);
    }
    
    /**
     * 처리내역을 저장한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertProcDesc(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lrm.testInfoRegDAO.insertProcDesc", parameter);
    }

    /**
     * 의뢰정보를 생성한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertTestReqAcceptList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lrm.testInfoRegDAO.insertTestReqAcceptList", parameter);
    }

    /**
     * 의뢰정보를 수정한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int updateTestReqAcceptList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lrm.testInfoRegDAO.updateTestReqAcceptList", parameter);
    }

    /**
     * 검체정보를 생성한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertSpecmInfoList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lrm.testInfoRegDAO.insertSpecmInfoList", parameter);
    }

    /**
     * 검체정보를 수정한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int updateSpecmInfoList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lrm.testInfoRegDAO.updateSpecmInfoList", parameter);
    }

    /**
     * 검체정보를 삭제한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteSpecmInfoList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lrm.testInfoRegDAO.deleteSpecmInfoList", parameter);
    }

    /**
     * 시험항목정보를 생성한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertTestInfoList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lrm.testInfoRegDAO.insertTestInfoList", parameter);
    }

    /**
     * 시험항목정보를 수정한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int updateTestInfoList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lrm.testInfoRegDAO.updateTestInfoList", parameter);
    }

    /**
     * 시험항목정보를 삭제한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteTestInfoList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lrm.testInfoRegDAO.deleteTestInfoList", parameter);
    }

    /**
     * 시험항목정보를 삭제한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteTestDialyList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lrm.testInfoRegDAO.deleteTestDialyList", parameter);
    }
    
    /**
     * IFIS에서 넘어와 처리된 정보를 IFIS 테이블에 저장 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int updateTestReqIFIS(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lrm.testInfoRegDAO.updateTestReqIFIS", parameter);
    }

    /**
     * 시험항목정보 로그를 생성한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertSpecmTestLog(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lrm.testInfoRegDAO.insertSpecmTestLog", parameter);
    }


    /**
     * 접수목록 번호 채번(temp table)
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public String selectCreateReqNumTemp(Map<String, Object> parameter) throws Exception {
        return (String)super.queryForObject("ls.lrm.testInfoRegDAO.selectCreateReqNumTemp", parameter, null);
    }

    /**
     * 
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int saveTestInfoTemp(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lrm.testInfoRegDAO.saveTestInfoTemp", parameter);
    }

    /**
     * 처리내역을 저장한다.(temp table)
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertProcDescTemp(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lrm.testInfoRegDAO.insertProcDescTemp", parameter);
    }

    /**
     * 검체정보를 생성한다.(temp table)
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertSpecmInfoListTemp(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lrm.testInfoRegDAO.insertSpecmInfoListTemp", parameter);
    }

    /**
     * 검체정보를 수정한다.(temp table)
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int updateSpecmInfoListTemp(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lrm.testInfoRegDAO.updateSpecmInfoListTemp", parameter);
    }

    /**
     * 검체정보를 삭제한다.(temp table)
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteSpecmInfoListTemp(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lrm.testInfoRegDAO.deleteSpecmInfoListTemp", parameter);
    }

    /**
     * 시험항목정보를 생성한다.(temp table)
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertTestInfoListTemp(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lrm.testInfoRegDAO.insertTestInfoListTemp", parameter);
    }

    /**
     * 시험항목정보를 수정한다.(temp table)
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int updateTestInfoListTemp(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lrm.testInfoRegDAO.updateTestInfoListTemp", parameter);
    }

    /**
     * 시험항목정보를 삭제한다.(temp table)
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteTestInfoListTemp(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lrm.testInfoRegDAO.deleteTestInfoListTemp", parameter);
    }

    /**
     * 단건 시험정보를 조회한다.(temp table)
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int selectTestInfoTemp(Map<String, Object> parameter) throws Exception {
        return super.queryForInt("ls.lrm.testInfoRegDAO.selectTestInfoTemp", parameter);
    }

    /**
     * 접수번호를 채번 한다.(temp table)
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public String selectCreateAcceptNumTemp(Map<String, Object> parameter) throws Exception {
        return (String) super.queryForObject("ls.lrm.testInfoRegDAO.selectCreateAcceptNumTemp", parameter, null);
    }

    /**
     * 시험접수 중간저장 마스터 테이블 save
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int saveLrmTestTempMst(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lrm.testInfoRegDAO.saveLrmTestTempMst", parameter);
    }

    /**
     * 임시저장 불러오기 팝업 목록 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectLoadTestInfoTempList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lrm.testInfoRegDAO.selectLoadTestInfoTempList", parameter);
    }

    /**
     * 의뢰정보를 조회한다.(temp table)
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectTestReqAcceptListTemp(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lrm.testInfoRegDAO.selectTestReqAcceptListTemp", parameter);
    }

    /**
     * 접수정보를 조회한다.(temp table)
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectSpecmInfoListTemp(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lrm.testInfoRegDAO.selectSpecmInfoListTemp", parameter);
    }

    /**
     * 시험정보를 조회한다.(temp table)
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectTestInfoListTemp(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lrm.testInfoRegDAO.selectTestInfoListTemp", parameter);
    }

    /**
     *  저장 시 시험접수 중간저장 마스터 테이블 저장여부 update 
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int updateLrmTestTempMst(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lrm.testInfoRegDAO.updateLrmTestTempMst", parameter);
    }

}
