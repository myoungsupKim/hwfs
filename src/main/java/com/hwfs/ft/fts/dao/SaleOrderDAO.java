package com.hwfs.ft.fts.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

import hone.core.util.record.RecordSet;

/**
* 입고(재고)를 판매 주문에 대하여 관리하는 SaleOrder DAO
*
* @ClassName SaleOrderDAO.java
* @Description SaleOrderDAO Class
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
@Repository("/ft/fts/saleOrderDAO")
public class SaleOrderDAO extends DefaultDAO {

    /**
     * 입고(재고)를 판매 주문에 대하여 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fts.saleOrderDAO.selectList", mapParam);
    }

    /**
     * 입고(재고)를 판매 주문에 대하여 관리(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insert(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.saleOrderDAO.insert", mapParam);
    }

    /**
     * 입고(재고)를 판매 주문에 대하여 관리(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int update(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.saleOrderDAO.update", mapParam);
    }

    /**
     * 입고(재고)를 판매 주문에 대하여 관리(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int delete(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.saleOrderDAO.delete", mapParam);
    }

    /**
     * 입고(재고)를 판매 주문에 대하여 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectItemInfoSaveSearchPop(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fts.saleOrderDAO.selectItemInfoSaveSearchPop", mapParam);
    }

    /**
     * 입고(재고)를 판매 주문에 대하여 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectItemInfoSaveSearchPop2(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fts.saleOrderDAO.selectItemInfoSaveSearchPop2", mapParam);
    }

    /**
     * 판매주문 마스터을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectSaleOrder(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fts.saleOrderDAO.selectSaleOrder", mapParam);
    }

    /**
     * 판매주문 마스터 시퀀스을 조회한다.
     *
     * @param
     * @return
     * @throws Exception
     */
    public String getSaleOrderNumSeq(Map<String, Object> parameter) {
        return (String) super.queryForObject("ft.fts.saleOrderDAO.getSaleOrderNumSeq", parameter, null);
    }

    /**
     * 판매주문등록 리스트를 조회 한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectSalesOrderRegList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fts.saleOrderDAO.selectSalesOrderRegList", mapParam);
    }

    /**
     * 주문 취소를 관리(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int deleteSaleOrderCancelLog(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.saleOrderDAO.deleteSaleOrderCancelLog", mapParam);
    }

}
