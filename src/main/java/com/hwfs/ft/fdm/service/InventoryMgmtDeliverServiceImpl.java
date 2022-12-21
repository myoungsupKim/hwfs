package com.hwfs.ft.fdm.service;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.cmn.util.DTOUtil;
import com.hwfs.ft.fdm.dao.DeliveritemOtherAmtDivDAO;
import com.hwfs.ft.fdm.dao.EntryMstDAO;
import com.hwfs.ft.fdm.dao.InventoryControlLogDAO;
import com.hwfs.ft.fdm.dao.InventoryMgmtDeliverDAO;
import com.hwfs.ft.ftp.dao.PoOrderOtherAmtDAO;
import com.hwfs.ft.fts.dao.ReleaseItemMgmtDAO;
import com.hwfs.ft.fts.dao.ReleaseMgmtDAO;
import com.hwfs.ft.fts.dao.SaleOrderDAO;
import com.hwfs.ft.fts.dao.SaleOrderItemMgmtDAO;
import com.hwfs.ft.fts.service.SaleOrderService;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.tobesoft.xplatform.data.DataSet;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

/**
* 입고정보를 등록 관리하는 InventoryMgmtDeliver Service Implementation
*
* @ClassName InventoryMgmtDeliverServiceImpl.java
* @Description InventoryMgmtDeliverServiceImpl Class
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2015.04.09    KJJ        최초생성
* </pre>
* @author FC종합전산구축 : 식재도매 KJJ
* @since 2015.04.09
* @version 1.0
* @see
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
@Service("/ft/fdm/inventoryMgmtDeliverService")
public class InventoryMgmtDeliverServiceImpl extends DefaultServiceImpl implements InventoryMgmtDeliverService {

    /** LogService */
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    /** InventoryMgmtDeliverDAO Bean 생성 */
    @Resource(name = "/ft/fdm/inventoryMgmtDeliverDAO")
    private InventoryMgmtDeliverDAO inventoryMgmtDeliverDAO;

    /** EntryMstDAO Bean 생성 */
    @Resource(name = "/ft/fdm/entryMstDAO")
    private EntryMstDAO entryMstDAO;

    /** DeliveritemOtherAmtDivDAO Bean 생성 */
    @Resource(name = "/ft/fdm/deliveritemOtherAmtDivDAO")
    private DeliveritemOtherAmtDivDAO deliveritemOtherAmtDivDAO;

    /** PoOrderOtherAmtDAO Bean 생성 */
    @Resource(name = "/ft/ftp/poOrderOtherAmtDAO")
    private PoOrderOtherAmtDAO poOrderOtherAmtDAO;

    /** PoOrderOtherAmtDAO Bean 생성 */
    @Resource(name = "/ft/fdm/inventoryControlLogDAO")
    private InventoryControlLogDAO inventoryControlLogDAO;

    /**
     * 입고정보를 등록 관리한다. 목록을 조회한다.
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
        return inventoryMgmtDeliverDAO.selectList(mapParam);
    }

    /**
     * 구매(내수) 입고정보를 등록 관리한다. DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
    public int saveDmtDeliver(DataSetMap dsPoOrderInfo, DataSetMap dsItemList) throws Exception {
        int insRowCnt = 0;

        logger.info("list.size() ::" + dsItemList.size());
        for (int i = 0; i < dsItemList.size(); i++) {
            Map<String, Object> rowData = dsItemList.get(i);
            //int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            //PO-300(100)-YYMM-SEQ(4):내수(300)/수입(100)
            String deliverNum = inventoryMgmtDeliverDAO.getInventoryMgmtDeliverS(rowData);
            String currYymm = LimsUtil.getDate("yyyyMM");
            String currYymmdd = LimsUtil.getDate("yyyyMMdd");
            deliverNum = "ST" + currYymm + deliverNum;
            logger.info("deliverNum ::" + deliverNum);
            rowData.put("deliverNum", deliverNum);
            rowData.put("deliverType", "10"); //발주입고
            rowData.put("deliverStatus", "20"); //입고
            rowData.put("firstDeliverDate", rowData.get("firstDeliverDate")); //최초입고일자
            rowData.put("currentWhDeliverDate", rowData.get("currentWhDeliverDate")); //현재 창고 입고 일자
            rowData.put("saleType", dsPoOrderInfo.get(0).get("saleType")); //판매 유형
            rowData.put("poType", dsPoOrderInfo.get(0).get("poType")); //구매 형태
            rowData.put("attachDept", dsPoOrderInfo.get(0).get("attachDept")); //귀속 부서
            rowData.put("entryNum", " "); //통관번호
            rowData.put("entryItemSeq", 0); //통관번호순번
            rowData.put("poOrderNum", dsPoOrderInfo.get(0).get("poOrderNum")); //구매 주문 번호
            rowData.put("splrCd", dsPoOrderInfo.get(0).get("splrCd")); //매입처 코드
            rowData.put("splrNm", dsPoOrderInfo.get(0).get("splrNm")); //매입처 명
            rowData.put("salsplceCd", dsPoOrderInfo.get(0).get("salsplceCd")); //매출처 코드
            rowData.put("salsplceNm", dsPoOrderInfo.get(0).get("salsplceNm")); //매출처 명
            rowData.put("intRate", dsPoOrderInfo.get(0).get("intRate")); //금리
            rowData.put("deliverUpriceForeignCurrenc", rowData.get("uprice")); //입고 단가 외화
            rowData.put("deliverUpriceKrw", rowData.get("uprice")); //입고 단가 원화
            rowData.put("deliverQuantity", rowData.get("quantity")); //입고 수량
            rowData.put("deliverWgt", rowData.get("wgt")); //입고 중량
            rowData.put("deliverAmt", rowData.get("wonwtrAmt")); //입고 금액
            rowData.put("lastSaleEdate", dsPoOrderInfo.get(0).get("saleEdate")); //최종판매일자
            rowData.put("poProposalNum", dsPoOrderInfo.get(0).get("poProposalNum")); //구매 품의 번호

            logger.info("dsItemList.size() ::" + dsItemList.size());
            logger.info("rowData ::" + rowData);
            //Insert 처리
            insRowCnt += inventoryMgmtDeliverDAO.insert(rowData);
        }

        return insRowCnt;
    }

    /**
     * 구매(내수) 입고정보를 삭제 관리한다.
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
    public int deleteDmtDeliver(DataSetMap dsPoOrderInfo, DataSetMap dsItemList) throws Exception {
        int delRowCnt = 0;

        logger.info("list.size() ::" + dsItemList.size());
        for (int i = 0; i < dsItemList.size(); i++) {
            Map<String, Object> rowData = dsItemList.get(i);
            //delete 처리
            delRowCnt += inventoryMgmtDeliverDAO.deleteDmtDeliver(rowData);
        }

        return delRowCnt;
    }

    /**
     * 입고정보를 등록 관리한다. DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
    public int saveList(DataSetMap list) throws Exception {
        int insRowCnt = 0;
        int updRowCnt = 0;
        int delRowCnt = 0;

        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> rowData = list.get(i);
            int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            //Insert 처리
            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                insRowCnt += inventoryMgmtDeliverDAO.insert(rowData);
            }
            //Update 처리
            else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                updRowCnt += inventoryMgmtDeliverDAO.update(rowData);
            }
            //Delete 처리.
            else if (rowType == DataSet.ROW_TYPE_DELETED) {
                delRowCnt += inventoryMgmtDeliverDAO.delete(rowData);
            }
        }

        return insRowCnt + updRowCnt + delRowCnt;
    }

    /**
     * 가입고정보를 등록 관리한다. DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
    public int saveReceiveReg(DataSetMap dsList) throws Exception {
        int insRowCnt = 0;
        int updRowCnt = 0;
        int delRowCnt = 0;
        logger.info("list.size() ::" + dsList.size());

        for (int i = 0; i < dsList.size(); i++) {
            Map<String, Object> rowData = dsList.get(i);
            int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            //Insert 처리

            String currYymmdd = LimsUtil.getDate("yyyyMMdd");
            rowData.put("deliverType", "10"); //발주입고
            rowData.put("deliverStatus", "10"); //가입고
            rowData.put("firstDeliverDate", currYymmdd); //최초입고일자
            rowData.put("currentWhDeliverDate", currYymmdd); //현재 창고 입고 일자
            rowData.put("saleType", rowData.get("saleType")); //판매 유형
            rowData.put("poType", rowData.get("poType")); //구매 형태
            rowData.put("attachDept", rowData.get("attachDept")); //귀속 부서
            rowData.put("entryNum", " "); //통관번호
            rowData.put("entryItemSeq", 0); //통관번호순번

            logger.info("itemSeq :" + rowData.get("itemSeq"));
            if (rowData.get("itemSeq") == null) {
                int itemSeq = inventoryMgmtDeliverDAO.getItemSeq(rowData);
                logger.info("itemSeq2 :" + itemSeq);
                rowData.put("itemSeq", itemSeq); //item seq
            }

            rowData.put("poOrderNum", rowData.get("poOrderNum")); //구매 주문 번호
            rowData.put("splrCd", rowData.get("splrCd")); //매입처 코드
            rowData.put("splrNm", rowData.get("splrNm")); //매입처 명
            rowData.put("salsplceCd", rowData.get("salsplceCd")); //매출처 코드
            rowData.put("salsplceNm", rowData.get("salsplceNm")); //매출처 명
            rowData.put("unit", rowData.get("unit")); //단위
            rowData.put("intRate", rowData.get("intRate")); //금리
            rowData.put("lshipExchangeRate", rowData.get("exchangeRate")); //환율

            rowData.put("deliverUpriceForeignCurrenc", rowData.get("uprice")); //입고 단가 외화
            rowData.put("deliverUpriceKrw", rowData.get("krwUprice")); //입고 단가 원화
            rowData.put("deliverQuantity", rowData.get("entryReqQuantity")); //입고 수량
            rowData.put("deliverWgt", rowData.get("entryReqWgt")); //입고 중량
            rowData.put("deliverAmt", rowData.get("entryReqWonwtrAmt")); //입고 금액
            //rowData.put("deliverAmt", rowData.get("krwWonwtrAmt")); //2016.01.09 USD로 저장되던것을 원화로 변경하니 수입통관시 금액 오류가 발생함, 기존 유지
            rowData.put("deliverAmtKrw", rowData.get("krwWonwtrAmt")); //입고 금액원화
            rowData.put("poProposalNum", rowData.get("poProposalNum")); //구매 품의 번호

            logger.info("dsList.size() ::" + dsList.size());
            logger.info("rowData ::" + rowData);

            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                //Insert 처리
                //PO-300(100)-YYMM-SEQ(4):내수(300)/수입(100)
                String deliverNum = inventoryMgmtDeliverDAO.getInventoryMgmtDeliverS(rowData);
                String currYymm = LimsUtil.getDate("yyyyMM");
                deliverNum = "ST" + currYymm + deliverNum;

                logger.info("deliverNum ::" + deliverNum);
                rowData.put("deliverNum", deliverNum);
                insRowCnt += inventoryMgmtDeliverDAO.insert(rowData);
            }
            //Update 처리
            else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                updRowCnt += inventoryMgmtDeliverDAO.update(rowData);
            }
            //Delete 처리.
            else if (rowType == DataSet.ROW_TYPE_DELETED) {
                delRowCnt += inventoryMgmtDeliverDAO.delete(rowData);
            }

        }

        return insRowCnt + updRowCnt + delRowCnt;
    }

    /**
     * 가입고 관리한다. 목록을 조회한다.
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
    public RecordSet selectReceiveRegList(Map<String, Object> mapParam) throws Exception {
        return inventoryMgmtDeliverDAO.selectReceiveRegList(mapParam);
    }

    /**
     * 수입면허 입고처리 한다. DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
    public int saveDeliver(DataSetMap dsList) throws Exception {
        int insRowCnt = 0;
        logger.info("list.size() ::" + dsList.size());
        String currYymmdd = LimsUtil.getDate("yyyyMMdd");

        Map<String, Object> deliverData = new HashMap<String, Object>();
        Map<String, Object> divData = new HashMap<String, Object>();
        Map<String, Object> paramMap = new HashMap<String, Object>();
        Map<String, Object> accumParamMap = new HashMap<String, Object>();

        logger.info("dsList.size() ::" + dsList.size());
        for (int i = 0; i < dsList.size(); i++) {
            Map<String, Object> rowData = dsList.get(i);

            RecordSet deliverRs = entryMstDAO.selectDeliverList(rowData); //수입면허 내역
            String lastSaleEdate = rowData.get("lastSaleEdate").toString();
            logger.info("lastSaleEdate ::" + lastSaleEdate);
            logger.info("deliverRs.size() ::" + deliverRs.size());
            String firstDeliverDate = rowData.get("firstDeliverDate").toString();
            logger.info("firstDeliverDate ::" + firstDeliverDate);

            paramMap.put("poOrderNum", rowData.get("poOrderNum"));

            for (int deliverRow = 0; deliverRow < deliverRs.size(); deliverRow++) {
                Map<String, Object> deliverRc = deliverRs.get(deliverRow);
                //Insert 처리

                deliverData.put("deliverType", "10"); //발주입고
                deliverData.put("deliverStatus", "20"); //입고
                deliverData.put("firstDeliverDate", firstDeliverDate); //최초입고일자
                deliverData.put("currentWhDeliverDate", firstDeliverDate); //현재 창고 입고 일자
                deliverData.put("saleType", deliverRc.get("saleType")); //판매 유형
                deliverData.put("poType", deliverRc.get("poType")); //구매 형태
                deliverData.put("attachDept", deliverRc.get("attachDept")); //귀속 부서
                deliverData.put("entryNum", deliverRc.get("entryNum")); //통관번호
                deliverData.put("entryItemSeq", deliverRc.get("entryItemSeq")); //통관번호순번
                deliverData.put("poOrderNum", deliverRc.get("poOrderNum")); //구매 주문 번호
                deliverData.put("itemSeq", deliverRc.get("itemSeq")); //품목 순번
                deliverData.put("itemCd", deliverRc.get("itemCd")); //품목 코드
                deliverData.put("itemNm", deliverRc.get("itemNm")); //품목 명
                deliverData.put("hsCd", deliverRc.get("hsCd")); //HS코드
                deliverData.put("splrCd", deliverRc.get("splrCd")); //매입처 코드
                deliverData.put("splrNm", deliverRc.get("splrNm")); //매입처 명
                deliverData.put("salsplceCd", deliverRc.get("salsplceCd")); //매출처 코드
                deliverData.put("salsplceNm", deliverRc.get("salsplceNm")); //매출처 명
                deliverData.put("whCd", deliverRc.get("whCd")); //창고 코드
                deliverData.put("whNm", deliverRc.get("whNm")); //창고 명
                deliverData.put("unit", deliverRc.get("unit")); //단위
                deliverData.put("lshipExchangeRate", deliverRc.get("exchangeRate")); //선적 환율(PO)
                deliverData.put("signExchangeRate", deliverRc.get("settleExchangeRate")); //결재 환율(대금결재)
                deliverData.put("intRate", deliverRc.get("intRate")); //금리
                deliverData.put("expectSalsGainrat", deliverRc.get("expectSalsGainRate")); //예상 매출 이익율

                deliverData.put("deliverUpriceForeignCurrenc", deliverRc.get("uprice")); //입고 단가 외화

                deliverData.put("deliverUpriceKrw", deliverRc.get("krwUprice")); //입고 단가 원화
                deliverData.put("deliverQuantity", deliverRc.get("entryReqQuantity")); //입고 수량
                deliverData.put("deliverWgt", deliverRc.get("entryReqWgt")); //입고 중량

                double wonwtrAmtKrw = Math.round(Double.parseDouble(deliverRc.get("wonwtrAmtKrw").toString())); //원물대
                double entryReqWonwtrAmt = Math.round(Double.parseDouble(deliverRc.get("entryReqWonwtrAmt").toString())); //통관금액(KRW)
                double totEntryReqWonwtrAmt = Math.round(Double.parseDouble(deliverRc.get("totEntryReqWonwtrAmt").toString())); //총 금액(USD)
                double totEntryReqWonwtrAmtKrw = Math.round(Double.parseDouble(deliverRc.get("totEntryReqWonwtrAmtKrw").toString())); //총 금액(KRW) 2016.01.09 추가
                double entryReqQuantity = Math.round(Double.parseDouble(deliverRc.get("entryReqQuantity").toString())); //입고될 수량
                double totEntryReqQuantity = Math.round(Double.parseDouble(deliverRc.get("totEntryReqQuantity").toString())); //원물대 누적합계
                double quantity = Math.round(Double.parseDouble(deliverRc.get("quantity").toString())); //원물대 수량

                DecimalFormat df = new DecimalFormat();
                logger.info("quantity :1:"+df.format(quantity) +" totEntryReqQuantity :"+ df.format(totEntryReqQuantity) +" entryReqQuantity :"+ df.format(entryReqQuantity));
                
                /*
                if ( quantity == (totEntryReqQuantity+entryReqQuantity)  )	//마지막으로 털릴때
                {
                    logger.info("deliverAmt :1:"+df.format(entryReqWonwtrAmt) +"-"+ df.format(totEntryReqWonwtrAmt) +"+"+ df.format(wonwtrAmtKrw) );
                    logger.info("deliverAmt :2:"+df.format(entryReqWonwtrAmt) +"*"+ df.format(entryReqQuantity) +"/"+ df.format(quantity) );
                    logger.info("deliverAmt :3:"+df.format(totEntryReqWonwtrAmt) +"-"+ df.format(wonwtrAmtKrw) );

                    double gap = totEntryReqWonwtrAmt +( Math.round(wonwtrAmtKrw * entryReqQuantity / quantity)) - wonwtrAmtKrw;		//누적 입고금액 + 이번에 입고될 금액 - 원물금액
                    logger.info("gap :::"+df.format(gap));	
                    double calDeliverAmt = Math.round(wonwtrAmtKrw * entryReqQuantity / quantity) -gap;		//원물대 보정
                    logger.info("calDeliverAmt :::"+df.format(Math.round(wonwtrAmtKrw * entryReqQuantity / quantity)));

                    deliverData.put("deliverAmt", calDeliverAmt ) ;	   //입고될 금액
                }
                else
                {
                    double calDeliverAmt = Math.round(wonwtrAmtKrw * entryReqQuantity / quantity);
                    logger.info("deliverAmt :4:"+df.format(wonwtrAmtKrw) +"*"+df.format(entryReqQuantity) +"/"+df.format(quantity)+"="+calDeliverAmt);
                    deliverData.put("deliverAmt", Math.round(wonwtrAmtKrw * entryReqQuantity / quantity)); //입고 금액
                }
                */
                
                if ( quantity == (totEntryReqQuantity+entryReqQuantity)  )	//마지막으로 털릴때
                {
                    logger.info("deliverAmt :1:"+df.format(entryReqWonwtrAmt) +"-"+ df.format(totEntryReqWonwtrAmtKrw) +"+"+ df.format(wonwtrAmtKrw) );
                    //logger.info("deliverAmt :2:"+df.format(entryReqWonwtrAmt) +"*"+ df.format(entryReqQuantity) +"/"+ df.format(quantity) );
                    //logger.info("deliverAmt :3:"+df.format(totEntryReqWonwtrAmt) +"-"+ df.format(wonwtrAmtKrw) );

                    double gap = totEntryReqWonwtrAmtKrw +( Math.round(wonwtrAmtKrw * entryReqQuantity / quantity)) - wonwtrAmtKrw;		//누적 입고금액 + 이번에 입고될 금액 - 원물금액
                    logger.info("gap :::"+df.format(gap));	
                    double calDeliverAmt = Math.round(wonwtrAmtKrw * entryReqQuantity / quantity) -gap;		//원물대 보정
                    logger.info("calDeliverAmt :::"+df.format(Math.round(wonwtrAmtKrw * entryReqQuantity / quantity)));

                    deliverData.put("deliverAmt", calDeliverAmt ) ;	   //입고될 금액
                }
                else
                {
                    double calDeliverAmt = Math.round(wonwtrAmtKrw * entryReqQuantity / quantity);
                    logger.info("deliverAmt :4:"+df.format(wonwtrAmtKrw) +"*"+df.format(entryReqQuantity) +"/"+df.format(quantity)+"="+calDeliverAmt);
                    deliverData.put("deliverAmt", calDeliverAmt ); //입고 금액
                }                

                deliverData.put("baeDeliverAmt", deliverRc.get("baeEntryReqWonwtrAmt")); //입고 금액(USD)
                deliverData.put("poProposalNum", deliverRc.get("poProposalNum")); //구매 품의 번호
                deliverData.put("incomeDtrDsctNum", deliverRc.get("incomeDtrDsctNum")); //수입 유통 식별 번호
                deliverData.put("estNo", deliverRc.get("estNo")); //EST 번호

                paramMap.put("poOrderNum", deliverRc.get("poOrderNum"));
                paramMap.put("entryNum", deliverRc.get("entryNum"));
                paramMap.put("itemCd", deliverRc.get("itemCd"));
                paramMap.put("itemSeq", deliverRc.get("itemSeq"));

                logger.info("deliverData ::" + deliverData);

                //Insert 처리
                //PO-300(100)-YYMM-SEQ(4):내수(300)/수입(100)
                String deliverNum = inventoryMgmtDeliverDAO.getInventoryMgmtDeliverS(deliverData);
                String currYymm = LimsUtil.getDate("yyyyMM");
                deliverNum = "ST" + currYymm + deliverNum;

                logger.info("deliverNum ::" + deliverNum);
                deliverData.put("deliverNum", deliverNum);
                deliverData.put("lastSaleEdate", lastSaleEdate); //최종판매종료일

