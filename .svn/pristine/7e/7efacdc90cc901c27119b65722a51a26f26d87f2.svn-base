package com.hwfs.ft.fts.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 주문 취소를 관리하는 SaleOrderCancelLog DAO
 *
 * @ClassName SaleOrderCancelLogDAO.java
 * @Description SaleOrderCancelLogDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.04   	KJJ        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재도매 KJJ
 * @since 2015.06.04
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ft/fts/saleOrderCancelLogDAO")
public class SaleOrderCancelLogDAO extends DefaultDAO {

    /**
     * 주문 취소를 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fts.saleOrderCancelLogDAO.selectList", mapParam);
    }

    /**
     * 주문 취소를 관리(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insert(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.saleOrderCancelLogDAO.insert", mapParam);
    }

    /**
     * 주문 취소를 관리(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int update(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.saleOrderCancelLogDAO.update", mapParam);
    }

    /**
     * 주문 취소를 관리(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int delete(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.saleOrderCancelLogDAO.delete", mapParam);
    }

    /**
     *총취소건을 조회한다.
     *
     * @param
     * @return
     * @throws Exception
     */
    public Record getCancelSumInfo(Map<String, Object> parameter) {
//        return (String) super.queryForObject("ft.fdm.entryItemDetailDAO.getGvrntaxRate", parameter, null);
        return super.queryForRecord("ft.fts.saleOrderCancelLogDAO.getCancelSumInfo", parameter);
    }


}
