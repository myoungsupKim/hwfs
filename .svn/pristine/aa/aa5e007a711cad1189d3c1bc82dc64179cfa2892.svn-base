package com.hwfs.ft.fsi.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 품목 조회하는 Item DAO
 *
 * @ClassName ItemDAO.java
 * @Description ItemDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.26   	KJJ        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재도매 KJJ
 * @since 2015.03.26
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ft/fsi/itemDAO")
public class ItemDAO extends DefaultDAO {

    /**
     * 품목 조회 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fsi.itemDAO.selectList", mapParam);
    }

    /**
     * 품목 조회(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insert(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fsi.itemDAO.insert", mapParam);
    }

    /**
     * 품목 조회(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int update(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fsi.itemDAO.update", mapParam);
    }

    /**
     * 품목 조회(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int delete(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fsi.itemDAO.delete", mapParam);
    }

    /**
     * 과세유형 조회 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectTaxTypeList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fsi.itemDAO.selectTaxTypeList", mapParam);
    }
}
