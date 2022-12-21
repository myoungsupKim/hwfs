package com.hwfs.sm.saa.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

/**
 * 담보정보등록하는 AccdDamboInfoReg Service Interface
 *
 * @ClassName AccdDamboInfoRegService.java
 * @Description AccdDamboInfoRegService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.24    최종덕        최초생성
 *
 * </pre>
 * @author FC종합전산구축 : 통합영업 최종덕
 * @since 2015.04.24
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface AccdDamboInfoRegService {

    /**
     * 담보정보 목록을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
    */
    RecordSet selectList(Map<String, Object> parameter) throws Exception;

    /**
     * 메인업장을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
    */
    RecordSet selectMainUpjang(Map<String, Object> parameter) throws Exception;

    /**
     * 부동산 목록을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
    */
    RecordSet selectRealEstate(Map<String, Object> parameter) throws Exception;

    /**
     * 보증보험 목록을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    RecordSet selectGuaranteeInsur(Map<String, Object> parameter) throws Exception;

    /**
     * 인보증 목록을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    RecordSet selectGuarantor(Map<String, Object> parameter) throws Exception;

    /**
     * 현금보증 목록을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    RecordSet selectCashGuarantee(Map<String, Object> parameter) throws Exception;

    /**
     * 질권 목록을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    RecordSet selectPledge(Map<String, Object> parameter) throws Exception;

    /**
     * 채권양도 목록을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    RecordSet selectAccRcvAlnt(Map<String, Object> parameter) throws Exception;

    /**
     * 담보정보 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
     *
     * @param realEstate
     * @param guaranteeInsur
     * @param guarantor
     * @param cashGuarantee
     * @param pledge
     * @param accRcvAlnt
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @param dataSetMap
     * @return 처리건수
     * @throws Exception
    */
    int saveList(DataSetMap realEstate, DataSetMap guaranteeInsur, DataSetMap guarantor, DataSetMap cashGuarantee, DataSetMap pledge, DataSetMap accRcvAlnt) throws Exception;
}
