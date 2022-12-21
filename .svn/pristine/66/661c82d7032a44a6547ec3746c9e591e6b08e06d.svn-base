package com.hwfs.fs.fse.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 이벤트 Master 등록관리하는 EventMstReg Service Interface
 *
 * @ClassName EventMstRegService.java
 * @Description EventMstRegService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.11    남기빈        최초생성
 *
 * </pre>
 * @author FC종합전산구축 : 통합영업 남기빈
 * @since 2015.03.11
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface EventMstRegService {

    /**
     * 이벤트 분류 목록을 조회한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
     * </pre>
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
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
     * </pre>
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
    RecordSet selectEventList(Map<String, Object> parameter) throws Exception;

    /**
     * 이벤트 master 정보를 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
    */
    RecordSet selectList(Map<String, Object> parameter) throws Exception;

    /**
     * 진행절차 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
    */
    RecordSet selectProgress(Map<String, Object> parameter) throws Exception;

    /**
     * 기기/포장제 목록
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    RecordSet selectUtensilList(Map<String, Object> parameter) throws Exception;


    /**
     * 서버 사진을 조회한다.(첨부파일)
     *
     * @param map
     * @return
     */
    RecordSet selectImgList(Map<String, Object> parameter) throws Exception;

    /**
     * 이벤트 Master 등록관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
     *
     * @param list
     * @param form
     * @param progress
     * @param utensil
     * @param file
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int saveList(DataSetMap list, DataSetMap form, DataSetMap progress , DataSetMap utensil, DataSetMap file) throws Exception;
    
    /**
     * 이벤트 Master 등록관리 DataSetMap의 데이터를 rowType에 따라 Delete 처리한다.
     *
     * @param list
     * @param form
     * @param progress
     * @param utensil
     * @param file
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int deleteList(DataSetMap form) throws Exception;
        
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
    
    /**
     * 이벤트 LV1 조회.(Tree) 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
    */
    RecordSet selectLevel1(Map<String, Object> parameter) throws Exception;
}
    


