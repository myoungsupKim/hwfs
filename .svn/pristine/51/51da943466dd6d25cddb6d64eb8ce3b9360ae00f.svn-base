package com.hwfs.ft.fsi.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

import hone.core.util.record.RecordSet;

/**
* 냉동창고수수료 DAO
*
* @ClassName FreezeWhCommMgmtDAO.java
* @Description FreezeWhCommMgmtDAO Class
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2015.08.26     jshoon        최초생성
* </pre>
* @author FC종합전산구축 : 식재도매 kjj
* @since 2015.08.26
* @version 1.0
* @see
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
@Repository("/ft/fsi/freezeWhCommMgmtDAO")
public class FreezeWhCommMgmtDAO extends DefaultDAO {

    /**
     * 냉동창고수수료 내역을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fsi.freezeWhCommMgmtDAO.selectList", mapParam);
    }

    /**
     * 팝업에서 사용하는 거래처 계좌번호 조회
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectSuplierAcctNoList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fsi.freezeWhCommMgmtDAO.selectSuplierAcctNoList", mapParam);
    }

    /**
     * 국세청번호를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int selectTaxBillNum(Map<String, Object> parameter) throws Exception {
        return super.queryForInt("ft.fsi.freezeWhCommMgmtDAO.selectTaxBillNum", parameter);
    }

    /**
     * 냉동창고수수료 내역을 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insert(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fsi.freezeWhCommMgmtDAO.insert", mapParam);
    }

    /**
     * 냉동창고수수료 내역을 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int update(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fsi.freezeWhCommMgmtDAO.update", mapParam);
    }

    /**
     * 냉동창고수수료 내역을 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int delete(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fsi.freezeWhCommMgmtDAO.delete", mapParam);
    }

    /**
     * 냉동창고수수료 전표번호를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int slipNumUpdate(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fsi.freezeWhCommMgmtDAO.slipNumUpdate", mapParam);
    }

    /**
     * 전자결과 결과를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int saveDraft(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fsi.freezeWhCommMgmtDAO.saveDraft", mapParam);
    }

    /**
     * 냉동창고수수료 일괄 저장
     *
     * @param mapParam
     * @return
     */
    public int saveListAll(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fsi.freezeWhCommMgmtDAO.saveListAll", mapParam);
    }

    /**
     * 팝업에서 사용하는 거래처 계좌번호 조회
     *
     * @param mapParam
     * @return
     */
    public Map<String, Object> selectDecAddr(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecord("ft.fsi.freezeWhCommMgmtDAO.selectDecAddr", mapParam);
    }

    /**
     * 귀속부서 CC Code 조회
     *
     * @param mapParam
     * @return
     */
    public String selectCcCd(Map<String, Object> mapParam) throws Exception {
        return (String) super.queryForObject("ft.fsi.freezeWhCommMgmtDAO.selectCcCd", mapParam, null);
    }
    
    /**
     * 관리(예산)부서 CC Code 조회
     *
     * @param mapParam
     * @return
     */
    public String selectMgmtCcCd(Map<String, Object> mapParam) throws Exception {
        return (String) super.queryForObject("ft.fsi.freezeWhCommMgmtDAO.selectMgmtCcCd", mapParam, null);
    }
    

}
