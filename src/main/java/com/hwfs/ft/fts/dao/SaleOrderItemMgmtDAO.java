package com.hwfs.ft.fts.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 입고(재고)를 판매 주문(품목)에 대하여 관리하는 SaleOrderItemMgmt DAO
 *
 * @ClassName SaleOrderItemMgmtDAO.java
 * @Description SaleOrderItemMgmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.06   	kjj        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재도매 kjj
 * @since 2015.05.06
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ft/fts/saleOrderItemMgmtDAO")
public class SaleOrderItemMgmtDAO extends DefaultDAO {

    /**
     * 입고(재고)를 판매 주문(품목)에 대하여 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fts.saleOrderItemMgmtDAO.selectList", mapParam);
    }

    /**
     * 입고(재고)를 판매 주문(품목)에 대하여 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList2(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fts.saleOrderItemMgmtDAO.selectList2", mapParam);
    }

    /**
     * 입고(재고)를 판매 주문(품목)에 대하여 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public Record getTotOrderQuantity(Map<String, Object> mapParam) {
        return super.queryForRecord("ft.fts.saleOrderItemMgmtDAO.getTotOrderQuantity", mapParam);
    }

    /**
     * 입고(재고)를 판매 주문(품목)에 대하여 관리(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insert(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.saleOrderItemMgmtDAO.insert", mapParam);
    }

    /**
     * 입고(재고)를 판매 주문(품목)에 대하여 관리(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int update(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.saleOrderItemMgmtDAO.update", mapParam);
    }

    /**
     * 입고(재고)를 판매 주문(품목)에 대하여 관리(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int delete(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.saleOrderItemMgmtDAO.delete", mapParam);
    }

    /**
     * 입고(재고)를 판매 주문(품목)에 대하여 관리(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int deleteAll(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.saleOrderItemMgmtDAO.deleteAll", mapParam);
    }

    /**
     * 판매주문 품목 관리 상세 조회
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectSaleOrderItemMgmt(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fts.saleOrderItemMgmtDAO.selectSaleOrderItemMgmt", mapParam);
    }

    public int getSaleOrderNumSeq(Map<String, Object> mapParam) throws Exception {
        return super.queryForInt("ft.fts.saleOrderItemMgmtDAO.getSaleOrderNumSeq", mapParam);
    }

    /**
     * 입고(재고)를 판매 주문(품목)에 대하여 관리(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateReleaseApprvReqQuantity(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.saleOrderItemMgmtDAO.updateReleaseApprvReqQuantity", mapParam);
    }

    /**
     * 입고(재고)를 판매 주문(품목)에 대하여 관리(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateWhgChgReleaseApprvReqQuantity(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.saleOrderItemMgmtDAO.updateWhgChgReleaseApprvReqQuantity", mapParam);
    }

    /**
     * 출고승인수량(중량)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateReleaseApprvQuantity(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.saleOrderItemMgmtDAO.updateReleaseApprvQuantity", mapParam);
    }

    /**
     * 출고승인수량(중량)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateReleaseQuantity(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.saleOrderItemMgmtDAO.updateReleaseQuantity", mapParam);
    }
    /**
     * 주문수량(중량)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateOrderQuantity(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.saleOrderItemMgmtDAO.updateOrderQuantity", mapParam);
    }

    /**
     * 판매주문테이블의 판매단가,판매금액 변경
     *
     * @param mapParam
     * @return
     */
    public int updateSaleOrderUpriceChg(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.saleOrderItemMgmtDAO.updateSaleOrderUpriceChg", mapParam);
    }

    /**
     * 입고(재고)를 판매 주문(품목)에 대하여 관리(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateCancelQuantity(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.saleOrderItemMgmtDAO.updateCancelQuantity", mapParam);
    }

    /**
     * 주문 취소상태를 관리(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateSaleOrderStatus(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.saleOrderItemMgmtDAO.updateSaleOrderStatus", mapParam);
    }

    /**
     * 주문 취소 건수 업데이트
     *
     * @param mapParam
     * @return
     */
    public int updateSaleOrderCancelQuantity(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.saleOrderItemMgmtDAO.updateSaleOrderCancelQuantity", mapParam);
    }
}
