package com.hwfs.fs.fse.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

/**
 * 이벤트 등록 관리자 승인하는 EventProcessApprvMgnt Service Interface
 *
 * @ClassName EventProcessApprvMgntService.java
 * @Description EventProcessApprvMgntService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.14    최종덕        최초생성
 *
 * </pre>
 * @author FC종합전산구축 : FC종합전산구축 :  통합영업 최종덕
 * @since 2015.04.14
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface EventProcessApprvMgntService {

    /**
     * 이벤트 분류 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
    */
    RecordSet selectCboList(Map<String, Object> parameter) throws Exception;

    /**
     * 이벤트 테마 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
    */
    RecordSet selectThemeList(Map<String, Object> parameter) throws Exception;

    /**
     * 이벤트 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
    */
    RecordSet selectList(Map<String, Object> parameter) throws Exception;

    /**
     * 이벤트 Master 정보를 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    RecordSet selectEventMst(Map<String, Object> map) throws Exception;

    /**
     * 이벤트 Master 진행정보를 조회한다.(Master 진행절차)
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    RecordSet selectMstProgress(Map<String, Object> map) throws Exception;
    
    /**
     * 기기/포장제 정보을 조회한다.(Master 기기/포장제)
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    RecordSet selectMstUtensil(Map<String, Object> parameter) throws Exception;

    /**
     * 서버 사진을 조회한다. (Master 첨부파일)
     *
     * @param map
     * @return
     */
    RecordSet selectImgList(Map<String, Object> parameter) throws Exception;
        
    
    /**
     * 이벤트 신청정보를 조회한다.
     * </pre>
     *
     * @param map
     * @return
     */
    RecordSet selectEventReq(Map<String, Object> parameter) throws Exception;

    /**
     * 이벤트 진행정보 관리 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
    */
    RecordSet selectProgress(Map<String, Object> parameter) throws Exception;

    /**
     * 기기정보를 조회한다.
     *
     * @param map
     * @return
     */
    RecordSet selectInforeg(Map<String, Object> parameter) throws Exception;

    /**
     * 사업장 기기정보를 조회한다.
     *
     * @param map
     * @return
     */
    RecordSet selectUpjangutensil(Map<String, Object> parameter) throws Exception;

    
    /**
     * 이벤트 master DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
     *
     * @param form
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int saveMstList(DataSetMap form) throws Exception;

    /**
     * 이벤트 신청정보 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
     *
     * @param form
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
     */
    int saveReqList(DataSetMap form) throws Exception;
}
