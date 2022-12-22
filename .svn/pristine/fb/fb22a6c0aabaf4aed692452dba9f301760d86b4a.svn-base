 package com.hwfs.fs.fse.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

/**
 * 이벤트 진행정보 관리하는 EventProcessInfoMgnt Service Interface
 *
 * @ClassName EventProcessInfoMgntService.java
 * @Description EventProcessInfoMgntService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.18    남기빈        최초생성
 *
 * </pre>
 * @author FC종합전산구축 : 통합영업 남기빈
 * @since 2015.03.18
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface EventProcessInfoMgntService {

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
     * 이벤트 진행정보 관리 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
    */
    RecordSet selectGrdList(Map<String, Object> parameter) throws Exception;

    /**
     * 이벤트 대분류 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
    */
    RecordSet selectLclass(Map<String, Object> parameter) throws Exception;

    /**
     * 이벤트 중분류 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
    */
    RecordSet selectMclass(Map<String, Object> parameter) throws Exception;

    /**
     * 이벤트 소분류 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
    */
    RecordSet selectSclass(Map<String, Object> parameter) throws Exception;

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
     * 이벤트 Master 진행정보를 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    RecordSet selectMstProgress(Map<String, Object> map) throws Exception;

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
     * 기기/물류 재고수량을 조회한다.
     *
     * @param map
     * @return
     */
    RecordSet selectInventoryQty(Map<String, Object> parameter) throws Exception;

    /**
     * 코드 정보를 조회한다.
     *
     * @param map
     * @return
     */
    RecordSet selectInforegCode(Map<String, Object> parameter) throws Exception;

    /**
     * 서버 사진을 조회한다.
     *
     * @param map
     * @return
     */
    RecordSet selectImgList(Map<String, Object> parameter) throws Exception;

    /**
     * 이벤트 진행정보 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
     *
     * @param form
     * @param progress
     * @param inforeg
     * @param utensil
     * @param file
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int saveList(DataSetMap form, DataSetMap progress, DataSetMap inforeg, DataSetMap utensil, DataSetMap file, String sabun) throws Exception;

    /**
     * XPLATFORM DataSetMap의 첨부파일을 rowType에 따라 Insert/Update/Delete 처리한다.
     * <pre>
     * - 파일은 파일저장소에 저장된다.
     * - 파일 저장소는 global.filerepository.path가 된다.
     * </pre>
     *
     * @parma listFile 첨부파일 Map List
     * @param relPath 파일이 저장될 상대패스
     * @param encYn 파일암호화여부
     * @return String 새로 채번된 참조일련번호 ("" 이면 변경되지 않음을 의미)
     * @throws Exception
     */
    public String save(DataSetMap listFile, String relPath, boolean encYn) throws Exception;
}