//                String fiscalSlipcDate = LimsUtil.checkNull(poOrderOtherAmtDAO.getFiscalSlipcDate(paramMap), "");	    //20151026 2건 에러 발생 쓰이는데 없음
               // if ("10".equals(deliverRc.get("poType").toString()) && "".equals(fiscalSlipcDate)) //수입,통관수수료의 결재일자가 존재하지 않을시
                //{
                    //throw processException("ft.fts.fail.saleOrderList.nosignDd.alert"); //통관수수료의 결재일자가 존재하지 않습니다.	//차후주석 풀기
                    //fiscalSlipcDate = currYymmdd;
                //}


                //1.입고처리
                insRowCnt += inventoryMgmtDeliverDAO.insert(deliverData);

                //2.부대비 배부 대상 구매주문 부대비 조회 - 가입고(수량에 따른 원물금액아 달라졌음)와 일반일고의 원물금액 가져오는 부분을 달리하여야함
                RecordSet otherRs = inventoryMgmtDeliverDAO.selectOtherList(paramMap);

                if (otherRs.size() > 0) {
                    for (int otherRow = 0; otherRow < otherRs.size(); otherRow++) {
                        Map<String, Object> deliverRd = otherRs.get(otherRow);
                        double commAmt = Double.parseDouble(deliverRd.get("commAmt").toString()); //부대비 금액(수수료)
                        double sumWonwtrAmt = Double.parseDouble(deliverRd.get("sumWonwtrAmt").toString()); //원물금액합
                        double deliverAmt = Double.parseDouble(deliverData.get("baeDeliverAmt").toString()); //금번 입고된 원물금액

                        int divSeq = deliveritemOtherAmtDivDAO.getDivSeq(deliverData);

                        divData.put("divSeq", divSeq);
                        divData.put("divDate", currYymmdd);
                        divData.put("deliverNum", deliverData.get("deliverNum"));
                        divData.put("poOrderNum", deliverData.get("poOrderNum"));
                        divData.put("commClass", deliverRd.get("commClass"));
                        divData.put("otherAmtSeq", deliverRd.get("otherAmtSeq"));
                        deliverRd.get("basiNum"); //근거번호
                        double divAmt = 0;

                        logger.info("basiKind :" + deliverRd.get("basiKind").toString() + " / "
                                + deliverRc.get("blNum").toString() + " / " + deliverRd.get("basiNum"));
                        if ("BL".equals(deliverRd.get("basiKind").toString())) {
                            if (deliverRc.get("blNum").toString().equals(deliverRd.get("basiNum").toString())) {
                                divAmt = commAmt * deliverAmt / sumWonwtrAmt; //배부금액
                                divAmt = Math.ceil(divAmt); //원단위 절사 상관없이 마지막에 배부 잔액 배부

                                divData.put("divAmt", divAmt);
                                accumParamMap.put("divAccumAmt", divAmt);
                                logger.info("배부 금액111 :"+deliverRd.get("commClass")+"//"+ + commAmt + " * " + deliverAmt + " / "+ sumWonwtrAmt + " :" + divAmt);
                                deliveritemOtherAmtDivDAO.insert(divData); //부대비 배부

                                accumParamMap.put("poOrderNum", deliverRd.get("poOrderNum"));
                                accumParamMap.put("otherAmtSeq", deliverRd.get("otherAmtSeq"));
                                accumParamMap.put("commClass", deliverRd.get("commClass"));

                                //3.배부누적금액 UPDATE
                                poOrderOtherAmtDAO.updateDivAccumAmt(accumParamMap);

                                //4.po의 수수료 금액 합과 입고된 배부금액의 합이 같을때 마지막 배부되는 금액에 배부 잔액을 배부한다.
                                RecordSet sumtDeliverRs = inventoryMgmtDeliverDAO.selectSumtDeliverList(paramMap); //배부된 합계 수량을 조회

                                RecordSet divRs = poOrderOtherAmtDAO.selectList(divData);
                                logger.info("divRs :"+divRs.get(0).getDouble("commAmt") + "/2/" + divRs.get(0).getDouble("divAccumAmt") );
                                logger.info("마지막1 :" + sumtDeliverRs.get(0).getString("commAmtSum") + "//"
                                        + sumtDeliverRs.get(1).getString("commAmtSum"));
                                if ( divRs.get(0).getDouble("commAmt") < divRs.get(0).getDouble("divAccumAmt") )
                                {
                                    double balAlt = divRs.get(0).getDouble("divAccumAmt") - divRs.get(0).getDouble("commAmt");

                                    divData = new HashMap<String, Object>();
                                    divData.put("deliverNum", deliverData.get("deliverNum"));
                                    divData.put("divSeq", divSeq);
                                    divData.put("divAmt", divAmt - balAlt);
                                    divData.put("poOrderNum", deliverRd.get("poOrderNum"));
                                    divData.put("otherAmtSeq", deliverRd.get("otherAmtSeq"));
                                    divData.put("commClass", deliverRd.get("commClass"));
                                    logger.info("deliverNum ::::"+deliverData.get("deliverNum")+"///"+divAmt+"//"+ balAlt);
                                    //4.마지막 입고시 부대비 잔액 배부 UPDATE
                                    deliveritemOtherAmtDivDAO.update(divData);

                                    //5.배부누적 누적잔액 금액을 수수료 금액으로 UPDATE
                                    poOrderOtherAmtDAO.updateDivAccumAmtBalAlt(divData);
                                }
                            }
                        }
                        //근거종료(CL) : 들어온 그대로 다 배부됨 : 로직 확인 필요
                        else {
                            logger.info("incomeLicNum :"+deliverRc.get("incomeLicNum").toString()+" // basiNum :"+deliverRd.get("basiNum").toString()) ;
                            if (deliverRc.get("incomeLicNum").toString().equals(deliverRd.get("basiNum").toString())) {
                                double entryReqWonwtrAmtSum = Double.parseDouble(deliverRc.get("entryReqWonwtrAmtSum").toString()); //CL 입고금액합계
                                divAmt = commAmt * deliverAmt / entryReqWonwtrAmtSum; //배부금액
                                divAmt = Math.ceil(divAmt); //원단위 절사 상관없이 마지막에 배부 잔액 배부

                                divData.put("divAmt", divAmt);
                                accumParamMap.put("divAccumAmt", divAmt);
                                logger.info("배부 금액22 :" + commAmt + " * " + deliverAmt + " / "+ entryReqWonwtrAmtSum + " :" + divAmt);
                                deliveritemOtherAmtDivDAO.insert(divData); //부대비 배부

                                accumParamMap.put("poOrderNum", deliverRd.get("poOrderNum"));
                                accumParamMap.put("otherAmtSeq", deliverRd.get("otherAmtSeq"));
                                accumParamMap.put("commClass", deliverRd.get("commClass"));

                                //3.배부누적금액 UPDATE
                                poOrderOtherAmtDAO.updateDivAccumAmt(accumParamMap);

                                //4.po의 수수료 금액 합과 입고된 배부금액의 합이 같을때 마지막 배부되는 금액에 배부 잔액을 배부한다.
                                RecordSet sumtDeliverRs = inventoryMgmtDeliverDAO.selectSumtDeliverList(paramMap); //배부된 합계 수량을 조회

                                RecordSet divRs = poOrderOtherAmtDAO.selectList(divData);
                                logger.info("마지막 :" + sumtDeliverRs.get(0).getString("commAmtSum") + "//"
                                        + sumtDeliverRs.get(1).getString("commAmtSum"));
//                                if (sumtDeliverRs.get(0).getDouble("commAmtSum") < sumtDeliverRs.get(1).getDouble("commAmtSum")) {
                                if ( divRs.get(0).getDouble("commAmt") < divRs.get(0).getDouble("divAccumAmt") )
                                {
                                    double balAlt = divRs.get(0).getDouble("divAccumAmt") - divRs.get(0).getDouble("commAmt");

                                    divData = new HashMap<String, Object>();
                                    divData.put("deliverNum", deliverData.get("deliverNum"));
                                    divData.put("divSeq", divSeq);
                                    divData.put("divAmt", divAmt - balAlt);
                                    divData.put("poOrderNum", deliverRd.get("poOrderNum"));
                                    divData.put("otherAmtSeq", deliverRd.get("otherAmtSeq"));
                                    divData.put("commClass", deliverRd.get("commClass"));
                                    logger.info("deliverNum ::::"+deliverData.get("deliverNum")+"///"+divAmt+"//"+ balAlt);
                                    //4.마지막 입고시 부대비 잔액 배부 UPDATE
                                    deliveritemOtherAmtDivDAO.update(divData);

                                    //5.배부누적 누적잔액 금액을 수수료 금액으로 UPDATE
                                    poOrderOtherAmtDAO.updateDivAccumAmtBalAlt(divData);

                                }
                            }

                        }

                    }
                }
                //5.통관테이블 입고여부 Y 업데이트
                deliverData.put("deliverYn", "Y");
                insRowCnt += entryMstDAO.updateDeliverYn(deliverData);
            }
        }
        return insRowCnt;
    }

    /**
     * 수입면허 입고취소처리 한다. DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
    public int cancelDeliver(DataSetMap dsList) throws Exception {
        int delRowCnt = 0;
        logger.info("list.size() ::" + dsList.size());
        Map<String, Object> paramMap = new HashMap<String, Object>();
        for (int i = 0; i < dsList.size(); i++) {
            Map<String, Object> rowData = dsList.get(i);

//            int getReleaseCnt = inventoryMgmtDeliverDAO.getReleaseCnt(rowData);
//            logger.info("getReleaseCnt :"+getReleaseCnt);
//            if ( getReleaseCnt > 0 )
//            {
//                throw new BizException("출고건 [ "+getReleaseCnt +" ]이 존재 합니다. 입고취소 할 수 업습니다.");
//            }

            //1.구매주문 부대비 부대비 누적금액 감액 적용
            RecordSet cancelRs = inventoryMgmtDeliverDAO.selectCancelOtherAmtDivList(rowData); //부대비 배부 삭제 대상 조회
            if (cancelRs.size() > 0) {
                for (int otherRow = 0; otherRow < cancelRs.size(); otherRow++) {
                    Map<String, Object> deliverRd = cancelRs.get(otherRow);

                    paramMap.put("poOrderNum", deliverRd.get("poOrderNum"));
                    paramMap.put("otherAmtSeq", deliverRd.get("otherAmtSeq"));
                    paramMap.put("divAccumAmt", deliverRd.get("divAmt"));
                    paramMap.put("commClass", deliverRd.get("commClass"));
                    poOrderOtherAmtDAO.updateDivAccumAmt(paramMap); //누적금액 감액
                }
            }
            //2.입고품목 부대비 배부 삭제
            delRowCnt += deliveritemOtherAmtDivDAO.cancelDeliver(rowData);
            //3.입고 삭제
            delRowCnt += inventoryMgmtDeliverDAO.cancelDeliver(rowData);
            //4통관테이블 입고여부 N 업데이트
            paramMap.put("entryNum", rowData.get("entryNum"));
            paramMap.put("deliverYn", "N");
            delRowCnt += entryMstDAO.updateDeliverYn(paramMap);
            //5.분할통관된 내역이 전체가 입고 취소됬을시 구매주문 부대비의 배부 누적 금액 0으로 만들어 준다.
            poOrderOtherAmtDAO.updateAllDivAccumAmtZero(rowData);

        }

        return delRowCnt;
    }

    /**
     * 재고현황(외부거래처) 목록을 조회한다.
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
    public RecordSet selectInventoryStatusCustList(Map<String, Object> mapParam) throws Exception {
        return inventoryMgmtDeliverDAO.selectInventoryStatusCustList(mapParam);
    }

    /**
     * 재고현황(외부거래처) 목록을 조회한다.
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
    public RecordSet selectInventoryStatusList(Map<String, Object> mapParam) throws Exception {
        return inventoryMgmtDeliverDAO.selectInventoryStatusList(mapParam);
    }

    /**
     * 부대비배부 목록을 조회한다.
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
    public RecordSet selectDeliverNumOtheramtDivListPop(Map<String, Object> mapParam) throws Exception {
        return inventoryMgmtDeliverDAO.selectDeliverNumOtheramtDivListPop(mapParam);
    }

    /**
     * 부대비배부 목록을 조회한다.
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
    public RecordSet selectDeliverNumOtheramtDivListPop2(Map<String, Object> mapParam) throws Exception {
        return inventoryMgmtDeliverDAO.selectDeliverNumOtheramtDivListPop2(mapParam);
    }

    /**
     * 창고이동 처리한다.
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
    public int saveWarehostMove(DataSetMap dsList) throws Exception {
        DecimalFormat df = new DecimalFormat();
        int insRowCnt = 0;
        Map<String, Object> otherAmtMap = new HashMap<String, Object>();
        Map<String, Object> deliverAmtMap = new HashMap<String, Object>();
        Map<String, Object> updateMap = new HashMap<String, Object>(); //이동전 데이타 세팅용
        for (int i = 0; i < dsList.size(); i++) {
            Map<String, Object> rowData = dsList.get(i);
            //Insert 처리
            String currYymmdd = LimsUtil.getDate("yyyyMMdd");

            RecordSet rs = inventoryMgmtDeliverDAO.selectList(rowData); //현재창고의 정보 조회
            for (int j = 0; j < rs.size(); j++) {
                Record rd = rs.getRecord(j);
                double deliverQuantity = Double.parseDouble(rd.get("deliverQuantity").toString());
                double deliverWgt = Double.parseDouble(rd.get("deliverWgt").toString());
                double deliverAmt = Double.parseDouble(rd.get("deliverAmt").toString());

                //PO-300(100)-YYMM-SEQ(4):내수(300)/수입(100)
                String deliverNum = inventoryMgmtDeliverDAO.getInventoryMgmtDeliverS(rowData);
                String currYymm = LimsUtil.getDate("yyyyMM");
                deliverNum = "ST" + currYymm + deliverNum;
                rd.put("deliverNum", deliverNum); //이동후 입고번호
                rd.put("deliverType", "20"); //입고 유형:이동입고
                logger.info("firstDeliverDate :"+rowData.get("firstDeliverDate"));
                rd.put("firstDeliverDate", rowData.get("firstDeliverDate")); //최초 입고 일자
                rd.put("currentWhDeliverDate", rowData.get("currentWhDeliverDate")); //현재 창고 입고 일자
                rd.put("whCd", rowData.get("moveWhCd")); //이동 입고될 창고코드 세팅
                rd.put("whNm", rowData.get("moveWhNm")); //이동 입고될 창고명 세팅
                rd.put("deliverQuantity", rowData.get("whMoveQuantity")); //이동 입고될 수량 세팅 1000 -> 400
                rd.put("deliverWgt", rowData.get("whMoveWgt")); //이동 입고될 중량 세팅
                rd.put("deliverAmt", rowData.get("whMoveAmt")); //이동 입고될 중량 세팅

                rd.put("releaseWaitQuantity", null);
                rd.put("releaseWaitWgt", null);
                rd.put("releaseEndQuantity", null);
                rd.put("releaseEndWgt", null);
                rd.put("rmaQuantity", null);
                rd.put("rmaWgt", null);
                rd.put("whMoveQuantity", null);
                rd.put("whMoveWgt", null);
                rd.put("orderRemainQuantity", null);
                rd.put("orderRemainWgt", null);

//                String unit = rd.get("unit").toString();
                String set1 = rd.get("set1").toString();
                double whMoveQuantity = Double.parseDouble(rowData.get("whMoveQuantity").toString());
                double whMoveWgt = Double.parseDouble(rowData.get("whMoveWgt").toString());
                double whMoveAmt = Double.parseDouble(rowData.get("whMoveAmt").toString());
                double divWonwtrAmt = Double.parseDouble(rowData.get("divWonwtrAmt").toString());

                double rRate = 0;
                logger.info("deliverQuantity :"+ "*"+ deliverQuantity +"//"+ deliverWgt);
                if ( "KG".equals(set1))
                {
                    rRate = whMoveWgt/deliverWgt;
                    logger.info("rRate1 :"+ "*"+ whMoveWgt +"/"+ deliverWgt +"="+rRate);
                }
                else
                {
                    rRate = whMoveQuantity/deliverQuantity;
                    logger.info("rRate22 :"+ whMoveQuantity +"/"+ deliverQuantity +"="+rRate);
                }
//                wonwtrAmt = wonwtrAmt * rRate;

                rd.put("deliverAmt", divWonwtrAmt); //이동 입고 분할된 원물금액

                logger.info("deliverAmt :" +  rowData.get("whMoveAmt"));
                logger.info("realDeliverAmt :" +  rd.get("realDeliverAmt"));
                logger.info("wonwtrAmt :" +  rd.get("wonwtrAmt"));
                //rd.put("initialDeliverNum", rowData.get("deliverNum"));

                Map<String, Object> mapRecord = DTOUtil.convertRecordToMap(rd);

                //1.이동창고 신규 데이타 insert
                insRowCnt += inventoryMgmtDeliverDAO.insert(mapRecord);

                //2.이동전 창고 데이타 UPDATE
                updateMap.put("deliverNum", rowData.get("deliverNum")); //이동 전 입고번호
                updateMap.put("whMoveQuantity",Double.parseDouble(LimsUtil.checkNull(rowData.get("whMoveQuantity"), "0").toString())); //이동 전 입고될 이동수량 세팅
                updateMap.put("whMoveWgt", Double.parseDouble(LimsUtil.checkNull(rowData.get("whMoveWgt"), "0").toString())); //이동 전 입고될 이동중량 세팅
                logger.info("rRate22 :"+ deliverAmt +"-"+ divWonwtrAmt +"="+deliverAmt);
                updateMap.put("deliverAmt", -divWonwtrAmt); //이동 전 입고될 이동수량 세팅


                insRowCnt += inventoryMgmtDeliverDAO.updateWhMoveData(updateMap);

                mapRecord.put("deliverNum", rowData.get("deliverNum"));
                RecordSet rs2 = deliveritemOtherAmtDivDAO.selectList(mapRecord); //배부된 부대비 조회


//                double minusRate = 1- rRate;	//감액비율
                double totDivAmt =0;
                for (int k = 0; k < rs2.size(); k++) {
                    Record rd2 = rs2.getRecord(k);
                    double divAmt = Double.parseDouble(rd2.get("divAmt").toString());

                    otherAmtMap.put("deliverNum", deliverNum);

                    double realDivAmt = Math.round(divAmt * rRate);
                    totDivAmt += realDivAmt;
                    logger.info("divAmt11 :"+ "*"+ divAmt +"*"+ rRate +"="+realDivAmt);
                    otherAmtMap.put("divSeq", rd2.get("divSeq"));
                    otherAmtMap.put("deliverNum", deliverNum);
                    otherAmtMap.put("divAmt", realDivAmt);
                    otherAmtMap.put("commClass", rd2.get("commClass"));
                    otherAmtMap.put("divDate", currYymmdd);
                    otherAmtMap.put("otherAmtSeq", rd2.get("otherAmtSeq"));
                    otherAmtMap.put("nonarrivAltYn", rd2.get("nonarrivAltYn"));
                    otherAmtMap.put("altFiscalSlipNum", rd2.get("altFiscalSlipNum"));

                    //4.창고이동후 배부된 부대비도 전체금액 대비 출고금액을 계산하여 비율로 증가한다
                    insRowCnt += deliveritemOtherAmtDivDAO.insert(otherAmtMap);

                    //5.원 창고건 부대배 감액
                    otherAmtMap.put("deliverNum", rowData.get("deliverNum")); //이동 전 입고번호
                    //
//                    double minusDivAmt = Math.round(divAmt * minusRate);
                    double minusDivAmt = Math.round(divAmt - realDivAmt);	//원부대비 - 감액된 부대비
                    logger.info("moveDivAmt :"+ divAmt+"-"+realDivAmt +"="+ minusDivAmt);

                    otherAmtMap.put("divAmt", minusDivAmt);		//
                    insRowCnt += deliveritemOtherAmtDivDAO.update(otherAmtMap);
                }
            }
        }
        return insRowCnt;
    }

    /**
     * 재고조정 목록을 조회한다.
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
    public RecordSet selectInventoryControlPop(Map<String, Object> mapParam) throws Exception {
        return inventoryMgmtDeliverDAO.selectInventoryControlPop(mapParam);
    }

    /**
     * 재고조정 처리한다.
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
    public int saveInventoryControl(DataSetMap dsList) throws Exception {
        int insRowCnt = 0;
        int updRowCnt = 0;
        int delRowCnt = 0;
        Map<String, Object> mapParam = new HashMap<String, Object>();
        Map<String, Object> releaseParam = new HashMap<String, Object>();
        Map<String, Object> releaseItemParam = new HashMap<String, Object>();
        Map<String, Object> saleOrderParam = new HashMap<String, Object>();
        Map<String, Object> saleOrderItemProcParam = new HashMap<String, Object>();

        String currYymmdd = LimsUtil.getDate("yyyyMMdd");
        for (int i = 0; i < dsList.size(); i++) {
            Map<String, Object> rowData = dsList.get(i);
            //1.회계쪽으로 잡이익, 잡손실에 대한 IF 차후 개발

            RecordSet controlRs = inventoryMgmtDeliverDAO.selectInventoryStatusList(mapParam);
            Map<String, Object> controlData = controlRs.get(0);

            //2.재고 조정 이력 테이블에 조정 되는 잡이익(+), 잡손실(-)에 대하여 이력 관리
            mapParam.put("deliverNum", rowData.get("deliverNum"));
            mapParam.put("inventoryModifyType", rowData.get("inventoryModifyType")); //재고 수정유형(+,-)
            mapParam.put("controlQuantity", rowData.get("controlQuantity")); //조정 수량
            mapParam.put("controlWgt", rowData.get("controlWgt")); //조정 중량
            mapParam.put("controlAmt", rowData.get("controlAmt")); //조정 금액
            mapParam.put("controlDate", rowData.get("controlDate")); //조정 일자
            mapParam.put("controlReason", rowData.get("controlReason")); //조정 사유
            mapParam.put("deliverType", "30"); //입고유형:조정입고
            mapParam.put("entryNum", controlData.get("entryNum"));
            mapParam.put("entryItemSeq", controlData.get("entryItemSeq"));
            mapParam.put("releaseDate", rowData.get("controlDate")); //출고일자:조정일자
            mapParam.put("poOrderNum", controlData.get("poOrderNum"));
            mapParam.put("itemCd", controlData.get("itemCd"));
            mapParam.put("seq", rowData.get("seq"));
logger.info("controlQuantity :"+rowData.get("controlQuantity"));
/*
            String controlQuantity = LimsUtil.checkNull(rowData.get("controlQuantity"), "0");

            float totQuantity = Float.parseFloat(rowData.get("deliverQuantity").toString()) + (Float.parseFloat(rowData.get("inventoryModifyType").toString() + controlQuantity));
            logger.info(
                    "totQuantity :" + Float.parseFloat(rowData.get("deliverQuantity").toString())
                            + (Float.parseFloat(
                                    rowData.get("inventoryModifyType").toString() + rowData.get("controlQuantity").toString())
                            + " = " + totQuantity));

            //중량 계산 : 입고중량 +- 조정중량
            float totWgt = Float.parseFloat(rowData.get("deliverWgt").toString())
                    + (Float.parseFloat(rowData.get("inventoryModifyType").toString() + rowData.get("controlWgt").toString()));
            logger.info(
                    "totWgt :" + Float.parseFloat(rowData.get("deliverWgt").toString())
                            + (Float.parseFloat(
                                    rowData.get("inventoryModifyType").toString() + rowData.get("controlWgt").toString()))
                            + "=" + totWgt);
            mapParam.put("orderQuantity", totQuantity);
            mapParam.put("orderWgt", totWgt);
*/
//            Map<String, Object> saleInfo = saleOrderService.setSaleInfo(mapParam);
//            float buyCst = Float.parseFloat(saleInfo.get("buyCst").toString());

            double controlQuantity = Double.parseDouble(LimsUtil.checkNull(rowData.get("controlQuantity"), "0"));
            double controlWgt = Double.parseDouble(LimsUtil.checkNull(rowData.get("controlWgt"), "0"));
            String inventoryModifyType = LimsUtil.checkNull(rowData.get("inventoryModifyType"), "");

            int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (rowType == DataSet.ROW_TYPE_DELETED) {
                controlQuantity = -controlQuantity;
                controlWgt = -controlWgt;
            }
            mapParam.put("inventoryControlQuantity", controlQuantity);
            mapParam.put("inventoryControlWgt", controlWgt);
            insRowCnt += inventoryMgmtDeliverDAO.updateInventoryControlQuantity(mapParam); //입고 TABLE에서 입고번호에 해당하는 재고조정 누적 수량(을)를 수정

            //2.재고조정 이력정보 생성
