package com.hwfs.sm.saa.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

/**
 * 사고채권발생보고하는 AccdArOccurRept Service Interface
 *
 * @ClassName AccdArOccurReptService.java
 * @Description AccdArOccurReptService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.29    최종덕        최초생성
 *
 * </pre>
 * @author FC종합전산구축 : 통합영업 최종덕
 * @since 2015.04.29
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface AccdArOccurReptService {

   /**
    * 사고채권발생보고 목록을 조회한다.
    *
    * @param parameter
    *            조회조건 Map
    * @return RecordSet
    *            조회결과
    * @throws Exception
    */
    RecordSet selectList(Map<String, Object> parameter) throws Exception;

    /**
     * 식재업장 정보를 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    RecordSet selectSaupNoList(Map<String, Object> parameter) throws Exception;

    /**
     * 업장정보를 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    RecordSet selectUpjang(Map<String, Object> parameter) throws Exception;

    /**
     * 거래처 채권 금액(급식)을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    RecordSet selectCustInfo(Map<String, Object> parameter) throws Exception;

    /**
     * 거래처 채권 금액(식재)을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    RecordSet selectCustInfoFms(Map<String, Object> parameter) throws Exception;

    /**
     * 채무자 목록을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    RecordSet selectDebt(Map<String, Object> parameter) throws Exception;

    /**
     * 담보 목록을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    RecordSet selectDambo(Map<String, Object> parameter) throws Exception;

    /**
     * 법적조치 목록을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    RecordSet selectLegal(Map<String, Object> parameter) throws Exception;

    /**
     * 거래내역 헤더 목록을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    RecordSet selectHdrDealDesc(Map<String, Object> parameter) throws Exception;

    /**
     * 거래내역 목록을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    RecordSet selectDealDesc(Map<String, Object> parameter) throws Exception;
    
    /**
     * 거래내역 헤더 목록을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    RecordSet selectHdrDealDescFs(Map<String, Object> parameter) throws Exception;
    
    /**
     * 거래내역 목록을 조회한다.
     *
     * @param parameter
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    RecordSet selectDealDescFs(Map<String, Object> parameter) throws Exception;

    /**
     * 사고채권발생보고 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
     *
     * @param list
     * @param debt
     * @param dambo
     * @param legal
     * @param file
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @param dataSetMap
     * @return 처리건수
     * @throws Exception
     */
    int saveList(DataSetMap list, DataSetMap debt, DataSetMap dambo, DataSetMap legal, DataSetMap file, LoginDTO loginDTO) throws Exception;

    /**
     * 사고채권발생보고 DataSetMap의 데이터를 Delete 처리한다.
     *
     * @param list
     * @param debt
     * @param dambo
     * @param legal
     * @param file
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @param dataSetMap
     * @return 처리건수
     * @throws Exception
     */
    int deleteList(DataSetMap list, DataSetMap file, LoginDTO loginDTO) throws Exception;
    
    /**
     * 전자결재정보를 Update 처리한다.
     * <pre>
     * - 업무 테이블에 Instance ID Update
     * - 결재정보 공통 테이블에 결재정보 Insert or Update
     * </pre>
     *
     * @param list
     * @return
     * @throws Exception
     */
    int saveSignInfo(DataSetMap list) throws Exception;
}
