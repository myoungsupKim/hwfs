package com.hwfs.ft.fgp.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 물품대금 마스터하는 GdspaymMst DAO
 *
 * @ClassName GdspaymMstDAO.java
 * @Description GdspaymMstDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.06   	kjj        최초생성
 * </pre>
 * @author FC종합전산구축 : 물품대금 마스터 kjj
 * @since 2015.04.06
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ft/fgp/gdspaymMstDAO")
public class GdspaymMstDAO extends DefaultDAO {

    /**
     * 물품대금 마스터 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fgp.gdspaymMstDAO.selectList", mapParam);
    }

    /**
     * 물품대금 마스터 관리(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insert(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fgp.gdspaymMstDAO.insert", mapParam);
    }

    /**
     * 물품대금 마스터 관리(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int update(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fgp.gdspaymMstDAO.update", mapParam);
    }

    /**
     * 물품대금 마스터 관리(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int delete(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fgp.gdspaymMstDAO.delete", mapParam);
    }

    /**
     * 전표 상태(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int createFiscalSlip(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fgp.gdspaymMstDAO.createFiscalSlip", mapParam);
    }

    /**
     * 전표 상태(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int cancelFiscalSlip(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fgp.gdspaymMstDAO.cancelFiscalSlip", mapParam);
    }

    /**
     * 물품대금 마스터 전표 생성 갯수을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectChkSlitCnt(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fgp.gdspaymMstDAO.selectChkSlitCnt", mapParam);
    }

    /**
     * 물품대금 마스터 정보을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectChkCancelInfo(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fgp.gdspaymMstDAO.selectChkCancelInfo", mapParam);
    }

    /**
     * 물품대금 마스터(내수) 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList2(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fgp.gdspaymMstDAO.selectList2", mapParam);
    }

    /**
     * 전표 상태(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int createDmtFiscalSlip(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fgp.gdspaymMstDAO.createDmtFiscalSlip", mapParam);
    }

    /**
     * 전표 상태(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int cancelDmtFiscalSlip(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fgp.gdspaymMstDAO.cancelDmtFiscalSlip", mapParam);
    }

    /**
     *결재일을 조회한다.
     *
     * @param
     * @return
     * @throws Exception
     */
    public String getBuyPaymSettledd(Map<String, Object> parameter) {
        return (String) super.queryForObject("ft.fgp.gdspaymMstDAO.getBuyPaymSettledd", parameter, null);
    }

    /**
     *과세유형 가져오기
     *
     * @param
     * @return
     * @throws Exception
     */
    public Record getVatClassCd(Map<String, Object> parameter) {
        return super.queryForRecord("ft.fgp.gdspaymMstDAO.getVatClassCd", parameter);
    }

    /**
     *결재일을 조회한다.
     *
     * @param
     * @return
     * @throws Exception
     */
    public String selectSlipNum(Map<String, Object> parameter) {
        return (String) super.queryForObject("ft.fgp.gdspaymMstDAO.selectSlipNum", parameter, null);
    }

    /**
     * 마스터 시퀀스을 조회한다.
     *
     * @param
     * @return
     * @throws Exception
     */
    public int getMaxSeq(Map<String, Object> parameter) {
        return super.queryForInt("ft.fgp.gdspaymMstDAO.getMaxSeq", parameter);
//        return (String) super.queryForObject("ft.fgp.gdspaymMstDAO.getMaxSeq", parameter, null);
    }

    /**
     * 물품대금(수입) 결재번호(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateIncomeDraft(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fgp.gdspaymMstDAO.updateIncomeDraft", mapParam);
    }
}
