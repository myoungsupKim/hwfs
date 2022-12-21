package com.hwfs.ft.fsi.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 창고, 품목별로 보관료를 관리.하는 WhbyItembyChargAmt DAO
 *
 * @ClassName WhbyItembyChargAmtDAO.java
 * @Description WhbyItembyChargAmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.16   	김종준        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재도매 김종준
 * @since 2015.03.16
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ft/fsi/whbyItembyChargAmtDAO")
public class WhbyItembyChargAmtDAO extends DefaultDAO {

    /**
     * 창고, 품목별로 보관료. 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fsi.whbyItembyChargAmtDAO.selectList", mapParam);
    }

    /**
     * 창고, 품목별로 보관료. 상세목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList2(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fsi.whbyItembyChargAmtDAO.selectList2", mapParam);
    }

    /**
     * 창고, 품목별로 보관료.(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insert(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fsi.whbyItembyChargAmtDAO.insert", mapParam);
    }

    /**
     * 창고, 품목별로 보관료.(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int update(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fsi.whbyItembyChargAmtDAO.update", mapParam);
    }

    /**
     * 창고, 품목별로 보관료.(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int delete(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fsi.whbyItembyChargAmtDAO.delete", mapParam);
    }

    /**
     * 창고, 품목별로 보관료(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int mergeGvrntaxRate(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fsi.whbyItembyChargAmtDAO.mergeGvrntaxRate", mapParam);
    }
}
