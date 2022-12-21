package com.hwfs.ft.fdm.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 입고정보를 등록 관리하는 InventoryMgmtDeliver DAO
 *
 * @ClassName InventoryMgmtDeliverDAO.java
 * @Description InventoryMgmtDeliverDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.09   	KJJ        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재도매 KJJ
 * @since 2015.04.09
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ft/fdm/inventoryMgmtDeliverDAO")
public class InventoryMgmtDeliverDAO extends DefaultDAO {

    /**
     *구매 품의 마스터 시퀀스을 조회한다.
     *
     * @param
     * @return
     * @throws Exception
     */
    public String getInventoryMgmtDeliverS(Map<String, Object> parameter) {
        return (String) super.queryForObject("ft.fdm.inventoryMgmtDeliverDAO.getInventoryMgmtDeliverS", parameter, null);
    }

    /**
     * 입고정보를 등록 관리한다. 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fdm.inventoryMgmtDeliverDAO.selectList", mapParam);
    }

    /**
     * 입고정보를 등록 관리한다.(을)를 등록한다.
     *
     * @param mapParam
     * @return
     */
    public int insert(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.inventoryMgmtDeliverDAO.insert", mapParam);
    }

    /**
     * 입고정보를 등록 관리한다.(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int update(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.inventoryMgmtDeliverDAO.update", mapParam);
    }

    /**
     * 입고정보를 등록 관리한다.(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateWhMoveData(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.inventoryMgmtDeliverDAO.updateWhMoveData", mapParam);
    }

    /**
     * 입고정보를 반품정보 관리한다.(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateRmaData(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.inventoryMgmtDeliverDAO.updateRmaData", mapParam);
    }

    /**
     * 입고정보를 등록 관리한다.(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateDeliverAmt(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.inventoryMgmtDeliverDAO.updateDeliverAmt", mapParam);
    }

    /**
     * 입고정보를 등록 관리한다.(을)를 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateMoveDeliverAmt(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.inventoryMgmtDeliverDAO.updateMoveDeliverAmt", mapParam);
    }

    /**
     * 입고정보를 등록 관리한다.(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int delete(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.inventoryMgmtDeliverDAO.delete", mapParam);
    }

    /**
     * 입고정보(내수)를 등록 관리한다.(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int deleteDmtDeliver(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.inventoryMgmtDeliverDAO.deleteDmtDeliver", mapParam);
    }

    /**
     * 입고정보를 등록 관리한다.(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int cancelDeliver(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.inventoryMgmtDeliverDAO.cancelDeliver", mapParam);
    }

    /**
     * 입고정보를 등록 관리한다. 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectReceiveRegList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fdm.inventoryMgmtDeliverDAO.selectReceiveRegList", mapParam);
    }

    /**
     * 부대비 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectOtherList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fdm.inventoryMgmtDeliverDAO.selectOtherList", mapParam);
    }

    /**
     * 부대비 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectCancelOtherAmtDivList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fdm.inventoryMgmtDeliverDAO.selectCancelOtherAmtDivList", mapParam);
    }

    /**
     * 재고현황 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectInventoryStatusList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fdm.inventoryMgmtDeliverDAO.selectInventoryStatusList", mapParam);
    }

    /**
     * 재고현황(외부거래처) 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectInventoryStatusCustList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fdm.inventoryMgmtDeliverDAO.selectInventoryStatusCustList", mapParam);
    }


    /**
     * 부대비배부 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectDeliverNumOtheramtDivListPop(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fdm.inventoryMgmtDeliverDAO.selectDeliverNumOtheramtDivListPop", mapParam);
    }

    /**
     * 부대비배부 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectDeliverNumOtheramtDivListPop2(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fdm.inventoryMgmtDeliverDAO.selectDeliverNumOtheramtDivListPop2", mapParam);
    }
    /**
     * 재고조정 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectInventoryControlPop(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fdm.inventoryMgmtDeliverDAO.selectInventoryControlPop", mapParam);
    }

    /**
     * 반품 목록을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectRmaPop(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fdm.inventoryMgmtDeliverDAO.selectRmaPop", mapParam);
    }

    /**
     * 부대비 배부된 합계 수량을 조회
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectSumtDeliverList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("ft.fdm.inventoryMgmtDeliverDAO.selectSumtDeliverList", mapParam);
    }

    /**
     * 부대비 배부된 합계 수량을 조회
     *
     * @param mapParam
     * @return
     */
    public int getItemSeq(Map<String, Object> mapParam) throws Exception {
        return super.queryForInt("ft.fdm.inventoryMgmtDeliverDAO.getItemSeq", mapParam);
    }


