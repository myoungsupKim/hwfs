package com.hwfs.ft.fdm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 재고(입고) 조정을 하면서 SAP쪽과 I/F한 이력 관리하는 InventoryControlLog DAO
 *
 * @ClassName InventoryControlLogDAO.java
 * @Description InventoryControlLogDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.22   	kjj        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재도매 kjj
 * @since 2015.04.22
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ft/fdm/inventoryControlLogDAO")
public class InventoryControlLogDAO extends DefaultDAO {

    /**
     * 재고(입고) 조정을 하면서 SAP쪽과 I/F한 이력 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fdm.inventoryControlLogDAO.selectList", mapParam);
    }

    /**
     * 재고(입고) 조정을 하면서 SAP쪽과 I/F한 이력 관리(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insert(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.inventoryControlLogDAO.insert", mapParam);
    }

    /**
     * 재고(입고) 조정을 하면서 SAP쪽과 I/F한 이력 관리(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int update(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.inventoryControlLogDAO.update", mapParam);
    }

    /**
     * 재고(입고) 조정을 하면서 SAP쪽과 I/F한 이력 관리(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int delete(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.inventoryControlLogDAO.delete", mapParam);
    }

    /**
     * 재고(입고) 조정을 하면서 SAP쪽과 I/F한 이력 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectInventoryControlLogList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fdm.inventoryControlLogDAO.selectInventoryControlLogList", mapParam);
    }
}
