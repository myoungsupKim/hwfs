package com.hwfs.ls.lcm.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

/**
 * IntroFrameLims Serive Class
 *
 * @ClassName UserMgmtService.java
 * @Description UserMgmtService Class
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
public interface IntroFrameLimsService {

    /**
     * 챠트 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectGraphList(Map<String, Object> parameter) throws Exception;

    /**
     * 검사원별 월간 진행현황 리스트를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectMonthIngList(Map<String, Object> parameter) throws Exception;

    /**
     * 접수 대기현황.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selecTestAcceptList(Map<String, Object> parameter) throws Exception;

    /**
     * 결재 대기현황.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selecTestApprvtList(Map<String, Object> parameter) throws Exception;

    /**
     * 승인처리 현황.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selecApprvActionList(Map<String, Object> parameter) throws Exception;

    /**
     * 체크리스트 현황.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selecCheckList(Map<String, Object> parameter) throws Exception;

    /**
     * 사후처리내역을 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selecAfterProcessHistory(Map<String, Object> parameter) throws Exception;

    /**
     * 사용자 권한을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectUserAuth(Map<String, Object> parameter) throws Exception;

    /**
     * Quick List를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectQuickList(Map<String, Object> parameter) throws Exception;

    /**
     * 금일접수검체수 / 월누계검체수를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectSpecmCntList(Map<String, Object> parameter) throws Exception;

    /**
     * 기간별 현황을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectTermCntList(Map<String, Object> parameter) throws Exception;

    /**
     * 월별 실적 현황 - 검체건수
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectMonthStaticSpecmList(Map<String, Object> parameter) throws Exception;

    /**
     * 월별 실적 현황 - 검체항목수
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectMonthStaticTestList(Map<String, Object> parameter) throws Exception;

    /**
     * 월별 실적 현황 - 부적합항목수
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectMonthStaticNotFitList(Map<String, Object> parameter) throws Exception;

}
