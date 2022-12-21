package com.hwfs.ft.fdm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 재고자산 폐기손실하는 InventoryAssetDisuseLoss Service Interface
 *
 * @ClassName InventoryAssetDisuseLossService.java
 * @Description InventoryAssetDisuseLossService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.07    KJJ        최초생성
 *
 * </pre>
 * @author FC종합전산구축 : 식재도매 KJJ
 * @since 2015.07.07
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface InventoryAssetDisuseLossService {

    /**
     * 재고자산 폐기손실 목록을 조회한다.
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
    RecordSet selectList(Map<String, Object> mapParam) throws Exception;


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
     * 재고자산 폐기손실을 회계전표 I/F 저장한다.
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
    public int createFiscalSlip( LoginDTO loginParameter, DataSetMap search, DataSetMap detailList ) throws Exception ;

    /**
     * 회계전표 IF 취소 버튼 클릭시 SAP
     *
     * @param proposalInfo, itemList, payList, blckMarkList
     * @throws Exception
     */
    public int cancelFiscalSlip( LoginDTO loginParameter, DataSetMap search, DataSetMap dsDetailList ) throws Exception ;

    /**
     * 재고자산 폐기손실 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int saveList(DataSetMap list) throws Exception;
}
