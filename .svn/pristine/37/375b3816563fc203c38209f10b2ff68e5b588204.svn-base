package com.hwfs.ft.fts.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.List;
import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

/**
 * 미착대체 Serive Class
 *
 * @ClassName NonarrivAltService.java
 * @Description NonarrivAltService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 06. 12.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : jshoon
 * @since 2015. 06. 12.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface NonarrivAltService {

    /**
     * PO목록을 조회한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectList(Map<String, Object> parameter) throws Exception;

    /**
     * PO상세 목록을 조회한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectDetailList(Map<String, Object> parameter) throws Exception;

    /**
     * PO상세 목록을 조회한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectDetailList2(Map<String, Object> parameter) throws Exception;
    /**
     * 미착내역을 저장한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param param
     * @param testArticleList
     * @param testDiaryList
     * @param listFile
     * @return
     * @throws Exception
     */
    Map<String, Object> saveList(Map<String, Object> param, DataSetMap detailList) throws Exception;

    /**
     * 미착내역을 회계전표 I/F 저장한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param param
     * @param testArticleList
     * @param testDiaryList
     * @param listFile
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> createFiscalSlip( LoginDTO loginParameter, DataSetMap search, DataSetMap detailList, DataSetMap detailList2 ) throws Exception ;


    /**
     * 미착내역을 회계전표 I/F 저장한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param param
     * @param testArticleList
     * @param testDiaryList
     * @param listFile
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> saveNonarrivAltDraft( LoginDTO loginParameter, DataSetMap search, DataSetMap detailList, DataSetMap detailList2 ) throws Exception ;

    /**
     * 회계전표 IF 취소 버튼 클릭시 SAP
     *
     * @param proposalInfo, itemList, payList, blckMarkList
     * @throws Exception
     */
    public int cancelFiscalSlip( LoginDTO loginParameter, DataSetMap search, DataSetMap dsDetailList, DataSetMap dsDetailList2 ) throws Exception ;
}
