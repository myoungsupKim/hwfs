package com.hwfs.ft.ftp.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 구매주문 부대비하는 PoOrderOtherAmt DAO
 *
 * @ClassName PoOrderOtherAmtDAO.java
 * @Description PoOrderOtherAmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.20   	KJJ        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재도매 KJJ
 * @since 2015.03.20
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ft/ftp/poOrderOtherAmtDAO")
public class PoOrderOtherAmtDAO extends DefaultDAO {

    /**
     * 구매주문 부대비 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.ftp.poOrderOtherAmtDAO.selectList", mapParam);
    }

    /**
     * 구매주문 부대비 관리(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insert(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.ftp.poOrderOtherAmtDAO.insert", mapParam);
    }

    /**
     * 구매주문 부대비 관리(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int update(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.ftp.poOrderOtherAmtDAO.update", mapParam);
    }

    /**
     * 구매주문 부대비 관리(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int delete(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.ftp.poOrderOtherAmtDAO.delete", mapParam);
    }

    /**
     * 구매주문 부대비 관리(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int deleteOtherAmt(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.ftp.poOrderOtherAmtDAO.deleteOtherAmt", mapParam);
    }

    /**
     * 구매주문 부대비 전표 상태(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int createFiscalSlip(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.ftp.poOrderOtherAmtDAO.createFiscalSlip", mapParam);
    }

    /**
     * 구매주문 부대비 전표 상태(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int cancelFiscalSlip(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.ftp.poOrderOtherAmtDAO.cancelFiscalSlip", mapParam);
    }

    /**
     * 구매주문 부대비 배부 누적금액(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateDivAccumAmt(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.ftp.poOrderOtherAmtDAO.updateDivAccumAmt", mapParam);
    }

    /**
     * 분할통관된 내역이 전체가 입고 취소됬을시 구매주문 부대비의 배부 누적 금액 0으로 만들어 준다.
     *
     * @param mapParam
     * @return
     */
    public int updateAllDivAccumAmtZero(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.ftp.poOrderOtherAmtDAO.updateAllDivAccumAmtZero", mapParam);
    }
    /**
     * 구매주문 부대비 배부 잔액 금액(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateDivAccumAmtBalAlt(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.ftp.poOrderOtherAmtDAO.updateDivAccumAmtBalAlt", mapParam);
    }


    /**
     *수수료 금액을 조회한다.
     *
     * @param
     * @return
     * @throws Exception
     */
    public String getCommAmt2(Map<String, Object> parameter) {
        return (String) super.queryForObject("ft.ftp.poOrderOtherAmtDAO.getCommAmt", parameter, null);
    }

    /**
     *수수료 금액을 조회한다.
     *
     * @param
     * @return
     * @throws Exception
     */
    public long getCommAmt(Map<String, Object> parameter) {
        //return (String) super.queryForObject("ft.ftp.poOrderOtherAmtDAO.getCommAmt", parameter, null);
        return (long)super.queryForLong("ft.ftp.poOrderOtherAmtDAO.getCommAmt", parameter);
    }

    /**
     *회계전표생성일자(결재일)을 조회한다.
     *
     * @param
     * @return
     * @throws Exception
     */
    public String getFiscalSlipcDate(Map<String, Object> parameter) {
        return (String) super.queryForObject("ft.ftp.poOrderOtherAmtDAO.getFiscalSlipcDate", parameter, null);
    }


    /**
     * 기타 선급금 정산 관리 전표 상태(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateSlipNum(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.ftp.poOrderOtherAmtDAO.updateSlipNum", mapParam);
    }

    /**
     * 마스터 시퀀스을 조회한다.
     *
     * @param
     * @return
     * @throws Exception
     */
    public int getOtherAmtSeq(Map<String, Object> parameter) {
        return super.queryForInt("ft.ftp.poOrderOtherAmtDAO.getOtherAmtSeq", parameter);
//        return (String) super.queryForObject("ft.fgp.gdspaymMstDAO.getMaxSeq", parameter, null);
    }

    /**
     * 구매주문 부대비 관리(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateOtherAmtDraft(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.ftp.poOrderOtherAmtDAO.updateOtherAmtDraft", mapParam);
    }

}
