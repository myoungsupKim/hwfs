package com.hwfs.ft.ftr.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

import hone.core.util.record.RecordSet;

/**
 * 식재도매 통계조회 Dao Class
 *
 * @ClassName FtStatsDAO.java
 * @Description FtStatsDAO Class
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
@Repository("/ft/ftr/ftStatsDAO")
public class FtStatsDAO extends DefaultDAO {

    /**
     * PO별 재고 금액을 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet pobyInventoryAmt(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftr.ftStatsDAO.pobyInventoryAmt", parameter);
    }

    /**
     * PO별 재고 이력을 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet pobyInventoryLog(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftr.ftStatsDAO.pobyInventoryLog", parameter);
    }

    /**
     * 출고내역을 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet releaseDescInquery(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftr.ftStatsDAO.releaseDescInquery", parameter);
    }

    /**
     * 창고/품목별 재고현황
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet whItemInquery(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftr.ftStatsDAO.whItemInquery", parameter);
    }

    /**
     * 품목/창고별 재고현황
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet itemWhInquery(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftr.ftStatsDAO.itemWhInquery", parameter);
    }

    /**
     * 영업사원별 매출현황
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet poSalsStatus(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftr.ftStatsDAO.poSalsStatus", parameter);
    }

    /**
     * PO별 기타선급금 미착 금액 상세
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet pobyPrepayamtNonarrivAmtDetail(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftr.ftStatsDAO.pobyPrepayamtNonarrivAmtDetail", parameter);
    }

    /**
     * 일별 재고 부진재고 상세
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet ddbyInventoryPoorInventoryDet(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftr.ftStatsDAO.ddbyInventoryPoorInventoryDet", parameter);
    }

    /**
     * 월별 PO별 판매완료
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet mmbyPobySalend(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftr.ftStatsDAO.mmbyPobySalend", parameter);
    }

    /**
     * 입고 PO 품목별 원가/판가 상세 - 수입
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet deliverPoItembyDetailIncome(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftr.ftStatsDAO.deliverPoItembyDetailIncome", parameter);
    }

    /**
     * 입고 PO 품목별 원가/판가 상세 - 판매
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet deliverPoItembyDetailDmt(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftr.ftStatsDAO.deliverPoItembyDetailDmt", parameter);
    }

    /**
     * PO별 내수 매입 금액
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet pobyDmtBuyAmt(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftr.ftStatsDAO.pobyDmtBuyAmt", parameter);
    }

    /**
     * PO별 수입 현황
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet pobyIncomeStatusRpt(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftr.ftStatsDAO.pobyIncomeStatusRpt", parameter);
    }
    
    /**
     * PO별 수입 현황
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet pobyIncomeStatusRpt2(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftr.ftStatsDAO.pobyIncomeStatusRpt2", parameter);
    }    

    /**
     * 월별 예상 창고 보관료
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet expectWhChargamtRpt(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftr.ftStatsDAO.expectWhChargamtRpt", parameter);
    }

    /**
     * 주차 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectWeekYearMm(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftr.ftStatsDAO.selectWeekYearMm", parameter);
    }

    /**
     * 주차에 대해 이번주차외 이전 5개 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectWeekOfYearMm(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftr.ftStatsDAO.selectWeekOfYearMm", parameter);
    }

    /**
     * 품목별 시세 관리 리포트
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet itembyPriceMgmtRpt(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftr.ftStatsDAO.itembyPriceMgmtRpt", parameter);
    }

    /**
     * 주차에 대해 시세를 저장
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int saveWeekYearMm(Map<String, Object> parameter) throws Exception {
        return super.update("ft.ftr.ftStatsDAO.saveWeekYearMm", parameter);
    }

    /**
     * 부진재고 상세 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet poorInventoryDet(Map<String, Object> parameter) {
        return super.queryForRecordSet("ft.ftr.ftStatsDAO.poorInventoryDet", parameter);
    }

    /**
     * PO별 재고 금액을 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet salesmanPlanRegList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftr.ftStatsDAO.salesmanPlanRegList", parameter);
    }

    /**
     * PO별 재고 금액을 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet salesmanPlanRegList2(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftr.ftStatsDAO.salesmanPlanRegList2", parameter);
    }


    /**
     * 영업사원 계획 등록(사업계획,수정계획)을 등록
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int salesmanPlanReg(Map<String, Object> parameter) throws Exception {
        return super.update("ft.ftr.ftStatsDAO.salesmanPlanReg", parameter);
    }

    /**
     * 영업사원 계획 등록(사업계획,수정계획)을 삭제
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteSalesmanPlanReg(Map<String, Object> parameter) throws Exception {
        return super.update("ft.ftr.ftStatsDAO.deleteSalesmanPlanReg", parameter);
    }

    /**
     * 영업사원 계획 실적 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet salesmanPlanRegAct(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftr.ftStatsDAO.salesmanPlanRegAct", parameter);
    }

    /**
     * PO별 재고 금액을 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet sapSlipSendStatus(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftr.ftStatsDAO.sapSlipSendStatus", parameter);
    }

    /**
     * PO별 재고 금액을 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet sapSlipSendStatusDtlList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftr.ftStatsDAO.sapSlipSendStatusDtlList", parameter);
    }

    /**
     * PO별 미착 재고 현황
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet pobyNonarrivInventoryStatus(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftr.ftStatsDAO.pobyNonarrivInventoryStatus", parameter);
    }

    /**
     * PO별 상품 재고 현황
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet pobyGoodsInventoryStatus(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftr.ftStatsDAO.pobyGoodsInventoryStatus", parameter);
    }
}
