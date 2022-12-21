package com.hwfs.ft.fdm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 입고 부대비 배부 정보를 등록 관리하는 DeliveritemOtherAmtDiv DAO
 *
 * @ClassName DeliveritemOtherAmtDivDAO.java
 * @Description DeliveritemOtherAmtDivDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.16   	kjj        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재도매 kjj
 * @since 2015.04.16
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ft/fdm/deliveritemOtherAmtDivDAO")
public class DeliveritemOtherAmtDivDAO extends DefaultDAO {

    /**
     * 입고 부대비 배부 정보를 등록 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fdm.deliveritemOtherAmtDivDAO.selectList", mapParam);
    }

    /**
     * 입고 부대비 배부 정보를 등록 관리(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insert(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.deliveritemOtherAmtDivDAO.insert", mapParam);
    }

    /**
     * 입고 부대비 배부 정보를 등록 관리(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insertDiv(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.deliveritemOtherAmtDivDAO.insertDiv", mapParam);
    }
    /**
     * 입고 부대비 배부 정보를 등록 관리(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateDivAmt(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.deliveritemOtherAmtDivDAO.updateDivAmt", mapParam);
    }

    /**
     * 입고 부대비 배부 정보를 등록 관리(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int update(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.deliveritemOtherAmtDivDAO.update", mapParam);
    }


    /**
     * 입고 부대비 배부 정보를 등록 관리(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateLastDivAmt(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.deliveritemOtherAmtDivDAO.updateLastDivAmt", mapParam);
    }
    /**
     * 입고 부대비 배부 정보를 등록 관리(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int delete(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.deliveritemOtherAmtDivDAO.delete", mapParam);
    }
    /**
     * 입고 부대비 배부 정보를 등록 관리(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int deleteDeptMngmv(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.deliveritemOtherAmtDivDAO.deleteDeptMngmv", mapParam);
    }
    /**
     * 입고 부대비 배부 정보를 등록 관리(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int cancelDeliver(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.deliveritemOtherAmtDivDAO.cancelDeliver", mapParam);
    }

    /**
     * 입고 부대비 배부 정보를 삭제 한다.
     *
     * @param mapParam
     * @return
     */
    public int cancelOtherAmtDiv(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.deliveritemOtherAmtDivDAO.cancelOtherAmtDiv", mapParam);
    }

    /**
     * 입고 부대비 배부 순번을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public int getDivSeq(Map<String, Object> mapParam) throws Exception {
        return super.queryForInt("ft.fdm.deliveritemOtherAmtDivDAO.getDivSeq", mapParam);

    }

    /**
     *부대비 배부 총금액을 조회한다.
     *
     * @param
     * @return
     * @throws Exception
     */
    public long getOtherAmt(Map<String, Object> parameter) {
        return (long) super.queryForLong("ft.fdm.deliveritemOtherAmtDivDAO.getOtherAmt", parameter);
    }

    /**
     *부대비 배부 총금액을 조회한다.
     *
     * @param
     * @return
     * @throws Exception
     */
    public long getTariffAmt(Map<String, Object> parameter) {
        return (long) super.queryForLong("ft.fdm.deliveritemOtherAmtDivDAO.getTariffAmt", parameter);
    }

    /**
     * 입고 부대비 배부 정보를 등록 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList2(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fdm.deliveritemOtherAmtDivDAO.selectList2", mapParam);
    }

    /**
     * 입고 부대비 배부 순번을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public int getDiffOfDate(Map<String, Object> mapParam) throws Exception {
        return super.queryForInt("ft.fdm.deliveritemOtherAmtDivDAO.getDiffOfDate", mapParam);

    }
}
