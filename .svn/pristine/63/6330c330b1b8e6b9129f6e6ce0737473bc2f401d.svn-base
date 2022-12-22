package com.hwfs.ls.lcm.service;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ls.lcm.dao.IntroFrameLimsDAO;
import com.hwfs.sc.cmn.dao.IntroFrameDAO;

import hone.core.util.record.RecordSet;

/**
 * IntroFrameLims ServiceImple Class
 *
 * @ClassName UserMgmtServiceImple.java
 * @Description UserMgmtServiceImple Class
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
@Service("/ls/lcm/introFrameLimsService")
public class IntroFrameLimsServiceImpl extends DefaultServiceImpl implements IntroFrameLimsService {

    @Resource(name = "/ls/lcm/introFrameLimsDAO")
    private IntroFrameLimsDAO introFrameLimsDAO;

    /** IntroFrameDAO Bean 생성 */
    @Resource(name = "/sc/cmn/introFrameDAO")
    private IntroFrameDAO introFrameDAO;

    /**
     * 챠트 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.IntroFrameLimsService#selectGraphList(java.util.Map)
    */
    @Override
    public RecordSet selectGraphList(Map<String, Object> parameter) throws Exception {
        return introFrameLimsDAO.selectGraphList(parameter);
    }

    /**
     * 검사원별 월간 진행현황 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.IntroFrameLimsService#selectMonthIngList(java.util.Map)
    */
    public RecordSet selectMonthIngList(Map<String, Object> parameter) throws Exception {
        return introFrameLimsDAO.selectMonthIngList(parameter);
    }

    /**
     * 접수대기 현황
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.IntroFrameLimsService#selecTestAcceptList(java.util.Map)
    */
    public RecordSet selecTestAcceptList(Map<String, Object> parameter) throws Exception {
        return introFrameLimsDAO.selecTestAcceptList(parameter);
    }

    /**
     * 결재대기 현황
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.IntroFrameLimsService#selecTestApprvtList(java.util.Map)
    */
    public RecordSet selecTestApprvtList(Map<String, Object> parameter) throws Exception {
        return introFrameLimsDAO.selecTestApprvtList(parameter);
    }

    /**
     * 승인처리 현황
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.IntroFrameLimsService#selecTestApprvtList(java.util.Map)
    */
    public RecordSet selecApprvActionList(Map<String, Object> parameter) throws Exception {
        return introFrameLimsDAO.selecApprvActionList(parameter);
    }

    /**
     * 체크리스트 현황
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.IntroFrameLimsService#selecTestApprvtList(java.util.Map)
    */
    public RecordSet selecCheckList(Map<String, Object> parameter) throws Exception {
        return introFrameLimsDAO.selecCheckList(parameter);
    }

    /**
     * 사후처리내역을 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.IntroFrameLimsService#selecTestApprvtList(java.util.Map)
    */
    public RecordSet selecAfterProcessHistory(Map<String, Object> parameter) throws Exception {
        return introFrameLimsDAO.selecAfterProcessHistory(parameter);
    }

    /**
     * 사용자 권한을 조회한다
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.IntroFrameLimsService#selectUserAuth(java.util.Map)
    */
    public RecordSet selectUserAuth(Map<String, Object> parameter) throws Exception {
        return introFrameLimsDAO.selectUserAuth(parameter);
    }

    /**
     * Quick List를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.IntroFrameLimsService#selectQuickList(java.util.Map)
    */
    public RecordSet selectQuickList(Map<String, Object> parameter) throws Exception {
        parameter.put("introFrameId", "IntroFrame_lims");
        return introFrameDAO.selectQuickList(parameter);
    }

    /**
     * 금일접수검체수 / 월누계검체수를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.IntroFrameLimsService#selectSpecmCntList(java.util.Map)
    */
    public RecordSet selectSpecmCntList(Map<String, Object> parameter) throws Exception {
        return introFrameLimsDAO.selectSpecmCntList(parameter);
    }

    /**
     * 기간별 현황을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.IntroFrameLimsService#selectTermCntList(java.util.Map)
    */
    public RecordSet selectTermCntList(Map<String, Object> parameter) throws Exception {
        return introFrameLimsDAO.selectTermCntList(parameter);
    }

    /**
     * 월별 실적 현황 - 검체건수
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.IntroFrameLimsService#selectMonthStaticSpecmList(java.util.Map)
    */
    public RecordSet selectMonthStaticSpecmList(Map<String, Object> parameter) throws Exception {
        return introFrameLimsDAO.selectMonthStaticSpecmList(parameter);
    }

    /**
     * 월별 실적 현황 - 시험항목수
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.IntroFrameLimsService#selectMonthStaticTestList(java.util.Map)
    */
    public RecordSet selectMonthStaticTestList(Map<String, Object> parameter) throws Exception {
        return introFrameLimsDAO.selectMonthStaticTestList(parameter);
    }

    /**
     * 월별 실적 현황 - 부적합항목수
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lcm.service.IntroFrameLimsService#selectMonthStaticNotFitList(java.util.Map)
    */
    public RecordSet selectMonthStaticNotFitList(Map<String, Object> parameter) throws Exception {
        return introFrameLimsDAO.selectMonthStaticNotFitList(parameter);
    }

}
