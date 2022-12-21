package com.hwfs.ls.lsm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

/**
 * 월계획 조정 관리 Serive Class
 *
 * @ClassName MonthlyPlanMgmtService.java
 * @Description MonthlyPlanMgmtService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 9. 22.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 9. 22.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface MonthlyPlanMgmtService {

    /**
     * 월계획 조정 수립 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectList(Map<String, Object> parameter) throws Exception;

    /**
     * 공전유형 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectClassList(Map<String, Object> parameter) throws Exception;

    /**
     * 월계획 조정 조회 - 검사시료 수
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectTestCnt(Map<String, Object> parameter) throws Exception;

    /**
     * 월계획 조정 조회 - 화학 검사 수
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectMicbioCnt(Map<String, Object> parameter) throws Exception;

    /**
     * 월계획 조정 조회 - 생물 검사 수
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectPhyChemCnt(Map<String, Object> parameter) throws Exception;

    /**
     * 자재 목록 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectItemList(Map<String, Object> parameter) throws Exception;

    /**
     * 전체 저장
     *
     * @param parameter
     * @param saveList
     * @return
     * @throws Exception
     */
    Map<String, Object> saveList(Map<String, Object> parameter, DataSetMap saveList) throws Exception;

    /**
     * 월별 공전유형 삭제
     *
     * @param reagentTransListt
     * @return
     * @throws Exception
     */
    Map<String, Object> deleteSpecm(Map<String, Object> parameter) throws Exception;

    /**
     * 월계획 조정 세부 내역 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectItemDtlList(Map<String, Object> parameter) throws Exception;

    /**
     * 년간계획 월계획을 복사한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    Map<String, Object> saveYearPlanMigration(Map<String, Object> parameter) throws Exception;

    /**
     * 시험결과 부적합 이력조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectDetailList(Map<String, Object> parameter) throws Exception;

}
