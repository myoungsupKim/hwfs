package com.hwfs.ft.fts.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ft.fdm.dao.InventoryMgmtDeliverDAO;
import com.hwfs.ft.fts.dao.SaleOrderCancelLogDAO;
import com.hwfs.ft.fts.dao.SaleOrderItemMgmtDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 주문 취소를 관리하는 SaleOrderCancelLog Service Implementation
 *
 * @ClassName SaleOrderCancelLogServiceImpl.java
 * @Description SaleOrderCancelLogServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.04    KJJ        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재도매 KJJ
 * @since 2015.06.04
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ft/fts/saleOrderCancelLogService")
public class SaleOrderCancelLogServiceImpl extends DefaultServiceImpl implements SaleOrderCancelLogService {

    /** LogService */
    private final Logger logger = LoggerFactory.getLogger (this.getClass());

    /** SaleOrderCancelLogDAO Bean 생성 */
    @Resource(name = "/ft/fts/saleOrderCancelLogDAO")
    private SaleOrderCancelLogDAO saleOrderCancelLogDAO;

    /** SaleOrderItemMgmtDAO Bean 생성 */
    @Resource(name = "/ft/fts/saleOrderItemMgmtDAO")
    private SaleOrderItemMgmtDAO saleOrderItemMgmtDAO;

    /** InventoryMgmtDeliverDAO Bean 생성 */
    @Resource(name = "/ft/fdm/inventoryMgmtDeliverDAO")
    private InventoryMgmtDeliverDAO inventoryMgmtDeliverDAO;

    /**
     * 주문 취소를 관리 목록을 조회한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
     * </pre>
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return saleOrderCancelLogDAO.selectList(mapParam);
    }

    /**
     * 주문 취소를 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    @SuppressWarnings("unchecked")
    public int saveList(DataSetMap dsSearch, DataSetMap list) throws Exception {
        int insRowCnt = 0;
        int updRowCnt = 0;
        int delRowCnt = 0;
        logger.info(" dsSearch.size()  ::"+dsSearch.size() );
        for (int i = 0 ; i < dsSearch.size() ; i++) {
            Map<String, Object> rowData = dsSearch.get(i);
            int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            //Insert 처리
            Map<String, Object> saleOrderItemMap = new HashMap ();
            double cancelQuantity = Double.parseDouble(LimsUtil.checkNull(rowData.get("cancelQuantity"),"0").toString());
            double cancelWgt = Double.parseDouble(LimsUtil.checkNull(rowData.get("cancelWgt"),"0").toString());
            double orgCancelQuantity = Double.parseDouble(LimsUtil.checkNull(rowData.get("orgCancelQuantity"),"0").toString());
            double orgCancelWgt = Double.parseDouble(LimsUtil.checkNull(rowData.get("orgCancelWgt"),"0").toString());

//            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                rowData.put("saleOrderStatus", "20");	//구매주문상태: 취소
                insRowCnt += saleOrderCancelLogDAO.insert(rowData);

                logger.info(" cancelQuantity1 ::"+orgCancelQuantity+"//"+cancelQuantity+"//"+rowData.get("deliverNum"));
                saleOrderItemMap.put("flag", "U");
                saleOrderItemMap.put("deliverNum", rowData.get("deliverNum"));
                saleOrderItemMap.put("orderRemainQuantity", -cancelQuantity);
                saleOrderItemMap.put("orderRemainWgt", -cancelWgt);

                updRowCnt += saleOrderItemMgmtDAO.updateSaleOrderCancelQuantity(rowData);	//주문판매 취소건수 업데이트


                updRowCnt += inventoryMgmtDeliverDAO.updateOrderRemainQuantity(saleOrderItemMap); //입고 TABLE에서 입고번호에 해당하는 Row의 주문잔여수량(중량) 차감
//            }
//            //Update 처리
//            else if (rowType == DataSet.ROW_TYPE_UPDATED) {
//                updRowCnt += saleOrderCancelLogDAO.update(rowData);
//
//                Record rd = saleOrderCancelLogDAO.getCancelSumInfo(rowData);
//                logger.info("sumCancelQuantity :"+rd.getFloat("sumCancelQuantity") +" sumCancelWgt :"+ rd.getFloat("sumCancelWgt"));
//                if ( rd.getFloat("sumCancelQuantity") ==0 && rd.getFloat("sumCancelWgt") ==0 )
//                {
//                    rowData.put("saleOrderStatus", "10");	//구매주문상태: 주문등록
//                    updRowCnt += saleOrderItemMgmtDAO.updateSaleOrderStatus(rowData);
//                }
//                else
//                {
//                    rowData.put("saleOrderStatus", "20");	//구매주문상태: 취소
//                    updRowCnt += saleOrderItemMgmtDAO.updateSaleOrderStatus(rowData);
//                }
//                logger.info(" cancelQuantity2 ::"+orgCancelQuantity+"//"+cancelQuantity);
//
//                float gapQuantity = orgCancelQuantity - cancelQuantity;
//                logger.info("gapQuantity :"+ gapQuantity);
//                float gapWgt = orgCancelWgt - cancelWgt;
//                logger.info("gapWgt :"+ gapWgt);
//
//                saleOrderItemMap.put("flag", "U");
//                saleOrderItemMap.put("deliverNum", rowData.get("deliverNum"));
//                saleOrderItemMap.put("orderRemainQuantity", gapWgt);
//                saleOrderItemMap.put("orderRemainWgt", gapWgt);
//
//                updRowCnt += saleOrderItemMgmtDAO.updateSaleOrderCancelQuantity(rowData);	//주문판매 취소건수 업데이트
//
//            }
//            //Delete 처리.
//            else if (rowType == DataSet.ROW_TYPE_DELETED) {
//                delRowCnt += saleOrderCancelLogDAO.delete(rowData);
//                saleOrderItemMap.put("flag", "U");
//                saleOrderItemMap.put("deliverNum", rowData.get("deliverNum"));
//                saleOrderItemMap.put("orderRemainQuantity", cancelQuantity);
//                saleOrderItemMap.put("orderRemainWgt", cancelWgt);
//
//                Record rd = saleOrderCancelLogDAO.getCancelSumInfo(rowData);
//                if ( rd.getFloat("sumCancelQuantity") ==0 && rd.getFloat("sumCancelWgt") ==0 )
//                {
//                    rowData.put("saleOrderStatus", "10");	//구매주문상태: 주문등록
//                    updRowCnt += saleOrderItemMgmtDAO.updateSaleOrderStatus(rowData);
//                }
//                else
//                {
//                    rowData.put("saleOrderStatus", "20");	//구매주문상태: 취소
//                    updRowCnt += saleOrderItemMgmtDAO.updateSaleOrderStatus(rowData);
//                }
//
//                updRowCnt += saleOrderItemMgmtDAO.updateSaleOrderCancelQuantity(rowData);	//주문판매 취소건수 업데이트
//            }
        }

        return insRowCnt + updRowCnt + delRowCnt;
    }
}
