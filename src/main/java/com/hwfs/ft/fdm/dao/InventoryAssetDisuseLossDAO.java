package com.hwfs.ft.fdm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 재고자산 폐기손실하는 InventoryAssetDisuseLoss DAO
 *
 * @ClassName InventoryAssetDisuseLossDAO.java
 * @Description InventoryAssetDisuseLossDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.07   	KJJ        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재도매 KJJ
 * @since 2015.07.07
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ft/fdm/inventoryAssetDisuseLossDAO")
public class InventoryAssetDisuseLossDAO extends DefaultDAO {

    /**
     * 재고자산 폐기손실 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fdm.inventoryAssetDisuseLossDAO.selectList", mapParam);
    }

     /**
     * PO 상세 정보를 조회
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectDetailList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.fdm.inventoryAssetDisuseLossDAO.selectDetailList", parameter);
    }

    /**
     * 재고자산 폐기손실(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insert(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.inventoryAssetDisuseLossDAO.insert", mapParam);
    }

    /**
     * 재고자산 폐기손실(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int update(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.inventoryAssetDisuseLossDAO.update", mapParam);
    }

    /**
     * 재고자산 폐기손실(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int delete(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.inventoryAssetDisuseLossDAO.delete", mapParam);
    }

}
