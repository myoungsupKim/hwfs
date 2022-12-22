package com.hwfs.ft.fts.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ft.fdm.dao.DeliveritemOtherAmtDivDAO;
import com.hwfs.ft.fdm.dao.EntryItemDetailDAO;
import com.hwfs.ft.fdm.dao.InventoryMgmtDeliverDAO;
import com.hwfs.ft.fgp.dao.GdspaymMstDAO;
import com.hwfs.ft.ftp.dao.PoOrderOtherAmtDAO;
import com.hwfs.ft.ftp.dao.ProposalDAO;
import com.hwfs.ft.fts.dao.ReleaseMgmtDAO;
import com.hwfs.ft.fts.dao.SaleOrderDAO;
import com.hwfs.ft.fts.dao.SaleOrderItemMgmtDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.tobesoft.xplatform.data.DataSet;

/**
* 입고(재고)를 판매 주문에 대하여 관리하는 SaleOrder Service Implementation
*
* @ClassName SaleOrderServiceImpl.java
* @Description SaleOrderServiceImpl Class
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2015.05.06    kjj        최초생성
* </pre>
* @author FC종합전산구축 : 식재도매 kjj
* @since 2015.05.06
* @version 1.0
* @see
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
@Service("/ft/fts/saleOrderService")
public class SaleOrderServiceImpl extends DefaultServiceImpl implements SaleOrderService {

    /** LogService */
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    /** SaleOrderDAO Bean 생성 */
    @Resource(name = "/ft/fts/saleOrderDAO")
    private SaleOrderDAO saleOrderDAO;

    /** SaleOrderItemMgmtDAO Bean 생성 */
    @Resource(name = "/ft/fts/saleOrderItemMgmtDAO")
    private SaleOrderItemMgmtDAO saleOrderItemMgmtDAO;

    /** InventoryMgmtDeliverDAO Bean 생성 */
    @Resource(name = "/ft/fdm/inventoryMgmtDeliverDAO")
    private InventoryMgmtDeliverDAO inventoryMgmtDeliverDAO;

    /** PoOrderOtherAmtDAO Bean 생성 */
    @Resource(name = "/ft/ftp/poOrderOtherAmtDAO")
    private PoOrderOtherAmtDAO poOrderOtherAmtDAO;

    /** EntryItemDetailDAO Bean 생성 */
    @Resource(name = "/ft/fdm/entryItemDetailDAO")
    private EntryItemDetailDAO entryItemDetailDAO;

    /** EntryItemDetailDAO Bean 생성 */
    @Resource(name = "/ft/fdm/deliveritemOtherAmtDivDAO")
    private DeliveritemOtherAmtDivDAO deliveritemOtherAmtDivDAO;

    /** EntryItemDetailDAO Bean 생성 */
    @Resource(name = "/ft/ftp/proposalDAO")
    private ProposalDAO proposalDAO;

    /** EntryItemDetailDAO Bean 생성 */
    @Resource(name = "/ft/fgp/gdspaymMstDAO")
    private GdspaymMstDAO gdspaymMstDAO;

    /** ReleaseMgmtDAO Bean 생성 */
    @Resource(name = "/ft/fts/releaseMgmtDAO")
    private ReleaseMgmtDAO releaseMgmtDAO;

    /**
     * 입고(재고)를 판매 주문에 대하여 관리 목록을 조회한다.
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
        return saleOrderDAO.selectList(mapParam);
    }

    /**
     * 입고(재고)를 판매 주문에 대하여 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
        logger.info("list.size() ::::" + list.size());
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> rowData = list.get(i);
            int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            logger.info("rowType ::::" + rowType);
            //Insert 처리
            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                insRowCnt += saleOrderDAO.insert(rowData);
            }
            //Update 처리
            else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                updRowCnt += saleOrderDAO.update(rowData);
            }
            //Delete 처리.
            else if (rowType == DataSet.ROW_TYPE_DELETED) {
                delRowCnt += saleOrderDAO.delete(rowData);
            }
        }

        return insRowCnt + updRowCnt + delRowCnt;
    }

    /**
     * 입고(재고)를 판매 주문에 대하여 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
    public int deleteList(DataSetMap list) throws Exception {
        int insRowCnt = 0;
        int updRowCnt = 0;
        int delRowCnt = 0;
        logger.info("list.size() ::::" + list.size());
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> rowData = list.get(i);

            //주문상태(품목의 상태)가 한 품목이라도 승인요청 이후 단계가 있으면 불가
            int saleApprvCnt = releaseMgmtDAO.getSaleApprvCnt(rowData);
            if (saleApprvCnt > 0) {
                throw processException("ft.fts.fail.saleOrderList.delete.alert"); //승인요청 이후 단계가 존재합니다. 삭제 할 수 없습니다.
            }

            //----------------현재고 대비 주문량 체크---------------------
            rowData.put("flag", "U");
            //rowData.put("orderRemainQuantity", Float.parseFloat(LimsUtil.checkNull(rowData.get("remainQuantity"))) * -1);
            //rowData.put("orderRemainWgt", Float.parseFloat(LimsUtil.checkNull(rowData.get("remainWgt"))) * -1);
            rowData.put("orderRemainQuantity", Double.parseDouble(LimsUtil.checkNull(rowData.get("orderQuantity"))) * -1);
            rowData.put("orderRemainWgt", Double.parseDouble(LimsUtil.checkNull(rowData.get("orderWgt"))) * -1);
            updRowCnt += inventoryMgmtDeliverDAO.updateOrderRemainQuantity(rowData); //입고 TABLE에서 입고번호에 해당하는 Row의 주문잔여수량(중량) 증가

            delRowCnt += saleOrderDAO.deleteSaleOrderCancelLog(rowData); //판매주문 취소 이력
            delRowCnt += saleOrderDAO.delete(rowData); //판매주문 마스트
            delRowCnt += saleOrderItemMgmtDAO.deleteAll(rowData); //판매주문 상세
        }

        return insRowCnt + updRowCnt + delRowCnt;
    }

    /**
     * 입고(재고)를 판매 주문에 대하여 관리 목록을 조회한다.
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
    public RecordSet selectItemInfoSaveSearchPop(Map<String, Object> mapParam) throws Exception {
        return saleOrderDAO.selectItemInfoSaveSearchPop(mapParam);
    }

    /**
     * 입고(재고)를 판매 주문에 대하여 관리 목록을 조회한다.
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
    public RecordSet selectItemInfoSaveSearchPop2(Map<String, Object> mapParam) throws Exception {
        return saleOrderDAO.selectItemInfoSaveSearchPop2(mapParam);
    }

    /**
     * 판매주문 마스터을 조회한다.
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
    public RecordSet selectSaleOrder(Map<String, Object> mapParam) throws Exception {
        return saleOrderDAO.selectSaleOrder(mapParam);
    }

    /**
     * 관세비용 및 입고예정정보를 등록 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    @Override
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> saveSaleOrderDtl(LoginDTO loginParameter, DataSetMap search, DataSetMap dsSaleOrder,
            DataSetMap dsSaleOrderItemMgmtList) throws Exception {
        int saleOrderProcCnt = 0;
        int saleOrderItemProcCnt = 0;
        int releaseWaitProcCnt = 0;
        String saleOrderNum = ""; //통관 번호
        String[] arrSaleOrderNum = new String[dsSaleOrder.size()];

        List<Map<String, Object>> listMap = new ArrayList();
        List<Object> deliverNum = new ArrayList<Object>();
        Map<String, Object> map = new HashMap();
        		
        //1.판매주문 마스터 저장
        if (dsSaleOrder.size() > 0) {
        	
            for (int i = 0; i < dsSaleOrder.size(); i++) {
                Map<String, Object> parameter = dsSaleOrder.get(i);
                int rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
                if (rowType == DataSet.ROW_TYPE_INSERTED) {
                    saleOrderNum = saleOrderDAO.getSaleOrderNumSeq(parameter); //판매 주문 번호 : SO-YYMM-SEQ(6)
                    logger.info("saleOrderNum2  ::::" + saleOrderNum);

                    String currYymm = LimsUtil.getDate("yyMM");
                    saleOrderNum = "SO" + currYymm + saleOrderNum;
                    arrSaleOrderNum[i] = saleOrderNum;
                    parameter.put("saleOrderNum", saleOrderNum);
                    saleOrderProcCnt += saleOrderDAO.insert(parameter);
                } else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                    saleOrderProcCnt += saleOrderDAO.update(parameter);
                    saleOrderNum = parameter.get("saleOrderNum").toString();
                }
                deliverNum.add("'"+parameter.get("deliverNum").toString()+"'");	// 저장후 재조회시 변경된 건만 조회하기 위한 key
            }
        }

        logger.info("saleOrderNum3  ::::" + saleOrderNum);

        //2.판매주문 품목 상세 저장
        if (dsSaleOrderItemMgmtList.size() > 0) {
            for (int i = 0; i < dsSaleOrderItemMgmtList.size(); i++) {
                Map<String, Object> parameter = dsSaleOrderItemMgmtList.get(i);
                parameter.put("cuser", loginParameter.getSabun());
                parameter.put("uuser", loginParameter.getSabun());
                parameter.put("saleOrderStatus", "10"); //판매주문등록
                int rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

                if (rowType == DataSet.ROW_TYPE_INSERTED) {
//                    if (!"".equals(saleOrderNum)) {
//                        parameter.put("saleOrderNum", saleOrderNum);
//                    }
//                    saleOrderNum = parameter.get("saleOrderNum").toString();
                     if (!"".equals(arrSaleOrderNum[i])) {
                         parameter.put("saleOrderNum", arrSaleOrderNum[i]);
                     }
                     saleOrderNum = parameter.get("saleOrderNum").toString();

                    logger.info("deliverQuantity :" + parameter.get("deliverQuantity"));
                    logger.info("orgOrderQuantity :" + parameter.get("orgOrderQuantity"));
                    logger.info("orderQuantity :" + parameter.get("orderQuantity"));
                    logger.info("releaseWaitQuantity :" + parameter.get("releaseWaitQuantity"));
                    logger.info("releaseEndQuantity :" + parameter.get("releaseEndQuantity"));
                    logger.info("rmaQuantity :" + parameter.get("rmaQuantity"));
                    logger.info("whMoveQuantity :" + parameter.get("whMoveQuantity"));
                    int saleOrderNumSeq = saleOrderItemMgmtDAO.getSaleOrderNumSeq(parameter);
                    logger.info("saleOrderNumSeq:" + saleOrderNumSeq);
                    parameter.put("saleOrderNumSeq", saleOrderNumSeq);

                    RecordSet rs = saleOrderItemMgmtDAO.selectList(parameter); //판매주문 마스터 주문수량

                    double orderQuantity = 0;
                    double releaseQuantity = 0; //출고수량(주문)
                    if (rs.size() > 0) {
                        orderQuantity = Double.parseDouble(LimsUtil.checkNull(rs.get(0).get("orderQuantity"), "0").toString());
                        releaseQuantity = Double.parseDouble(LimsUtil.checkNull(rs.get(0).get("releaseQuantity"), "0").toString());
                    }
                    logger.info("rs.get(0).get(orderQuantity) :" + orderQuantity);
                    logger.info("rs.get(0).get(releaseQuantity) :" + releaseQuantity);

                    //----------------현재고 대비 주문량 체크---------------------
                    //전재고  = 입고-((주문+출고대기+출고완료)+(반품+창고이동))
                    //현재고를 체크하여 현재고 보다 주문량이 많으면 안되게 체크
                    double focOrderQuantity = Double.parseDouble(LimsUtil.checkNull(parameter.get("orderQuantity"), "0").toString());
                    double focOrderWgt = Double.parseDouble(LimsUtil.checkNull(parameter.get("orderWgt"), "0").toString());
                    logger.info("focOrderWgt :" + focOrderWgt);

                    parameter.put("focOrderQuantity", focOrderQuantity);
                    parameter.put("releaseDate", dsSaleOrder.get(0).get("releaseDate"));

                    parameter = setSaleInfo(parameter); //판매원가 계산


                    saleOrderItemProcCnt += saleOrderItemMgmtDAO.insert(parameter);

                    parameter = chkIncomeCstAmt(parameter);	  //수입원가 보정작업

                    parameter.put("flag", "I");
                    double orderRemainQuantity = focOrderQuantity; //주문잔여수량 : 입고수량 - 주문수량
                    double orderRemainWgt = focOrderWgt; //주문잔여수량 : 입고수량 - 주문수량
                    logger.info("orderRemainQuantity :"
                            + Double.parseDouble(LimsUtil.checkNull(parameter.get("deliverQuantity"), "0").toString()) + "-"
                            + focOrderQuantity + "=" + orderRemainQuantity);
                    logger.info(
                            "orderRemainWgt :" + Double.parseDouble(LimsUtil.checkNull(parameter.get("deliverWgt"), "0").toString())
                                    + "-" + focOrderWgt + "=" + orderRemainWgt);
                    parameter.put("orderRemainQuantity", Math.round(orderRemainQuantity * 100d) / 100d);
                    parameter.put("orderRemainWgt", Math.round(orderRemainWgt * 100d) / 100d);
                    releaseWaitProcCnt += inventoryMgmtDeliverDAO.updateOrderRemainQuantity(parameter); //입고 TABLE에서 입고번호에 해당하는 Row의 주문잔여수량(중량) 증가

                }
            }
        }

        logger.info("LAST saleOrderNum :" + saleOrderNum);
        map.put("saleOrderNum", saleOrderNum); //판매주문번호 전달
        map.put("procCnt", saleOrderProcCnt + saleOrderItemProcCnt + releaseWaitProcCnt); //실행건 전달
        map.put("deliverNum", deliverNum);
        listMap.add(map);

        return listMap;
    }

    /**
     * 매입원가 조회 및 보정작업(원단위)한다.
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
    public Map<String, Object> chkIncomeCstAmt(Map<String, Object> parameter) throws Exception {
        int cnt = 0;
        DecimalFormat df = new DecimalFormat();

        Record incomeCstRs = inventoryMgmtDeliverDAO.selectIncomeCst(parameter); //총수입원가 금액 조회

        double buycst =  incomeCstRs.getDouble("buycst");	 //수입원가
        double remainOrderQuantity =  incomeCstRs.getDouble("remainOrderQuantity");	 //남은수량
        double remainBuyCst =  incomeCstRs.getDouble("remainBuyCst");	 //남은 수입원가
        if ( remainOrderQuantity == 0 )	   //남은수량이 없을시 보정 한다.
        {
            parameter.put("remainBuyCst", remainBuyCst);
            cnt += inventoryMgmtDeliverDAO.updateBuycst(parameter); //입고 TABLE에서 입고번호에 해당하는 Row의 주문잔여수량(중량) 증가
        }


        return parameter;
    }

    /**
     * 판매원가 조회 및 저장한다.
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
    public Map<String, Object> setSaleInfo(Map<String, Object> parameter) throws Exception {
        DecimalFormat df = new DecimalFormat();
        //----------------판매원가 계산---------------------
        /*
         1. 물대금액(B/L) =  금액(USD) * 결재환율
               KG원가(\)  = ROUND( 물대금액(B/L) / 수입 원가 금액(1+2+3) )
         2. 관세금액(통관) = ( (금액(USD) * 통관 결재환율)-공제금액+보험료 ) * 관세율
               (통관)KG원가(\) =  ROUND( 2. 관세금액(통관) / 수입 원가 금액(1+2+3) )
         3. 부대비용금액

            수입 원가 금액(1+2+3) = 	물대금액(B/L) + 관세금액(통관) + 부대비용금액
        */
        RecordSet inventoryRs = inventoryMgmtDeliverDAO.selectList(parameter); //입고

        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("poOrderNum", parameter.get("poOrderNum"));
        paramMap.put("commClass", "B-19"); //보험료 임시세팅 차후 변경분 반영 필요
        logger.info("##########2");
        double sumCommAmt = Double.parseDouble(LimsUtil.checkNull(poOrderOtherAmtDAO.getCommAmt(paramMap), "0"));
        logger.info("sumCommAmt :" + sumCommAmt);

        double gvrntaxRate = 0;
        double whChargCost = 0;
        double ioutCost = 0;
        if ("10".equals(inventoryRs.get(0).get("poType").toString())) //수입
        {
            Record rd = entryItemDetailDAO.getGvrntaxRate(parameter);
            if (rd != null) {
                gvrntaxRate = Double.parseDouble(LimsUtil.checkNull(rd.get("gvrntaxRate"), "0").toString()); //관세율
                whChargCost = Double.parseDouble(LimsUtil.checkNull(rd.get("chargCost"), "0").toString()); //창고보관료
                ioutCost = Double.parseDouble(LimsUtil.checkNull(rd.get("ioutCost"), "0").toString()); //창고입출고비
            }
        }
        else
        {
            gvrntaxRate = 0; //관세율
            whChargCost = Double.parseDouble(LimsUtil.checkNull(inventoryRs.get(0).get("chargCost"), "0").toString()); //창고보관료
            ioutCost = Double.parseDouble(LimsUtil.checkNull(inventoryRs.get(0).get("ioutCost"), "0").toString()); //창고입출고비
        }

        logger.info("gvrntaxRate :" + gvrntaxRate);
        parameter.put("ioutCost", ioutCost); //입출고 비용

        logger.info("gvrntaxRate :" + gvrntaxRate);
        logger.info("chargCost :" + whChargCost);
        logger.info("ioutCost :" + ioutCost);

        double deliverAmt = Double.parseDouble(LimsUtil.checkNull(inventoryRs.get(0).get("deliverAmt"), "0").toString()); //입고금액
        double signExchangeRate = Double.parseDouble(LimsUtil.checkNull(inventoryRs.get(0).get("signExchangeRate"), "0").toString()); //결재 환율
        double lshipExchangeRate = Double.parseDouble(LimsUtil.checkNull(inventoryRs.get(0).get("lshipExchangeRate"), "0").toString()); //선적 환율
        double deliverUpriceForeignCurrenc = Double.parseDouble(LimsUtil.checkNull(inventoryRs.get(0).get("deliverUpriceForeignCurrenc"), "0").toString()); //입고단가(외화)

        logger.info("원deliverAmt :" + df.format(deliverAmt));


        double deliverQuantity = Double.parseDouble(LimsUtil.checkNull(inventoryRs.get(0).get("deliverQuantity"), "0").toString()); //선적 환율
        double deliverWgt = Double.parseDouble(LimsUtil.checkNull(inventoryRs.get(0).get("deliverWgt"), "0").toString()); //선적 환율


        String set1 = inventoryRs.get(0).get("set1").toString();

        //----------------수입원가 계산
        //물대금액(B/L) =  금액(USD) * 결재환율
        double remainQuantity = Double.parseDouble(LimsUtil.checkNull(parameter.get("orderQuantity"), "0").toString());
        double remainWgt = Double.parseDouble(LimsUtil.checkNull(parameter.get("orderWgt"), "0").toString());

        double releaseBaseQw = 0;
        double deliverBaseQw = 0;
        if ( "KG".equals(set1) )
        {
            releaseBaseQw = remainWgt;
            deliverBaseQw = deliverWgt;
        } else {
            releaseBaseQw = remainQuantity;
            deliverBaseQw = deliverQuantity;
        }

        if ("10".equals(inventoryRs.get(0).get("poType").toString())) //수입
        {
//            deliverAmt = deliverAmt / lshipExchangeRate;	//입고금액은  선적환율을 곱하여 들어왔기때문에 선적환율을 나눠준다
              deliverAmt = deliverUpriceForeignCurrenc * deliverBaseQw;
        }
        logger.info("deliverAmt :" + deliverUpriceForeignCurrenc +"*"+deliverBaseQw+" :" + deliverAmt+"  /// deliverAmt:"+deliverAmt / lshipExchangeRate);
        logger.info("set1 :" + set1 +"//deliverBaseQw :"+deliverBaseQw+"//releaseBaseQw :" + releaseBaseQw+"// deliverAmt:"+deliverAmt);

        double wonwtrAmt = deliverAmt;
        if ("10".equals(inventoryRs.get(0).get("poType").toString())) //수입
        {
            wonwtrAmt = Math.round(deliverAmt * signExchangeRate);	  //입고금액은  결재환율을 적용한다.
        }


        logger.info("물대금액(B/L) 금액(USD) :" + df.format(deliverAmt) +"*"+  signExchangeRate  + "=" + df.format(wonwtrAmt));
        //관세금액(통관) = ( (금액(USD) * 통관 결재환율)-공제금액+보험료 ) * 관세율
