package com.hwfs.ft.fdm.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 관세비용 및 입고예정 품목 상세 정보를 등록 관리하는 EntryItemDetail DAO
 *
 * @ClassName EntryItemDetailDAO.java
 * @Description EntryItemDetailDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.13   	kjj        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재도매 kjj
 * @since 2015.04.13
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ft/fdm/entryItemDetailDAO")
public class EntryItemDetailDAO extends DefaultDAO {

    /**
     * 관세비용 및 입고예정 품목 상세 정보를 등록 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fdm.entryItemDetailDAO.selectList", mapParam);
    }

    /**
     * 관세비용 및 입고예정 품목 상세 정보를 등록 관리(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insert(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.entryItemDetailDAO.insert", mapParam);
    }

    /**
     * 관세비용 및 입고예정 품목 상세 정보를 등록 관리(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int update(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.entryItemDetailDAO.update", mapParam);
    }

    /**
     * 관세비용 및 입고예정 품목 상세 정보를 등록 관리(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int delete(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.entryItemDetailDAO.delete", mapParam);
    }

    /**
     * 관세비용 및 입고예정 품목 상세 정보를 등록 관리(을)를 전체 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int deleteAll(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.entryItemDetailDAO.deleteAll", mapParam);
    }

    /**
     * 통관 품목 상세를 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectEntryItemDetail(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fdm.entryItemDetailDAO.selectEntryItemDetail", mapParam);
    }

    /**
     * 가입고 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectReceiveRegList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fdm.entryItemDetailDAO.selectReceiveRegList", mapParam);
    }

    /**
     * 통관 삭제시 구매 주문 품목 상세의 차감시킬 통관 완료 수량을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectEntryReqQuantity(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fdm.entryItemDetailDAO.selectEntryReqQuantity", mapParam);
    }

    /**
     *관세율을 조회한다.
     *
     * @param
     * @return
     * @throws Exception
     */
    public Record getGvrntaxRate(Map<String, Object> parameter) {
//        return (String) super.queryForObject("ft.fdm.entryItemDetailDAO.getGvrntaxRate", parameter, null);
        return super.queryForRecord("ft.fdm.entryItemDetailDAO.getGvrntaxRate", parameter);
    }
}