    /**
     * 입고정보를 출고대기수량(중량) 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateReleaseWaitQuantity(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.inventoryMgmtDeliverDAO.updateReleaseWaitQuantity", mapParam);
    }

    /**
     * 입고정보를 출고대기수량(중량) 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateOrderRemainQuantity(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.inventoryMgmtDeliverDAO.updateOrderRemainQuantity", mapParam);
    }

    /**
     * 입고정보를 출고완료수량(중량) 수정한다.
     *
     * @param mapParam
     * @return
     */
    public int updateReleaseEndQuantity(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.inventoryMgmtDeliverDAO.updateReleaseEndQuantity", mapParam);
    }

    /**
     * 환입시 입고수량을 수정한다
     *
     * @param mapParam
     * @return
     */
    public int updatDeliverQuantity(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.inventoryMgmtDeliverDAO.updatDeliverQuantity", mapParam);
    }

    /**
     * 중량변경에 따른 입고금액을 수정한다
     *
     * @param mapParam
     * @return
     */
    public int updatDeliverAmt(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.inventoryMgmtDeliverDAO.updatDeliverAmt", mapParam);
    }

    /**
     * 재고조정 누적 수량(을)를 수정
     *
     * @param mapParam
     * @return
     */
    public int updateInventoryControlQuantity(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.inventoryMgmtDeliverDAO.updateInventoryControlQuantity", mapParam);
    }


    /**
     *관세율을 조회한다.
     *
     * @param
     * @return
     * @throws Exception
     */
    public Record select(Map<String, Object> parameter) {
//        return (String) super.queryForObject("ft.fdm.entryItemDetailDAO.getGvrntaxRate", parameter, null);
        return super.queryForRecord("ft.fdm.inventoryMgmtDeliverDAO.selectList", parameter);
    }

    /**
     *업장에 custcd 가져오기
     *
     * @param
     * @return
     * @throws Exception
     */
    public Record selectCustCd(Map<String, Object> parameter) {
        return super.queryForRecord("ft.fdm.inventoryMgmtDeliverDAO.selectCustCd", parameter);
    }

    /**
     * 가입고정보를 등록 관리한다.(을)를 삭제한다.
     *
     * @param mapParam
     * @return
     */
    public int deleteGaDeliver(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.inventoryMgmtDeliverDAO.deleteGaDeliver", mapParam);
    }

    /**
     * 수입원가를 조회한다.
     *
     * @param mapParam
     * @return
     */
    public Record selectIncomeCst(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecord("ft.fdm.inventoryMgmtDeliverDAO.selectIncomeCst", mapParam);
    }

    /**
     * 수입원가를 조회한다.
     *
     * @param mapParam
     * @return
     */
    public Record selectIncomeCst2(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecord("ft.fdm.inventoryMgmtDeliverDAO.selectIncomeCst2", mapParam);
    }
    /**
     * 주문테이블 수입원가 보정작업한다.
     *
     * @param mapParam
     * @return
     */
    public int updateBuycst(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.inventoryMgmtDeliverDAO.updateBuycst", mapParam);
    }

    /**
     * 출고테이블 수입원가 보정작업한다.
     *
     * @param mapParam
     * @return
     */
    public int updateBuycst2(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.inventoryMgmtDeliverDAO.updateBuycst2", mapParam);
    }

    /**
     * 출고테이블 수입원가 보정작업한다.
     *
     * @param mapParam
     * @return
     */
    public int updateBuycst3(Map<String, Object> mapParam) throws Exception {
        return super.update("ft.fdm.inventoryMgmtDeliverDAO.updateBuycst3", mapParam);
    }

    /**
     * 출고건수을 조회
     *
     * @param mapParam
     * @return
     */
    public int getReleaseCnt(Map<String, Object> mapParam) throws Exception {
        return super.queryForInt("ft.fdm.inventoryMgmtDeliverDAO.getReleaseCnt", mapParam);
    }
}
