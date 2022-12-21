package com.hwfs.ls.lcm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * IntroFrameLims Dao Class
 *
 * @ClassName IntroFrameLimsDAO.java
 * @Description IntroFrameLimsDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 20.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 4. 20.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ls/lcm/introFrameLimsDAO")
public class IntroFrameLimsDAO extends DefaultDAO {

    /**
     * 챠트 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectGraphList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.introFrameLimsDAO.selectGraphList", parameter);
    }

    /**
     * 검사원별 월간 진행현황 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectMonthIngList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.introFrameLimsDAO.selectMonthIngList", parameter);
    }

    /**
     * 접수대기 현황
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selecTestAcceptList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.introFrameLimsDAO.selecTestAcceptList", parameter);
    }

    /**
     * 결재대기 현황
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selecTestApprvtList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.introFrameLimsDAO.selecTestApprvtList", parameter);
    }

    /**
     * 승인처리 현황
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selecApprvActionList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.introFrameLimsDAO.selecApprvActionList", parameter);
    }

    /**
     * 체크리스트 현황
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selecCheckList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.introFrameLimsDAO.selecCheckList", parameter);
    }

    /**
     * 사후처리내역을 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selecAfterProcessHistory(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.introFrameLimsDAO.selecAfterProcessHistory", parameter);
    }

    /**
     * 사용자 권한을 조회한다
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectUserAuth(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.introFrameLimsDAO.selectUserAuth", parameter);
    }

    /**
     * 금일접수검체수 / 월누계검체수를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectSpecmCntList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.introFrameLimsDAO.selectSpecmCntList", parameter);
    }

    /**
     * 기간별 현황을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectTermCntList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.introFrameLimsDAO.selectTermCntList", parameter);
    }

    /**
     * 월별 실적 현황 - 검체건수
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectMonthStaticSpecmList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.introFrameLimsDAO.selectMonthStaticSpecmList", parameter);
    }

    /**
     * 월별 실적 현황 - 검체항목수
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectMonthStaticTestList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.introFrameLimsDAO.selectMonthStaticTestList", parameter);
    }

    /**
     * 월별 실적 현황 - 부적합항목수
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectMonthStaticNotFitList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.introFrameLimsDAO.selectMonthStaticNotFitList", parameter);
    }

}
