package com.hwfs.ft.fdm.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 입고정보를 등록 관리하는 InventoryMgmtDeliver Service Interface
 *
 * @ClassName InventoryMgmtDeliverService.java
 * @Description InventoryMgmtDeliverService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.09    KJJ        최초생성
 *
 * </pre>
 * @author FC종합전산구축 : 식재도매 KJJ
 * @since 2015.04.09
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface InventoryMgmtDeliverService {

    /**
     * 입고정보를 등록 관리한다. 목록을 조회한다.
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
     * 입고정보를 등록 관리한다. DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
     * 구매(내수) 입고정보를 등록 관리한다. DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int saveDmtDeliver(DataSetMap dsPoOrderInfo, DataSetMap dsItemList) throws Exception;

    /**
     * 구매(내수) 입고정보를 삭제한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int deleteDmtDeliver(DataSetMap dsPoOrderInfo, DataSetMap dsItemList) throws Exception;


    /**
     * 가입고정보를 등록 관리한다. DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int saveReceiveReg( DataSetMap dsㅣist) throws Exception;

    /**
     * 가입고 관리한다. 목록을 조회한다.
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
    RecordSet selectReceiveRegList(Map<String, Object> mapParam) throws Exception;

    /**
     * 구매주문(수입)을 입고처리 한다.
     *
     * @param proposalInfo, itemList, payList, blckMarkList
     * @throws Exception
     */
    int saveDeliver( DataSetMap dsList ) throws Exception ;

    /**
     * 구매주문(수입)을 입고취소 처리 한다.
     *
     * @param proposalInfo, itemList, payList, blckMarkList
     * @throws Exception
     */
    int cancelDeliver( DataSetMap dsList ) throws Exception ;

    /**
     * 재고현황 목록을 조회한다.
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
    RecordSet selectInventoryStatusList(Map<String, Object> mapParam) throws Exception;

    /**
     * 재고현황(외부거래처) 목록을 조회한다.
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
    RecordSet selectInventoryStatusCustList(Map<String, Object> mapParam) throws Exception;

    /**
     * 부대비배부 목록을 조회한다.
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
    RecordSet selectDeliverNumOtheramtDivListPop(Map<String, Object> mapParam) throws Exception;

    /**
     * 부대비배부 목록을 조회한다.
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
    RecordSet selectDeliverNumOtheramtDivListPop2(Map<String, Object> mapParam) throws Exception;

    /**
     * 재고 저 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int saveInventoryStatusList( DataSetMap dsㅣist) throws Exception;

    /**
     * 창고이동 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int saveWarehostMove( DataSetMap dsㅣist) throws Exception;

    /**
     * 재고조정 목록을 조회한다.
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
    RecordSet selectInventoryControlPop(Map<String, Object> mapParam) throws Exception;

    /**
     * 재고조정 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int saveInventoryControl( DataSetMap dsㅣist) throws Exception;

    /**
     * 반품 목록을 조회한다.
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
    RecordSet selectRmaPop(Map<String, Object> mapParam) throws Exception;

    /**
     * 면허번호 중복체크
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int savetRmaPop( DataSetMap dsㅣist) throws Exception;


    /**
     * 재고현황(외부거래처) 목록을 조회한다.
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
    Record selectCustCd(Map<String, Object> mapParam) throws Exception;

    /**
     * 가입고 삭제 처리 한다.
     *
     * @param proposalInfo, itemList, payList, blckMarkList
     * @throws Exception
     */
    int deleteGaDeliver( DataSetMap dsList ) throws Exception ;

    /**
     * 부대비 금액 수정처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int saveOtherDivList( DataSetMap dsㅣist) throws Exception;
}
