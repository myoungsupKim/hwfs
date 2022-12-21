package com.hwfs.ft.ftr.service;

import java.util.Map;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

/**
 * 통합목록 조회 Serive Class
 *
 * @ClassName FtStatsService.java
 * @Description FtStatsService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 7. 06.   kkj         최초생성
 * </pre>
 * @author FC종합전산구축 : 식재도매 kkh
 * @since 2015. 7. 06.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface FtStatsService {

    /**
     * PO별 재고 금액을 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet pobyInventoryAmt(Map<String, Object> parameter) throws Exception;

    /**
     * PO별 재고 이력을 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet pobyInventoryLog(Map<String, Object> parameter) throws Exception;

    /**
     * 출고내역을 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet releaseDescInquery(Map<String, Object> parameter) throws Exception;

    /**
     * 창고/품목별 재고현황
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet whItemInquery(Map<String, Object> parameter) throws Exception;

    /**
     * 품목/창고별 재고현황
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet itemWhInquery(Map<String, Object> parameter) throws Exception;

    /**
     * 영업사원별 매출현황
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet poSalsStatus(Map<String, Object> parameter) throws Exception;

    /**
     * PO별 기타선급금 미착 금액 상세
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet pobyPrepayamtNonarrivAmtDetail(Map<String, Object> parameter) throws Exception;

    /**
     * 일별 재고 부진재고 상세
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet ddbyInventoryPoorInventoryDet(Map<String, Object> parameter) throws Exception;

    /**
     * 월별 PO별 판매완료
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet mmbyPobySalend(Map<String, Object> parameter) throws Exception;

    /**
     * 입고 PO 품목별 원가/판가 상세 - 수입
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet deliverPoItembyDetailIncome(Map<String, Object> parameter) throws Exception;

    /**
     * 입고 PO 품목별 원가/판가 상세 - 판매
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet deliverPoItembyDetailDmt(Map<String, Object> parameter) throws Exception;

    /**
     * PO별 내수 매입 금액
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet pobyDmtBuyAmt(Map<String, Object> parameter) throws Exception;

    /**
     * PO별 수입 현황
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet pobyIncomeStatusRpt(Map<String, Object> parameter) throws Exception;

    /**
     * PO별 수입 현황
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet pobyIncomeStatusRpt2(Map<String, Object> parameter) throws Exception;
    
    /**
     * 월별 예상 창고 보관료
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet expectWhChargamtRpt(Map<String, Object> parameter) throws Exception;

    /**
     * 주차 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectWeekYearMm(Map<String, Object> parameter) throws Exception;

    /**
     * 주차에 대해 이번주차외 이전 5개 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectWeekOfYearMm(Map<String, Object> parameter) throws Exception;

    /**
     * 품목별 시세 관리 리포트
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet itembyPriceMgmtRpt(Map<String, Object> parameter) throws Exception;

    /**
     * 주차에 대해 시세를 저장
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    Map<String, Object> saveWeekYearMm(Map<String, Object> parameter, DataSetMap saveList) throws Exception;


    /**
     * 부진재고 상세 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet poorInventoryDet(Map<String, Object> parameter) throws Exception;


    /**
     * 영업사원 계획 등록(사업계획)을 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet salesmanPlanRegList(Map<String, Object> parameter) throws Exception;

    /**
     * 영업사원 계획 등록(수정계획)을 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet salesmanPlanRegList2(Map<String, Object> parameter) throws Exception;

    /**
     * 영업사원 계획 등록(사업계획,수정계획)을 등록
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    Map<String, Object> salesmanPlanReg(Map<String, Object> parameter, DataSetMap saveList, DataSetMap saveList2) throws Exception;


    /**
     * 영업사원 계획 실적 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet salesmanPlanRegAct(Map<String, Object> parameter) throws Exception;

    /**
     * SAP 전표 전송 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet sapSlipSendStatus(Map<String, Object> parameter) throws Exception;

    /**
     * SAP 전표 전송 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet sapSlipSendStatusDtlList(Map<String, Object> parameter) throws Exception;

    /**
     * PO별 미착 재고 현황
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet pobyNonarrivInventoryStatus(Map<String, Object> parameter) throws Exception;

    /**
     * PO별 상품 재고 현황
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet pobyGoodsInventoryStatus(Map<String, Object> parameter) throws Exception;
}