//        double tariffAmt = (Math.round(deliverAmt * lshipExchangeRate) + sumCommAmt) * gvrntaxRate;
        logger.info("tariffAmt :"+deliveritemOtherAmtDivDAO.getTariffAmt(parameter));
        double tariffAmt = Double.parseDouble(LimsUtil.checkNull(deliveritemOtherAmtDivDAO.getTariffAmt(parameter), "0"));

        logger.info("관세금액(통관) tariffAmt :" + tariffAmt);
        //부대비용금액
        double otherAmtTotAmt = Double.parseDouble(LimsUtil.checkNull(deliveritemOtherAmtDivDAO.getOtherAmt(parameter), "0"));
        parameter.put("otherAmtTotAmt", otherAmtTotAmt); //부대비 총액 세팅
        logger.info("부대비용금액 otherAmt :" + otherAmtTotAmt);





        ///////////////view 수입원가  계산///////////////
        Record incomeCstRs = inventoryMgmtDeliverDAO.selectIncomeCst(parameter); //총수입원가 금액 조회

        double buyCst =  incomeCstRs.getDouble("buyCst");	 //수입원가
        long viewIncomeCstAmt = (long)(deliverAmt + otherAmtTotAmt) ;

        long realIncomeCstAmt = Math.round(buyCst * releaseBaseQw / deliverBaseQw);
        logger.info("realIncomeCstAmt :" + buyCst + "*" + releaseBaseQw + "/" + deliverBaseQw +"=" + df.format((realIncomeCstAmt)) );
        /////////////////////////////////////////////////





        //수입원가금액 : 물대금액(B/L) + 관세금액(통관)+ 부대비용금액
