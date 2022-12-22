package com.hwfs.ft.fts.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 판매 주문내역에 대하여 출고(품목)를 관리하는 ReleaseItemMgmt DAO
 *
 * @ClassName ReleaseItemMgmtDAO.java
 * @Description ReleaseItemMgmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.30   	kjj        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재도매 kjj
 * @since 2015.04.30
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ft/fts/releaseItemMgmtDAO")
public class ReleaseItemMgmtDAO extends DefaultDAO {

    /**
     * 판매 주문내역에 대하여 출고(품목)를 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fts.releaseItemMgmtDAO.selectList", mapParam);
    }



    /**
     * 판매 주문내역에 대하여 출고(품목)를 관리(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insert(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.releaseItemMgmtDAO.insert", mapParam);
    }

    /**
     * 판매 주문내역에 대하여 출고(품목)를 관리(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int update(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.releaseItemMgmtDAO.update", mapParam);
    }

    /**
     * 판매 주문내역에 대하여 출고(품목)를 관리(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int delete(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.releaseItemMgmtDAO.delete", mapParam);
    }

    public int getReleaseMgmtCnt(Map<String, Object> mapParam) throws Exception {
        return super.queryForInt("ft.fts.releaseItemMgmtDAO.getReleaseMgmtCnt", mapParam);
    }


    /**
     * 입고(재고)를 판매 주문(품목)에 대하여 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public Record selectReleaseItemMgmtInfo(Map<String, Object> mapParam) {
        return super.queryForRecord("ft.fts.releaseItemMgmtDAO.selectReleaseItemMgmtInfo", mapParam);
    }

    /**
     * 판매 주문내역에 대하여 환입 처리한다.
     *
     * @param mapParam
     * @return
     */
    public int releaseWhgChg(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.releaseItemMgmtDAO.releaseWhgChg", mapParam);
    }


    /**
     * 판매 주문내역에 대하여 출고승인 처리한다.
     *
     * @param mapParam
     * @return
     */
    public int releaseApprov(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.releaseItemMgmtDAO.releaseApprov", mapParam);
    }

    /**
     * 판매 주문내역에 대하여 출고확정 처리한다.
     *
     * @param mapParam
     * @return
     */
    public int releaseConfirm(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.releaseItemMgmtDAO.releaseConfirm", mapParam);
    }

    /**
     * 중량변경건 실중량 출고확정 취소시 NULL 처리한다.
     *
     * @param mapParam
     * @return
     */
    public int updateRealWgt(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.releaseItemMgmtDAO.updateRealWgt", mapParam);
    }

    /**
     * 환입시 출고수량(중량) 업데이트 처리한다.
     *
     * @param mapParam
     * @return
     */
    public int updateReleaseQuantity(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.releaseItemMgmtDAO.updateReleaseQuantity", mapParam);
    }

    /**
     * 판매 주문내역에 대하여 단가변경 처리한다.
     *
     * @param mapParam
     * @return
     */
    public int releaseUpriceChg(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.releaseItemMgmtDAO.releaseUpriceChg", mapParam);
    }

    /**
     * 입고(재고)를 판매 주문(품목)에 대하여 관리 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public Record selectSumOrderWgtInfo(Map<String, Object> mapParam) {
        return super.queryForRecord("ft.fts.releaseItemMgmtDAO.selectSumOrderWgtInfo", mapParam);
    }

    /**
     * 판매 주문내역에 대하여 매출확정 처리한다.
     *
     * @param mapParam
     * @return
     */
    public int releaseSalsConfirm(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.releaseItemMgmtDAO.releaseSalsConfirm", mapParam);
    }

    /**
     * 판매 주문내역에 대하여 출고확정 처리한다.
     *
     * @param mapParam
     * @return
     */
    public int releaseConfirmDeptMngmv(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fts.releaseItemMgmtDAO.releaseConfirmDeptMngmv", mapParam);
    }
}
