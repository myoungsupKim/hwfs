package com.hwfs.ft.fdm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 관세비용 및 입고예정정보를 등록 관리하는 EntryMst DAO
 *
 * @ClassName EntryMstDAO.java
 * @Description EntryMstDAO Class
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
@Repository("/ft/fdm/entryMstDAO")
public class EntryMstDAO extends DefaultDAO {

    /**
     * 관세비용 및 입고예정정보를 등록 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fdm.entryMstDAO.selectList", mapParam);
    }

    /**
     * 관세비용 및 입고예정정보를 등록 관리(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insert(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.entryMstDAO.insert", mapParam);
    }

    /**
     * 관세비용 및 입고예정정보를 등록 관리(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int update(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.entryMstDAO.update", mapParam);
    }

    /**
     * 관세비용 및 입고예정정보를 등록 관리(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int delete(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.entryMstDAO.delete", mapParam);
    }

    /**
     * 관세비용 및 입고예정정보를 등록 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectItemInfoSaveSearchPop(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fdm.entryMstDAO.selectItemInfoSaveSearchPop", mapParam);
    }

    /**
     * 관세비용 및 입고예정정보를 등록 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectItemInfoSaveSearchPop2(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fdm.entryMstDAO.selectItemInfoSaveSearchPop2", mapParam);
    }

    /**
     * 관세비용 및 입고예정정보를 등록 관리 가입고  목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectItemInfoSaveReceiveSearchPop(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fdm.entryMstDAO.selectItemInfoSaveReceiveSearchPop", mapParam);
    }

    /**
     * 관세비용 및 입고예정정보를 등록 관리 가입고 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectItemInfoSaveReceiveSearchPop2(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fdm.entryMstDAO.selectItemInfoSaveReceiveSearchPop2", mapParam);
    }

    /**
     * 통관 마스터을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectEntryMst(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fdm.entryMstDAO.selectEntryMst", mapParam);
    }

    /**
     * 통관 마스터을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet searchSignExchangeRate(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fdm.entryMstDAO.searchSignExchangeRate", mapParam);
    }
    /**
     * 통관 마스터 시퀀스을 조회한다.
     *
     * @param
     * @return
     * @throws Exception
     */
    public String getEntryNumSeq(Map<String, Object> parameter) {
        return (String) super.queryForObject("ft.fdm.entryMstDAO.getEntryNumSeq", parameter, null);
    }

    /**
     * 관세비용 및 입고예정정보를 등록 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectBlListPop(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fdm.entryMstDAO.selectBlListPop", mapParam);
    }

    /**
     * 관세비용 및 입고예정정보를 등록 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectBlListPop2(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fdm.entryMstDAO.selectBlListPop2", mapParam);
    }

    /**
     * 입고대상 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectDeliverList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fdm.entryMstDAO.selectDeliverList", mapParam);
    }

    /**
     * 통관테이블 입고여부 Y 업데이트
     *
     * @param mapParam
     * @return
     */
    public int updateDeliverYn(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.entryMstDAO.updateDeliverYn", mapParam);
    }

    /**
     *면허번호 중복체크
     *
     * @param
     * @return
     * @throws Exception
     */
    public String dupIncomeLicNumYn(Map<String, Object> parameter) {
        return (String) super.queryForObject("ft.fdm.entryMstDAO.dupIncomeLicNumYn", parameter, null);
    }
}
