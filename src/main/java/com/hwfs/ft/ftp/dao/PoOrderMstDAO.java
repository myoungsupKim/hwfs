package com.hwfs.ft.ftp.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 구매 주문에 대한 내역을 등록 관리.하는 PoOrderMst DAO
 *
 * @ClassName PoOrderMstDAO.java
 * @Description PoOrderMstDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.16   	김종준        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재도매 김종준
 * @since 2015.03.16
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ft/ftp/poOrderMstDAO")
public class PoOrderMstDAO extends DefaultDAO {

    /**
     * 구매 주문에 대한 내역. 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.ftp.poOrderMstDAO.selectList", mapParam);
    }

    /**
     * 구매 주문에 대한 내역.(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insert(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.ftp.poOrderMstDAO.insert", mapParam);
    }

    /**
     * 구매 주문에 대한 내역.(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int update(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.ftp.poOrderMstDAO.update", mapParam);
    }

    /**
     * 구매 주문에 대한 내역.(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateSaleType(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.ftp.poOrderMstDAO.updateSaleType", mapParam);
    }
    
    /**
     * 구매 주문에 대한 보험정보 관련 내역.(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateIns(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.ftp.poOrderMstDAO.updateIns", mapParam);
    }

    /**
     * 구매 주문에 대한 내역.(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int delete(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.ftp.poOrderMstDAO.delete", mapParam);
    }


    /**
     * 구매 품의 삭제한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @return
     * @param parameter
     */
    public int deletePoOrderMst(Map<String, Object> parameter) {
        //if (parameter.size() <= 0) return 0;
        return super.update("ft.ftp.poOrderMstDAO.deletePoOrderMst", parameter);
    }

    /**
     * PoOrderMstService.java
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @return
     * @param parameter
     */
    public int updatePoOrderStatus(Map<String, Object> parameter) {
        //if (parameter.size() <= 0) return 0;
        return super.update("ft.ftp.poOrderMstDAO.updatePoOrderStatus", parameter);
    }

    /**
     * PoOrderMstService.java
     * <pre>
     * 확정취소는 구매형태가 수입은 매입전표 발행전까지 가능하고, 내수는 품목탭에 창고코드가 한 품목도 없을 때 가능하다
     * </pre>
     *
     * @return
     * @param parameter
     */
    public int chkGdspaymCnt(Map<String, Object> parameter) {
        return super.queryForInt("ft.ftp.poOrderMstDAO.chkGdspaymCnt", parameter);
    }

    /**
     * PoOrderMstService.java
     * <pre>
     * 확정취소는 구매형태가 수입은 매입전표 발행전까지 가능하고, 내수는 품목탭에 창고코드가 한 품목도 없을 때 가능하다
     * </pre>
     *
     * @return
     * @param parameter
     */
    public int chkWhCdCnt(Map<String, Object> parameter) {
        return super.queryForInt("ft.ftp.poOrderMstDAO.chkWhCdCnt", parameter);
    }

    /**
     * 확정 취소는 PO후상태가 확정이면 취소 불가
     *
     * @param
     * @return
     * @throws Exception
     */
    public String selectPoAfterstatus(Map<String, Object> parameter) {
        return (String) super.queryForObject("ft.ftp.poOrderMstDAO.selectPoAfterstatus", parameter, null);
    }