//        long incomeCstAmt = (long) (wonwtrAmt + tariffAmt + otherAmtTotAmt);
//        long incomeCstAmt = (long) (wonwtrAmt - tariffAmt+  otherAmtTotAmt);
        long incomeCstAmt = (long) (wonwtrAmt +  otherAmtTotAmt);

        logger.info("수입원가금액 incomeCstAmt :" + df.format(wonwtrAmt) +"+"+ otherAmtTotAmt + "=" + incomeCstAmt);
        parameter.put("buyCst", incomeCstAmt); //매입원가 세팅

        //매입단가 계산 : 매입원가 / 수량
        long buyUprice = Math.round(incomeCstAmt / deliverBaseQw);
        logger.info("매입단가 buyUprice :" + incomeCstAmt + "/" + deliverBaseQw + "=" + df.format(buyUprice) );
        parameter.put("buyUprice", buyUprice); //매입단가 세팅
        parameter.put("buyCst", (long)(buyUprice*deliverBaseQw)); //매입원가 세팅
        incomeCstAmt = (long)(buyUprice*deliverBaseQw);
        logger.info("매입단가 buyCst :" + buyUprice + "*" + deliverBaseQw + "=" + df.format((incomeCstAmt)) );

        //----------------수수료 및 연이자 내역 계산
        //당사이윤 = (수입원가금액/0.98) - 수입원가금액
        Record salsGainRatRd = proposalDAO.getSalsGainRat(parameter);
        double expectSalsGainrat = 0;
        if (salsGainRatRd != null) {
            expectSalsGainrat = Double.parseDouble(LimsUtil.checkNull(salsGainRatRd.getString("salsGainRat"), "1"));
        } else {
            expectSalsGainrat = 0;
        }
        //        double expectSalsGainrat = Double.parseDouble(LimsUtil.checkNull(parameter.get("expectSalsGainrat"),"1").toString());	 //차후 예상매출이익율 문의 필요
        logger.info("당사이윤 expectSalsGainrat :" + expectSalsGainrat);

        String releaseDate = parameter.get("releaseDate").toString();
        logger.info(inventoryRs.get(0).get("lastSaleEdate").toString() + "//orderDate :" + releaseDate);
        double blckDiff = 0;
        double blckMark = 0;
        logger.info(Integer.parseInt(inventoryRs.get(0).get("lastSaleEdate").toString()) + "////////" + Integer.parseInt(releaseDate));
        if (Integer.parseInt(inventoryRs.get(0).get("lastSaleEdate").toString()) < Integer.parseInt(releaseDate)) //판매종료일 보다 출고요청이 늦게 드어갔다면 패널티
        {
            blckDiff = diffOfDate(inventoryRs.get(0).get("lastSaleEdate").toString(), releaseDate); //승인요청일(주문일로 바뀜) - 판매종료일
            logger.info("blckDiff :" + blckDiff);

            Record blckRc = proposalDAO.getRatio(paramMap);
            if (blckRc != null) {
                double basisDays = blckRc.getDouble("basisDays"); //기준일수
                double basisBlckMarkRat = blckRc.getDouble("basisBlckMarkRat"); //기준패널티율
                double incDays = blckRc.getDouble("incDays"); //증가일수
                double incBlckMarkRat = blckRc.getDouble("incBlckMarkRat"); //증가패널티율

                double basisCnt = Math.ceil(blckDiff / basisDays);
                logger.info("basisCnt :" + basisCnt);
                if (basisCnt > 1) {
                    double basisCnt2 = Math.ceil((blckDiff - basisDays) / incDays);
                    blckMark = (basisBlckMarkRat + Double.parseDouble(basisCnt2 + "") * incBlckMarkRat);
                    //3 + ((105 - 30) /
                    logger.info("basisDays :" + basisDays + "//" + basisBlckMarkRat + "//" + incDays + "//" + incBlckMarkRat
                            + "//" + basisCnt + "//" + blckMark);
                } else {
                    blckMark = basisBlckMarkRat;
                }
                parameter.put("blckMark", blckMark); //패널티
            }
        }
        double ourComProfit = 0;
        //수수료 적용
        if ( (1-(expectSalsGainrat / 100)) != 0 )	//이윤없음
        {
            ourComProfit = Math.round((incomeCstAmt / (( 1-(expectSalsGainrat / 100))))) - incomeCstAmt; //벌점 포함
        }
        if ( expectSalsGainrat  < 0 )	//이윤없음
        {
            ourComProfit = 0;
        }
        logger.info("당사이윤 ourComProfit :" + "(" + incomeCstAmt + "/(1-(" + expectSalsGainrat + "/100))) -"+ incomeCstAmt + "=" + df.format(ourComProfit));

        double blacOurComProfit = 0;
        //벌점 적용
        if ( blckMark / 100 != 0 )	//이윤없음
        {
            blacOurComProfit =  Math.round((incomeCstAmt / ( 1 - (blckMark / 100)))) - incomeCstAmt; //벌점 포함
        }
        if ( blckMark  < 0 )	//이윤없음
        {
            blacOurComProfit = 0;
        }
        logger.info("당사이윤 blacOurComProfit :" + "(" + incomeCstAmt + "/(1-(" + blckMark + "/100) )) -"+ incomeCstAmt + "=" + df.format(blacOurComProfit));



        //창고보관료 : (수량 * 보관료 * 창고보관일 + 수량  * 입출고비 )
        long whChargDd = diffOfDate(inventoryRs.get(0).get("firstDeliverDate").toString(), releaseDate); //창고보관일 : 판매종료일(출고확정일자 수정 필요) - 창고입고일 +1
        parameter.put("from", releaseDate);
        parameter.put("to", inventoryRs.get(0).get("firstDeliverDate").toString() );
        whChargDd = deliveritemOtherAmtDivDAO.getDiffOfDate(parameter);
        logger.info("창고보관료 releaseDate :" + releaseDate+ "//"
                + inventoryRs.get(0).get("firstDeliverDate").toString() + "="+ whChargDd);

        logger.info("창고보관료 whChargDd :" + whChargDd);
        long chargAmt = Math.round((deliverBaseQw * whChargCost * whChargDd + deliverBaseQw * ioutCost));
        logger.info("창고보관료 chargAmt :" + deliverBaseQw + "*" + whChargCost + "*" + whChargDd + "+" + deliverBaseQw + "*"
                + ioutCost + "=" + chargAmt);
        parameter.put("whChargCost", chargAmt); //창고 보관 비용

        //물대이자 : 물대금액(B/L) * ( 판매일자 - 결재일자) * 금리 /365
        String buyPaymSettledd = gdspaymMstDAO.getBuyPaymSettledd(parameter); //결재일자 조회
        logger.info("물대이자 buyPaymSettledd :" + buyPaymSettledd);
        if (buyPaymSettledd == null) //물대이자의 결재일자가 존재하지 않을시
        {
            throw processException("ft.fts.fail.saleOrderList.nobyPaySettledd.alert"); //물품대금 결재일자가 존재하지 않습니다.
        }
