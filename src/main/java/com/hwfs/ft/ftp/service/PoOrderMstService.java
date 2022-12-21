package com.hwfs.ft.ftp.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.List;
import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.sap.list.SlipDtlList;

 /**
 * 구매 주문에 대한 내역을 등록 관리.하는 PoOrderMst Service Interface
 *
 * @ClassName PoOrderMstService.java
 * @Description PoOrderMstService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.16    김종준        최초생성
 *
 * </pre>
 * @author FC종합전산구축 : 식재도매 김종준
 * @since 2015.03.16
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface PoOrderMstService {

    /**
     * 구매 주문에 대한 내역. 목록을 조회한다.
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
     * 구매 주문에 대한 내역. DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
     * 구매주문 삭제 한다.
     *
     * @param proposalInfo, itemList, payList, blckMarkList
     * @throws Exception
     */
    int deletePoOrderMst(LoginDTO loginParameter,DataSetMap search, DataSetMap dsPoOrderList ) throws Exception;

    /**
     * 구매주문 확정한다.
     *
     * @param proposalInfo, itemList, payList, blckMarkList
     * @throws Exception
     */
    int updatePoOrderStatus(LoginDTO loginParameter,DataSetMap search, DataSetMap dsPoOrderList ) throws Exception;


    /**
     * 구매 주문에 대한 상세내역. 목록을 조회한다.
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
    RecordSet selectPoOrderDtl(Map<String, Object> mapParam) throws Exception;

    /**
     * 구매 주문 품목 상세를 조회한다.
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
    RecordSet selectPoOrderItemDetail(Map<String, Object> mapParam) throws Exception;


    /**
     * 구매 주문 지불 조건를 조회한다.
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
    RecordSet selectPoOrderPayCond(Map<String, Object> mapParam) throws Exception;

    /**
     * 구매주문 INVOICE를 조회한다.
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
    RecordSet selectPoOrderInvoice(Map<String, Object> mapParam) throws Exception;


    /**
     * 구매주문 첨부문서를 조회한다.
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
    RecordSet selectPoOrderAppenddoc(Map<String, Object> mapParam) throws Exception;

    /**
     * 구매주문 부대비를 조회한다.
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
    RecordSet selectPoOrderOtherAmt(Map<String, Object> mapParam) throws Exception;


    /**
     * 기타 선급금 정산를 조회한다.
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
    RecordSet selectEtcPrepayamtAdjust(Map<String, Object> mapParam) throws Exception;


    /**
     * 구매주문(수입)을 저장 한다.
     *
     * @param proposalInfo, itemList, payList, blckMarkList
     * @throws Exception
     */
    List<Map<String, Object>> savePoOrderDtl(
              LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap dsPoOrderInfo
            , DataSetMap dsItemList
            , DataSetMap dsPayList
            , DataSetMap dsInvoiceList
            , DataSetMap dsAppendDocList
            , DataSetMap dsOtherAmtList
            , DataSetMap dsEtcPrepayamtList
            , DataSetMap dsCommSals
            ) throws Exception ;

    /**
     * 보험정보 관련(수입)을 저장 한다.
     *
     * @param proposalInfo, itemList, payList, blckMarkList
     * @throws Exception
     */
    List<Map<String, Object>> saveInsDtl(
              LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap dsPoOrderInfo
            ) throws Exception ;
    /**
     * 회계전표 IF 버튼 클릭시 SAP
     *
     * @param proposalInfo, itemList, payList, blckMarkList
     * @throws Exception
     */
    public List<Map<String, Object>> createFiscalSlip( LoginDTO loginParameter, DataSetMap search, DataSetMap dsOtherAmtList ) throws Exception ;

    /**
     * 회계전표 IF 취소 버튼 클릭시 SAP
     *
     * @param proposalInfo, itemList, payList, blckMarkList
     * @throws Exception
     */
    public int cancelFiscalSlip( LoginDTO loginParameter, DataSetMap search, DataSetMap dsOtherAmtList ) throws Exception ;


    /**
     * 기타선급금 정산 회계전표 IF 버튼 클릭시 SAP
     *
     * @param proposalInfo, itemList, payList, blckMarkList
     * @throws Exception
     */
    public List<Map<String, Object>> createEtcFiscalSlipIf( LoginDTO loginParameter, DataSetMap search, DataSetMap dsEtcPrepayamtList ) throws Exception ;

    /**
     *기타선급금 정산 회계전표 IF 취소 버튼 클릭시 SAP
     *
     * @param proposalInfo, itemList, payList, blckMarkList
     * @throws Exception
     */
    public int cancelEtcFiscalSlipIf( LoginDTO loginParameter, DataSetMap search, DataSetMap dsEtcPrepayamtList ) throws Exception ;


    /**
     * 구매주문(수입)을 저장 한다.
     *
     * @param proposalInfo, itemList, payList, blckMarkList
     * @throws Exception
     */
    List<Map<String, Object>> saveDmtPoOrderDtl(
              LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap dsPoOrderInfo
            , DataSetMap dsItemList
            , DataSetMap dsPayList
            , DataSetMap dsAppendDocList
            ) throws Exception ;

    /**
     * 통관 수입면허번호 조회한다.
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
    RecordSet selectbasiNumList(Map<String, Object> mapParam) throws Exception;

    /**
     * 매출수수료 조회한다.
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
    RecordSet selectCommSalsList(Map<String, Object> mapParam) throws Exception;


    /**
     * 선급금(수입)을 저장 한다.
     *
     * @param proposalInfo, itemList, payList, blckMarkList
     * @throws Exception
     */
    List<Map<String, Object>> saveEtcPrepayamtList(
              LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap dsPoOrderInfo
            , DataSetMap dsEtcPrepayamtList
            ) throws Exception ;

    /**
     * 수수료 정보를 등록한다.
     *
     * @param proposalInfo, itemList, payList, blckMarkList
     * @throws Exception
     */
    List<Map<String, Object>> saveOtherAmtList(
            LoginDTO loginParameter
          , DataSetMap search
          , DataSetMap dsPoOrderInfo
          , DataSetMap dsEtcPrepayamtList
          ) throws Exception ;

    /**
     * 수수료 매출 정보를 등록한다.
     *
     * @param proposalInfo, itemList, payList, blckMarkList
     * @throws Exception
     */
    List<Map<String, Object>> saveCommSalsList(
            LoginDTO loginParameter
          , DataSetMap search
          , DataSetMap dsPoOrderInfo
          , DataSetMap dsCommSals
          ) throws Exception ;

    /**
     * 수수료 매출 관리 상태(을)를 수정한다.
     *
     * @param proposalInfo, itemList, payList, blckMarkList
     * @throws Exception
     */
    List<Map<String, Object>> saveCommSalsConfirm(
            LoginDTO loginParameter
          , DataSetMap search
          , DataSetMap dsPoOrderInfo
          , DataSetMap dsCommSals
          ) throws Exception ;

    /**
     * 수수료 매출 관리 상태(을)를 수정한다.
     *
     * @param proposalInfo, itemList, payList, blckMarkList
     * @throws Exception
     */
    List<Map<String, Object>> saveCommSalsConfirmCancel(
            LoginDTO loginParameter
          , DataSetMap search
          , DataSetMap dsPoOrderInfo
          , DataSetMap dsCommSals
          ) throws Exception ;

    /**
     * 수수료 매출 매출마감 한다.
     *
     * @param proposalInfo, itemList, payList, blckMarkList
     * @throws Exception
     */
    List<Map<String, Object>> saveSalsReg(
            LoginDTO loginParameter
          , DataSetMap search
          , DataSetMap dsPoOrderInfo
          , DataSetMap dsCommSals
          ) throws Exception ;

    /**
     * 원시전표 불러오기 을 조회한다.
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
    RecordSet selectSlipCallPop(Map<String, Object> mapParam) throws Exception;
    
    /**
     * 영업회계 원시전표 불러오기 을 조회한다.
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
    RecordSet selectIfcSlipCallPop(Map<String, Object> mapParam) throws Exception;

    /**
     * 가수금전표 불러오기 을 조회한다.
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
    RecordSet selectSuspenseCallPop(Map<String, Object> mapParam) throws Exception;



    /**
     * 수수료 정보를 등록한다.
     *
     * @param proposalInfo, itemList, payList, blckMarkList
     * @throws Exception
     */
    List<Map<String, Object>> saveOtherAmtDraft(
            LoginDTO loginParameter
          , DataSetMap search
          , DataSetMap dsPoOrderInfo
          , DataSetMap dsEtcPrepayamtList
          ) throws Exception ;


    /**
     * 수수료 정보를 등록한다.
     *
     * @param proposalInfo, itemList, payList, blckMarkList
     * @throws Exception
     */
    List<Map<String, Object>> saveEtcAmtDraft(
            LoginDTO loginParameter
          , DataSetMap search
          , DataSetMap dsPoOrderInfo
          , DataSetMap dsEtcPrepayamtList
          ) throws Exception ;
}