    /**
     * 구매 주문에 대한 내역. 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectPoOrderDtl(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.ftp.poOrderMstDAO.selectPoOrderDtl", mapParam);
    }

    /**
     * 구매 주문 품목 상세를 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectPoOrderItemDetail(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.ftp.poOrderMstDAO.selectPoOrderItemDetail", mapParam);
    }

    /**
     * 구매 주문 지불 조건를 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectPoOrderPayCond(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.ftp.poOrderMstDAO.selectPoOrderPayCond", mapParam);
    }

    /**
     * 구매주문 INVOICE를 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectPoOrderInvoice(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.ftp.poOrderMstDAO.selectPoOrderInvoice", mapParam);
    }

    /**
     * 구매주문 첨부문서를 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectPoOrderAppenddoc(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.ftp.poOrderMstDAO.selectPoOrderAppenddoc", mapParam);
    }

    /**
     * 구매주문 부대비를 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectPoOrderOtherAmt(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.ftp.poOrderMstDAO.selectPoOrderOtherAmt", mapParam);
    }

    /**
     * 기타 선급금 정산를 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectEtcPrepayamtAdjust(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.ftp.poOrderMstDAO.selectEtcPrepayamtAdjust", mapParam);
    }

    /**
     *구매 품의 마스터 시퀀스을 조회한다.
     *
     * @param
     * @return
     * @throws Exception
     */
    public String getPoOrderMstSeq(Map<String, Object> parameter) {
        return (String) super.queryForObject("ft.ftp.poOrderMstDAO.getPoOrderMstSeq", parameter, null);
    }

    /**
     * PoOrderMstService.java
     * <pre>
     * 원물 금액 합
     * </pre>
     *
     * @return
     * @param parameter
     */
    public RecordSet getWonwtrAmtSum(Map<String, Object> parameter) {
        return super.queryForRecordSet("ft.ftp.poOrderMstDAO.getWonwtrAmtSum", parameter);
    }

    /**
     * PoOrderMstService.java
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @return
     * @param parameter
     */
    public int updatePoAfterstatus(Map<String, Object> parameter) {
        //if (parameter.size() <= 0) return 0;
        return super.update("ft.ftp.poOrderMstDAO.updatePoAfterstatus", parameter);
    }

    /**
     * 통관 수입면허번호 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectbasiNumList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.ftp.poOrderMstDAO.selectbasiNumList", mapParam);
    }

    /**
     * 매출수수료를 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectCommSalsList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.ftp.poOrderMstDAO.selectCommSalsList", mapParam);
    }

    /**
     * 매출수수료를 마감 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectSalsRegs(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.ftp.poOrderMstDAO.selectSalsRegs", mapParam);
    }

    /**
     *SAP 외부문서 번호 조회한다.
     *
     * @param
     * @return
     * @throws Exception
     */
    public String selectSlipNum(Map<String, Object> parameter) {
        return (String) super.queryForObject("ft.ftp.poOrderMstDAO.selectSlipNum", parameter, null);
    }

    /**
     * 기타선급금 if 대상 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectEtcPrepayamtList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.ftp.poOrderMstDAO.selectEtcPrepayamtList", mapParam);
    }

    /**
     * 원시전표 불러오기을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectSlipCallPop(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.ftp.poOrderMstDAO.selectSlipCallPop", mapParam);
    }
    
    /**
     * 영업회계 원시전표 불러오기을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectIfcSlipCallPop(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.ftp.poOrderMstDAO.selectIfcSlipCallPop", mapParam);
    }

    /**
     * 원시전표 불러오기을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectSuspenseCallPop(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.ftp.poOrderMstDAO.selectSuspenseCallPop", mapParam);
    }

    /**
     * 수수료 if 대상 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectOtherAmtIfList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.ftp.poOrderMstDAO.selectOtherAmtIfList", mapParam);
    }


    /**
     * 수수료 if 대상 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectOtherAmtIfList2(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.ftp.poOrderMstDAO.selectOtherAmtIfList2", mapParam);
    }

    /**
     * 수수료 if 대상 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectOtherAmtIfList3(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.ftp.poOrderMstDAO.selectOtherAmtIfList3", mapParam);
    }

    /**
     * 수수료 if 대상 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectFocOtherAmtIfList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.ftp.poOrderMstDAO.selectFocOtherAmtIfList", mapParam);
    }

    /**
     * 구매 주문에 대한 통관환율,일자.(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateExchangeInfo(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.ftp.poOrderMstDAO.updateExchangeInfo", mapParam);
    }

}