//        long wonwtrDd = diffOfDate(buyPaymSettledd, inventoryRs.get(0).get("lastSaleEdate").toString()); //판매종료일 - 물대금액(B/L)의결재일 +1 ->차후 물대금액(B/L)의결재일 가져오는 방법?
        parameter.put("from", releaseDate);
        parameter.put("to", buyPaymSettledd );
        long wonwtrDd = deliveritemOtherAmtDivDAO.getDiffOfDate(parameter);
        double intRate = Double.parseDouble(LimsUtil.checkNull(inventoryRs.get(0).get("intRate"), "0").toString()); //금리
        double wonwtrInt = Math.round(wonwtrAmt * wonwtrDd * intRate / 100 / 365); //물대이자
        logger.info("물대이자 wonwtrDd :" + wonwtrDd+"// lastSaleEdate:"+releaseDate+"// buyPaymSettledd:"+buyPaymSettledd);
        logger.info("물대이자 intRate :" + intRate);
        logger.info("물대이자 wonwtrInt :" + df.format(wonwtrAmt) + "*" + wonwtrDd + "*" + intRate + "/100 /" + 365 + "=" + df.format(wonwtrInt) );

        //통관수수료 결재일
        String fiscalSlipcDate = LimsUtil.checkNull(poOrderOtherAmtDAO.getFiscalSlipcDate(paramMap), "");
        logger.info("통관수수료 결재일 fiscalSlipcDate :" + fiscalSlipcDate);
        String currYymmdd = LimsUtil.getDate("yyyyMMdd");
        double wtrlrgTariffInt = 0;
        if ("10".equals(inventoryRs.get(0).get("poType").toString())) //수입
        {
            //if ("".equals(fiscalSlipcDate)) //통관수수료의 결재일자가 존재하지 않을시
            //{
                //throw processException("ft.fts.fail.saleOrderList.nosignDd.alert"); //통관수수료의 결재일자가 존재하지 않습니다.  //차후주석 풀기
                //fiscalSlipcDate = currYymmdd;
            //}
            long signDd = 1;
            if (!"".equals(fiscalSlipcDate)) //통관수수료의 결재일자가 존재하지 않을시
            {
                signDd = diffOfDate(fiscalSlipcDate, releaseDate); //판매종료일 - 관세금액(통관)의결재일 +1 ->관세금액(통관) 수수료의 통관수수료의 결재일
            }

            //관세/부대비용이자 : (관세금액(통관) + 부대비용금액) * (판매종료일 - 관세금액(통관)의결재일 ) *금리 * /365 -> 차후 관세금액(통관)의결재일 가져오는 방법?
            wtrlrgTariffInt = Math.round((otherAmtTotAmt ) * (signDd+1) * intRate /100 / 365);
            logger.info("관세/부대비용이자 wtrlrgTariffInt :" + "(" +  "+" + otherAmtTotAmt +") *" + (signDd+1) + "*" + intRate+ "/100/" + 365 + "=" + +wtrlrgTariffInt);
        }

        parameter.put("wtrlrgTariffInt", wtrlrgTariffInt); //관세/부대비용이자  세팅
        //수수료 및 연이자 내역 :  당사이윤(벌점포함) +  창고보관료 + 물대이자 + 관세/부대비용이자 + 벌점
        double totalComm = ourComProfit + blacOurComProfit+ chargAmt + wonwtrInt + wtrlrgTariffInt;

        logger.info("수수료 및 연이자 내역 totalComm :" + df.format(ourComProfit)+ "+" + df.format(blacOurComProfit) + "+"  + "+" + df.format(chargAmt)  + "+" + df.format(wonwtrInt) + "+" + df.format(wtrlrgTariffInt) + "="+ df.format(totalComm));

        //----------------판매내역 계산
        //판매단가 : 수입원가금액 + 수수료 및 연이자 내역
        logger.info("deliverBaseQw:" + deliverBaseQw);
        long saleUprice = Math.round((incomeCstAmt + totalComm) / deliverBaseQw);
        parameter.put("saleUprice", saleUprice); //판매단가 세팅
        logger.info("판매단가 saleUprice :(" + df.format(incomeCstAmt) + "+" + df.format(totalComm) + ")/" + deliverBaseQw + "=" + df.format(saleUprice));

        //판매금액 : 판매단가 * 수량
        long saleAmt = Math.round(saleUprice * releaseBaseQw);
        String saleOrderType = parameter.get("saleOrderType").toString();	//판매주문유형
        logger.info("판매금액 saleAmt :" + df.format(saleUprice)  +"*"+  releaseBaseQw +"="+ Math.round(saleAmt)+"//saleOrderType :"+saleOrderType);

        double divRate = Math.round(releaseBaseQw / deliverBaseQw * 100d) / 100d;
        logger.info("divRate :" + divRate);


        parameter.put("otherAmtTotAmt", Math.round(otherAmtTotAmt * divRate)); //부대비 총액 세팅
        parameter.put("buyCst", Math.round(realIncomeCstAmt)); //매입원가 세팅
        parameter.put("blckMark", Math.round(blckMark * divRate)); //패널티
        parameter.put("whChargCost", Math.round(chargAmt * divRate)); //창고 보관 비용
        parameter.put("wtrlrgTariffInt", Math.round(wtrlrgTariffInt * divRate)); //관세/부대비용이자  세팅
        if ( "50".equals(saleOrderType) )	//판매주문유형:부서이관
        {
            parameter.put("saleCst", incomeCstAmt* divRate); //매입원가 세팅
        }
        else
        {
            parameter.put("saleCst", saleAmt); //판매원가 세팅
        }

        logger.info("원buyCst :" + Math.round(incomeCstAmt ));
        logger.info("otherAmtTotAmt :" + Math.round(otherAmtTotAmt * divRate));
        logger.info("buyCst 나누기:" + Math.round(incomeCstAmt * divRate));
        logger.info("blckMark :" + Math.round(blckMark * divRate));
        logger.info("whChargCost :" + Math.round(chargAmt * divRate));
        logger.info("wtrlrgTariffInt :" + Math.round(wtrlrgTariffInt * divRate));
        logger.info("saleCst :" + saleAmt);

        return parameter;
    }

    /**
     * 날짜 사이 일수를 구한다.
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
    public static long diffOfDate(String begin, String end) throws Exception {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
        Date beginDate = formatter.parse(begin);
        Date endDate = formatter.parse(end);

        long diff = endDate.getTime() - beginDate.getTime();
        long diffDays = diff / (24 * 60 * 60 * 1000);

        return diffDays;
    }

    /**
     * 판매주문등록 리스트를 조회 한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param mapParam
     * @return
     * @throws Exception
     * @see com.hwfs.ft.fts.service.SaleOrderService#selectSalesOrderRegList(java.util.Map)
    */
    public RecordSet selectSalesOrderRegList(Map<String, Object> mapParam) throws Exception {
        return saleOrderDAO.selectSalesOrderRegList(mapParam);
    }

}
