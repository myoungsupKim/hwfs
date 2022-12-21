package com.hwfs.ft.fts.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 환입관리하는 PurchaseReturnMgmt DAO
 *
 * @ClassName PurchaseReturnMgmtDAO.java
 * @Description PurchaseReturnMgmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.29   	KJJ        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재도매 KJJ
 * @since 2015.07.29
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ft/fts/purchaseReturnMgmtDAO")
public class PurchaseReturnMgmtDAO extends DefaultDAO {

    /**
     * 환입관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fts.purchaseReturnMgmtDAO.selectList", mapParam);
    }

    /**
     * 환입관리(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insert(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.purchaseReturnMgmtDAO.insert", mapParam);
    }

    /**
     * 환입관리(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int update(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.purchaseReturnMgmtDAO.update", mapParam);
    }

    /**
     * 환입관리(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateCst(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.purchaseReturnMgmtDAO.updateCst", mapParam);
    }

    /**
     * 환입관리(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateCstSeq(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.purchaseReturnMgmtDAO.updateCstSeq", mapParam);
    }

    /**
     * 환입관리(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int delete(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.purchaseReturnMgmtDAO.delete", mapParam);
    }

}
