package com.hwfs.ft.fsi.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 국가,품목,기간별로 관세율을 관리하는 GvrntaxRateMgmt DAO
 *
 * @ClassName GvrntaxRateMgmtDAO.java
 * @Description GvrntaxRateMgmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.12   	김종준        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재도매 김종준
 * @since 2015.03.12
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ft/fsi/gvrntaxRateMgmtDAO")
public class GvrntaxRateMgmtDAO extends DefaultDAO {

    /**
     * 기간별 관세율관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fsi.gvrntaxRateMgmtDAO.selectList", mapParam);
    }

    /**
     * 시작일자, 종료일자 포함여부 체크
     *
     * @param mapParam
     * @return
     */
    public RecordSet checkDateList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fsi.gvrntaxRateMgmtDAO.checkDateList", mapParam);
    }

    /**
     * 기간별 관세율관리(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insert(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fsi.gvrntaxRateMgmtDAO.insert", mapParam);
    }

    /**
     * 기간별 관세율관리(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int update(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fsi.gvrntaxRateMgmtDAO.update", mapParam);
    }

    /**
     * 기간별 관세율관리(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int delete(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fsi.gvrntaxRateMgmtDAO.delete", mapParam);
    }

    /**
     * 기간별 관세율관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectGvrntaxRatePop(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fsi.gvrntaxRateMgmtDAO.selectGvrntaxRatePop", mapParam);
    }

}
