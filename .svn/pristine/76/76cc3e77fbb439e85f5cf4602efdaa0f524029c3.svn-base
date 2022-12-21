package com.hwfs.ft.ftp.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 기타 선급금 정산하는 EtcPrepayamtAdjust DAO
 *
 * @ClassName EtcPrepayamtAdjustDAO.java
 * @Description EtcPrepayamtAdjustDAO Class
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
@Repository("/ft/ftp/etcPrepayamtAdjustDAO")
public class EtcPrepayamtAdjustDAO extends DefaultDAO {

    /**
     * 기타 선급금 정산 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.ftp.etcPrepayamtAdjustDAO.selectList", mapParam);
    }

    /**
     * 기타 선급금 정산 관리(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insert(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.ftp.etcPrepayamtAdjustDAO.insert", mapParam);
    }

    /**
     * 기타 선급금 정산 관리(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int update(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.ftp.etcPrepayamtAdjustDAO.update", mapParam);
    }

    /**
     * 기타 선급금 정산 관리(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int delete(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.ftp.etcPrepayamtAdjustDAO.delete", mapParam);
    }

    /**
     * 기타 선급금 정산 관리(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int deleteEtcPrepay(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.ftp.etcPrepayamtAdjustDAO.deleteEtcPrepay", mapParam);
    }

    /**
     * 기타 선급금 정산 관리 전표 상태(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int createEtcFiscalSlipIf(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.ftp.etcPrepayamtAdjustDAO.createEtcFiscalSlipIf", mapParam);
    }

    /**
     * 기타 선급금 정산 관리 전표 상태(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int cancelEtcFiscalSlipIf(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.ftp.etcPrepayamtAdjustDAO.cancelEtcFiscalSlipIf", mapParam);
    }

    /**
     * 기타 선급금 정산 관리 누적 대체 금액(수수료 체크 누적금액) 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateAccumAltAmt(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.ftp.etcPrepayamtAdjustDAO.updateAccumAltAmt", mapParam);
    }

    /**
     * 기타 선급금 정산 관리 누적 대체 금액(수수료 체크 누적금액) 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateAccumAltAmt2(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.ftp.etcPrepayamtAdjustDAO.updateAccumAltAmt2", mapParam);
    }

    /**
     * 구매주문 부대비 관리(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateEtcAmtDraft(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.ftp.etcPrepayamtAdjustDAO.updateEtcAmtDraft", mapParam);
    }

    /**
     *단위변경시 단위에 해당하는 실단위 가져오기
     *
     * @param
     * @return
     * @throws Exception
     */
    public Record selectAccumAltAmt(Map<String, Object> mapParam) {
        return super.queryForRecord("ft.ftp.etcPrepayamtAdjustDAO.selectAccumAltAmt", mapParam);
    }

    /**
     *단위변경시 단위에 해당하는 실단위 가져오기
     *
     * @param
     * @return
     * @throws Exception
     */
    public Record selectAccumAltAmt2(Map<String, Object> mapParam) {
        return super.queryForRecord("ft.ftp.etcPrepayamtAdjustDAO.selectAccumAltAmt2", mapParam);
    }
}
