package com.hwfs.sm.saa.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 사고채권발생보고하는 AccdArOccurRept DAO
 *
 * @ClassName AccdArOccurReptDAO.java
 * @Description AccdArOccurReptDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.29      최종덕        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최종덕
 * @since 2015.04.29
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/saa/accdArOccurReptDAO")
public class AccdArOccurReptDAO extends DefaultDAO {

    /**
     * 사고채권발생보고 목록을 조회한다.
     *
     * @param parameter
     * @return
     */
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("sm.saa.accdArOccurReptDAO.selectList", parameter);
    }

    /**
     * 식재업장 정보를 조회한다.
     *
     * @param parameter
     * @return
     */
    public RecordSet selectSaupNoList(Map<String, Object> parameter) throws Exception {
    	return super.queryForRecordSet("sm.saa.accdArOccurReptDAO.selectSaupNoList", parameter);
    }

    /**
     * 업장정보를 조회한다.
     *
     * @param parameter
     * @return
     */
    public RecordSet selectUpjang(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("sm.saa.accdArOccurReptDAO.selectUpjang", parameter);
    }
   
    /**
     * 거래처 채권 금액(급식)을 조회한다.
     *
     * @param parameter
     * @return
     */
    public RecordSet selectCustInfo(Map<String, Object> parameter) throws Exception {
    	return super.queryForRecordSet("sm.saa.accdArOccurReptDAO.selectCustInfo", parameter);
    }

    /**
     * 거래처 채권 금액(식재)을 조회한다.
     *
     * @param parameter
     * @return
     */
    public RecordSet selectCustInfoFms(Map<String, Object> parameter) throws Exception {
    	return super.queryForRecordSet("sm.saa.accdArOccurReptDAO.selectCustInfoFms", parameter);
    }

    /**
     * 채무자 목록을 조회한다.
     *
     * @param parameter
     * @return
     */
    public RecordSet selectDebt(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("sm.saa.accdArOccurReptDAO.selectDebt", parameter);
    }

    /**
     * 담보 목록을 조회한다.
     *
     * @param parameter
     * @return
     */
    public RecordSet selectDambo(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("sm.saa.accdArOccurReptDAO.selectDambo", parameter);
    }

    /**
     * 법적조치 목록을 조회한다.
     *
     * @param parameter
     * @return
     */
    public RecordSet selectLegal(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("sm.saa.accdArOccurReptDAO.selectLegal", parameter);
    }

    /**
     * 거래내역 헤더값을 조회한다.
     *
     * @param parameter
     * @return
     */
    public RecordSet selectHdrDealDesc(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("sm.saa.accdArOccurReptDAO.selectHdrDealDesc", parameter);
    }

    /**
     * 거래내역 목록을 조회한다.
     *
     * @param parameter
     * @return
     */
    public RecordSet selectDealDesc(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("sm.saa.accdArOccurReptDAO.selectDealDesc", parameter);
    }
    
    /**
     * 거래내역 헤더값을 조회한다.
     *
     * @param parameter
     * @return
     */
    public RecordSet selectHdrDealDescFs(Map<String, Object> parameter) throws Exception {
    	return super.queryForRecordSet("sm.saa.accdArOccurReptDAO.selectHdrDealDescFs", parameter);
    }
    
    /**
     * 거래내역 목록을 조회한다.
     *
     * @param parameter
     * @return
     */
    public RecordSet selectDealDescFs(Map<String, Object> parameter) throws Exception {
    	return super.queryForRecordSet("sm.saa.accdArOccurReptDAO.selectDealDescFs", parameter);
    }

    /**
     * 순번을 조회한다.
     *
     * @param parameter
     * @return
     */
    public RecordSet selectAccdCustMstSeq(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("sm.saa.accdArOccurReptDAO.selectAccdCustMstSeq", parameter);
    }

    /**
     * 사고업장관리(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insertAccdCustMst(Map<String, Object> mapParam) throws Exception {
        return super.update("sm.saa.accdArOccurReptDAO.insertAccdCustMst", mapParam);
    }

    /**
     * 사고채권(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insertAccdAr(Map<String, Object> mapParam) throws Exception {
        return super.update("sm.saa.accdArOccurReptDAO.insertAccdAr", mapParam);
    }

    /**
     * 채무자(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insertAccdArDebtor(Map<String, Object> mapParam) throws Exception {
        return super.update("sm.saa.accdArOccurReptDAO.insertAccdArDebtor", mapParam);
    }

    /**
     * 법적조치(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insertAccdArLegalMrmt(Map<String, Object> mapParam) throws Exception {
        return super.update("sm.saa.accdArOccurReptDAO.insertAccdArLegalMrmt", mapParam);
    }

    /**
     * 사고업장관리(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateAccdCustMst(Map<String, Object> mapParam) throws Exception {
        return super.update("sm.saa.accdArOccurReptDAO.updateAccdCustMst", mapParam);
    }

    /**
     * 사고채권(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateAccdAr(Map<String, Object> mapParam) throws Exception {
        return super.update("sm.saa.accdArOccurReptDAO.updateAccdAr", mapParam);
    }

    /**
     * 채무자(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateAccdArDebtor(Map<String, Object> mapParam) throws Exception {
        return super.update("sm.saa.accdArOccurReptDAO.updateAccdArDebtor", mapParam);
    }

    /**
     * 법적조치(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateAccdarlegalMrmt(Map<String, Object> mapParam) throws Exception {
        return super.update("sm.saa.accdArOccurReptDAO.updateAccdarlegalMrmt", mapParam);
    }

    /**
     * 부동산정보(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateRealEstate(Map<String, Object> mapParam) throws Exception {
        return super.update("sm.saa.accdArOccurReptDAO.updateRealEstate", mapParam);
    }

    /**
     * 보증보험정보(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateGuaranteeInsur(Map<String, Object> mapParam) throws Exception {
        return super.update("sm.saa.accdArOccurReptDAO.updateGuaranteeInsur", mapParam);
    }

    /**
     * 인보증정보(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateGuarantor(Map<String, Object> mapParam) throws Exception {
        return super.update("sm.saa.accdArOccurReptDAO.updateGuarantor", mapParam);
    }

    /**
     * 현금보증정보(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateCashGuarantee(Map<String, Object> mapParam) throws Exception {
        return super.update("sm.saa.accdArOccurReptDAO.updateCashGuarantee", mapParam);
    }

    /**
     * 질권정보(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updatePledge(Map<String, Object> mapParam) throws Exception {
        return super.update("sm.saa.accdArOccurReptDAO.updatePledge", mapParam);
    }

    /**
     * 채권양도정보(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateAccRcvAlnt(Map<String, Object> mapParam) throws Exception {
        return super.update("sm.saa.accdArOccurReptDAO.updateAccRcvAlnt", mapParam);
    }

    /**
     * 전자결재정보를 Update 처리한다.
     * <pre>
     * - Instance ID와 결재진행상태 Update
     * </pre>
     *
     * @param parameter
     * @return
     */
    public int updateSign(Map<String, Object> parameter) throws Exception {
        return super.update("sm.saa.accdArOccurReptDAO.updateSign", parameter);
    }

    /**
     * 사고업장관리(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int deleteAccdCustMst(Map<String, Object> mapParam) throws Exception {
        return super.update("sm.saa.accdArOccurReptDAO.deleteAccdCustMst", mapParam);
    }

    /**
     * 사고채권(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int deleteAccdAr(Map<String, Object> mapParam) throws Exception {
        return super.update("sm.saa.accdArOccurReptDAO.deleteAccdAr", mapParam);
    }

    /**
     * 채무자(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int deleteAccdArDebtor(Map<String, Object> mapParam) throws Exception {
        return super.update("sm.saa.accdArOccurReptDAO.deleteAccdArDebtor", mapParam);
    }

    /**
     * 법적조치(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int deleteAccdarlegalMrmt(Map<String, Object> mapParam) throws Exception {
        return super.update("sm.saa.accdArOccurReptDAO.deleteAccdarlegalMrmt", mapParam);
    }
}
