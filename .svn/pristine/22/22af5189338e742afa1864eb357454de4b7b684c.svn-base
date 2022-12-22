package com.hwfs.ls.ltm.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 시험진행 및 결과 조회 Dao Class
 *
 * @ClassName TestResultInqueryDAO.java
 * @Description TestResultInqueryDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 30.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 3. 30.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ls/ltm/testResultInqueryDAO")
public class TestResultInqueryDAO extends DefaultDAO {

    /**
     * 의뢰목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.ltm.testResultInqueryDAO.selectList", parameter);
    }

    /**
     * 검체목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectSpecmList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.ltm.testResultInqueryDAO.selectSpecmList", parameter);
    }

    /**
     * 시험항목 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectDetailList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.ltm.testResultInqueryDAO.selectDetailList", parameter);
    }

    /**
     * 시험일지 데이터를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectTestDiary(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.ltm.testResultInqueryDAO.selectTestDiary", parameter);
    }

    /**
     * 시험일지 건수를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int selectTestDiaryCnt(Map<String, Object> parameter) throws Exception {
        return super.queryForInt("ls.ltm.testResultInqueryDAO.selectTestDiaryCnt", parameter);
    }

    /**
     * 시험일지의 최종판정이 완료되었는지 여부 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public String selectTestDiaryEndYn(Map<String, Object> parameter) throws Exception {
        return (String) super.queryForObject("ls.ltm.testResultInqueryDAO.selectTestDiaryEndYn", parameter, null);
    }

    /**
     * 시험일지 데이터를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectLastProgressStatus(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.ltm.testResultInqueryDAO.selectLastProgressStatus", parameter);
    }

    /**
     * 시험일지 시험방법 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectTestDiaryMethodList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.ltm.testResultInqueryDAO.selectTestDiaryMethodList", parameter);
    }

    /**
     * 시험일지 시험방법 DATA를 시험항목에서 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectTestDiaryMethodArticleList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.ltm.testResultInqueryDAO.selectTestDiaryMethodArticleList", parameter);
    }

    /**
     * 시험일지 Master를 생성한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertTestArticleList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.ltm.testResultInqueryDAO.insertTestArticleList", parameter);
    }

    /**
     * 시험일지 Master를 수정한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int updateTestArticleList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.ltm.testResultInqueryDAO.updateTestArticleList", parameter);
    }

    /**
     * 시험일지 시험방법을 생성 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertTestDiaryList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.ltm.testResultInqueryDAO.insertTestDiaryList", parameter);
    }

    /**
     * 시험일지 시험방법을 수정 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int updateTestDiaryList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.ltm.testResultInqueryDAO.updateTestDiaryList", parameter);
    }

    /**
     * 시험일지 시험방법을 삭제 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteTestDiaryList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.ltm.testResultInqueryDAO.deleteTestDiaryList", parameter);
    }

    /**
     * 시험일지 시험방법을 전체 삭제 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteAllTestDiaryList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.ltm.testResultInqueryDAO.deleteAllTestDiaryList", parameter);
    }

    /**
     * 시험결과 상신 전 검사목적,방법을 등록한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int saveInsptPurpMtod(Map<String, Object> parameter) throws Exception {
        return super.update("ls.ltm.testResultInqueryDAO.saveInsptPurpMtod", parameter);
    }

    /**
     * 시험결과 구매전송 검사목적,방법을 등록한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int saveInsptPurpMtodItemSend(Map<String, Object> parameter) throws Exception {
        return super.update("ls.ltm.testResultInqueryDAO.saveInsptPurpMtodItemSend", parameter);
    }

    /**
     * 시험결과 상신 Master를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Record selectReportMst(Map<String, Object> parameter) throws Exception {
        return super.queryForRecord("ls.ltm.testResultInqueryDAO.selectReportMst", parameter);
    }

    /**
     * 시험결과 상신 Detail를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectReportDetail(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.ltm.testResultInqueryDAO.selectReportDetail", parameter);
    }

    /**
     * 검체폐기 정보를 등록한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int saveDisuseYn(Map<String, Object> parameter) throws Exception {
        return super.update("ls.ltm.testResultInqueryDAO.saveDisuseYn", parameter);
    }

    /**
     * 성적서 발급여부를 변경.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int saveInspectRptIssueYn(Map<String, Object> parameter) throws Exception {
        return super.update("ls.ltm.testResultInqueryDAO.saveInspectRptIssueYn", parameter);
    }

    /**
     * 검체 폐기대상 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectSpecmDisuseList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.ltm.testResultInqueryDAO.selectSpecmDisuseList", parameter);
    }

    /**
     * 검체폐기 정보를 일괄 등록한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int saveDisuseAllYn(Map<String, Object> parameter) throws Exception {
        return super.update("ls.ltm.testResultInqueryDAO.saveDisuseAllYn", parameter);
    }

    /**
     * 서버 사진을 조회한다.
     *
     * @param parameter
     * @return
     */
    public RecordSet selectImgList(Map<String, Object> parameter) {
        return super.queryForRecordSet("ls.ltm.testResultInqueryDAO.selectImgList", parameter);
    }
    

    /**
     * 구매수기 등록한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertSendItem(Map<String, Object> parameter) throws Exception {
        return super.update("ls.ltm.testResultInqueryDAO.insertSendItem", parameter);
    }

    /**
     * 결재상신팝업 저장내역 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @since 20171123
     * @author 유선미
     */
    public RecordSet selectGwDraftTemp(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.ltm.testResultInqueryDAO.selectGwDraftTemp", parameter);
    }

    /**
     * 결재상신 팝업 임시저장
     *
     * @param parameter
     * @return
     * @throws Exception
     * @since 20171123
     * @author 유선미
     */
    public int saveGwDraftTemp(Map<String, Object> param) throws Exception {
        return super.update("ls.ltm.testResultInqueryDAO.saveGwDraftTemp", param);
    }

    /**
     * 시험항목 기준규격 수정한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int updateBasisStand(Map<String, Object> parameter) throws Exception {
        return super.update("ls.ltm.testResultInqueryDAO.updateBasisStand", parameter);
    }
    
}


