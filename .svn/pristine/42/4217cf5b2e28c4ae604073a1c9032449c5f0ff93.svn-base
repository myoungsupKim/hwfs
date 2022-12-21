package com.hwfs.ft.fts.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

/**
* 판매 주문내역에 대하여 출고를 관리하는 ReleaseMgmt DAO
*
* @ClassName ReleaseMgmtDAO.java
* @Description ReleaseMgmtDAO Class
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2015.04.30   	kjj        최초생성
* </pre>
* @author FC종합전산구축 : 식재도매 kjj
* @since 2015.04.30
* @version 1.0
* @see
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
@Repository("/ft/fts/releaseMgmtDAO")
public class ReleaseMgmtDAO extends DefaultDAO {

    /**
     * 출고등록전 다시한번 출고가능 수량을 체크한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Map<String, Object> getSaleQuantityCheck(Map<String, Object> parameter) throws Exception {
        return (Map<String, Object>) super.queryForRecord("ft.fts.releaseMgmtDAO.getSaleQuantityCheck", parameter);
    }

    /**
     *판매 주문내역 마스터 시퀀스을 조회한다.
     *
     * @param
     * @return
     * @throws Exception
     */
    public String getReleaseMgmtS(Map<String, Object> parameter) {
        return (String) super.queryForObject("ft.fts.releaseMgmtDAO.getReleaseMgmtS", parameter, null);
    }

    /**
     * 판매 주문내역에 대하여 출고를 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fts.releaseMgmtDAO.selectList", mapParam);
    }

    /**
     * 판매 주문내역에 대하여 출고를 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet releaseRegList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fts.releaseMgmtDAO.releaseRegList", mapParam);
    }

    /**
     * 판매 주문내역에 대하여 출고를 관리(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insert(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.releaseMgmtDAO.insert", mapParam);
    }

    /**
     * 판매 주문내역에 대하여 출고를 관리(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int update(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.releaseMgmtDAO.update", mapParam);
    }

    /**
     * 판매 주문내역에 대하여 출고를 관리(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int delete(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.releaseMgmtDAO.delete", mapParam);
    }

    /**
     * 판매 주문내역에 대하여 출고승인요청 건수 조회
     *
     * @param mapParam
     * @return
     */
    public int getSaleApprvCnt(Map<String, Object> mapParam) throws Exception {
        return super.queryForInt("ft.fts.releaseMgmtDAO.getSaleApprvCnt", mapParam);
    }

    /**
     * 판매 주문내역에 대하여 출고승인요청 건수 조회
     *
     * @param mapParam
     * @return
     */
    public String getLastdayOfMonth(Map<String, Object> mapParam) throws Exception {
        return (String)super.queryForObject("ft.fts.releaseMgmtDAO.getLastdayOfMonth", mapParam, null);
    }

    
    /**
     *승인요청일을 조회한다.
     *
     * @param
     * @return
     * @throws Exception
     */
    public String getApprvReqDate(Map<String, Object> parameter) {
        return (String) super.queryForObject("ft.fts.releaseMgmtDAO.getApprvReqDate", parameter, null);
    }

    /**
     * 판매 주문내역에 대하여 출고승인요청 처리한다.
     *
     * @param mapParam
     * @return
     */
    public int printReleaseReg(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.releaseMgmtDAO.printReleaseReg", mapParam);
    }

    /**
     * 판매 주문내역에 대하여 출고승인요청 처리한다.
     *
     * @param mapParam
     * @return
     */
    public int printReleaseRegChk(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.releaseMgmtDAO.printReleaseRegChk", mapParam);
    }
    /**
     * 판매 주문내역에 대하여 출고승인요청 처리한다.
     *
     * @param mapParam
     * @return
     */
    public int releaseApprovReq(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.releaseMgmtDAO.releaseApprovReq", mapParam);
    }

    /**
     * 판매 주문내역에 대하여 출고승인요청취소 처리한다.
     *
     * @param mapParam
     * @return
     */
    public int releaseApprovReqCancel(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.releaseMgmtDAO.releaseApprovReqCancel", mapParam);
    }

    /**
     * 판매 주문내역에 대하여 환입 처리한다.
     *
     * @param mapParam
     * @return
     */
    public int releasePurchaseReturn(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.releaseMgmtDAO.releasePurchaseReturn", mapParam);
    }

    /**
     * 출고 주문내역에 대하여 출고를 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectReleaseMgmtList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fts.releaseMgmtDAO.selectReleaseMgmtList", mapParam);
    }

    /**
     * 출고 품목 주문내역에 대하여 출고를 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectReleaseItemMgmtList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fts.releaseMgmtDAO.selectReleaseItemMgmtList", mapParam);
    }

    /**
     * 판매 주문내역에 대하여 출고증을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectReleaseReqCertificatePrintPop(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fts.releaseMgmtDAO.selectReleaseReqCertificatePrintPop", mapParam);
    }

    /**
     * 판매 주문내역에 대하여 출고증을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectReleaseReqCertificatePrintPop2(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fts.releaseMgmtDAO.selectReleaseReqCertificatePrintPop2", mapParam);
    }

    /**
     * 판매 주문내역에 대하여 출고증 발행 처리한다.
     *
     * @param mapParam
     * @return
     */
    public int printReleaseReqCertificate(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.releaseMgmtDAO.printReleaseReqCertificate", mapParam);
    }

    /**
     * 판매 주문내역에 대하여 출고확정 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectSalsConfirmList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fts.releaseMgmtDAO.selectSalsConfirmList", mapParam);
    }

    /**
     * 판매 주문내역에 대하여 출고확정대상 Sum 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectSalsConfirmSumList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fts.releaseMgmtDAO.selectSalsConfirmSumList", mapParam);
    }

    /**
     * 판매 주문내역에 환입 출고확정대상 Sum 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectSalsConfirmSumList2(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fts.releaseMgmtDAO.selectSalsConfirmSumList2", mapParam);
    }

    /**
     * 판매 원가대체 회계번호 수정 처리한다.
     *
     * @param mapParam
     * @return
     */
    public int updateCstSlipFiscalNum(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.releaseMgmtDAO.updateCstSlipFiscalNum", mapParam);
    }

    /**
     * 판매 원가대체 회계번호 수정 처리한다.
     *
     * @param mapParam
     * @return
     */
    public int updateIncCstSlipFiscalNum(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.releaseMgmtDAO.updateIncCstSlipFiscalNum", mapParam);
    }
    /**
     * 판매 부서이관 회계번호 수정 처리한다.
     *
     * @param mapParam
     * @return
     */
    public int updateDeptMngmvSlipFiscalNum(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.releaseMgmtDAO.updateDeptMngmvSlipFiscalNum", mapParam);
    }
    /**
     * 판매 원가대체 회계번호 수정 처리한다.
     *
     * @param mapParam
     * @return
     */
    public int saveBuyCostExceptDraft(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.releaseMgmtDAO.saveBuyCostExceptDraft", mapParam);
    }

    /**
     * 판매 원가대체 회계번호 수정 처리한다.
     *
     * @param mapParam
     * @return
     */
    public int saveBuyCostExceptDraft2(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.releaseMgmtDAO.saveBuyCostExceptDraft2", mapParam);
    }

    /**
     * 출고등록전 다시한번 출고가능 수량을 체크한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Record getLendingChk2(Map<String, Object> parameter) throws Exception {
        return super.queryForRecord("ft.fts.releaseMgmtDAO.getLendingChk2", parameter);
    }

    /**
     * 출고증 Fax 발송
     *
     * @param mapParam
     * @return
     */
    public RecordSet releaseFaxTransfer(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fts.releaseMgmtDAO.releaseFaxTransfer", mapParam);
    }

    /**
     * 여신 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectLendList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fts.releaseMgmtDAO.selectLendList", mapParam);
    }

    /**
     * 출고등록전 다시한번 출고가능 수량을 체크한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public Record selectCreInfo(Map<String, Object> parameter) throws Exception {
        return super.queryForRecord("fm.fmo.orderRequestDAO.selectCreInfoFTS", parameter);
    }

    /**
     * 출고증 Fax 발송
     *
     * @param mapParam
     * @return
     */
    public Record dealReqDocPublishCustFaxTransfer(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecord("ft.fts.releaseMgmtDAO.dealReqDocPublishCustFaxTransfer", mapParam);
    }

    /**
     * 출고증 Fax 발송
     *
     * @param mapParam
     * @return
     */
    public RecordSet dealReqDocPublishListFaxTransfer(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fts.releaseMgmtDAO.dealReqDocPublishListFaxTransfer", mapParam);
    }

    /**
     * 출고증 Fax 발송
     *
     * @param mapParam
     * @return
     */
    public RecordSet dealReqDocPublishListFaxTransferChk(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fts.releaseMgmtDAO.dealReqDocPublishListFaxTransferChk", mapParam);
    }
    
    /**
     * 판매 주문내역에 대하여 출고증 발행 이력 저장한다.
     *
     * @param mapParam
     * @return
     */
    public int printReleaseReqPubhist(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.releaseMgmtDAO.printReleaseReqPubhist", mapParam);
    }

}