//            logger.info("saleCst :" + buyCst);
//            mapParam.put("saleCst", buyCst); //판매원가 -매입원가(이익율 고려안한)

//            insRowCnt += inventoryControlLogDAO.insert(mapParam);


            //Insert 처리
            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                insRowCnt += inventoryControlLogDAO.insert(mapParam);
            }
            //Update 처리
            else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                updRowCnt += inventoryControlLogDAO.update(mapParam);
            }
            //Delete 처리.
            else if (rowType == DataSet.ROW_TYPE_DELETED) {
                delRowCnt += inventoryControlLogDAO.delete(mapParam);
            }
            //4.잡손실(-) sap부분 구현 - 원가차감 화면에서 구현
        }

        return insRowCnt;
    }

    /**
     * 반품 목록을 조회한다.
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
    public RecordSet selectRmaPop(Map<String, Object> mapParam) throws Exception {
        return inventoryMgmtDeliverDAO.selectRmaPop(mapParam);
    }

    /**
     * 내수반품 처리한다.
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
    public int savetRmaPop(DataSetMap dsList) throws Exception {
        int insRowCnt = 0;
        Map<String, Object> mapParam = new HashMap<String, Object>();
        for (int i = 0; i < dsList.size(); i++) {
            Map<String, Object> rowData = dsList.get(i);

            mapParam.put("deliverNum", rowData.get("deliverNum"));
            mapParam.put("rmaQuantity",
                    rowData.get("rmaModifyType") + "" + Math.abs(Double.parseDouble(rowData.get("rmaQuantity").toString()))); //반품 수량
            mapParam.put("rmaWgt",
                    rowData.get("rmaModifyType") + "" + Math.abs(Double.parseDouble(rowData.get("rmaWgt").toString()))); //반품 중량

            insRowCnt += inventoryMgmtDeliverDAO.updateRmaData(mapParam);
        }

        return insRowCnt;
    }

    /**
     * 입고정보를 등록 관리한다. DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
    public int saveInventoryStatusList(DataSetMap list) throws Exception {
        int insRowCnt = 0;
        int updRowCnt = 0;
        int delRowCnt = 0;
        Map<String, Object> mapParam = new HashMap<String, Object>();
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> rowData = list.get(i);
            int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            //Insert 처리
            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                insRowCnt += inventoryMgmtDeliverDAO.insert(rowData);
            }
            //Update 처리
            else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                mapParam.put("deliverNum", rowData.get("deliverNum"));
                mapParam.put("mfgDate", rowData.get("mfgDate"));
                mapParam.put("dtrLimt", rowData.get("dtrLimt"));
                mapParam.put("estNo", rowData.get("estNo"));
                mapParam.put("incomeDtrDsctNum", rowData.get("incomeDtrDsctNum"));
                mapParam.put("lastSaleEdate", rowData.get("lastSaleEdate"));

                updRowCnt += inventoryMgmtDeliverDAO.update(mapParam);
            }
            //Delete 처리.
            else if (rowType == DataSet.ROW_TYPE_DELETED) {
                delRowCnt += inventoryMgmtDeliverDAO.delete(rowData);
            }
        }

        return insRowCnt + updRowCnt + delRowCnt;
    }

    /**
     * 업장에 custcd 가져오기
     * <pre>
     * 업장에 custcd 가져오기
     * </pre>
     *
     * @param inVar
     * @return PgmAuthDTO
     * @throws Exception
     */
    @Override
    public Record selectCustCd(Map<String, Object> inVar)
            throws Exception {

        return inventoryMgmtDeliverDAO.selectCustCd(inVar);
    }

    /**
     * 가입고 삭제 처리한다.
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
    public int deleteGaDeliver(DataSetMap dsList) throws Exception {
        int delRowCnt = 0;
        logger.info("list.size() ::" + dsList.size());
        Map<String, Object> paramMap = new HashMap<String, Object>();
        for (int i = 0; i < dsList.size(); i++) {
            Map<String, Object> rowData = dsList.get(i);

            //2.입고품목 부대비 배부 삭제
            delRowCnt += inventoryMgmtDeliverDAO.deleteGaDeliver(rowData);
        }

        return delRowCnt;
    }

    /**
     * 부대비 금액 수정처리한다.
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
    public int saveOtherDivList(DataSetMap list) throws Exception {
        int updRowCnt = 0;
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> rowData = list.get(i);
            int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            //Update 처리
            if (rowType == DataSet.ROW_TYPE_UPDATED) {

                updRowCnt += deliveritemOtherAmtDivDAO.update(rowData);
            }
        }

        return updRowCnt;
    }
}
