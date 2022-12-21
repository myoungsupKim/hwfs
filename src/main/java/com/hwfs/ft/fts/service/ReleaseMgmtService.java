package com.hwfs.ft.fts.service;

import java.util.List;
import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

/**
* 판매 주문내역에 대하여 출고를 관리하는 ReleaseMgmt Service Interface
*
* @ClassName ReleaseMgmtService.java
* @Description ReleaseMgmtService Class
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2015.04.30    kjj        최초생성
*
* </pre>
* @author FC종합전산구축 : 식재도매 kjj
* @since 2015.04.30
* @version 1.0
* @see
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
public interface ReleaseMgmtService {

    /**
     * 판매 주문내역에 대하여 출고를 관리 목록을 조회한다.
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
     * 판매 주문내역에 대하여 출고를 관리 목록을 조회한다.
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
    RecordSet releaseRegList(Map<String, Object> mapParam) throws Exception;

    /**
     * 판매 주문내역에 대하여 출고를 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
     * 판매 주문내역에 대하여 출고를 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int saveReleaseReg(DataSetMap list) throws Exception;

    /**
     * 출고에 대하여 관리 DataSetMap의 데이터를 rowType에 따라 Delete 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int deleteReleaseReg(DataSetMap list) throws Exception;

    /**
     * 출고에 대하여 관리 DataSetMap의 데이터를 rowType에 따라 출력 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int printReleaseReg(DataSetMap list) throws Exception;

    /**
     * 판매 주문내역에 대하여 출고승인요청 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int releaseApprovReq(DataSetMap list, Map<String, Object> mapParam) throws Exception;

    /**
     * 출고 내역에 대하여 출고를 관리 목록을 조회한다.
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
    RecordSet selectReleaseMgmtList(Map<String, Object> mapParam) throws Exception;

    /**
     * 출고 품목내역에 대하여 출고를 관리 목록을 조회한다.
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
    RecordSet selectReleaseItemMgmtList(Map<String, Object> mapParam) throws Exception;

    /**
     * 판매 주문내역에 대하여 출고등록취소 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int releaseRollCancel(DataSetMap list) throws Exception;

    /**
     * 판매 주문내역에 대하여 거래명세서 출력  처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int printDealReqDocPublish(DataSetMap list) throws Exception;

    /**
     * 판매 주문내역에 대하여 거래명세서 출력  처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int printDealReqDocPublishChk(DataSetMap list) throws Exception;
    /**
     * 판매 주문내역에 대하여 출고승인요청취소 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int releaseApprovReqCancel(DataSetMap list) throws Exception;

    /**
     * 판매 주문내역에 대하여 출고승인 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int releaseApprov(DataSetMap list, Map<String, Object> parameter) throws Exception;

    /**
     * 판매 주문내역에 대하여 팀장승인취소 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int releaseApprovCancel(DataSetMap list) throws Exception;

    /**
     * 판매 주문내역에 대하여 출고확정 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int releaseConfirm(DataSetMap search, DataSetMap list, LoginDTO loginDTO) throws Exception;

    /**
     * 판매 주문내역에 대하여 출고확정 취소 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int releaseConfirmCancel(DataSetMap list) throws Exception;

    /**
     * 판매 주문내역에 대하여 환입 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int releasePurchaseReturn(DataSetMap list) throws Exception;

    /**
     * 판매 주문내역에 대하여 중량변경 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int releaseWhgChg(DataSetMap list) throws Exception;

    /**
     * 판매 주문내역에 대하여 단가변경 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int releaseUpriceChg(DataSetMap list) throws Exception;

    /**
     * 판매 주문내역에 대하여 출고증 목록을 조회한다.
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
    RecordSet selectReleaseReqCertificatePrintPop(Map<String, Object> mapParam) throws Exception;

    /**
     * 판매 주문내역에 대하여 출고증 목록을 조회한다.
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
    RecordSet selectReleaseReqCertificatePrintPop2(Map<String, Object> mapParam) throws Exception;

    /**
     * 판매 주문내역에 대하여 출고증 발행  처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int printReleaseReqCertificate(DataSetMap dsSearch, DataSetMap list) throws Exception;

    /**
     * 판매 주문내역에 대하여 출고확정 목록을 조회한다.
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
    RecordSet selectSalsConfirmList(Map<String, Object> mapParam) throws Exception;

    /**
     * 판매 주문내역에 대하여 출고확정 Insert/Update/Delete 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int saveSalsConfirmList(DataSetMap list, LoginDTO loginDTO, DataSetMap dsSearch ) throws Exception;

    /**
     * 판매 주문내역에 대하여 출고확정 목록을 조회한다.
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
    RecordSet selectSalsConfirmSumList(Map<String, Object> mapParam) throws Exception;

    /**
     * 판매 주문내역에 대하여 매입원가 차감 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    List<Map<String, Object>> releaseBuyCostExcept(DataSetMap search, DataSetMap list, LoginDTO loginDTO) throws Exception;

    /**
     * 판매 주문내역에 대하여 매입원가 차감 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    List<Map<String, Object>> saveBuyCostExceptDraft(DataSetMap search, DataSetMap list, LoginDTO loginDTO) throws Exception;

    /**
     * 여신체크
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param inVar
     * @return PgmAuthDTO
     * @throws Exception
     */
    public RecordSet getLendingChk(Map<String, Object> inVar) throws Exception;

    /**
     * 여신체크 내부
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param inVar
     * @return PgmAuthDTO
     * @throws Exception
     */
    public Record getLendingChk2(Map<String, Object> inVar ) throws Exception;

    /**
     * 출고증 Fax 발송
     *
     * @param inVar
     * @return PgmAuthDTO
     * @throws Exception
     */
    public RecordSet releaseFaxTransfer(Map<String, Object> parameter) throws Exception;

    /**
     * 원가대체 회계전표 IF 취소 버튼 클릭시 SAP
     *
     * @param ds_search, ds_gdspaymList
     * @throws Exception
     */
    public int releaseBuyCostExceptCancel( LoginDTO loginParameter, DataSetMap search, DataSetMap dsList ) throws Exception ;

    /**
     * 여신체크
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param inVar
     * @return PgmAuthDTO
     * @throws Exception
     */
    public RecordSet selectLendList(Map<String, Object> inVar) throws Exception;

    /**
     * 거래명세서 Fax 발송 거래처정보
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Record dealReqDocPublishCustFaxTransfer(Map<String, Object> parameter) throws Exception;

    /**
     * 거래명세서 Fax 발송 리스트
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet dealReqDocPublishListFaxTransfer(Map<String, Object> parameter) throws Exception;


    /**
     * 거래명세서 Fax 발송 리스트
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet dealReqDocPublishListFaxTransferChk(Map<String, Object> parameter) throws Exception;
    
    /**
     * 해당월의 마지막 일자 호출
     *
     * @param parameter
     * @return
     * @throws Exception
     */    
    public String getLastdayOfMonth(String pDate) throws Exception;
}
