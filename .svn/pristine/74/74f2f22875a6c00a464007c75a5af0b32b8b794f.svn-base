package com.hwfs.ft.fts.service;

import java.util.List;
import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

/**
* 입고(재고)를 판매 주문에 대하여 관리하는 SaleOrder Service Interface
*
* @ClassName SaleOrderService.java
* @Description SaleOrderService Class
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2015.05.06    kjj        최초생성
*
* </pre>
* @author FC종합전산구축 : 식재도매 kjj
* @since 2015.05.06
* @version 1.0
* @see
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
public interface SaleOrderService {

    /**
     * 입고(재고)를 판매 주문에 대하여 관리 목록을 조회한다.
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
     * 입고(재고)를 판매 주문에 대하여 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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

    /**
     * 입고(재고)를 판매 주문에 대하여 관리 DataSetMap의 데이터를 rowType에 따라 Delete 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int deleteList(DataSetMap list) throws Exception;

    /**
     * 입고(재고)를 판매 주문에 대하여 관리 목록을 조회한다.
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
    RecordSet selectItemInfoSaveSearchPop(Map<String, Object> mapParam) throws Exception;

    /**
     * 입고(재고)를 판매 주문에 대하여 관리 상세 목록을 조회한다.
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
    RecordSet selectItemInfoSaveSearchPop2(Map<String, Object> mapParam) throws Exception;

    /**
     * 판매주문 마스터을 조회한다.
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
    RecordSet selectSaleOrder(Map<String, Object> mapParam) throws Exception;

    /**
     * 판매주문 내역을 저장 한다.
     *
     * @param proposalInfo, itemList, payList, blckMarkList
     * @throws Exception
     */
    List<Map<String, Object>> saveSaleOrderDtl(LoginDTO loginParameter, DataSetMap search, DataSetMap dsSaleOrder,
            DataSetMap dsSaleOrderItemMgmtList) throws Exception;

    /**
     * 판매원가 조회 한다.
     *
     * @param proposalInfo, itemList, payList, blckMarkList
     * @throws Exception
     */
    Map<String, Object> setSaleInfo(Map<String, Object> parameter) throws Exception;

    /**
     * 판매주문등록 리스트를 조회 한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectSalesOrderRegList(Map<String, Object> parameter) throws Exception;

}
