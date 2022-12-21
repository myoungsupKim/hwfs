package com.hwfs.ft.fts.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.math.BigDecimal;
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
import com.hwfs.cmn.exception.BizException;
import com.hwfs.fm.fmo.dao.OrderRequestDAO;
import com.hwfs.ft.fdm.dao.DeliveritemOtherAmtDivDAO;
import com.hwfs.ft.fdm.dao.EntryItemDetailDAO;
import com.hwfs.ft.fdm.dao.InventoryMgmtDeliverDAO;
import com.hwfs.ft.fgp.dao.GdspaymMstDAO;
import com.hwfs.ft.fsi.dao.FtSapInterfaceDAO;
import com.hwfs.ft.fsi.dao.SalsplceDAO;
import com.hwfs.ft.ftp.dao.PoOrderMstDAO;
import com.hwfs.ft.ftp.dao.PoOrderOtherAmtDAO;
import com.hwfs.ft.ftp.dao.ProposalDAO;
import com.hwfs.ft.fts.dao.PurchaseReturnMgmtDAO;
import com.hwfs.ft.fts.dao.ReleaseItemMgmtDAO;
import com.hwfs.ft.fts.dao.ReleaseMgmtDAO;
import com.hwfs.ft.fts.dao.SaleOrderItemMgmtDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.ls.ltm.dao.TestEndApprvDAO;
import com.hwfs.sc.cmn.dao.GwIfDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.sap.EAIListMap;
import com.hwfs.sc.cmn.sap.EAIResponse;
import com.hwfs.sc.cmn.sap.dto.SlipCancelDTO;
import com.hwfs.sc.cmn.sap.dto.SlipDtlDTO;
import com.hwfs.sc.cmn.sap.dto.SlipMstDTO;
import com.hwfs.sc.cmn.sap.list.SlipCancelList;
import com.hwfs.sc.cmn.sap.list.SlipDtlList;
import com.hwfs.sc.cmn.sap.list.SlipMstList;
import com.hwfs.sc.cmn.sap.service.EAIService;
import com.ifis.sc.scc.CommonUtil;
import com.sz.util.AppDataUtility;
import com.tobesoft.xplatform.data.DataSet;

/**
* 판매 주문내역에 대하여 출고를 관리하는 ReleaseMgmt Service Implementation
*
* @ClassName ReleaseMgmtServiceImpl.java
* @Description ReleaseMgmtServiceImpl Class
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2015.04.30    kjj        최초생성
* </pre>
* @author FC종합전산구축 : 식재도매 kjj
* @since 2015.04.30
* @version 1.0
* @see
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
@Service("/ft/fts/releaseMgmtService")
public class ReleaseMgmtServiceImpl extends DefaultServiceImpl implements ReleaseMgmtService {

    /** LogService */
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    /** ReleaseMgmtDAO Bean 생성 */
    @Resource(name = "/ft/fts/releaseMgmtDAO")
    private ReleaseMgmtDAO releaseMgmtDAO;

    /** ReleaseItemMgmtDAO Bean 생성 */
    @Resource(name = "/ft/fts/releaseItemMgmtDAO")
    private ReleaseItemMgmtDAO releaseItemMgmtDAO;

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

    @Resource(name = "/ls/ltm/testEndApprvDAO")
    private TestEndApprvDAO testEndApprvDAO;

    /** PoOrderMstDAO Bean 생성 */
    @Resource(name = "/ft/ftp/poOrderMstDAO")
    private PoOrderMstDAO poOrderMstDAO;

    @Resource(name = "EAIService")
    EAIService eaiService;

    /** FtSapInterfaceDAO Bean 생성 */
    @Resource(name = "/ft/fsi/ftSapInterfaceDAO")
    private FtSapInterfaceDAO ftSapInterfaceDAO;

    /** GwIfDAO Bean 생성 */
    @Resource(name = "/sc/cmn/gwIfDAO")
    private GwIfDAO gwIfDAO;

    /** WhDAO Bean 생성 */
    @Resource(name = "/ft/fsi/salsplceDAO")
    private SalsplceDAO salsplceDAO;

    /** OrderRequestDAO Bean 생성 */
    @Resource(name = "/fm/fmo/orderRequestDAO")
    private OrderRequestDAO orderRequestDAO;

    /** PurchaseReturnMgmtDAO Bean 생성 */
    @Resource(name = "/ft/fts/purchaseReturnMgmtDAO")
    private PurchaseReturnMgmtDAO purchaseReturnMgmtDAO;

    /**
     * 판매 주문내역에 대하여 출고를 관리 목록을 조회한다.
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
        return releaseMgmtDAO.selectList(mapParam);
    }

    /**
     * 판매 주문내역에 대하여 출고를 관리 목록을 조회한다.
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
    public RecordSet releaseRegList(Map<String, Object> mapParam) throws Exception {
        return releaseMgmtDAO.releaseRegList(mapParam);
    }

    /**
     * 판매 주문내역에 대하여 출고를 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
                insRowCnt += releaseMgmtDAO.insert(rowData);
            }
            //Update 처리
            else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                updRowCnt += releaseMgmtDAO.update(rowData);
            }
            //Delete 처리.
            else if (rowType == DataSet.ROW_TYPE_DELETED) {
                delRowCnt += releaseMgmtDAO.delete(rowData);
            }
        }

        return insRowCnt + updRowCnt + delRowCnt;
    }

    /**
     * 판매 주문내역에 대하여 출고를 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
    public int saveReleaseReg(DataSetMap list) throws Exception {
        int releaseItemProcCnt = 0;
        int releaseWaitProcCnt = 0;
        Map<String, Object> rsCheckQuantiry = new HashMap<String, Object>();

        //2.출고 품목 상세 저장
        Map<String, Object> releaseMgmtMap = new HashMap(); //출고 마스터 세팅 맵
        if (list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                Map<String, Object> parameter = list.get(i);
                int rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

                if (rowType == DataSet.ROW_TYPE_UPDATED) {

                    // 출고등록전 다시한번 출고가능 수량을 체크한다.
                    // 2015.06.30 kkj 추가
                    //float focOrderQuantity = Float.parseFloat(LimsUtil.checkNull(parameter.get("releaseQuantity"),"0").toString());
                    rsCheckQuantiry = releaseMgmtDAO.getSaleQuantityCheck(parameter);
                    double releaseExpectQuantitys = Double.parseDouble(LimsUtil.checkNull(rsCheckQuantiry.get("releaseExpectQuantity"), "0").toString());
                    double releaseExpectWgts = Double.parseDouble(LimsUtil.checkNull(rsCheckQuantiry.get("releaseExpectWgt"), "0").toString());
                    /*
                    if (releaseExpectQuantitys == 0 || releaseExpectWgts == 0) {
                        throw new BizException("출고 가능 수량,중량이 없습니다.");
                    }
                    */
                    if (parameter.get("unit").equals("KG"))
                    {
                    	if (releaseExpectWgts == 0) {
                            throw new BizException("출고 가능 중량이 없습니다.");
                        }	
                    }
                    if (!parameter.get("unit").equals("KG"))
                    {
                    	if (releaseExpectQuantitys == 0) {
                            throw new BizException("출고 가능 수량이 없습니다.");
                        }
                    }

                    String newReleaseNum = releaseMgmtDAO.getReleaseMgmtS(parameter);
                    String currYymm = LimsUtil.getDate("yyMM");
                    newReleaseNum = "DO" + currYymm + newReleaseNum;
                    logger.info("newReleaseNum :" + newReleaseNum);

                    releaseMgmtMap.put("saleOrderNum", parameter.get("saleOrderNum")); //판매주문번호
                    releaseMgmtMap.put("saleOrderNumSeq", parameter.get("saleOrderNumSeq")); //판매주문번호순번
                    releaseMgmtMap.put("saleOrderNumSeq", parameter.get("saleOrderNumSeq")); //판매주문번호순번
                    releaseMgmtMap.put("releaseStatusCd", "10"); //출고 상태 코드 :출고등록
                    releaseMgmtMap.put("itemCd", parameter.get("itemCd")); //품목코드
                    releaseMgmtMap.put("itemNm", parameter.get("itemNm")); //품목명
                    releaseMgmtMap.put("hsCd", parameter.get("hsCd")); //HS코드
                    releaseMgmtMap.put("whCd", parameter.get("whCd")); //창고코드
                    releaseMgmtMap.put("unit", parameter.get("unit")); //단위
                    releaseMgmtMap.put("releaseQuantity", parameter.get("releaseQuantity")); //출고수량
                    releaseMgmtMap.put("releaseWgt", parameter.get("releaseWgt")); //출고중량
                    releaseMgmtMap.put("realWgt", parameter.get("releaseExpectWgt")); //실중량
                    logger.info("realWgt :::" + parameter.get("releaseExpectWgt"));

                    releaseMgmtMap.put("deliverNum", parameter.get("deliverNum")); //입고번호
                    releaseMgmtMap.put("entryNum", parameter.get("entryNum")); //통관번호
                    releaseMgmtMap.put("entryItemSeq", parameter.get("entryItemSeq")); //통관번호순번
                    releaseMgmtMap.put("releaseNum", newReleaseNum); //출고번호

                    releaseMgmtMap.put("shipmentType", "10"); //출하 유형-일반
                    releaseMgmtMap.put("saleAged", parameter.get("saleAged")); //판매 경로
                    releaseMgmtMap.put("attachDept", parameter.get("attachDept")); //귀속 부서
                    releaseMgmtMap.put("salePrcgId", parameter.get("salePrcgId")); //판매 담당자 ID
                    releaseMgmtMap.put("custCd", parameter.get("releaseplceCd")); //거래처 코드

                    double focOrderQuantity = Double.parseDouble(LimsUtil.checkNull(parameter.get("releaseQuantity"), "0").toString());

                    double releaseExpectQuantity = Double.parseDouble(LimsUtil.checkNull(parameter.get("releaseExpectQuantity"), "0").toString());
                    double releaseExpectWgt = Double.parseDouble(LimsUtil.checkNull(parameter.get("releaseExpectWgt"), "0").toString());
                    releaseMgmtMap.put("focOrderQuantity", focOrderQuantity);
                    parameter.put("releaseDate", parameter.get("releaseDate"));
                    releaseMgmtMap.put("releaseDate", parameter.get("releaseDate"));

                    //판매원가 계산
                    releaseMgmtMap = setSaleInfo(parameter, releaseMgmtMap); //판매원가 계산

                    releaseMgmtMap.put("releaseQuantity", parameter.get("releaseExpectQuantity")); //출고수량
                    releaseMgmtMap.put("releaseWgt", parameter.get("releaseExpectWgt")); //출고중량
                    logger.info("releaseQuantity :::" + releaseMgmtMap.get("releaseQuantity"));

                    double releaseApprvReqQuantity = Double.parseDouble(LimsUtil.checkNull(parameter.get("releaseExpectQuantity"), "0").toString()); //출고 승인 요청 수량
                    double releaseApprvReqWgt = Double.parseDouble(LimsUtil.checkNull(parameter.get("releaseExpectWgt"), "0").toString());
                    releaseMgmtMap.put("releaseApprvReqQuantity", releaseApprvReqQuantity); //출고 승인 요청 수량
                    releaseMgmtMap.put("releaseApprvReqWgt", releaseApprvReqWgt); //출고 승인 요청 중량

                    //6.출고시 여신 차감하고 있어야 함 -> 여신체크 로직 나오면 차후 추가
                    //판매주문상태는 잔여수량 > 0 이면 분할출고, 전여수량 =0 이면 판매완료로 update
                    String saleOrderStatus = "30";
                    double orderRemainQuantity = Double.parseDouble(LimsUtil.checkNull(parameter.get("orderRemainQuantity"), "0").toString()); //주문잔여수량
                    logger.info("orderRemainQuantity :::" + orderRemainQuantity);

                    releaseMgmtMap.put("saleOrderStatus", saleOrderStatus); //판매 주문 상태
                    releaseMgmtMap.put("releaseStatusCd", "10"); //출고 상태 코드 :출고등록
                    releaseItemProcCnt += releaseItemMgmtDAO.insert(releaseMgmtMap);

                    releaseMgmtMap.put("poOrderNum", parameter.get("poOrderNum"));

                    parameter = chkIncomeCstAmt(releaseMgmtMap);	  //수입원가 보정작업

                    releaseMgmtMap.put("flag", "I");

                    releaseMgmtMap.put("releaseExpectQuantity", releaseExpectQuantity);
                    releaseMgmtMap.put("releaseExpectWgt", releaseExpectWgt);
                    releaseWaitProcCnt += inventoryMgmtDeliverDAO.updateReleaseWaitQuantity(releaseMgmtMap); //입고 TABLE에서 입고번호에 해당하는 Row의 출고대기수량(중량) +

                    releaseMgmtMap.put("orderRemainQuantity", -Math.round(releaseExpectQuantity * 100d) / 100d);
                    releaseMgmtMap.put("orderRemainWgt", -Math.round(releaseExpectWgt * 100d) / 100d);
                    releaseWaitProcCnt += inventoryMgmtDeliverDAO.updateOrderRemainQuantity(releaseMgmtMap); //입고 TABLE에서 입고번호에 해당하는 Row의 주문잔여수량(중량) 증가

                    releaseMgmtMap.put("releaseExpectQuantity", releaseExpectQuantity); //출고예정수량
                    releaseMgmtMap.put("releaseExpectWgt", releaseExpectWgt); //출고예정수량
                    releaseWaitProcCnt += saleOrderItemMgmtDAO.updateReleaseApprvReqQuantity(releaseMgmtMap); // 판매주문테이블의 출고승인요청수량(중량)을 +

                }
            }
        }
        return releaseItemProcCnt + releaseWaitProcCnt; //실행건 전달
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

        Record incomeCstRs = inventoryMgmtDeliverDAO.selectIncomeCst2(parameter); //총수입원가 금액 조회

        double buycst =  incomeCstRs.getDouble("buycst");	 //수입원가
        double remainOrderQuantity =  incomeCstRs.getDouble("remainOrderQuantity");	 //남은수량
        double remainBuyCst =  incomeCstRs.getDouble("remainBuyCst");	 //남은 수입원가
        logger.info(remainOrderQuantity+"/////////"+remainBuyCst);
        if ( remainOrderQuantity == 0 )	   //남은수량이 없을시 보정 한다.
        {
            parameter.put("remainBuyCst", remainBuyCst);
            cnt += inventoryMgmtDeliverDAO.updateBuycst2(parameter); //입고 TABLE에서 입고번호에 해당하는 Row의 주문잔여수량(중량) 증가
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
    public Map<String, Object> setSaleInfo(Map<String, Object> parameter, Map<String, Object> releaseMgmtMap) throws Exception {
        //----------------판매원가 계산---------------------
        /*
         1. 물대금액(B/L) =  금액(USD) * 결재환율
               KG원가(\)  = ROUND( 물대금액(B/L) / 수입 원가 금액(1+2+3) )
         2. 관세금액(통관) = ( (금액(USD) * 통관 결재환율)-공제금액+보험료 ) * 관세율
               (통관)KG원가(\) =  ROUND( 2. 관세금액(통관) / 수입 원가 금액(1+2+3) )
         3. 부대비용금액

            수입 원가 금액(1+2+3) = 	물대금액(B/L) + 관세금액(통관) + 부대비용금액
        */
        DecimalFormat df = new DecimalFormat();
        RecordSet inventoryRs = inventoryMgmtDeliverDAO.selectList(parameter); //입고

        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("poOrderNum", parameter.get("poOrderNum"));
        paramMap.put("commClass", "B-19"); //적하보험 - 보험료 임시세팅 차후 변경분 반영 필요
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
        releaseMgmtMap.put("saleTransportAmt", ioutCost); //입출고 비용

        logger.info("gvrntaxRate :" + gvrntaxRate);
        logger.info("chargCost :" + whChargCost);
        logger.info("ioutCost :" + ioutCost);

        double deliverAmt = Double.parseDouble(LimsUtil.checkNull(inventoryRs.get(0).get("deliverAmt"), "0").toString()); //입고금액
        double signExchangeRate = Double.parseDouble(LimsUtil.checkNull(inventoryRs.get(0).get("signExchangeRate"), "0").toString()); //결재 환율
        double lshipExchangeRate = Double.parseDouble(LimsUtil.checkNull(inventoryRs.get(0).get("lshipExchangeRate"), "0").toString()); //선적 환율
        double deliverUpriceForeignCurrenc = Double.parseDouble(LimsUtil.checkNull(inventoryRs.get(0).get("deliverUpriceForeignCurrenc"), "0").toString()); //입고단가(외화)

        logger.info("원deliverAmt :" + df.format(deliverAmt));

//        if ("10".equals(inventoryRs.get(0).get("poType").toString())) //수입
//        {
//            deliverAmt = deliverAmt / lshipExchangeRate;	//입고금액은  선적환율을 곱하여 들어왔기때문에 선적환율을 나눠준다
//        }

        double deliverQuantity = Double.parseDouble(LimsUtil.checkNull(inventoryRs.get(0).get("deliverQuantity"), "0").toString()); //선적 환율
        double deliverWgt = Double.parseDouble(LimsUtil.checkNull(inventoryRs.get(0).get("deliverWgt"), "0").toString()); //선적 환율

        String set1 = inventoryRs.get(0).get("set1").toString();

        //----------------수입원가 계산
        //물대금액(B/L) =  금액(USD) * 결재환율
        double releaseExpectQuantity = Double.parseDouble(LimsUtil.checkNull(parameter.get("releaseExpectQuantity"), "0").toString());
        double releaseExpectWgt = Double.parseDouble(LimsUtil.checkNull(parameter.get("releaseExpectWgt"), "0").toString());

        double releaseBaseQw = 0;
        double deliverBaseQw = 0;
        if ("KG".equals(set1) ) {
            releaseBaseQw = releaseExpectWgt;
            deliverBaseQw = deliverWgt;
        } else {
            releaseBaseQw = releaseExpectQuantity;
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

        logger.info("set1 :" + set1 + "//releaseBaseQw :" + releaseBaseQw);

        logger.info("물대금액(B/L) 금액(USD) :" + df.format(deliverAmt) +"*"+  signExchangeRate  + "=" + df.format(wonwtrAmt));
        //관세금액(통관) = ( (금액(USD) * 통관 결재환율)-공제금액+보험료 ) * 관세율
//        double tariffAmt = (Math.round(deliverAmt * lshipExchangeRate) + sumCommAmt) * gvrntaxRate;
        double tariffAmt = Double.parseDouble(LimsUtil.checkNull(deliveritemOtherAmtDivDAO.getTariffAmt(parameter), "0"));
//        logger.info("관세금액(통관) tariffAmt : (Math.round(" + deliverAmt + "*" + lshipExchangeRate + ")-" + sumCommAmt + ") *"+ gvrntaxRate + "=" + tariffAmt);
        logger.info("관세금액(통관) tariffAmt :" + tariffAmt);
        //부대비용금액
        double otherAmtTotAmt = Double.parseDouble(LimsUtil.checkNull(deliveritemOtherAmtDivDAO.getOtherAmt(parameter), "0"));
        releaseMgmtMap.put("otherAmtTotAmt", otherAmtTotAmt); //부대비 총액 세팅
        logger.info("부대비용금액 otherAmt :" + otherAmtTotAmt);




        ///////////////view 수입원가  계산///////////////
        Record incomeCstRs = inventoryMgmtDeliverDAO.selectIncomeCst2(parameter); //총수입원가 금액 조회

        double buyCst =  incomeCstRs.getDouble("buyCst");	 //수입원가
        double focDeliverQuantity =  incomeCstRs.getDouble("deliverQuantity");	 //수입원가
//        long viewIncomeCstAmt = (long)(deliverAmt + otherAmtTotAmt) ;

        long realIncomeCstAmt = Math.round(buyCst * releaseBaseQw / focDeliverQuantity);	//총수입원가(krw) * 출고수량 / 입고수량
        logger.info("realIncomeCstAmt :" + df.format(buyCst) + "*" + releaseBaseQw + "/" + focDeliverQuantity +"=" + df.format((realIncomeCstAmt)) );
        /////////////////////////////////////////////////


        //수입원가금액 : 물대금액(B/L) + 관세금액(통관)+ 부대비용금액
        long incomeCstAmt = (long) (wonwtrAmt +  otherAmtTotAmt);
        logger.info("수입원가금액 incomeCstAmt :" + df.format(wonwtrAmt) + "+" +  otherAmtTotAmt + "=" + incomeCstAmt);
        releaseMgmtMap.put("buyCst", incomeCstAmt); //매입원가 세팅

        //매입단가 계산 : 매입원가 / 수량
        long buyUprice = Math.round(incomeCstAmt / deliverBaseQw);
        logger.info("매입단가 buyUprice :" + incomeCstAmt + "/" + deliverBaseQw + "=" + df.format(buyUprice) );
        releaseMgmtMap.put("buyUprice", buyUprice); //매입단가 세팅
        incomeCstAmt = (long)(buyUprice*deliverBaseQw);
        logger.info("매입단가 buyCst :" + buyUprice + "*" + deliverBaseQw + "=" + df.format((incomeCstAmt)) );
        //releaseMgmtMap.put("buyCst", buyUprice*deliverBaseQw); //매입원가 세팅

        //----------------수수료 및 연이자 내역 계산
        //당사이윤 = (수입원가금액/0.98) - 수입원가금액
        Record salsGainRatRd = proposalDAO.getSalsGainRat(parameter);
        double expectSalsGainrat = 0;
        if (salsGainRatRd != null) {
            expectSalsGainrat = Double.parseDouble(LimsUtil.checkNull(salsGainRatRd.getString("salsGainRat"), "1"));
        } else {
            expectSalsGainrat = 0;
        }
        logger.info("당사이윤 expectSalsGainrat :" + expectSalsGainrat);

        String releaseDate = parameter.get("releaseDate").toString();
        logger.info(inventoryRs.get(0).get("lastSaleEdate").toString() + "//orderDate :" + releaseDate);
        long blckDiff = 0;
        double blckMark = 0;
        if (!"".equals( LimsUtil.checkNull(parameter.get("blckMark"),""))) //화면에서 패널티 변경시 변경된 패널티 적용
        {
            blckMark = Double.parseDouble(LimsUtil.checkNull(parameter.get("blckMark").toString(), "0").toString());
        } else {
            if (Integer.parseInt(inventoryRs.get(0).get("lastSaleEdate").toString()) < Integer.parseInt(releaseDate)) //판매종료일 보다 주문이 늦게 드어갔다면 패널티
            {
                blckDiff = diffOfDate(inventoryRs.get(0).get("lastSaleEdate").toString(), releaseDate); //승인요청일(주문일로 바뀜) - 판매종료일
                logger.info("blckDiff :" + blckDiff);

                Record blckRc = proposalDAO.getRatio(paramMap);
                logger.info("blckRc :" + blckRc);
                logger.info("blckMark1 :" + parameter.get("blckMark").toString());
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
                    releaseMgmtMap.put("blckMark", blckMark); //창고 보관 비용
                }
            }
        }
        logger.info("blckMark2 :" + blckMark);
        releaseMgmtMap.put("blckMark", blckMark); //벌점 세팅
        double ourComProfit = 0;
        //수수료 적용
        if ((1 - (expectSalsGainrat / 100)) != 0) //이윤없음
        {
            ourComProfit = Math.round((incomeCstAmt / ((1 - (expectSalsGainrat / 100))))) - incomeCstAmt; //벌점 포함
        }
        if (expectSalsGainrat < 0) //이윤없음
        {
            ourComProfit = 0;
        }
        logger.info("당사이윤 ourComProfit :" + "(" + incomeCstAmt + "/(1-(" + expectSalsGainrat + "/100))) -" + incomeCstAmt + "="
                + ourComProfit);

        double blacOurComProfit = 0;
        //벌점 적용
        if (blckMark / 100 != 0) //이윤없음
        {
            blacOurComProfit = Math.round((incomeCstAmt / (1 - (blckMark / 100)))) - incomeCstAmt; //벌점 포함
        }
        if (blckMark < 0) //이윤없음
        {
            blacOurComProfit = 0;
        }
        logger.info("당사이윤 blacOurComProfit :" + "(" + incomeCstAmt + "/(1-(" + blckMark + "/100) )) -" + incomeCstAmt + "="
                + blacOurComProfit);

        //창고보관료 : (수량 * 보관료 * 창고보관일 + 수량  * 입출고비 )
        long whChargDd = diffOfDate(inventoryRs.get(0).get("firstDeliverDate").toString(), releaseDate); //창고보관일 : 판매종료일 - 창고입고일 +1
        parameter.put("from", releaseDate);
        parameter.put("to", inventoryRs.get(0).get("firstDeliverDate").toString() );
        whChargDd = deliveritemOtherAmtDivDAO.getDiffOfDate(parameter);
        logger.info("창고보관료 releaseDate :" + releaseDate+ "//"
                + inventoryRs.get(0).get("firstDeliverDate").toString() + "="+ whChargDd);

        logger.info("창고보관료 whChargDd :" + whChargDd);
        //        focOrderQuantity = parameter.get("focOrderQuantity");
        //        double focOrderQuantity = Double.parseDouble(LimsUtil.checkNull(parameter.get("orderQuantity"),"0").toString());

        long chargAmt = Math.round((deliverBaseQw * whChargCost * whChargDd + deliverBaseQw * ioutCost));
        logger.info("창고보관료 chargAmt :" + deliverBaseQw + "*" + whChargCost + "*" + whChargDd + "+" + deliverBaseQw + "*"
                + ioutCost + "=" + chargAmt);
        releaseMgmtMap.put("whChargCost", chargAmt); //창고 보관 비용

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
                //throw processException("ft.fts.fail.saleOrderList.nosignDd.alert");	//통관수수료의 결재일자가 존재하지 않습니다.	//차후주석 풀기
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

        releaseMgmtMap.put("wtrlrgTariffInt", wtrlrgTariffInt); //관세/부대비용이자  세팅
        //수수료 및 연이자 내역 :  당사이윤(벌점포함) +  창고보관료 + 물대이자 + 관세/부대비용이자 + 벌점
        double totalComm = ourComProfit + blacOurComProfit + chargAmt + wonwtrInt + wtrlrgTariffInt;
        logger.info("수수료 및 연이자 내역 totalComm :" + df.format(ourComProfit)+ "+" + df.format(blacOurComProfit) + "+"  + "+" + df.format(chargAmt)  + "+" + df.format(wonwtrInt) + "+" + df.format(wtrlrgTariffInt) + "="+ df.format(totalComm));

        long saleUprice = 0;
        long orgSaleUprice = Long.parseLong(LimsUtil.checkNull(parameter.get("orgSaleUprice"), "0".toString()).toString());
        logger.info("변경 판매단가 orgSaleUprice :" + orgSaleUprice);
        if (parameter.get("orgSaleUprice") != null) {
            saleUprice = orgSaleUprice;
        } else {
            saleUprice = Math.round((incomeCstAmt + totalComm) / deliverBaseQw);
        }
        //        long saleUprice = Math.round((incomeCstAmt + totalComm) / deliverQuantity);
        releaseMgmtMap.put("saleUprice", saleUprice); //판매단가 세팅
        logger.info("판매단가 saleUprice :(" + df.format(incomeCstAmt) + "+" + df.format(totalComm) + ")/" + deliverBaseQw + "=" + df.format(saleUprice));

        logger.info("변경 판매단가 releaseBaseQw :" + releaseBaseQw);
        //판매금액 : 판매단가 * 수량
        double saleAmt = Math.round(saleUprice * releaseBaseQw);
        String saleOrderType = parameter.get("saleOrderType").toString();	//판매주문유형
        logger.info("판매금액 saleAmt :" + saleUprice  +"*"+  releaseBaseQw +"="+ Math.round(saleAmt)+"//saleOrderType :"+saleOrderType);


        ///////////////////////////////////


        double divRate = Math.round(releaseBaseQw / deliverBaseQw * 100d) / 100d;
        logger.info("divRate :" + divRate);


        releaseMgmtMap.put("saleTransportAmt", Math.round(ioutCost* divRate)); //입출고 비용
        releaseMgmtMap.put("otherAmtTotAmt", Math.round(otherAmtTotAmt* divRate)); //부대비 총액 세팅
//        releaseMgmtMap.put("buyCst", Math.round(incomeCstAmt* divRate)); //매입원가 세팅
        releaseMgmtMap.put("buyCst", realIncomeCstAmt); //매입원가 세팅

//        releaseMgmtMap.put("buyUprice", Math.round(buyUprice* divRate)); //매입단가 세팅
        releaseMgmtMap.put("blckMark", Math.round(blckMark* divRate)); //벌점 세팅
        releaseMgmtMap.put("whChargCost", Math.round(chargAmt* divRate)); //창고 보관 비용
        releaseMgmtMap.put("wtrlrgTariffInt", Math.round(wtrlrgTariffInt* divRate)); //관세/부대비용이자  세팅
        releaseMgmtMap.put("saleUprice", saleUprice); //판매단가 세팅

        if (parameter.get("orgSaleCst") != null)	//판매금액 변경시 20451028 서영미
        {
            //판매금액 변경시
            long saleCst = 0;
            long orgSaleCst = Long.parseLong(LimsUtil.checkNull(parameter.get("orgSaleCst"), "0".toString()).toString());
            logger.info("변경 판매단가 orgSaleCst :" + orgSaleCst);
            if (parameter.get("orgSaleCst") != null) {
                saleCst = orgSaleCst;
            }
            //        long saleUprice = Math.round((incomeCstAmt + totalComm) / deliverQuantity);

            logger.info("변경 판매금액 saleCst :" + saleCst);

            releaseMgmtMap.put("saleAmt", saleCst); //매입원가 세팅
            releaseMgmtMap.put("realSaleAmt", saleCst); //매입원가 세팅
        }
        else
        {
        	/*
            if ( "50".equals(saleOrderType) )	//판매주문유형:부서이관
            {
                releaseMgmtMap.put("saleAmt", Math.round(incomeCstAmt* divRate)); //매입원가 세팅
                releaseMgmtMap.put("realSaleAmt", Math.round(incomeCstAmt* divRate)); //매입원가 세팅
            }
            else
            {
                releaseMgmtMap.put("saleAmt", saleAmt); //판매금액 세팅
                releaseMgmtMap.put("realSaleAmt", saleAmt); //실판매금액 세팅
            }
            */
        	releaseMgmtMap.put("saleAmt", saleAmt); //판매금액 세팅
            releaseMgmtMap.put("realSaleAmt", saleAmt); //실판매금액 세팅
        }

        logger.info("원buyCst :" + Math.round(incomeCstAmt ));
        logger.info("otherAmtTotAmt :" + Math.round(otherAmtTotAmt * divRate));
        logger.info("buyCst 나누기:" + Math.round(incomeCstAmt * divRate));
        logger.info("blckMark :" + Math.round(blckMark * divRate));
        logger.info("whChargCost :" + Math.round(chargAmt * divRate));
        logger.info("wtrlrgTariffInt :" + Math.round(wtrlrgTariffInt * divRate));
        logger.info("saleCst :" + saleAmt);
        return releaseMgmtMap;
    }

    /**
     * 출고에 대하여 관리 DataSetMap의 데이터를 rowType에 따라 Delete 처리한다.
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
    public int deleteReleaseReg(DataSetMap list) throws Exception {
        int insRowCnt = 0;
        int updRowCnt = 0;
        int delRowCnt = 0;
        logger.info("list.size() ::::" + list.size());
        Map<String, Object> sumReleaseMgmtMap = new HashMap();
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> parameter = list.get(i);

            //주문상태(품목의 상태)가 한 품목이라도 승인요청 이후 단계가 있으면 불가
            int saleApprvCnt = releaseMgmtDAO.getSaleApprvCnt(parameter);
            if (saleApprvCnt > 0) {
                throw processException("ft.fts.fail.saleOrderList.delete.alert"); //승인요청 이후 단계가 존재합니다. 삭제 할 수 없습니다.
            }
            logger.info("deliverNum ::::" + parameter.get("deliverNum"));
            logger.info("releaseNum ::::" + parameter.get("releaseNum"));
            sumReleaseMgmtMap.put("releaseNum", parameter.get("releaseNum")); //출고번호
            sumReleaseMgmtMap.put("releaseNumSeq", parameter.get("releaseNumSeq")); //출고번호 seq
            sumReleaseMgmtMap.put("deliverNum", parameter.get("deliverNum")); //입고번호
            sumReleaseMgmtMap.put("saleOrderNum", parameter.get("saleOrderNum")); //주문번호
            sumReleaseMgmtMap.put("saleOrderNumSeq", parameter.get("saleOrderNumSeq")); //주문 SEQ

            sumReleaseMgmtMap.put("flag", "U");
            double totQuantity = Double.parseDouble(LimsUtil.checkNull(parameter.get("totQuantity"), "0").toString());
            double releaseExpectQuantity = Double.parseDouble(LimsUtil.checkNull(parameter.get("releaseExpectQuantity"), "0").toString());

            double totWgt = Double.parseDouble(LimsUtil.checkNull(parameter.get("totWgt"), "0").toString());
            double releaseExpectWgt = Double.parseDouble(LimsUtil.checkNull(parameter.get("releaseExpectWgt"), "0").toString());

            totQuantity = totQuantity - releaseExpectQuantity;
            totWgt = totWgt - releaseExpectWgt;
            sumReleaseMgmtMap.put("totQuantity", totQuantity); //총 수량:총출고예정수량
            sumReleaseMgmtMap.put("totWgt", totWgt); //총 수량:총출고예정수량

            logger.info("totQuantity :" + totQuantity + "-" + releaseExpectQuantity + "=" + totQuantity);
            logger.info("totWgt :" + totWgt + "-" + releaseExpectWgt + "=" + totWgt);

            double deliverUpriceForeignCurrenc = Double.parseDouble(LimsUtil.checkNull(parameter.get("deliverUpriceForeignCurrenc"), "0").toString()); //입고 단가 외화
            double deliverUpriceKrw = Double.parseDouble(LimsUtil.checkNull(parameter.get("deliverUpriceKrw"), "0").toString()); //입고 단가 원화

            double totAmtUsd = Math.round(totQuantity * deliverUpriceForeignCurrenc);
            double totAmtKrw = Math.round(totWgt * deliverUpriceKrw);
            logger.info("totAmtUsd :" + totQuantity + "*" + deliverUpriceForeignCurrenc + "=" + totAmtUsd);
            logger.info("totAmtKrw :" + totWgt + "*" + deliverUpriceKrw + "=" + totAmtKrw);
            sumReleaseMgmtMap.put("totAmtUsd", totAmtUsd); //총 금액_USD
            sumReleaseMgmtMap.put("totAmtKrw", totAmtKrw); //총 금액 KRW

            sumReleaseMgmtMap.put("releaseExpectQuantity", -releaseExpectQuantity); //출고예정수량
            sumReleaseMgmtMap.put("releaseExpectWgt", -releaseExpectWgt); //출고예정수량

            delRowCnt += releaseMgmtDAO.update(sumReleaseMgmtMap); //출고 총금액,총수량, 총 금액_USD, 총 금액 KRW 수정

            delRowCnt += saleOrderItemMgmtDAO.updateReleaseApprvReqQuantity(sumReleaseMgmtMap); // 판매주문테이블의 출고승인요청수량(중량)을 +

            delRowCnt += inventoryMgmtDeliverDAO.updateReleaseWaitQuantity(sumReleaseMgmtMap); //입고 TABLE에서 입고번호에 해당하는 Row의 출고대기수량(중량) 감소

            sumReleaseMgmtMap.put("orderRemainQuantity", releaseExpectQuantity);
            sumReleaseMgmtMap.put("orderRemainWgt", releaseExpectWgt);
            delRowCnt += inventoryMgmtDeliverDAO.updateOrderRemainQuantity(sumReleaseMgmtMap); //입고 TABLE에서 입고번호에 해당하는 Row의 주문잔여수량(중량) 증가

            delRowCnt += releaseItemMgmtDAO.delete(sumReleaseMgmtMap); //출고 상세

            int cnt = releaseItemMgmtDAO.getReleaseMgmtCnt(sumReleaseMgmtMap); //출고 상세 건수 조회
            logger.info("cnt :" + cnt);
            if (cnt == 0) //출고상세가 없을시 출고 마스터 삭제
            {
                delRowCnt += releaseMgmtDAO.delete(sumReleaseMgmtMap); //출고 마스트
            }

        }

        return insRowCnt + updRowCnt + delRowCnt;
    }

    /**
     * 판매 주문내역에 대하여 출고(품목)를 관리 출력 처리한다.
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
    public int printReleaseReg(DataSetMap list) throws Exception {
        int updRowCnt = 0;
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> rowData = list.get(i);

            rowData.put("releaseStatusCd", "15"); //입고요청서 출력
            updRowCnt += releaseMgmtDAO.printReleaseReg(rowData);
        }

        return updRowCnt;
    }

    /**
     * 판매 주문내역에 대하여 출고(품목)를 관리 출고승인요청 처리한다.
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
    public int releaseApprovReq(DataSetMap list, Map<String, Object> parameter) throws Exception {
        //여신체크
    	
    	//2020.05.18 김명섭 결함수정: 화면 그리드에서 다중 거래처 선택 후 처리할 거래처만 선택할 때 list.get(0) 로직은 잘못된 거래처코드로 처리될 수 있음
    	//logger.info("saleType ::::" + list.get(0).get("saleOrderType"));
    	//parameter.put("custCd", list.get(0).get("custCd"));
        //if ( !"50".equals(list.get(0).get("saleOrderType").toString()) ) {	// 부서이관이 아닐 경우에만
        //	lendingChk(parameter);
        //}
        for (int i = 0; i < list.size(); i++) {
            if ("1".equals(list.get(i).get("chk"))) {
            	logger.info("saleType ::::" + list.get(i).get("saleOrderType"));
            	parameter.put("custCd", list.get(i).get("custCd"));
                if ( !"50".equals(list.get(i).get("saleOrderType").toString()) ) {	// 부서이관이 아닐 경우에만
                	lendingChk(parameter);
                }
                break;
            }
        }    	

        int updRowCnt = 0;
        Map<String, Object> sumReleaseMgmtMap = new HashMap();
        String currYymmdd = LimsUtil.getDate("yyyyMMdd");
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> rowData = list.get(i);
            int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (rowType == DataSet.ROW_TYPE_UPDATED && "1".equals(rowData.get("chk"))) {
                rowData.put("preAmt1Yn", LimsUtil.checkNull(parameter.get("preAmt1Yn"), "1"));	// 계약이행예치금포함여부



                rowData.put("apprvReqDate", currYymmdd); //출고승인요청일
                rowData.put("releaseStatusCd", "20"); //출고승인요청

                logger.info("realSaleAmt ::::" + rowData.get("realSaleAmt"));

                updRowCnt += releaseMgmtDAO.releaseApprovReq(rowData);
            }
        }

        return updRowCnt;
    }

    /**
     * 출고에 대하여 관리 출고등록 취소 처리한다.
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
    public int releaseRollCancel(DataSetMap list) throws Exception {
        int insRowCnt = 0;
        int updRowCnt = 0;
        int delRowCnt = 0;
        logger.info("list.size() ::::" + list.size());
        Map<String, Object> releaseMgmtMap = new HashMap();
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> parameter = list.get(i);
            int rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (rowType == DataSet.ROW_TYPE_UPDATED && "1".equals(parameter.get("chk"))) {

                releaseMgmtMap.put("releaseNum", parameter.get("releaseNum")); //출고번호
                releaseMgmtMap.put("releaseNumSeq", parameter.get("releaseNumSeq")); //출고번호 seq
                releaseMgmtMap.put("deliverNum", parameter.get("deliverNum")); //입고번호
                releaseMgmtMap.put("saleOrderNum", parameter.get("saleOrderNum")); //주문번호
                releaseMgmtMap.put("saleOrderNumSeq", parameter.get("saleOrderNumSeq")); //주문 SEQ

                logger.info("deliverNum ::::" + parameter.get("deliverNum"));
                logger.info("releaseNum ::::" + parameter.get("releaseNum"));
                releaseMgmtMap.put("flag", "U");
                double releaseExpectQuantity = Double.parseDouble(LimsUtil.checkNull(parameter.get("releaseQuantity"), "0").toString());
                double releaseExpectWgt = Double.parseDouble(LimsUtil.checkNull(parameter.get("realWgt"), "0").toString());
                double releaseWgt = Double.parseDouble(LimsUtil.checkNull(parameter.get("releaseWgt"), "0").toString());

                if ( releaseWgt != releaseExpectWgt)	//중량변경시
                {
                    logger.info("####중량변경건###");
                    releaseMgmtMap.put("saleOrderStatus", "10"); //판매주문등록
                    releaseMgmtMap.put("releaseExpectQuantity", -releaseExpectQuantity); //출고예정수량
                    releaseMgmtMap.put("releaseExpectWgt", -releaseExpectWgt); //실중량만큼 -

                    delRowCnt += saleOrderItemMgmtDAO.updateReleaseApprvReqQuantity(releaseMgmtMap); //실중량 -
                    delRowCnt += inventoryMgmtDeliverDAO.updateReleaseWaitQuantity(releaseMgmtMap); //실중량 -

                    releaseMgmtMap.put("orderRemainQuantity", releaseExpectQuantity);
                    releaseMgmtMap.put("orderRemainWgt", releaseWgt);
                    delRowCnt += inventoryMgmtDeliverDAO.updateOrderRemainQuantity(releaseMgmtMap); //원출고중량 만큼 +

                    delRowCnt += releaseItemMgmtDAO.delete(releaseMgmtMap); //출고 상세
                }
                else
                {
                    logger.info("####정상 출고요청 취소건###");
                    releaseMgmtMap.put("saleOrderStatus", "10"); //판매주문등록
                    releaseMgmtMap.put("releaseExpectQuantity", -releaseExpectQuantity); //출고예정수량
                    releaseMgmtMap.put("releaseExpectWgt", -releaseExpectWgt); //출고예정수량

                    delRowCnt += saleOrderItemMgmtDAO.updateReleaseApprvReqQuantity(releaseMgmtMap); // 판매주문테이블의 출고승인요청수량(중량)을 +
                    delRowCnt += inventoryMgmtDeliverDAO.updateReleaseWaitQuantity(releaseMgmtMap); //입고 TABLE에서 입고번호에 해당하는 Row의 출고대기수량(중량) 감소

                    releaseMgmtMap.put("orderRemainQuantity", releaseExpectQuantity);
                    releaseMgmtMap.put("orderRemainWgt", releaseExpectWgt);
                    delRowCnt += inventoryMgmtDeliverDAO.updateOrderRemainQuantity(releaseMgmtMap); //입고 TABLE에서 입고번호에 해당하는 Row의 주문잔여수량(중량) 증가

                    delRowCnt += releaseItemMgmtDAO.delete(releaseMgmtMap); //출고 상세

                }

                delRowCnt += releaseItemMgmtDAO.delete(releaseMgmtMap); //출고 상세
            }
        }

        return insRowCnt + updRowCnt + delRowCnt;
    }

    /**
     * 출고에 대하여 관리 거래명세서 출력 처리한다.
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
    public int printDealReqDocPublish(DataSetMap list) throws Exception {
        int updRowCnt = 0;
        logger.info("list.size() ::::" + list.size());
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> rowData = list.get(i);
            //            rowData.put("releaseStatusCd", "15");	//입고요청서 출력
            int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (!"1".equals(LimsUtil.checkNull(list.get(0).get("srcPrintChk")))) //조회출력
            {
                if (rowType == DataSet.ROW_TYPE_UPDATED && "1".equals(rowData.get("chk")))
                {
                    logger.info("----------1");
                    updRowCnt += releaseMgmtDAO.printReleaseReg(rowData);
                }
            }
            else
            {
                logger.info("----------2");
                updRowCnt += releaseMgmtDAO.printReleaseReg(rowData);
            }

        }
        logger.info("updRowCnt::::" + updRowCnt);
        return updRowCnt;
    }

    /**
     * 출고에 대하여 관리 거래명세서 출력 처리한다.
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
    public int printDealReqDocPublishChk(DataSetMap list) throws Exception {
        int updRowCnt = 0;
        logger.info("list.size() ::::" + list.size());
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> rowData = list.get(i);
            //            rowData.put("releaseStatusCd", "15");	//입고요청서 출력
            updRowCnt += releaseMgmtDAO.printReleaseRegChk(rowData);
        }
        logger.info("updRowCnt::::" + updRowCnt);
        return updRowCnt;
    }
    /**
     * 판매 주문내역에 대하여 출고(품목)를 관리 출고승인요청취소 처리한다.
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
    public int releaseApprovReqCancel(DataSetMap list) throws Exception {
        int updRowCnt = 0;
        Map<String, Object> sumReleaseMgmtMap = new HashMap();

        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> rowData = list.get(i);
            int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (rowType == DataSet.ROW_TYPE_UPDATED && "1".equals(rowData.get("chk"))) {


                rowData.put("releaseStatusCd", "10"); //출고승인요청
                //1.출고요청취소
                updRowCnt += releaseMgmtDAO.releaseApprovReqCancel(rowData);

                Record rs = releaseItemMgmtDAO.selectReleaseItemMgmtInfo(rowData);

                double releaseQuantity = rs.getDouble("releaseQuantity"); //출고수량
                double releaseWgt = rs.getDouble("releaseWgt"); //출고중량

                sumReleaseMgmtMap.put("flag", "U");
                sumReleaseMgmtMap.put("deliverNum", rowData.get("deliverNum")); //입고번호
                sumReleaseMgmtMap.put("saleOrderNum", rowData.get("saleOrderNum")); //판매 주문 번호
                sumReleaseMgmtMap.put("saleOrderNumSeq", rowData.get("saleOrderNumSeq")); //판매 주문 번호 순번

                logger.info("releaseExpectQuantity :" + releaseQuantity + "//" + releaseWgt);
                sumReleaseMgmtMap.put("releaseExpectQuantity", -releaseQuantity); //출고예정수량
                sumReleaseMgmtMap.put("releaseExpectWgt", -releaseWgt); //출고예정중량
                //2.판매주문테이블의 출고승인요청수량(중량)을 -
                //            updRowCnt += saleOrderItemMgmtDAO.updateReleaseApprvReqQuantity(sumReleaseMgmtMap);
            }
        }

        return updRowCnt;
    }

    public static long diffOfDate(String begin, String end) throws Exception {

        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
        Date beginDate = formatter.parse(begin);
        Date endDate = formatter.parse(end);

        long diff = endDate.getTime() - beginDate.getTime();
        long diffDays = diff / (24 * 60 * 60 * 1000);

        return diffDays;
    }

    /**
     * 출고 주문내역에 대하여 출고를 관리 목록을 조회한다.
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
    public RecordSet selectReleaseMgmtList(Map<String, Object> mapParam) throws Exception {
        return releaseMgmtDAO.selectReleaseMgmtList(mapParam);
    }

    /**
     * 출고 품목 주문내역에 대하여 출고를 관리 목록을 조회한다.
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
    public RecordSet selectReleaseItemMgmtList(Map<String, Object> mapParam) throws Exception {
        return releaseMgmtDAO.selectReleaseItemMgmtList(mapParam);
    }

    public int lendingChk(Map<String, Object> rowData) throws Exception
    {
        logger.info("attachDept ::::" + rowData.get("attachDept"));

        logger.info("custCd1 ::::" + rowData.get("custCd"));
        rowData.put("attachDept", ""); //여신체크용 귀속부서 없이 조회
        RecordSet lendingRs = getLendingChk(rowData); //여신금액 조회
        Record lendingRs2 = getLendingChk2(rowData); //기출고금액 조회

        long creditAmount = 0;
        long rmnAmt = 0;
        long preAmt1 = 0;
        long preAmt2 = 0;
        long creditOverAmount = 0;
        if (lendingRs != null) {
            creditAmount = Long.parseLong(lendingRs.get(0).get("creditAmount").toString()); //여신금액

            rmnAmt = Long.parseLong(lendingRs.get(0).get("rmnAmt").toString()); //외상매출잔액 (-)
            preAmt1 = Long.parseLong(lendingRs.get(0).get("preAmt1").toString()); //계약이행예치금
            preAmt2 = Long.parseLong(lendingRs.get(0).get("preAmt2").toString()); //선수잔액
            creditOverAmount = Long.parseLong(lendingRs.get(0).get("creditOverAmount").toString()); //가용여신 (+)	 20151104 전윤희
        }
        //2019.04.03 김명섭 총여신금액에 계약이행예치금(preAmt1) 제외 (컴플라이언스 이성희과장 전산의뢰 요청사항)
        //long totCreditAmount = creditAmount - rmnAmt + preAmt2 + (LimsUtil.checkNull(rowData.get("preAmt1Yn"), "1").equals("1")?preAmt1:0) +creditOverAmount; //총여신금액
        long totCreditAmount = creditAmount - rmnAmt + preAmt2 + creditOverAmount; //총여신금액

        long releaseAmt = 0;
        long reqAmt = 0;
        long approvAmt = 0;
        long confirmAmt = 0;
        if (lendingRs2 != null) {
            releaseAmt = lendingRs2.getLong("releaseAmt"); //출고요청금액
            reqAmt = lendingRs2.getLong("reqAmt"); //승인요청금액
            approvAmt = lendingRs2.getLong("approvAmt"); //팀장승인금액
            confirmAmt = lendingRs2.getLong("confirmAmt"); //확정금액
        }
        long totInsideAmount = releaseAmt + reqAmt + approvAmt + confirmAmt; //기출고금액

        String str = "여신금액 :" + LimsUtil.getCommaNumber(creditAmount, "###,###,###,##0") + "\n";
                if (LimsUtil.checkNull(rowData.get("preAmt1Yn"), "1").equals("1")) {
                    str += "계약이행예치금 :"+ LimsUtil.getCommaNumber(preAmt1, "###,###,###,##0") + "\n";
                }
                str += "선수잔액 :"+ LimsUtil.getCommaNumber(preAmt2, "###,###,###,##0") + "\n"
                + "외상매출잔액 :"+ LimsUtil.getCommaNumber(rmnAmt, "###,###,###,##0") + "\n"

                + "임시여신 :"+ LimsUtil.getCommaNumber(creditOverAmount, "###,###,###,##0") + "\n"

                + "총여신금액   :"+ LimsUtil.getCommaNumber(totCreditAmount, "###,###,###,##0") + "\n" + "\n"
                + "출고등록 :"+ LimsUtil.getCommaNumber(releaseAmt, "###,###,###,##0") + "\n"
                + "승인요청 :"+ LimsUtil.getCommaNumber(reqAmt, "###,###,###,##0") + "\n"
                + "팀장승인 :"+ LimsUtil.getCommaNumber(approvAmt, "###,###,###,##0")
                + "\n" + "출고확정 :"+ LimsUtil.getCommaNumber(confirmAmt, "###,###,###,##0")
                + "\n" + "기출고금액 :"+ LimsUtil.getCommaNumber(totInsideAmount, "###,###,###,##0");
        logger.info("str ::::" + str);
        if (totCreditAmount < totInsideAmount) {	//여신금액 < 기출고금액 : 차후 <=로 수정
            long gap = totInsideAmount - totCreditAmount;
            str += "\n기출고금액 [" + LimsUtil.getCommaNumber(totInsideAmount, "###,###,###,##0") + "]  총여신금액["
                    + LimsUtil.getCommaNumber(totCreditAmount, "###,###,###,##0") + "] 대비 여신["+LimsUtil.getCommaNumber(gap, "###,###,###,##0")+"]이 부족합니다.";
            throw new BizException(str);
        }

        logger.info("str2 ::::" + str);

        return 1;
    }

    /**
     * 판매 주문내역에 대하여 출고(품목)를 관리 팀장승인 처리한다.
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
    public int releaseApprov(DataSetMap list, Map<String, Object> parameter) throws Exception {
        //여신체크
    	//2020.05.18 김명섭 결함수정: 화면 그리드에서 다중 거래처 선택 후 처리할 거래처만 선택할 때 list.get(0) 로직은 잘못된 거래처코드로 처리될 수 있음
    	//logger.info("saleType ::::" + list.get(0).get("saleOrderType"));
    	//parameter.put("custCd", list.get(0).get("custCd"));
        //if ( !"50".equals(list.get(0).get("saleOrderType").toString()) ) {	// 부서이관이 아닐 경우에만
        //	lendingChk(parameter);
        //}
        ////lendingChk(parameter);
        for (int i = 0; i < list.size(); i++) {
            if ("1".equals(list.get(i).get("chk"))) {
            	logger.info("saleType ::::" + list.get(i).get("saleOrderType"));
            	parameter.put("custCd", list.get(i).get("custCd"));
                if ( !"50".equals(list.get(i).get("saleOrderType").toString()) ) {	// 부서이관이 아닐 경우에만
                	lendingChk(parameter);
                }
                break;
            }
        }    	
        
        int updRowCnt = 0;
        Map<String, Object> sumReleaseMgmtMap = new HashMap();
        String currYymmdd = LimsUtil.getDate("yyyyMMdd");

        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> rowData = list.get(i);
            int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (rowType == DataSet.ROW_TYPE_UPDATED && "1".equals(rowData.get("chk"))) {
                rowData.put("preAmt1Yn", LimsUtil.checkNull(parameter.get("preAmt1Yn"), "1"));	// 계약이행예치금포함여부
 logger.info("custCd :::"+rowData.get("custCd"));

                rowData.put("apprvDate", currYymmdd); //팀장승인일
                rowData.put("releaseStatusCd", "30"); //팀장승인
                updRowCnt += releaseItemMgmtDAO.releaseApprov(rowData);

                Record rs = releaseItemMgmtDAO.selectReleaseItemMgmtInfo(rowData);

                sumReleaseMgmtMap.put("saleOrderNum", rowData.get("saleOrderNum")); //판매 주문 번호
                sumReleaseMgmtMap.put("saleOrderNumSeq", rowData.get("saleOrderNumSeq")); //판매 주문 번호 순번
                sumReleaseMgmtMap.put("releaseNum", rowData.get("releaseNum")); //출고번호
            }
        }

        return updRowCnt;
    }

    /**
     * 판매 주문내역에 대하여 출고(품목)를 관리 팀장승인취소 처리한다.
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
    public int releaseApprovCancel(DataSetMap list) throws Exception {
        int updRowCnt = 0;
        Map<String, Object> sumReleaseMgmtMap = new HashMap();
        String currYymmdd = LimsUtil.getDate("yyyyMMdd");
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> rowData = list.get(i);
            int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (rowType == DataSet.ROW_TYPE_UPDATED && "1".equals(rowData.get("chk"))) {
                rowData.put("apprvReqDate", currYymmdd); //출고승인요청일
                rowData.put("releaseStatusCd", "20"); //출고승인요청

                updRowCnt += releaseMgmtDAO.releaseApprovReq(rowData);
            }
        }

        return updRowCnt;
    }

    /**
     * 판매 주문내역에 대하여 출고(품목)를 관리 출고확정 처리한다.
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
    public int releaseConfirm(DataSetMap search, DataSetMap list, LoginDTO loginDTO) throws Exception {
        //여신체크
    	//2020.05.18 김명섭 결함수정: 화면 그리드에서 다중 거래처 선택 후 처리할 거래처만 선택할 때 list.get(0) 로직은 잘못된 거래처코드로 처리될 수 있음
        //search.get(0).put("custCd", list.get(0).get("custCd"));
        //if ( !"50".equals(list.get(0).get("saleOrderType").toString()) ) {	// 부서이관이 아닐 경우에만
        //	lendingChk(search.get(0));
        //}
        ////lendingChk(search.get(0));
        for (int i = 0; i < list.size(); i++) {
            if ("1".equals(list.get(i).get("chk"))) {
            	search.get(0).put("custCd", list.get(i).get("custCd"));
                if ( !"50".equals(list.get(i).get("saleOrderType").toString()) ) {	// 부서이관이 아닐 경우에만
                	lendingChk(search.get(0));
                }
                break;
            }
        }    	
        
        int updRowCnt = 0;
        Map<String, Object> sumReleaseMgmtMap = new HashMap();
        String currYymmdd = LimsUtil.getDate("yyyyMMdd");
        List<String> slipNums = new ArrayList<String>();

        Map<String, Object> deliverData = new HashMap<String, Object>();
        Map<String, Object> divData = new HashMap<String, Object>();

        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> rowData = list.get(i);
            int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (rowType == DataSet.ROW_TYPE_UPDATED && "1".equals(rowData.get("chk"))) {
                //rowData.put("preAmt1Yn", LimsUtil.checkNull(rowData.get("preAmt1Yn"), "1"));	// 계약이행예치금포함여부


                Record rs = releaseItemMgmtDAO.selectReleaseItemMgmtInfo(rowData);

                double releaseQuantity = rs.getDouble("releaseQuantity"); //출고수량
                double releaseWgt = rs.getDouble("realWgt"); //출고중량

                sumReleaseMgmtMap.put("flag", "U");
                sumReleaseMgmtMap.put("deliverNum", rowData.get("deliverNum")); //입고번호
                sumReleaseMgmtMap.put("saleOrderNum", rowData.get("saleOrderNum")); //판매 주문 번호
                sumReleaseMgmtMap.put("saleOrderNumSeq", rowData.get("saleOrderNumSeq")); //판매 주문 번호 순번

                logger.info("releaseExpectQuantity :" + releaseQuantity + "//" + releaseWgt);
                sumReleaseMgmtMap.put("releaseExpectQuantity", -releaseQuantity); //출고예정수량
                sumReleaseMgmtMap.put("releaseExpectWgt", -releaseWgt); //출고예정중량
                //3.입고 TABLE에서 입고번호에 해당하는 Row의 출고대기수량(중량) -
                updRowCnt += inventoryMgmtDeliverDAO.updateReleaseWaitQuantity(sumReleaseMgmtMap);

                //4.입고 TABLE에서 입고번호에 해당하는 Row의 출고완료수량(중량) +
                sumReleaseMgmtMap.put("releaseExpectQuantity", releaseQuantity); //출고완료수량
                sumReleaseMgmtMap.put("releaseExpectWgt", releaseWgt); //출고완료중량
                updRowCnt += inventoryMgmtDeliverDAO.updateReleaseEndQuantity(sumReleaseMgmtMap);

                //6.판매주문 품목 출고수량 +
                sumReleaseMgmtMap.put("releaseQuantity", releaseQuantity); //출고수량
                sumReleaseMgmtMap.put("releaseWgt", releaseWgt); //출고중량
                updRowCnt += saleOrderItemMgmtDAO.updateReleaseQuantity(sumReleaseMgmtMap); // 판매주문테이블의 출고수량(중량)을 +

                //7.출고 확정시 판매주문 품목 출고대기수량 -
                sumReleaseMgmtMap.put("releaseExpectQuantity", -releaseQuantity); //출고승인수량
                sumReleaseMgmtMap.put("releaseExpectWgt", -releaseWgt); //출고승인중량
                updRowCnt += saleOrderItemMgmtDAO.updateReleaseApprvReqQuantity(sumReleaseMgmtMap);


                String releaseStatusCd = rowData.get("saleOrderType").toString();
                logger.info("releaseStatusCd1 :" + releaseStatusCd);
                String deptMngmvDeliverNum ="";
                if ("50".equals(releaseStatusCd))	//부서이관 전표
                {

                    slipNums = createDeptMngmvSlipNum( i, search, rowData, loginDTO, slipNums );

                    Record inventoryRd = inventoryMgmtDeliverDAO.select(rowData);
                    //Insert 처리
                    //PO-300(100)-YYMM-SEQ(4):내수(300)/수입(100)
                    String deliverNum = inventoryMgmtDeliverDAO.getInventoryMgmtDeliverS(deliverData);
                    String currYymm = LimsUtil.getDate("yyyyMM");
                    deliverNum = "ST" + currYymm + deliverNum;
                    deptMngmvDeliverNum = deliverNum;
                    logger.info("deliverNum ::" + deliverNum);


                    deliverData.put("deliverNum", deliverNum);
                    deliverData.put("deliverType", "10"); //발주입고
                    deliverData.put("deliverStatus", "20"); //입고
                    deliverData.put("firstDeliverDate", inventoryRd.get("firstDeliverDate")); //최초입고일자
                    deliverData.put("currentWhDeliverDate", rowData.get("releaseDate")); //현재 창고 입고 일자
                    deliverData.put("saleType", inventoryRd.get("saleType")); //판매 유형
                    deliverData.put("poType", inventoryRd.get("poType")); //구매 형태
                    deliverData.put("attachDept", inventoryRd.get("attachDept")); //귀속 부서
                    deliverData.put("entryNum", inventoryRd.get("entryNum")); //통관번호
                    deliverData.put("entryItemSeq", inventoryRd.get("entryItemSeq")); //통관번호순번
                    deliverData.put("poOrderNum", inventoryRd.get("poOrderNum")); //구매 주문 번호
                    deliverData.put("itemSeq", inventoryRd.get("itemSeq")); //품목 순번
                    deliverData.put("itemCd", inventoryRd.get("itemCd")); //품목 코드
                    deliverData.put("itemNm", inventoryRd.get("itemNm")); //품목 명
                    deliverData.put("hsCd", inventoryRd.get("hsCd")); //HS코드
                    deliverData.put("splrCd", inventoryRd.get("splrCd")); //매입처 코드
                    deliverData.put("splrNm", inventoryRd.get("splrNm")); //매입처 명
                    deliverData.put("salsplceCd", inventoryRd.get("salsplceCd")); //매출처 코드
                    deliverData.put("salsplceNm", inventoryRd.get("salsplceNm")); //매출처 명
                    deliverData.put("whCd", inventoryRd.get("whCd")); //창고 코드
                    deliverData.put("whNm", inventoryRd.get("whNm")); //창고 명
                    deliverData.put("unit", inventoryRd.get("unit")); //단위
                    deliverData.put("lshipExchangeRate", inventoryRd.get("lshipExchangeRate")); //선적 환율(PO)
                    deliverData.put("signExchangeRate", inventoryRd.get("signExchangeRate")); //결재 환율(대금결재)
                    deliverData.put("intRate", inventoryRd.get("intRate")); //금리
                    deliverData.put("expectSalsGainrat", inventoryRd.get("expectSalsGainrat")); //예상 매출 이익율
                    deliverData.put("deliverUpriceForeignCurrenc", inventoryRd.get("deliverUpriceForeignCurrenc")); //입고 단가 외화
                    deliverData.put("deliverUpriceKrw", inventoryRd.get("deliverUpriceKrw")); //입고 단가 원화
                    deliverData.put("deliverQuantity", rowData.get("releaseQuantity")); //입고 수량
                    deliverData.put("deliverWgt", rowData.get("realWgt")); //입고 중량
                    deliverData.put("deliverAmt", rowData.get("realSaleAmt")); //입고 금액
                    deliverData.put("poProposalNum", inventoryRd.get("poProposalNum")); //구매 품의 번호
                    deliverData.put("incomeDtrDsctNum", inventoryRd.get("incomeDtrDsctNum")); //수입 유통 식별 번호
                    deliverData.put("estNo", inventoryRd.get("estNo")); //EST 번호
                    deliverData.put("lastSaleEdate", inventoryRd.get("lastSaleEdate")); //최종판매종료일
                    deliverData.put("deliverAmtKrw", inventoryRd.get("deliverAmtKrw")); //입고 금액 원화

                    logger.info("deliverData ::" + deliverData);
                    updRowCnt += inventoryMgmtDeliverDAO.insert(deliverData);	//입고처리

                    String set1 = inventoryRd.get("set1").toString();
                    Double deliverWgt = Double.parseDouble(LimsUtil.checkNull(inventoryRd.get("deliverWgt"), "0").toString()); //입고중량
                    Double realWgt = Double.parseDouble(LimsUtil.checkNull(rowData.get("realWgt"), "0").toString()); 			//실중량

                    Double deliverQuantity = Double.parseDouble(LimsUtil.checkNull(inventoryRd.get("deliverQuantity"), "0").toString()); //입고수량
                    Double releaseQuantity2 = Double.parseDouble(LimsUtil.checkNull(rowData.get("releaseQuantity"), "0").toString()); 			//실중량

                    Double rate = 0.0;	    //입고시 배부 비율
                    Double orgRate = 0.0;	//원부대비 배부 비율
                    if ( "KG".equals(set1))
                    {
                        rate = Math.round(realWgt / deliverWgt *100 * 100d) / 100d ;
                    }
                    else
                    {
                        rate = Math.round(releaseQuantity2 / deliverQuantity *100 * 100d) / 100d;
                    }
                    orgRate = 100 - rate;
                    logger.info("unit ::" + set1+"/ deliverQuantity :"+deliverQuantity+"/ releaseQuantity2 :"+releaseQuantity2+"/ deliverWgt :"+deliverWgt+"/ realWgt :"+realWgt+"/ orgRate :"+orgRate+"/ rate :"+rate);

                    RecordSet divRs = deliveritemOtherAmtDivDAO.selectList2(rowData);
                    for ( int k=0; k<divRs.size(); k++)
                    {
                        Record rd= divRs.get(k);
                        logger.info("divAmt ::"+rd.getString("divAmt"));


                        divData.put("deliverNum", deliverNum); //입고번호
                        divData.put("divSeq", rd.getInt("divSeq"));
                        divData.put("commClass", rd.getString("commClass"));
                        divData.put("divAmt", Math.round(rd.getDouble("divAmt") * rate / 100));
                        divData.put("divDate", currYymmdd);
                        divData.put("nonarrivAltYn", rd.getString("nonarrivAltYn"));
                        divData.put("otherAmtSeq", rd.getInt("otherAmtSeq"));
                        divData.put("altFiscalSlipNum", rd.getString("altFiscalSlipNum"));
                        divData.put("slipNum", rd.getString("slipNum"));
                        divData.put("signInstanceId", rd.getString("signInstanceId"));
                        deliveritemOtherAmtDivDAO.insert(divData);	//생성 부배비 배부 비율만큼 +
                    }

                }
                rowData.put("releaseConfirmDate", currYymmdd); //출고확정일
                rowData.put("releaseStatusCd", "40"); //출고확정
                rowData.put("deptMngmvDeliverNum", deptMngmvDeliverNum); //부서이관 입고번호
                //1.출고확정 처리
                updRowCnt += releaseItemMgmtDAO.releaseConfirm(rowData);

            }
        }
        return updRowCnt;
    }

    /**
     * 판매 주문내역에 대하여 출고(품목)를 관리 출고확정취소 처리한다.
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
    public int releaseConfirmCancel(DataSetMap list) throws Exception {
        int updRowCnt = 0;
        Map<String, Object> sumReleaseMgmtMap = new HashMap();
        Map<String, Object> delDeliverData = new HashMap<String, Object>();

        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> rowData = list.get(i);
            int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (rowType == DataSet.ROW_TYPE_UPDATED && "1".equals(rowData.get("chk"))) {

                Record rs = releaseItemMgmtDAO.selectReleaseItemMgmtInfo(rowData);

                double releaseQuantity = rs.getDouble("releaseQuantity"); //출고수량
                double releaseWgt = rs.getDouble("releaseWgt"); //출고중량
                double realWgt = Double.parseDouble(LimsUtil.checkNull(rowData.get("realWgt"), "0").toString()); //실중량

                sumReleaseMgmtMap.put("flag", "U");
                sumReleaseMgmtMap.put("deliverNum", rowData.get("deliverNum")); //입고번호
                sumReleaseMgmtMap.put("saleOrderNum", rowData.get("saleOrderNum")); //판매 주문 번호
                sumReleaseMgmtMap.put("saleOrderNumSeq", rowData.get("saleOrderNumSeq")); //판매 주문 번호 순번

                logger.info("releaseExpectQuantity :" + releaseQuantity + "//" + releaseWgt + "//" + realWgt);
                //            if ( realWgt > 0 )
                //            {
                //                //3.입고 TABLE에서 입고번호에 해당하는 Row의 출고대기수량(중량) +
                //                sumReleaseMgmtMap.put("releaseExpectQuantity", releaseQuantity);	//출고예정수량
                //                sumReleaseMgmtMap.put("releaseExpectWgt", realWgt);	//실중량
                //                updRowCnt += inventoryMgmtDeliverDAO.updateReleaseWaitQuantity(sumReleaseMgmtMap);
                //
                //                //4.입고 TABLE에서 입고번호에 해당하는 Row의 출고완료수량(중량) -
                //                sumReleaseMgmtMap.put("releaseExpectQuantity", -releaseQuantity);	//출고예정수량
                //                sumReleaseMgmtMap.put("releaseExpectWgt", -realWgt);	//출고예정중량
                //
                //                updRowCnt += inventoryMgmtDeliverDAO.updateReleaseEndQuantity(sumReleaseMgmtMap);
                //
                //                //5.판매주문 품목 출고수량 업데이트
                //                sumReleaseMgmtMap.put("releaseQuantity", -releaseQuantity);	//출고수량
                //                sumReleaseMgmtMap.put("releaseWgt", -realWgt);	//출고중량
                //                updRowCnt += saleOrderItemMgmtDAO.updateReleaseQuantity(sumReleaseMgmtMap);	   	   // 판매주문테이블의 출고수량(중량)을 +
                //
                //                //6.출고 확정 취소시 판매주문 품목 출고승인수량 +
                //                sumReleaseMgmtMap.put("releaseApprvQuantity", releaseQuantity);	//출고승인수량
                //                sumReleaseMgmtMap.put("releaseApprvWgt", realWgt);				//출고승인중량
                //                updRowCnt += saleOrderItemMgmtDAO.updateReleaseApprvQuantity(sumReleaseMgmtMap);
                //            }
                //            else
                //            {
                //3.입고 TABLE에서 입고번호에 해당하는 Row의 출고대기수량(중량) +
                sumReleaseMgmtMap.put("releaseExpectQuantity", releaseQuantity); //출고예정수량
                sumReleaseMgmtMap.put("releaseExpectWgt", releaseWgt); //출고예정중량
                updRowCnt += inventoryMgmtDeliverDAO.updateReleaseWaitQuantity(sumReleaseMgmtMap);

                //4.입고 TABLE에서 입고번호에 해당하는 Row의 출고완료수량(중량) -
                sumReleaseMgmtMap.put("releaseExpectQuantity", -releaseQuantity); //출고예정수량
                sumReleaseMgmtMap.put("releaseExpectWgt", -releaseWgt); //출고예정중량
                updRowCnt += inventoryMgmtDeliverDAO.updateReleaseEndQuantity(sumReleaseMgmtMap);

                //5.판매주문 품목 출고수량 업데이트
                sumReleaseMgmtMap.put("releaseQuantity", -releaseQuantity); //출고수량
                sumReleaseMgmtMap.put("releaseWgt", -releaseWgt); //출고중량
                updRowCnt += saleOrderItemMgmtDAO.updateReleaseQuantity(sumReleaseMgmtMap); // 판매주문테이블의 출고수량(중량)을 +

                //6.출고 확정 취소시 판매주문 품목 출고대기수량 +
                sumReleaseMgmtMap.put("releaseExpectQuantity", releaseQuantity); //출고대기수량
                sumReleaseMgmtMap.put("releaseExpectWgt", releaseWgt); //출고대기중량
                updRowCnt += saleOrderItemMgmtDAO.updateReleaseApprvReqQuantity(sumReleaseMgmtMap);
                //            }

                //1.출고확정취소 처리한다.
                rowData.put("releaseConfirmDate", ""); //출고확정일
                rowData.put("releaseStatusCd", "30"); //출고승인
                updRowCnt += releaseItemMgmtDAO.releaseConfirm(rowData);


                String releaseStatusCd = rowData.get("saleOrderType").toString();
                logger.info("releaseStatusCd1 :" + releaseStatusCd);
                if ("50".equals(releaseStatusCd))	//부서이관 전표
                {
                    delDeliverData.put("deliverNum", rs.get("deptMngmvDeliverNum"));
                    updRowCnt += inventoryMgmtDeliverDAO.delete(delDeliverData);	//입고삭제처리

                    updRowCnt += deliveritemOtherAmtDivDAO.deleteDeptMngmv(delDeliverData);	//생성 부대비 삭제

                    rowData.put("deptMngmvDeliverNum", "");
                    rowData.put("deptMngmvSlipFiscalNum", "");
                    rowData.put("deptMngmvSlipCdate", "");
                    rowData.put("deptMngmvDeliverNum", "");
                    updRowCnt += releaseItemMgmtDAO.releaseConfirmDeptMngmv(rowData);	// 부서이관 전표번호,생성일,입고번호 '' 초기화
                }


            }

        }
        return updRowCnt;
    }

    /**
     * 판매 주문내역에 대하여 출고(품목)를 관리 환입 처리한다.
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
    public int releasePurchaseReturn(DataSetMap list) throws Exception {
        String currYymmdd = LimsUtil.getDate("yyyyMMdd");

        int updRowCnt = 0;
        Map<String, Object> sumReleaseMgmtMap = new HashMap();
        Map<String, Object> deliverData = new HashMap<String, Object>();
        Map<String, Object> divMap = new HashMap<String, Object>();
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> rowData = list.get(i);
            int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (rowType == DataSet.ROW_TYPE_UPDATED && "1".equals(rowData.get("chk"))) {
                Record rs = releaseItemMgmtDAO.selectReleaseItemMgmtInfo(rowData);
                double saleUprice = rs.getDouble("saleUprice"); //판매단가

                double purchaseReturnQuantity = Double.parseDouble(LimsUtil.checkNull(rowData.get("purchaseReturnQuantity"), "0").toString()); //환입수량
                double purchaseReturnWgt = Double.parseDouble(LimsUtil.checkNull(rowData.get("purchaseReturnWgt"), "0").toString()); //환입중량
                double purchaseReturnDeliverNum = Double.parseDouble(LimsUtil.checkNull(rowData.get("purchaseReturnDeliverNum"), "0").toString()); //환입금액
                double purchaseReturnCst = Double.parseDouble(LimsUtil.checkNull(rowData.get("purchaseReturnCst"), "0").toString()); //환입원가

                sumReleaseMgmtMap.put("flag", "U");
                sumReleaseMgmtMap.put("deliverNum", rowData.get("deliverNum")); //입고번호
                sumReleaseMgmtMap.put("saleOrderNum", rowData.get("saleOrderNum")); //판매 주문 번호
                sumReleaseMgmtMap.put("saleOrderNumSeq", rowData.get("saleOrderNumSeq")); //판매 주문 번호 순번
                sumReleaseMgmtMap.put("deliverQuantity", purchaseReturnQuantity); //입고수량 +
                sumReleaseMgmtMap.put("deliverWgt", purchaseReturnWgt); //입고중량 +

                //판매금액 : 판매단가 * 수량
                double saleAmt = 0;
                String set1 = rs.getString("set1");
                if ("KG".equals(set1)) {
                    saleAmt = Math.round(saleUprice * purchaseReturnWgt);
                    logger.info("saleAmt :" + saleUprice + "*" + purchaseReturnWgt + "=" + saleAmt);
                } else {
                    saleAmt = Math.round(saleUprice * purchaseReturnQuantity);
                    logger.info("saleAmt2 :" + saleUprice + "*" + purchaseReturnQuantity + "=" + saleAmt);
                }
                //sumReleaseMgmtMap.put("deliverAmt", purchaseReturnDeliverNum);
                sumReleaseMgmtMap.put("deliverAmt", purchaseReturnCst);

                //2.원 데이타 환입 처리
                rowData.put("purchaseReturnDeliverNum", purchaseReturnDeliverNum);
                rowData.put("cstSlipFiscalNum", "");	//매입원가전표번호
                updRowCnt += releaseMgmtDAO.releasePurchaseReturn(rowData);

                rowData.put("purchaseReturnAmt", purchaseReturnDeliverNum);
                rowData.put("purchaseReturnCst", purchaseReturnCst);
                //3.환입관리에 인서트
                updRowCnt += purchaseReturnMgmtDAO.insert(rowData);





                //4.입고 테이블 인서트
                Record inventoryRd = inventoryMgmtDeliverDAO.select(rowData);
                //Insert 처리
                //PO-300(100)-YYMM-SEQ(4):내수(300)/수입(100)
                String deliverNum = inventoryMgmtDeliverDAO.getInventoryMgmtDeliverS(deliverData);
                String currYymm = LimsUtil.getDate("yyyyMM");
                deliverNum = "ST" + currYymm + deliverNum;
                logger.info("deliverNum ::" + deliverNum);


                deliverData.put("deliverNum", deliverNum);
                deliverData.put("deliverType", "10"); //발주입고
                deliverData.put("deliverStatus", "20"); //입고
                deliverData.put("firstDeliverDate", rowData.get("purchaseReturnDate")); //최초입고일자
                deliverData.put("currentWhDeliverDate", rowData.get("purchaseReturnDate")); //현재 창고 입고 일자
                deliverData.put("saleType", inventoryRd.get("saleType")); //판매 유형
                deliverData.put("poType", inventoryRd.get("poType")); //구매 형태
                deliverData.put("attachDept", inventoryRd.get("attachDept")); //귀속 부서
                deliverData.put("entryNum", inventoryRd.get("entryNum")); //통관번호
                deliverData.put("entryItemSeq", inventoryRd.get("entryItemSeq")); //통관번호순번
                deliverData.put("poOrderNum", inventoryRd.get("poOrderNum")); //구매 주문 번호
                deliverData.put("itemSeq", inventoryRd.get("itemSeq")); //품목 순번
                deliverData.put("itemCd", inventoryRd.get("itemCd")); //품목 코드
                deliverData.put("itemNm", inventoryRd.get("itemNm")); //품목 명
                deliverData.put("hsCd", inventoryRd.get("hsCd")); //HS코드
                deliverData.put("splrCd", inventoryRd.get("splrCd")); //매입처 코드
                deliverData.put("splrNm", inventoryRd.get("splrNm")); //매입처 명
                deliverData.put("salsplceCd", inventoryRd.get("salsplceCd")); //매출처 코드
                deliverData.put("salsplceNm", inventoryRd.get("salsplceNm")); //매출처 명
                deliverData.put("whCd", inventoryRd.get("whCd")); //창고 코드
                deliverData.put("whNm", inventoryRd.get("whNm")); //창고 명
                deliverData.put("unit", inventoryRd.get("unit")); //단위
                deliverData.put("lshipExchangeRate", inventoryRd.get("lshipExchangeRate")); //선적 환율(PO)
                deliverData.put("signExchangeRate", inventoryRd.get("signExchangeRate")); //결재 환율(대금결재)
                deliverData.put("intRate", inventoryRd.get("intRate")); //금리
                deliverData.put("expectSalsGainrat", inventoryRd.get("expectSalsGainrat")); //예상 매출 이익율


                deliverData.put("deliverUpriceForeignCurrenc", inventoryRd.get("deliverUpriceForeignCurrenc")); //입고 단가 외화
                deliverData.put("deliverUpriceKrw", inventoryRd.get("deliverUpriceKrw")); //입고 단가 원화
                deliverData.put("deliverQuantity", purchaseReturnQuantity); //입고 수량
                deliverData.put("deliverWgt", purchaseReturnWgt); //입고 중량

                Double lshipExchangeRate = Double.parseDouble(LimsUtil.checkNull(inventoryRd.get("lshipExchangeRate"), "0").toString()); 					 //선적 환율
                Double deliverUpriceForeignCurrenc = Double.parseDouble(LimsUtil.checkNull(inventoryRd.get("deliverUpriceForeignCurrenc"), "0").toString()); //입고 단가 외화
                Double deliverAmt = Double.parseDouble(LimsUtil.checkNull(inventoryRd.get("deliverAmt"), "0").toString()); //입고 단가 외화
                Double deliverQuantity = Double.parseDouble(LimsUtil.checkNull(inventoryRd.get("deliverQuantity"), "0").toString()); //입고 단가 외화
                Double deliverWgt = Double.parseDouble(LimsUtil.checkNull(inventoryRd.get("deliverWgt"), "0").toString()); //입고 단가 외화
                Double deliverAmtKrw = Double.parseDouble(LimsUtil.checkNull(inventoryRd.get("deliverWgt"), "0").toString()); //입고 단가 외화
                if ("KG".equals(set1)) {
                    //deliverData.put("deliverAmt", Math.round(purchaseReturnDeliverNum)); //입고 금액
                	deliverData.put("deliverAmt", Math.round(purchaseReturnCst)); //입고 금액
//                    deliverData.put("deliverAmtKrw", Math.round(purchaseReturnDeliverNum)); //입고 금액 원화
                    logger.info("deliverAmt :::"+deliverAmt +"*"+ purchaseReturnWgt +"/"+ deliverWgt+"="+deliverData.get("deliverAmt"));
                }
                else
                {
                    //deliverData.put("deliverAmt", Math.round(purchaseReturnDeliverNum)); //입고 금액
                	deliverData.put("deliverAmt", Math.round(purchaseReturnCst)); //입고 금액
                    logger.info("deliverAmt :::"+deliverAmt +"*"+ purchaseReturnQuantity +"/"+ deliverQuantity+"="+deliverData.get("deliverAmt"));
                }
                deliverData.put("poProposalNum", inventoryRd.get("poProposalNum")); //구매 품의 번호
                deliverData.put("incomeDtrDsctNum", inventoryRd.get("incomeDtrDsctNum")); //수입 유통 식별 번호
                deliverData.put("estNo", inventoryRd.get("estNo")); //EST 번호
                deliverData.put("lastSaleEdate", inventoryRd.get("lastSaleEdate")); //최종판매종료일
                
                deliverData.put("orgDeliverNum", rowData.get("deliverNum")); //원본입고번호 2016.01.11 추가
                deliverData.put("orgReleaseNum", rowData.get("releaseNum")); //원본출고번호 2016.01.11 추가
                

                updRowCnt += inventoryMgmtDeliverDAO.insert(deliverData);	//입고처리

                //5.부대비 배부 인서트(비율만큼)
                /* 환입일 경우 부대비는 생성하지 않도록 정정 2016.01.11 (환입은 원물대에 대해서만 발생함)
                RecordSet divRs = deliveritemOtherAmtDivDAO.selectList2(rowData);	//기존 입고 조회
                for ( int j=0; j<divRs.size(); j++)	  //기존입고 조회후 배부
                {
                    Map<String, Object> divData = divRs.get(j);
                    divData.put("deliverNum", deliverNum);	//신규 입고번호 세팅후 SEQ 가져온다
                    int divSeq = deliveritemOtherAmtDivDAO.getDivSeq(divData);

                    divMap.put("deliverNum", deliverNum);
                    divMap.put("divSeq", divSeq);
                    divMap.put("commClass", divData.get("commClass"));
                    double rate = 0;
                    Double divAmt = Double.parseDouble(LimsUtil.checkNull(divData.get("divAmt") , "0").toString()); //입고 단가 외화
                    if ("KG".equals(set1)) {
                        rate = purchaseReturnWgt/deliverWgt;
                    }
                    else
                    {
                        rate = purchaseReturnQuantity/deliverQuantity;
                    }
                    divMap.put("divAmt", Math.round(divAmt *rate) );			//비율만큼 부대비 배부한다
                    logger.info("divAmt ::" + divAmt +"*"+rate +"="+divAmt *rate );
                    divMap.put("divDate", rowData.get("purchaseReturnDate"));
                    divMap.put("nonarrivAltYn", divData.get("nonarrivAltYn"));
                    divMap.put("otherAmtSeq", divData.get("otherAmtSeq"));
                    divMap.put("altFiscalSlipNum", divData.get("altFiscalSlipNum"));
                    divMap.put("slipNum", divData.get("slipNum"));
                    divMap.put("signInstanceId", divData.get("signInstanceId"));

                    deliveritemOtherAmtDivDAO.insert(divMap); //부대비 배부
                }
                */

            }
        }

        return updRowCnt;
    }

    /**
     * 판매 주문내역에 대하여 출고(품목)를 관리 중량변경 처리한다.
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
    public int releaseWhgChg(DataSetMap list) throws Exception {
        int updRowCnt = 0;
        DecimalFormat df = new DecimalFormat();
        Map<String, Object> sumReleaseMgmtMap = new HashMap();
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> rowData = list.get(i);

            //여신체크 한후 하단 로직 실행

            Double realWgt = Double.parseDouble(LimsUtil.checkNull(rowData.get("realWgt"), "0").toString()); //실 중량
            Double releaseQuantity = Double.parseDouble(LimsUtil.checkNull(rowData.get("releaseQuantity"), "0").toString()); //실 중량
            Double orgRealWgt = Double.parseDouble(LimsUtil.checkNull(rowData.get("orgRealWgt"), "0").toString()); //실 중량
            Double saleUprice = Double.parseDouble(LimsUtil.checkNull(rowData.get("saleUprice"), "0").toString()); //판매단가
            String unit = LimsUtil.checkNull(rowData.get("unit")); //판매단가
            long realSaleAmt = Math.round(saleUprice * realWgt);
            Double gap = realWgt - orgRealWgt;

            logger.info("realSaleAmt :" + saleUprice + "*" + realWgt + "=" + realSaleAmt);

            rowData.put("realSaleAmt", realSaleAmt);

            //2.실중량, 실판매가격 변경
            updRowCnt += releaseItemMgmtDAO.releaseWhgChg(rowData);

            //1.원가차감 보정
            ///////////////view 수입원가  계산///////////////
            Record incomeCstRs = inventoryMgmtDeliverDAO.selectIncomeCst2(rowData); //총수입원가 금액 조회

//            double buycst =  incomeCstRs.getDouble("buycst");	 //수입원가
            double remainOrderQuantity =  incomeCstRs.getDouble("remainOrderQuantity");	 //남은수량
            //double lastRemainOrderQuantity =remainOrderQuantity;
            double remainBuyCst =  incomeCstRs.getDouble("remainBuyCst");	 //남은 수입원가

            logger.info("remainOrderQuantity :" + remainOrderQuantity);
            if ( remainOrderQuantity <= 0 )	   //출고한 중량이 많을시 보정작업
            {
                if ( "KG".equals(unit))
                {
                    logger.info("-------------1");
                    rowData.put("remainBuyCst", remainBuyCst);
                    inventoryMgmtDeliverDAO.updateBuycst2(rowData); //입고 TABLE에서 입고번호에 해당하는 Row의 주문잔여수량(중량) 증가
                }
            }
            else
            {
                logger.info("-------------2");
                double buyCst = Double.parseDouble(LimsUtil.checkNull(rowData.get("buyCst"), "0").toString()); //판매단가
                double focDeliverQuantity =  incomeCstRs.getDouble("deliverQuantity");	 //수입원가

                long realIncomeCstAmt = 0;
                if ( "KG".equals(unit))
                {
                    realIncomeCstAmt = Math.round(buyCst * realWgt / orgRealWgt);	//총수입원가(krw) * 출고수량 / 입고수량
                    logger.info("realIncomeCstAmt :" + df.format(buyCst) + "*" + realWgt + "/" + orgRealWgt +"=" + df.format((realIncomeCstAmt)) );
                }
//                else
//                {
//                    realIncomeCstAmt = Math.round(buyCst * releaseQuantity / focDeliverQuantity);	//총수입원가(krw) * 출고수량 / 입고수량
//                    logger.info("realIncomeCstAmt :" + df.format(buyCst) + "*" + releaseQuantity + "/" + focDeliverQuantity +"=" + df.format((realIncomeCstAmt)) );
//                }
                rowData.put("remainBuyCst", realIncomeCstAmt); //매입원가 세팅
                inventoryMgmtDeliverDAO.updateBuycst3(rowData); //입고 TABLE에서 입고번호에 해당하는 Row의 주문잔여수량(중량) 증가
            }


           /////////////////////////////////////////////////


            //chkIncomeCstAmt(rowData);	  //수입원가 보정작업

            //399

            // 300 -  200
            //        50 -> gap(+50)까지 변경 가능
            //중량변경시 변경된 중량 gap(40) < 입고중량(400) - 현재주문량(400 + 100)
            //            Record rd = releaseItemMgmtDAO.selectSumOrderWgtInfo(rowData);
            //            Float totReleaseApprvReqWgt = rd.getFloat("releaseApprvReqWgt");	//입고번호에 해당하는 총 주문중량
            //입고중량 > 주문중량합 + 주문gap
            //            logger.info("deliverWgt :"+ deliverWgt +">"+ totReleaseApprvReqWgt+"+"+gap);
            //            if ( deliverWgt < totReleaseApprvReqWgt + gap )
            //            {
            //                throw processException("ft.fts.fail.release.nochgwgt.alert");	//입고중량보다 변경될 실중량이 큽니다.
            //            }

            //입고 TABLE에서 입고번호에 해당하는 Row의 출고대기수량(중량) +
            sumReleaseMgmtMap.put("flag", "U");
            sumReleaseMgmtMap.put("deliverNum", rowData.get("deliverNum")); //입고번호
            sumReleaseMgmtMap.put("saleOrderNum", rowData.get("saleOrderNum")); //주문번호
            sumReleaseMgmtMap.put("saleOrderNumSeq", rowData.get("saleOrderNumSeq")); //주문 SEQ
            sumReleaseMgmtMap.put("releaseExpectQuantity", 0); //출고예정수량 - 그대로
            sumReleaseMgmtMap.put("releaseExpectWgt", gap); //출고예정중량
            logger.info("gap :"+realWgt +"-"+ orgRealWgt +"="+gap);
            updRowCnt += inventoryMgmtDeliverDAO.updateReleaseWaitQuantity(sumReleaseMgmtMap);

            //판매주문 품목 출고대기중량 업데이트
            sumReleaseMgmtMap.put("releaseExpectQuantity", 0); //출고대기수량 - 그대로
            sumReleaseMgmtMap.put("releaseExpectWgt", gap); //출고대기중량
            updRowCnt += saleOrderItemMgmtDAO.updateReleaseApprvReqQuantity(sumReleaseMgmtMap); // 판매주문테이블의 출고대기중량(중량)을 +

        }
        return updRowCnt;
    }

    /**
     * 판매 주문내역에 대하여 출고(품목)를 관리 단가변경 처리한다.
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
    public int releaseUpriceChg(DataSetMap list) throws Exception {
        int updRowCnt = 0;
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> rowData = list.get(i);

            //여신체크 한후 하단 로직 실행

            Record rs = releaseItemMgmtDAO.selectReleaseItemMgmtInfo(rowData);

            double saleUprice = Double.parseDouble(LimsUtil.checkNull(rowData.get("saleUprice"), "0").toString()); //판매단가
            double releaseQuantity = Double.parseDouble(LimsUtil.checkNull(rowData.get("releaseQuantity"), "0").toString()); //출고수량
            double releaseWgt = Double.parseDouble(LimsUtil.checkNull(rowData.get("releaseWgt"), "0").toString()); //출고중량
            double saleAmt = 0;

            String set1 = rs.getString("set1");
            if ("KG".equals(set1)) {
                saleAmt = saleUprice * releaseWgt;
            } else {
                saleAmt = saleUprice * releaseQuantity;
            }
            logger.info("realSaleAmt :" + saleUprice + "*" + releaseWgt + "=" + saleAmt + "//" + set1);
            rowData.put("saleAmt", Math.round(saleAmt));

            //1.판매단가 변경
            rowData.put("releaseStatusCd", "20"); //승인요청단계로
            updRowCnt += releaseItemMgmtDAO.releaseUpriceChg(rowData);

            //2.주문단가 수정
            updRowCnt += saleOrderItemMgmtDAO.updateSaleOrderUpriceChg(rowData); // 판매주문테이블의 판매단가,판매금액 변경
        }

        return updRowCnt;
    }

    /**
     * 판매 주문내역에 대하여 출고증 목록을 조회한다.
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
    public RecordSet selectReleaseReqCertificatePrintPop(Map<String, Object> mapParam) throws Exception {
        return releaseMgmtDAO.selectReleaseReqCertificatePrintPop(mapParam);
    }

    /**
     * 판매 주문내역에 대하여 출고증 목록을 조회한다.
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
    public RecordSet selectReleaseReqCertificatePrintPop2(Map<String, Object> mapParam) throws Exception {
        return releaseMgmtDAO.selectReleaseReqCertificatePrintPop2(mapParam);
    }

    /**
     * 출고에 대하여 관리 출고증 발행 처리한다.
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
    public int printReleaseReqCertificate(DataSetMap dsSearch, DataSetMap list) throws Exception {
        int updRowCnt = 0;
        int insRowCnt = 0;
        logger.info("list.size() ::::" + list.size());
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> rowData = list.get(i);
            int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (rowType == DataSet.ROW_TYPE_UPDATED && "1".equals(rowData.get("chk")))
            {
                updRowCnt += releaseMgmtDAO.printReleaseReqCertificate(rowData);
                insRowCnt += releaseMgmtDAO.printReleaseReqPubhist(rowData);
            }
        }

        return updRowCnt;
    }

    /**
     * 판매 주문내역에 대하여 출고확정 목록을 조회한다.
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
    public RecordSet selectSalsConfirmList(Map<String, Object> mapParam) throws Exception {
        return releaseMgmtDAO.selectSalsConfirmList(mapParam);
    }

    /**
     * 마감 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    public List<String> saveSalsCloseList(RecordSet rs, LoginDTO loginDTO, DataSetMap dsSearch, List<Map<String, Object>> listMap2) throws Exception {
        logger.info("rs.size()112 ::::" + rs.size());
        Map<String, Object> retProcVal = new HashMap<String, Object>();
        String pReceiptNum = "";
        List<String> arrReceiptNum = new ArrayList<String>();
        //영업회계 마감
        for (int i = 0; i < rs.size(); i++) {
            Map<String, Object> rowData = rs.get(i);
            Map<String, Object> procParam = new HashMap<String, Object>();
            if ( "CONFIRM".equals(dsSearch.get(0).get("salsConfirmFlag")))	//매출확정flag
            {
                procParam.put("p_upmu", "FTP"); // 업무구분 : LIMS(연구소), IFIS(고도화), FTP(식재도매)
            }
            else if ( "CANCEL".equals(dsSearch.get(0).get("salsConfirmFlag")))	//매출확정 취소flag
            {
                procParam.put("p_upmu", "FTPD"); // 업무구분 : LIMS(연구소), IFIS(고도화), FTPD(식재도매)
            }
            procParam.put("p_req_num", ""); // 키값 : 구분할수 있는 값 세팅
            procParam.put("p_occur_date", rowData.get("releaseDate")); // 발생일자
            procParam.put("p_upjang", rowData.get("upjang")); // 영업사원 업장코드
            procParam.put("p_mu_cd", rowData.get("muCd")); // mu코드
            procParam.put("p_cc_cd", rowData.get("ccCd")); // cc코드
            procParam.put("p_custcd", rowData.get("custCd")); // 거래처번호
            procParam.put("p_vat_gubun", rowData.get("taxCode")); // 과세 여부
            procParam.put("p_amt", rowData.get("saleAmt")); // 총합계 : 과세여부에 따라 procedure에서 갈라치기
            procParam.put("p_sal_quantity", rowData.get("releaseQuantity")); // 판매 수량
            procParam.put("p_cuser", loginDTO.getSabun()); // 처리자
            procParam.put("p_param_receipt_num", rowData.get("receiptNum")); //기존영수증번호
            procParam.put("p_pay_cd", "7"); //지불코드

            // 마감테이블에 전송
            retProcVal = testEndApprvDAO.updateTestEndApprvSLA(procParam);

            logger.debug("LTM_IF_SLA_SALESINFO_PRO Procedure ==> " + retProcVal);
            String pRetCode = retProcVal.get("P_RET_CODE").toString();
            logger.info("pRetCode ::::" + pRetCode);
            logger.debug("P_RECEIPT_NUM Procedure ==> " + LimsUtil.checkNull(retProcVal.get("P_RECEIPT_NUM")));

            pReceiptNum = LimsUtil.checkNull(retProcVal.get("P_RECEIPT_NUM")+"|"+rowData.get("releaseNum"));
            logger.info("pReceiptNum ::::" + pReceiptNum);
            arrReceiptNum.add(pReceiptNum);
            if ("E".equals(pRetCode)) {
                throw new BizException(retProcVal.get("P_RET_MSG").toString());
            }

        }
        return arrReceiptNum;
    }

    /**
     * 마감 처리한다.
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
    public int saveSalsConfirmList_orgBack(DataSetMap list, LoginDTO loginDTO, DataSetMap dsSearch) throws Exception {
        int updRowCnt = 0;
        /*
        logger.info("list.size()112 ::::" + list.size());
        Map<String, Object> retProcVal = new HashMap<String, Object>();
        String currYymmdd = LimsUtil.getDate("yyyyMMdd");
        String pReceiptNum = "";

        List<Map<String, Object>> listMap = new ArrayList(); //정상 출고건

        List<String> releaseNumLi = new ArrayList<String>();
        List<String> seqLi = new ArrayList<String>();

        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> rowData = list.get(i);
            String seq = LimsUtil.checkNull(rowData.get("seq"));
            int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (rowType == DataSet.ROW_TYPE_UPDATED && "1".equals(rowData.get("chk"))) {
                releaseNumLi.add(rowData.get("releaseNum").toString());
                seqLi.add(rowData.get("seq").toString());
                listMap.add(rowData);
            }
        }



        //영업회계 마감
        RecordSet rs = null;
        if (listMap.size() > 0) {
            Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("releaseNums", releaseNumLi);
            paramMap.put("seqs", seqLi);
            rs = releaseMgmtDAO.selectSalsConfirmSumList(paramMap);
            logger.info("salsConfirmFlag::::" + dsSearch.get(0).get("salsConfirmFlag"));
            pReceiptNum = saveSalsCloseList(rs, loginDTO, dsSearch );

            logger.info("list .size()::::" + list.size());
            //출고품목 관리 매출확정
            for (int i = 0; i < list.size(); i++) {
                Map<String, Object> rowData = list.get(i);
                int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
                if (rowType == DataSet.ROW_TYPE_UPDATED && "1".equals(rowData.get("chk"))) {

                    if ( "CONFIRM".equals(dsSearch.get(0).get("salsConfirmFlag")))	//매출확정flag
                    {
                        rowData.put("releaseStatusCd", "50"); //매출마감
                        rowData.put("confirmYn", "Y"); //확정여부 : Y
                    }
                    else if ( "CANCEL".equals(dsSearch.get(0).get("salsConfirmFlag")))	//매출확정 취소flag
                    {
                        rowData.put("releaseStatusCd", "60"); //매출마감취소
                        rowData.put("confirmYn", "C"); //확정여부 취소: C
                    }

                    rowData.put("salsConfirmDate", rowData.get("releaseDate")); //매출확정일자 :출고일자
                    rowData.put("receiptNum", pReceiptNum);
                    updRowCnt += releaseItemMgmtDAO.releaseSalsConfirm(rowData);

                    rowData.put("salsConfirmDate", rowData.get("releaseDate")); //매출확정일자 :출고일자
                    rowData.put("receiptNum", pReceiptNum);
                    updRowCnt += purchaseReturnMgmtDAO.update(rowData);

                }
            }

        }
        */
         return updRowCnt;
    }

    /**
     * 마감 처리한다.
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
    public int saveSalsConfirmList(DataSetMap list, LoginDTO loginDTO, DataSetMap dsSearch) throws Exception {
        int updRowCnt = 0;
        logger.info("list.size()112 ::::" + list.size());
        Map<String, Object> retProcVal = new HashMap<String, Object>();
        String pReceiptNum = "";

        List<Map<String, Object>> listMap = new ArrayList(); //정상 출고건
        List<Map<String, Object>> listMap2 = new ArrayList(); //환입건

        List<String> normarLi = new ArrayList<String>();
        List<String> returnLi = new ArrayList<String>();



        RecordSet rs = null;
        Map<String, Object> paramMap = new HashMap<String, Object>();
        logger.info("list.size()2222 ::::" + list.size());

        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> rowData = list.get(i);
            int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            String seq = LimsUtil.checkNull(rowData.get("seq"));
            String releaseNum = LimsUtil.checkNull(rowData.get("releaseNum"));
            logger.info("seq ::::" + seq+"//chk :"+rowData.get("chk"));
            if (rowType == DataSet.ROW_TYPE_UPDATED && "1".equals(rowData.get("chk")))
            {
                logger.info("----------------1");
                if ("".equals(seq)) //정상 출고건
                {
                    StringBuffer bufResult = new StringBuffer();
                    bufResult.append(" SELECT                                                           \n");
                    bufResult.append("      A.*                                                         \n");
                    bufResult.append("     ,NULL SEQ                                                    \n");
                    bufResult.append("     ,NULL AS PURCHASE_RETURN_QUANTITY2                           \n");
                    bufResult.append("     ,NULL AS PURCHASE_RETURN_WGT2                                \n");
                    bufResult.append("     ,NULL AS PURCHASE_RETURN_DATE2                               \n");
                    bufResult.append("     ,NULL AS PURCHASE_RETURN_AMT2                                \n");
                    bufResult.append("     ,NULL AS SALS_CONFIRM_DATE2                                  \n");
                    bufResult.append("     ,NULL AS CONFIRM_YN2                                         \n");
                    bufResult.append("     ,NULL AS CST_SLIP_FISCAL_NUM2                                \n");
                    bufResult.append("     ,A.RECEIPT_NUM AS RECEIPT_NUM2                               \n");
                    bufResult.append("  FROM RELEASE_ITEM_MGMT A                                        \n");
                    bufResult.append("  WHERE  A.RELEASE_NUM ='"+releaseNum+"'							\n");

                    normarLi.add(bufResult.toString());
                }

                if (!"".equals(seq)) //정상 출고건
                {
                    StringBuffer bufResult2 = new StringBuffer();
                    bufResult2.append("  SELECT                                                          \n");
                    bufResult2.append("      A.*                                                         \n");
                    bufResult2.append("     ,B.SEQ                                                       \n");
                    bufResult2.append("     ,B.PURCHASE_RETURN_QUANTITY AS PURCHASE_RETURN_QUANTITY2     \n");
                    bufResult2.append("     ,B.PURCHASE_RETURN_WGT AS PURCHASE_RETURN_WGT2               \n");
                    bufResult2.append("     ,B.PURCHASE_RETURN_DATE AS PURCHASE_RETURN_DATE2             \n");
                    bufResult2.append("     ,B.PURCHASE_RETURN_AMT AS PURCHASE_RETURN_AMT2               \n");
                    bufResult2.append("     ,B.SALS_CONFIRM_DATE                                         \n");
                    bufResult2.append("     ,B.CONFIRM_YN                                                \n");
                    bufResult2.append("     ,B.CST_SLIP_FISCAL_NUM                                       \n");
                    bufResult2.append("     ,B.RECEIPT_NUM AS RECEIPT_NUM2                               \n");
                    bufResult2.append("  FROM RELEASE_ITEM_MGMT A, PURCHASE_RETURN_MGMT B                \n");
                    bufResult2.append("  WHERE A.RELEASE_NUM = B.RELEASE_NUM                             \n");
                    bufResult2.append("  AND   B.RELEASE_NUM ='"+releaseNum+"'							\n");
                    bufResult2.append("  AND   B.SEQ ="+seq+"											\n");
                    returnLi.add(bufResult2.toString());
                }
            }
        }

        logger.info("normarLi.size() ::::" + normarLi.size()+"//returnCnt :"+returnLi.size());
        //정상건 + 환입건
        String totBufResult = "";
        if ( normarLi.size() > 0 && returnLi.size() > 0)
        {
//            paramMap.put("query", bufResult.toString()+" \n UNION ALL \n "+bufResult2.toString());

            if (  normarLi.size() > 0 )
            {
                for (int k=0; k<normarLi.size(); k++)
                {
                    totBufResult += normarLi.get(k);
                    logger.info(k+" <-k :1:::->" + (normarLi.size()-1));
                    if ( k != (normarLi.size()-1))
                    {
                        totBufResult +=" \n UNION ALL \n ";
                    }
                }
            }

            if (  returnLi.size() > 0 )
            {
                totBufResult +=" \n UNION ALL \n ";
                for (int k=0; k<returnLi.size(); k++)
                {
                    totBufResult += returnLi.get(k);
                    if ( k != (returnLi.size()-1))
                    {
                        totBufResult +=" \n UNION ALL \n ";
                    }
                }
            }

            logger.info("totBufResult ::::" + totBufResult);
            paramMap.put("query", totBufResult);

        }

        //정상건만 존재시
        else if ( normarLi.size() > 0 && returnLi.size() == 0)
        {
            if (  normarLi.size() > 0 )
            {
                for (int k=0; k<normarLi.size(); k++)
                {
                    totBufResult += normarLi.get(k);
                    logger.info(k+" <-k :1:::->" + (normarLi.size()-1));
                    if ( k != (normarLi.size()-1))
                    {
                        totBufResult +=" \n UNION ALL \n ";
                    }
                }
            }

            paramMap.put("query", totBufResult);
        }
        //환입건만 존재시
        else if ( normarLi.size() == 0 && returnLi.size() > 0)
        {
            for (int k=0; k<returnLi.size(); k++)
            {
                totBufResult += returnLi.get(k);
                if ( k != (returnLi.size()-1))
                {
                    totBufResult +=" \n UNION ALL \n ";
                }
            }
            paramMap.put("query", totBufResult);
        }

        rs = releaseMgmtDAO.selectSalsConfirmSumList(paramMap);

        List<String> pReceiptNums = saveSalsCloseList(rs, loginDTO, dsSearch, listMap2 );

        logger.info("pReceiptNums.size() ::::" + pReceiptNums.size());
        for (int i = 0; i < pReceiptNums.size(); i++) {
            String receiptNum = pReceiptNums.get(i).split("[|]")[0];
            String[] releaseNums = pReceiptNums.get(i).split("[|]")[1].split("-");
            logger.info("list.size() ::::" + list.size());
            for (int j = 0; j < list.size(); j++) {
                Map<String, Object> rowData = list.get(j);
                int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
                if (rowType == DataSet.ROW_TYPE_UPDATED && "1".equals(rowData.get("chk"))  ) {
                    logger.info("releaseNum ::::" + rowData.get("releaseNum"));
                    String seq = LimsUtil.checkNull(rowData.get("seq"));
                    if ( "CONFIRM".equals(dsSearch.get(0).get("salsConfirmFlag")))	//매출확정
                    {

                        for (int k = 0; k < releaseNums.length; k++) {
                            if ( releaseNums[k].equals(rowData.get("releaseNum")) )
                            {
                                logger.info("releaseNums[k] ::::" + releaseNums[k]);
                                rowData.put("releaseStatusCd", "50"); //매출마감
                                rowData.put("confirmYn", "Y"); //확정여부 : Y
                                rowData.put("receiptNum", receiptNum);
                                rowData.put("salsConfirmDate", rowData.get("releaseDate")); //매출확정일자 :출고일자
                                if ("".equals(seq))		//정상건
                                {
                                    updRowCnt += releaseItemMgmtDAO.releaseSalsConfirm(rowData);
                                }
                                else					//환입건
                                {
                                    updRowCnt += purchaseReturnMgmtDAO.update(rowData);
                                }
                            }
                        }
                    }
                    else		//매출확정 취소
                    {
                        logger.info("cancel  receiptNum ::::" + receiptNum+"//"+rowData.get("receiptNum"));
                        if ( receiptNum.equals(rowData.get("receiptNum")) )
                        {
                            rowData.put("releaseStatusCd", "40"); //매출마감취소
                            rowData.put("confirmYn", "C"); //확정여부 취소: C
                            rowData.put("receiptNum", "");
                            rowData.put("salsConfirmDate", ""); //매출확정일자

                            if ("".equals(seq))		//정상건
                            {
                                updRowCnt += releaseItemMgmtDAO.releaseSalsConfirm(rowData);
                            }
                            else					//환입건
                            {
                                updRowCnt += purchaseReturnMgmtDAO.update(rowData);
                            }

//                            updRowCnt += releaseItemMgmtDAO.releaseSalsConfirm(rowData);
//                            updRowCnt += purchaseReturnMgmtDAO.update(rowData);
                        }
                    }
                }
            }
        }

        return updRowCnt;
    }


    /**
     * 마감 처리한다.
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
    public int saveSalsConfirmList_orgBack2(DataSetMap list, LoginDTO loginDTO, DataSetMap dsSearch) throws Exception {
        int updRowCnt = 0;
        logger.info("list.size()112 ::::" + list.size());
        Map<String, Object> retProcVal = new HashMap<String, Object>();
        String pReceiptNum = "";

        List<Map<String, Object>> listMap = new ArrayList(); //정상 출고건
        List<Map<String, Object>> listMap2 = new ArrayList(); //환입건

        List<String> releaseNumLi = new ArrayList<String>();
        List<String> releaseNumLi2 = new ArrayList<String>();
        List<String> seqLi = new ArrayList<String>();

        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> rowData = list.get(i);
            String seq = LimsUtil.checkNull(rowData.get("seq"));
            int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (rowType == DataSet.ROW_TYPE_UPDATED && "1".equals(rowData.get("chk"))) {
                if ("".equals(seq)) //정상 출고건
                {
                    releaseNumLi.add(rowData.get("releaseNum").toString());
                    listMap.add(rowData);
                }
                else //환입건
                {
                    releaseNumLi2.add(rowData.get("releaseNum").toString());
                    seqLi.add(rowData.get("seq").toString());
                    listMap2.add(rowData);
                }
            }
        }

        //영업회계 마감
        RecordSet rs = null;
        if (listMap.size() > 0) {
            Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("releaseNums", releaseNumLi);
            rs = releaseMgmtDAO.selectSalsConfirmSumList(paramMap);

            logger.info("salsConfirmFlag::::" + dsSearch.get(0).get("salsConfirmFlag"));
//            pReceiptNum = saveSalsCloseList(rs, loginDTO, dsSearch, listMap2 );
            logger.info("pReceiptNum::::" + pReceiptNum);

            logger.info("list .size()::::" + list.size());
            //출고품목 관리 매출확정
            for (int i = 0; i < list.size(); i++) {
                Map<String, Object> rowData = list.get(i);
                int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
                if (rowType == DataSet.ROW_TYPE_UPDATED && "1".equals(rowData.get("chk"))) {

                    if ( "CONFIRM".equals(dsSearch.get(0).get("salsConfirmFlag")))	//매출확정flag
                    {
                        rowData.put("releaseStatusCd", "50"); //매출마감
                        rowData.put("confirmYn", "Y"); //확정여부 : Y
                    }
                    else if ( "CANCEL".equals(dsSearch.get(0).get("salsConfirmFlag")))	//매출확정 취소flag
                    {
                        rowData.put("releaseStatusCd", "60"); //매출마감취소
                        rowData.put("confirmYn", "C"); //확정여부 취소: C
                    }

                    rowData.put("salsConfirmDate", rowData.get("releaseDate")); //매출확정일자 :출고일자
                    rowData.put("receiptNum", pReceiptNum);
                    updRowCnt += releaseItemMgmtDAO.releaseSalsConfirm(rowData);
                }
            }

        }
/*
        //영업회계 마감
        if (listMap2.size() > 0) {
            Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("releaseNums", releaseNumLi2);
            paramMap.put("seq", seqLi);
            rs = releaseMgmtDAO.selectSalsConfirmSumList2(paramMap);

            pReceiptNum = saveSalsCloseList(rs, loginDTO, dsSearch, listMap2);

            logger.info("list 2.size()::::" + list.size());
            //환입 관리 매출확정
            for (int i = 0; i < list.size(); i++) {
                Map<String, Object> rowData = list.get(i);
                int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
                if (rowType == DataSet.ROW_TYPE_UPDATED && "1".equals(rowData.get("chk"))) {
                    if ( "CONFIRM".equals(dsSearch.get(0).get("salsConfirmFlag")))	//매출확정flag
                    {
                        paramMap.put("confirmYn", "Y"); //확정여부 : Y
                        paramMap.put("salsConfirmDate", rowData.get("releaseDate")); //매출확정일자 :출고일자
                    }
                    else if ( "CANCEL".equals(dsSearch.get(0).get("salsConfirmFlag")))	//매출확정 취소flag
                    {
                        paramMap.put("salsConfirmDate", ""); //매출확정일자 :출고일자
                        paramMap.put("confirmYn", "C"); //확정여부 취소: C
                    }
                    updRowCnt += purchaseReturnMgmtDAO.update(rowData);
                }
            }

        }
*/
        return updRowCnt;
    }
    /**
     * 판매 주문내역에 대하여 출고확정 Insert/Update/Delete 처리한다.
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
    public int saveSalsConfirmList_back(DataSetMap list, RecordSet list2, LoginDTO loginDTO) throws Exception {
        int updRowCnt = 0;
        logger.info("list.size()11 ::::" + list2.size());
        Map<String, Object> retProcVal = new HashMap<String, Object>();
        String currYymmdd = LimsUtil.getDate("yyyyMMdd");
        String pReceiptNum = "";
        //영업회계 마감
        for (int i = 0; i < list2.size(); i++) {
            Map<String, Object> rowData = list2.get(i);
            Map<String, Object> procParam = new HashMap<String, Object>();

            logger.info("rowData.get(custCd) ::::" + rowData.get("custCd"));

            procParam.put("p_upmu", "FTP"); // 업무구분 : LIMS(연구소), IFIS(고도화), FTP(식재도매)
            procParam.put("p_req_num", ""); // 키값 : 구분할수 있는 값 세팅
            procParam.put("p_occur_date", LimsUtil.getDate("yyyyMMdd")); // 발생일자
            //            procParam.put("p_occur_date", "20150709"); // 발생일자
            procParam.put("p_upjang", rowData.get("upjang")); // 영업사원 업장코드
            procParam.put("p_mu_cd", rowData.get("muCd")); // mu코드
            procParam.put("p_cc_cd", rowData.get("ccCd")); // cc코드
            procParam.put("p_custcd", rowData.get("custCd")); // 거래처번호
            procParam.put("p_vat_gubun", rowData.get("taxCode")); // 과세 여부
            procParam.put("p_amt", rowData.get("saleAmt")); // 총합계 : 과세여부에 따라 procedure에서 갈라치기
            procParam.put("p_sal_quantity", rowData.get("releaseQuantity")); // 판매 수량
            procParam.put("p_cuser", loginDTO.getSabun()); // 처리자
            procParam.put("p_param_receipt_num", rowData.get("receiptNum")); //기존영수증번호
            procParam.put("p_pay_cd", "7"); //지불코드
            logger.info("saleUprice ::" + rowData.get("saleUprice"));
            //            procParam.put("p_uprice", rowData.get("saleUprice")); 	//지불코드

            // 마감테이블에 전송
            retProcVal = testEndApprvDAO.updateTestEndApprvSLA(procParam);

            logger.debug("LTM_IF_SLA_SALESINFO_PRO Procedure ==> " + retProcVal);
            String pRetCode = retProcVal.get("P_RET_CODE").toString();
            logger.info("pRetCode ::::" + pRetCode);
            logger.debug("P_RECEIPT_NUM Procedure ==> " + LimsUtil.checkNull(retProcVal.get("P_RECEIPT_NUM")));
            pReceiptNum = LimsUtil.checkNull(retProcVal.get("P_RECEIPT_NUM"));

            if ("E".equals(pRetCode)) {
                throw new BizException(retProcVal.get("P_RET_MSG").toString());
            }

        }

        logger.info("list .size()::::" + list.size());
        //출고품목 관리 매출확정
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> rowData = list.get(i);
            int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (rowType == DataSet.ROW_TYPE_UPDATED && "1".equals(rowData.get("chk"))) {
                rowData.put("releaseStatusCd", "50"); //매출마감
                rowData.put("salsConfirmDate", currYymmdd); //매출확정일자
                rowData.put("receiptNum", pReceiptNum);
                updRowCnt += releaseItemMgmtDAO.releaseSalsConfirm(rowData);
            }
        }

        return updRowCnt;
    }

    /**
     * 판매 주문내역에 대하여 출고확정 목록을 조회한다.
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
    public RecordSet selectSalsConfirmSumList(Map<String, Object> mapParam) throws Exception {
        return releaseMgmtDAO.selectSalsConfirmSumList(mapParam);
    }

    /**
     * saveIncomDraft 설명
     * <pre>
     * 수수료 정보를 등록한다.
     * </pre>
     *
     * @param parameter
     * @return
     * @see com.hwfs.ft.ftp.service.proposalService#saveEtcPrepayamtList(java.util.Map)
    */
    @Override
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> saveBuyCostExceptDraft(DataSetMap search, DataSetMap detailList, LoginDTO loginParameter)
            throws Exception {
        int otherAmtProcCnt = 0;
        String poOrderNum = ""; //구매주문 번호

        List<Map<String, Object>> listMap = new ArrayList();
        Map<String, Object> map = new HashMap();

        //원물대
        if (detailList.size() > 0) {
            for (int i = 0; i < detailList.size(); i++) {
                Map<String, Object> parameter = detailList.get(i);
                int rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
                if (rowType == DataSet.ROW_TYPE_UPDATED && "1".equals(parameter.get("chk")) ) {
                    poOrderNum = parameter.get("poOrderNum").toString();

                    parameter.put("cuser", loginParameter.getSabun());
                    parameter.put("uuser", loginParameter.getSabun());
                    parameter.put("nonarrivSlipCreationYn", "Y");
                    logger.info("signInstanceId ::" + parameter.get("signInstanceId"));
                    logger.info("signInstanceId2 ::" + parameter.get("signInstanceId2"));
                    logger.info("signInstanceId4 ::" + parameter.get("signInstanceId4"));
                    //1.품의상태:상신중 update
                    if ( "1".equals(search.get(0).get("flag")) )    //부서이관
                    {
                        otherAmtProcCnt += releaseMgmtDAO.saveBuyCostExceptDraft2(parameter);
                        //SCC_SIGN_INFO 테이블에 결재정보저장 (Insert or Update)
                        parameter.put("signInstanceId", parameter.get("signInstanceId2"));
                        parameter.put("signInstanceId4", null);
                        gwIfDAO.saveSignInfo(parameter);
                    }
                    else if ( "2".equals(search.get(0).get("flag")) )    //매입원가차감
                    {
                        parameter.put("signInstanceId4", null);
                        parameter.put("signInstanceId", parameter.get("signInstanceId"));
                        otherAmtProcCnt += releaseMgmtDAO.saveBuyCostExceptDraft(parameter);
                        //SCC_SIGN_INFO 테이블에 결재정보저장 (Insert or Update)
                        gwIfDAO.saveSignInfo(parameter);
                    }
                    else if ( "3".equals(search.get(0).get("flag")) )    //매입원가증감
                    {
                        parameter.put("signInstanceId", parameter.get("signInstanceId4"));
                        otherAmtProcCnt += purchaseReturnMgmtDAO.updateCstSeq(parameter);
                        //SCC_SIGN_INFO 테이블에 결재정보저장 (Insert or Update)
                        gwIfDAO.saveSignInfo(parameter);
                    }
                }
            }
        }

        logger.info("LAST poOrderNum :" + poOrderNum);
        map.put("poOrderNum", poOrderNum); //구매품의 번호 전달
        map.put("procCnt", otherAmtProcCnt); //실행건 전달
        listMap.add(map);

        return listMap;
    }

    @SuppressWarnings("unchecked")
    public List<String> createDeptMngmvSlipNum(int i, DataSetMap search, Map<String, Object> parameter, LoginDTO loginDTO, List<String> slipNums ) throws Exception {
        logger.info("####부서이관##");
        String currYymmdd = LimsUtil.getDate("yyyyMMddHHmmss");
        List<Map<String, Object>> topListMap = new ArrayList();
        Map<String, Object> topMap = new HashMap();
        String draft = search.get(0).get("draft").toString(); //상신,전표처리 구분
        logger.info("draft :" + draft);
//        ArrayList slipNums = new ArrayList();


        SlipMstDTO mst = new SlipMstDTO();
        //마스터 생성
//        String slipNum = poOrderMstDAO.selectSlipNum(parameter);
        String slipNum = LimsUtil.checkNull(parameter.get("slipNum2"), "").toString();
        String slipStatus = LimsUtil.checkNull(parameter.get("slipStatus"),"").toString();
        logger.info("slipNum :"+slipNum+"// slipStatus111:"+slipStatus+"//draft:"+draft);

        if ( "".equals(slipNum) || "Z".equals(slipStatus) || "R".equals(slipStatus) || "E".equals(slipStatus) || "C".equals(slipStatus))	//신규 이거나 취소, 에러시 전표번호 생성
        {
            slipNum = poOrderMstDAO.selectSlipNum(parameter);
        }
        logger.info("slipNum REAL:"+slipNum+"//i :"+i);
        slipNums.add(i, slipNum);

        parameter.put("slipNum", slipNum);
        mst.setSlipNum(slipNum);	            ///SAP과 연결 키 -유일키
        mst.setBuCd("2000");		            //회사코드
        mst.setSlipType("7P");	            //전표유형
        mst.setSlipEvidenceDate(currYymmdd.substring(0, 8));	//전표증빙일자 - 매입전표일자
        mst.setSlipPeriodDate(currYymmdd.substring(0, 8));	//전표전기일자 - 매입전표일자
        mst.setCurrency("KRW");				//통화

//        mst.setElctntaxBillApprvnum(parameter.get("taxBillNum").toString());	//전자세금계산서승인번호

        logger.info("currYymmdd :"+currYymmdd);
        mst.setInputDate(currYymmdd.substring(0,8));			//입력일자
        mst.setInputTime(currYymmdd.substring(8));			//입력시간 -6자리
        mst.setWriteEmpSabun(loginDTO.getSabun()); //작성사원부서 : 로그인사번
        mst.setWriteEmpDept(loginDTO.getDeptId()); //작성사원부서
        mst.setWriteEmpMuCd(loginDTO.getMuCd());
        mst.setSysCd("IFC"); //시스템코드
        mst.setElctnSignId( LimsUtil.checkNull(parameter.get("signInstanceId2"),"")); //전자결재ID - 임시세팅
        mst.setSignStatus( LimsUtil.checkNull(parameter.get("signProgressStatus2"),"")); //전표상태 - 임시세팅
        mst.setSignType("1"); //결재유형:G/W 결재
        mst.setSlipText("부서이관 전표 ["+loginDTO.getDeptNm()+"]");	  //(ex)상품권 청구 [FC외식사업지원팀]
        if ("Y".equals(draft)) //상신
        {
            mst.setPistat("9");
        }

        List<SlipMstDTO> master = new ArrayList<SlipMstDTO>();
        master.add(mst);

        SlipMstList mstList = new SlipMstList();
        mstList.setDataList(master);

        int ii = 0;
        List<SlipDtlDTO> detail = new ArrayList<SlipDtlDTO>();
        //차변 만들기 : 상품_일반상품
        SlipDtlDTO dtl11 = new SlipDtlDTO();	  //
        dtl11.setSlipNum(slipNum);	            ///SAP과 연결 키 -유일키
        dtl11.setBuCd("2000");
        dtl11.setSlipType("7P");	            //전표유형

        dtl11.setSlipCurrencyAmt( BigDecimal.valueOf(Long.parseLong(parameter.get("realSaleAmt").toString())) );					//전표통화금액 :결재금액

        dtl11.setSlipEvidenceDate(currYymmdd.substring(0,8));	//전표증빙일자 - 전표발행일
        dtl11.setSlipPeriodDate(currYymmdd.substring(0,8));	//전표전기일자 - 지불예정일자
        dtl11.setDtlNum(new BigDecimal(ii++)); 	//회계 전표의 개별 항목 번호
        dtl11.setMasterAcct("11401010");		//미착품
        dtl11.setDrCrClass("1");				//1:차변
        logger.info("remark::: 2:"+parameter.get("remark").toString());
        dtl11.setItemText(parameter.get("poOrderNum").toString() + " " + parameter.get("remark").toString());			//품목텍스트 - 적요2
        dtl11.setAttachDept(parameter.get("attachDeptSap").toString());		//귀속부서
        
        dtl11.setMgmtDept(parameter.get("chgAttachDeptSap").toString());		//관리부서-부서이관
        logger.info("chgAttachDeptSap::: "+parameter.get("chgAttachDeptSap").toString());
        dtl11.setPayCond("F000");		            //지불조건 : 환율(외화)정보 있으면 : E000 나머지 : F000

        detail.add(dtl11);

        //대변 계정만들기 : 상품_일반상품
        SlipDtlDTO dtl21 = new SlipDtlDTO();
        dtl21.setSlipNum(slipNum);	            ///SAP과 연결 키 -유일키
        dtl21.setBuCd("2000");
        dtl21.setSlipType("7P");	            //전표유형

        dtl21.setSlipCurrencyAmt( BigDecimal.valueOf(Long.parseLong(parameter.get("realSaleAmt").toString())) );					//전표통화금액 :결재금액

        dtl21.setSlipEvidenceDate(currYymmdd.substring(0,8));	//전표증빙일자 - 전표발행일
        dtl21.setSlipPeriodDate(currYymmdd.substring(0,8));	//전표전기일자 - 지불예정일자
        dtl21.setDtlNum(new BigDecimal(ii++)); 	//회계 전표의 개별 항목 번호
        dtl21.setMasterAcct("11401010");		//상품_일반상품
        dtl21.setDrCrClass("2");				//1:차변

        dtl21.setSlipCurrencyAmt( BigDecimal.valueOf(Long.parseLong(parameter.get("realSaleAmt").toString())) );					//전표통화금액 :결재금액
        dtl21.setItemText(parameter.get("poOrderNum").toString() + " " +parameter.get("remark").toString());			//품목텍스트 - 적요2
        dtl21.setAttachDept(parameter.get("attachDeptSap").toString());		//귀속부서
        dtl21.setMgmtDept(parameter.get("chgAttachDeptSap").toString());		//관리부서-부서이관
        dtl21.setPayCond("F000");		            //지불조건 : 환율(외화)정보 있으면 : E000 나머지 : F000

        detail.add(dtl21);


        //차변 만들기 : 타계정상품대체
        SlipDtlDTO dtl12 = new SlipDtlDTO();	  //
        dtl12.setSlipNum(slipNum);	            ///SAP과 연결 키 -유일키
        dtl12.setBuCd("2000");
        dtl12.setSlipType("7P");	            //전표유형

        dtl12.setSlipCurrencyAmt( BigDecimal.valueOf(Long.parseLong(parameter.get("realSaleAmt").toString())) );					//전표통화금액 :결재금액
        dtl12.setItemText(parameter.get("poOrderNum").toString() + " " +parameter.get("remark").toString());			//품목텍스트 - 적요2
        dtl12.setAttachDept(parameter.get("attachDeptSap").toString());		//귀속부서
        dtl12.setMgmtDept(parameter.get("chgAttachDeptSap").toString());		//관리부서-부서이관

        dtl12.setSlipEvidenceDate(currYymmdd.substring(0,8));	//전표증빙일자 - 전표발행일
        dtl12.setSlipPeriodDate(currYymmdd.substring(0,8));	//전표전기일자 - 지불예정일자
        dtl12.setDtlNum(new BigDecimal(ii++)); 	//회계 전표의 개별 항목 번호
        dtl12.setMasterAcct("90005050");		//타계정상품대체
        dtl12.setDrCrClass("1");				//1:차변
        dtl12.setPayCond("F000");		            //지불조건 : 환율(외화)정보 있으면 : E000 나머지 : F000

        detail.add(dtl12);

        //대변 계정만들기 : 타계정상품대체
        SlipDtlDTO dtl22 = new SlipDtlDTO();
        dtl22.setSlipNum(slipNum);	            ///SAP과 연결 키 -유일키
        dtl22.setBuCd("2000");
        dtl22.setSlipType("7P");	            //전표유형
        dtl22.setMasterAcct("90005050");		//타계정상품대체
        dtl22.setDrCrClass("2");				//2:대변
        dtl22.setSlipEvidenceDate(currYymmdd.substring(0,8));	//전표증빙일자 - 매입전표일자
        dtl22.setSlipPeriodDate(currYymmdd.substring(0,8));	//전표전기일자 - 지불예정일자
        dtl22.setPayCond("F000");		            //지불조건 : 환율(외화)정보 있으면 : E000 나머지 : F000


        String remarks2 ="";

        double exchangeRate = Double.parseDouble(LimsUtil.checkNull(parameter.get("signExchangeRate").toString(),"0"));
        double payAmt = Double.parseDouble(parameter.get("realSaleAmt").toString());

        String strSettleExchangeRate = String.format("%.2f", exchangeRate);
        String strPayAmt = String.format("%.2f", payAmt);

        remarks2 = parameter.get("unit").toString()
                +" / "+strSettleExchangeRate
                +" / "+strPayAmt
                ;
        remarks2 = remarks2 +" / "+ parameter.get("remark").toString();
        logger.info("remarks2 :"+remarks2);

        dtl22.setSlipCurrencyAmt( BigDecimal.valueOf(Long.parseLong(parameter.get("realSaleAmt").toString())) );					//전표통화금액 :결재금액
        dtl22.setItemText( parameter.get("poOrderNum").toString() + " " +parameter.get("remark").toString() );			//품목텍스트 - 적요2
        dtl22.setAttachDept(parameter.get("attachDeptSap").toString());		//귀속부서
        dtl22.setMgmtDept(parameter.get("chgAttachDeptSap").toString());		//관리부서-부서이관
        dtl22.setDtlNum(new BigDecimal(ii++)); 	//회계 전표의 개별 항목 번호

        detail.add(dtl22);


        SlipDtlList dtlList = new SlipDtlList();
        dtlList.setDataList(detail);

        EAIListMap map = new EAIListMap();
        map.addEAIList("master", mstList);
        map.addEAIList("detail", dtlList);


        EAIResponse res = eaiService.call(map);

        if (res.isSuccess()) {
            logger.debug("성공");
        }
        else {
            logger.debug(res.getErrorMsg());
            throw processException(res.getErrorMsg());

        }

        //원가대체 회계번호 수정 처리한다.
        parameter.put("releaseNum", parameter.get("releaseNum").toString());
        parameter.put("deptMngmvSlipNum", slipNum);

        releaseMgmtDAO.updateDeptMngmvSlipFiscalNum(parameter);

        if ("Y".equals(draft)) //상신
        {
            logger.info("------------1");
            parameter.put("slipStatus", "9"); //상신
        } else {
            logger.info("------------2");
            parameter.put("slipStatus", "A"); //전표요청
        }
        parameter.put("slipNum", slipNums.get(i));
        parameter.put("buCd", "2000");
        parameter.put("workClass", "부서이관");

        parameter.put("slipNum", slipNum);
        RecordSet fsiRs = ftSapInterfaceDAO.selectList(parameter);
        if (fsiRs.size() > 0) {
            ftSapInterfaceDAO.update(parameter);
        } else {
            ftSapInterfaceDAO.insert(parameter);
        }

        if ( !"Y".equals(draft))	  //상신
        {
        	parameter.put("signInstanceId", parameter.get("signInstanceId2"));
            ftSapInterfaceDAO.updateSignInstanceId(parameter);	  //전자결재 아이디 update
        }

        return slipNums;
    }
    /**
     * 판매 주문내역에 대하여 출고(품목)를 관리 매입원가 차감 처리한다.
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
    public List<Map<String, Object>> releaseBuyCostExcept(DataSetMap search, DataSetMap list, LoginDTO loginDTO)
            throws Exception {
        int updRowCnt = 0;
        DecimalFormat df = new DecimalFormat();
        List<Map<String, Object>> topListMap = new ArrayList();
        Map<String, Object> topMap = new HashMap();
        String draft = search.get(0).get("draft").toString(); //상신,전표처리 구분
        String flag = search.get(0).get("flag").toString(); //부서이관,매입원가차감 구분자
        logger.info("draft :" + draft);
        logger.info("flag :" + flag);
//        ArrayList slipNums = new ArrayList();
        List<String> slipNums = new ArrayList<String>();
        int slipNumRow =-1;
        String currYymmdd = LimsUtil.getDate("yyyyMMddHHmmss");
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> parameter = list.get(i);

            int rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            String seq = LimsUtil.checkNull(parameter.get("seq"), ""); //환입 seq
            if (rowType == DataSet.ROW_TYPE_UPDATED && "1".equals(parameter.get("chk")) ) {
                if ( "".equals(seq))
                {

                    slipNumRow++;
                    String releaseStatusCd = parameter.get("saleOrderType").toString();
                    logger.info("releaseStatusCd :" + releaseStatusCd);

                    if ("1".equals(flag))	//부서이관 전표
                    {
                        logger.info("#####부서이관#####");
                        slipNums = createDeptMngmvSlipNum( i, search, parameter, loginDTO, slipNums );
                        updRowCnt++;
                    }
                    else if ("2".equals(flag))	 //매입원가차감 전표 + 20051029 김은영
                    {

                        double buyCst = Double.parseDouble(parameter.get("buyCst").toString());	//+
                        double buyUprice = Double.parseDouble(parameter.get("buyUprice").toString());

                        logger.info("buyCst :"+buyCst+"//"+buyUprice);

                        logger.info("#####매입원가차감#####");
                        SlipMstDTO mst = new SlipMstDTO();


                        //마스터 생성
                        String slipNum = LimsUtil.checkNull(parameter.get("cstSlipFiscalNum"), "").toString();
                        String slipStatus = LimsUtil.checkNull(parameter.get("slipStatus"),"").toString();
                        logger.info("slipNum :"+slipNum+"// slipStatus111:"+slipStatus+"//draft:"+draft+"// releaseDate:"+parameter.get("releaseDate"));
                        int year = Integer.parseInt(parameter.get("releaseDate").toString().substring(0,4));
                        int month  = Integer.parseInt(parameter.get("releaseDate").toString().substring(5,6));
                        int lastDay = CommonUtil.getLastDayOfMon(year, month);
                        
                        //String lastReleaseDate = parameter.get("releaseDate").toString().substring(0,6)+lastDay+"";
                        String lastReleaseDate = getLastdayOfMonth(parameter.get("releaseDate").toString()); 
                        
                        logger.info("lastReleaseDate :"+lastReleaseDate);

                        if ( "".equals(slipNum) || "Z".equals(slipStatus) || "R".equals(slipStatus) || "E".equals(slipStatus) || "C".equals(slipStatus))	//신규 이거나 취소, 에러시 전표번호 생성
                        {
                            logger.info("없다");
                            slipNum = poOrderMstDAO.selectSlipNum(parameter);
                        }
                        logger.info("slipNum REAL:"+slipNum);


                        parameter.put("slipNum", slipNum);
                        logger.info("slipNumRow :"+slipNumRow);
                        slipNums.add(slipNumRow, slipNum);

                        mst.setSlipNum(slipNum); ///SAP과 연결 키 -유일키
                        mst.setBuCd("2000"); //회사코드
                        mst.setSlipType("7O"); //전표유형
                        mst.setSlipEvidenceDate(lastReleaseDate); //전표증빙일자 - 매입전표일자
                        mst.setSlipPeriodDate(lastReleaseDate); //전표전기일자 - 매입전표일자
                        mst.setCurrency("KRW"); //통화

                        //            mst.setElctntaxBillApprvnum(parameter.get("taxBillNum").toString());	//전자세금계산서승인번호

                        logger.info("currYymmdd :" + currYymmdd);
                        mst.setInputDate(currYymmdd.substring(0, 8)); //입력일자
                        mst.setInputTime(currYymmdd.substring(8)); //입력시간 -6자리
                        mst.setWriteEmpSabun(loginDTO.getSabun()); //작성사원부서 : 로그인사번
                        mst.setWriteEmpDept(loginDTO.getDeptId()); //작성사원부서
                        mst.setWriteEmpMuCd(loginDTO.getMuCd());
                        mst.setSysCd("IFC"); //시스템코드
                        mst.setElctnSignId( LimsUtil.checkNull(parameter.get("signInstanceId"),"")); //전자결재ID - 임시세팅
                        mst.setSignStatus( LimsUtil.checkNull(parameter.get("signProgressStatus"),"")); //전표상태 - 임시세팅
                        mst.setSignType("1"); //결재유형:G/W 결재
                        mst.setSlipText("매입원가차감 전표 ["+loginDTO.getDeptNm()+"]");	  //(ex)상품권 청구 [FC외식사업지원팀]
                        if ("Y".equals(draft)) //상신
                        {
                            mst.setPistat("9");
                        }

                        List<SlipMstDTO> master = new ArrayList<SlipMstDTO>();
                        master.add(mst);

                        SlipMstList mstList = new SlipMstList();
                        mstList.setDataList(master);

                        int ii = 0;
                        List<SlipDtlDTO> detail = new ArrayList<SlipDtlDTO>();
                        //차변 만들기 : 상품원가_일반
                        SlipDtlDTO dtl11 = new SlipDtlDTO(); //
                        dtl11.setSlipNum(slipNum); ///SAP과 연결 키 -유일키
                        dtl11.setBuCd("2000");
                        dtl11.setSlipType("7O"); //전표유형
                        dtl11.setSlipEvidenceDate(lastReleaseDate); //전표증빙일자 - 전표발행일
                        dtl11.setSlipPeriodDate(lastReleaseDate); //전표전기일자 - 지불예정일자
                        dtl11.setMasterAcct("42201010"); //상품원가_일반
                        dtl11.setDrCrClass("1"); //1:차변

                        dtl11.setCcCd(parameter.get("attachDeptSap").toString()); //코스트 센터 CC_CD


                        String remark = LimsUtil.checkNull(parameter.get("remark"), ""); //업장
                        if ("".equals(remark)) {
                            remark = parameter.get("poOrderNum").toString() + " " + remark;
                        }
                        dtl11.setSlipCurrencyAmt(BigDecimal.valueOf(buyCst)); //공급가액
                        dtl11.setItemText(remark); //품목텍스트 - 적요2
                        dtl11.setSlipCurrencyAmt(BigDecimal.valueOf(buyCst)); //전표통화금액 :결재금액
                        dtl11.setLcNum(parameter.get("lcNum").toString()); //LC번호
                        dtl11.setPoNum(parameter.get("poOrderNum").toString()); //PO번호
                        dtl11.setAttachDept(parameter.get("attachDeptSap").toString()); //귀속부서
                        dtl11.setMgmtDept(parameter.get("attachDeptSap").toString()); //관리부서-귀속부서와 동일
                        dtl11.setDtlNum(new BigDecimal(ii++)); //회계 전표의 개별 항목 번호
                        detail.add(dtl11);

                        //대변 계정만들기 : 상품_일반상품
                        SlipDtlDTO dtl21 = new SlipDtlDTO();
                        dtl21.setSlipNum(slipNum); ///SAP과 연결 키 -유일키
                        dtl21.setBuCd("2000");
                        dtl21.setSlipType("7O"); //전표유형

                        dtl21.setSlipCurrencyAmt(BigDecimal.valueOf(buyCst)); //전표통화금액 :결재금액
                        dtl21.setSlipEvidenceDate(lastReleaseDate); //전표증빙일자 - 전표발행일
                        dtl21.setSlipPeriodDate(lastReleaseDate); //전표전기일자 - 지불예정일자
                        dtl21.setDtlNum(new BigDecimal(ii++)); //회계 전표의 개별 항목 번호
                        dtl21.setMasterAcct("11401010"); //상품_일반상품
                        dtl21.setDrCrClass("2"); //2:대변
                        dtl21.setItemText(remark); //품목텍스트 - 적요2
                        dtl21.setAttachDept(parameter.get("attachDeptSap").toString()); //귀속부서
                        dtl21.setMgmtDept(parameter.get("attachDeptSap").toString()); //관리부서-귀속부서와 동일

                        detail.add(dtl21);

                        SlipDtlList dtlList = new SlipDtlList();
                        dtlList.setDataList(detail);

                        EAIListMap map = new EAIListMap();
                        map.addEAIList("master", mstList);
                        map.addEAIList("detail", dtlList);

                        EAIResponse res = eaiService.call(map);

                        if (res.isSuccess()) {
                            logger.debug("성공");
                        } else {
                            logger.debug(res.getErrorMsg());
                            throw processException(res.getErrorMsg());

                        }

                        //원가대체 회계번호 수정 처리한다.
                        parameter.put("releaseNum", parameter.get("releaseNum").toString());
                        parameter.put("cstSlipFiscalNum", slipNum);
                        parameter.put("fiscalSlipNum", slipNum);
                        parameter.put("cstExceptYn", "Y");	//매입원가 차감여부
                        parameter.put("cstSlipCdate", lastReleaseDate);

//                        if ("".equals(seq)) //정상건
//                        {
                        logger.info("incSignInstanceId :" + parameter.get("incSignInstanceId"));
                            updRowCnt += releaseMgmtDAO.updateCstSlipFiscalNum(parameter);
//                        } else //환입건
//                        {
                            updRowCnt += purchaseReturnMgmtDAO.updateCstSeq(parameter);
//                        }

                        if ("Y".equals(draft)) //상신
                        {
                            logger.info("------------1");
                            parameter.put("slipStatus", "9"); //상신
                        } else {
                            logger.info("------------2");
                            parameter.put("slipStatus", "A"); //전표요청
                        }
//                        parameter.put("slipNum", slipNums.get(slipNumRow));
                        parameter.put("slipNum", slipNum);
                        parameter.put("buCd", "2000");
                        parameter.put("workClass", "매입원가 차감");

                        RecordSet fsiRs = ftSapInterfaceDAO.selectList(parameter);
                        if (fsiRs.size() > 0) {
                            ftSapInterfaceDAO.update(parameter);
                        } else {
                            ftSapInterfaceDAO.insert(parameter);
                        }
                        if ( !"Y".equals(draft))	  //상신
                        {
                            ftSapInterfaceDAO.updateSignInstanceId(parameter);	  //전자결재 아이디 update
                        }
                    }
                }


                if ("3".equals(flag))	 //매입원가증감 전표 - 20051029 김은영
                {
                    slipNumRow++;
                    double buyCst = -Double.parseDouble(parameter.get("purchaseReturnCst").toString());	//매입원가 증가 :환입원가-
                    double buyUprice = Double.parseDouble(parameter.get("buyUprice").toString());
                    logger.info("buyCst :"+buyCst+"//"+buyUprice);
                    logger.info("#####매입원가증감#####");
                    SlipMstDTO mst = new SlipMstDTO();

                    //마스터 생성
                    String slipNum = LimsUtil.checkNull(parameter.get("cstIncSlipFiscalNum"), "").toString();
                    String slipStatus = LimsUtil.checkNull(parameter.get("slipStatus4"),"").toString();
                    logger.info("slipNum :"+slipNum+"// slipStatus111:"+slipStatus+"//draft:"+draft);
                    if ( "".equals(slipNum) || "Z".equals(slipStatus) || "R".equals(slipStatus) || "E".equals(slipStatus) || "C".equals(slipStatus))	//신규 이거나 취소, 에러시 전표번호 생성
                    {
                        logger.info("없다");
                        slipNum = poOrderMstDAO.selectSlipNum(parameter);
                    }
                    logger.info("slipNum REAL:"+slipNum);


                    parameter.put("slipNum", slipNum);
                    logger.info("slipNumRow :"+slipNumRow);
                    slipNums.add(slipNumRow, slipNum);

                    mst.setSlipNum(slipNum); ///SAP과 연결 키 -유일키
                    mst.setBuCd("2000"); //회사코드
                    mst.setSlipType("7O"); //전표유형


                    mst.setSlipEvidenceDate(parameter.get("purchaseReturnDate").toString()); //전표증빙일자 - 매입전표일자	 --환입일로 수정 필요 20151105 이유빈
                    mst.setSlipPeriodDate(parameter.get("purchaseReturnDate").toString()); //전표전기일자 - 매입전표일자
                    mst.setCurrency("KRW"); //통화

                    logger.info("currYymmdd :" + currYymmdd);
                    mst.setInputDate(currYymmdd.substring(0, 8)); //입력일자
                    mst.setInputTime(currYymmdd.substring(8)); //입력시간 -6자리
                    mst.setWriteEmpSabun(loginDTO.getSabun()); //작성사원부서 : 로그인사번
                    mst.setWriteEmpDept(loginDTO.getDeptId()); //작성사원부서
                    mst.setWriteEmpMuCd(loginDTO.getMuCd());
                    mst.setSysCd("IFC"); //시스템코드
                    mst.setElctnSignId( LimsUtil.checkNull(parameter.get("signInstanceId4"),"")); //전자결재ID - 임시세팅
                    mst.setSignStatus( LimsUtil.checkNull(parameter.get("signProgressStatus4"),"")); //전표상태 - 임시세팅
                    mst.setSignType("1"); //결재유형:G/W 결재
                    mst.setSlipText("매입원가증감 전표 ["+loginDTO.getDeptNm()+"]");	  //(ex)상품권 청구 [FC외식사업지원팀]
                    if ("Y".equals(draft)) //상신
                    {
                        mst.setPistat("9");
                    }

                    List<SlipMstDTO> master = new ArrayList<SlipMstDTO>();
                    master.add(mst);

                    SlipMstList mstList = new SlipMstList();
                    mstList.setDataList(master);

                    int ii = 0;
                    List<SlipDtlDTO> detail = new ArrayList<SlipDtlDTO>();
                    //차변 만들기 : 상품원가_일반
                    SlipDtlDTO dtl11 = new SlipDtlDTO(); //
                    dtl11.setSlipNum(slipNum); ///SAP과 연결 키 -유일키
                    dtl11.setBuCd("2000");
                    dtl11.setSlipType("7O"); //전표유형
                    dtl11.setSlipEvidenceDate(parameter.get("purchaseReturnDate").toString()); //전표증빙일자 - 전표발행일
                    dtl11.setSlipPeriodDate(parameter.get("purchaseReturnDate").toString()); //전표전기일자 - 지불예정일자
                    dtl11.setMasterAcct("42201010"); //상품원가_일반
                    dtl11.setDrCrClass("1"); //1:차변

                    dtl11.setCcCd(parameter.get("attachDeptSap").toString()); //코스트 센터 CC_CD

                    String remark = LimsUtil.checkNull(parameter.get("remark"), ""); //업장
                    if ("".equals(remark)) {
                        remark = parameter.get("poOrderNum").toString() + " " + remark;
                    }
                    dtl11.setSlipCurrencyAmt(BigDecimal.valueOf(buyCst)); //공급가액
                    dtl11.setItemText(remark); //품목텍스트 - 적요2
                    dtl11.setSlipCurrencyAmt(BigDecimal.valueOf(buyCst)); //전표통화금액 :결재금액
                    dtl11.setLcNum(parameter.get("lcNum").toString()); //LC번호
                    dtl11.setPoNum(parameter.get("poOrderNum").toString()); //PO번호
                    dtl11.setAttachDept(parameter.get("attachDeptSap").toString()); //귀속부서
                    dtl11.setMgmtDept(parameter.get("attachDeptSap").toString()); //관리부서-귀속부서와 동일
                    dtl11.setDtlNum(new BigDecimal(ii++)); //회계 전표의 개별 항목 번호
                    detail.add(dtl11);

                    //대변 계정만들기 : 상품_일반상품
                    SlipDtlDTO dtl21 = new SlipDtlDTO();
                    dtl21.setSlipNum(slipNum); ///SAP과 연결 키 -유일키
                    dtl21.setBuCd("2000");
                    dtl21.setSlipType("7O"); //전표유형

                    dtl21.setSlipCurrencyAmt(BigDecimal.valueOf(buyCst)); //전표통화금액 :결재금액
                    dtl21.setSlipEvidenceDate(parameter.get("purchaseReturnDate").toString()); //전표증빙일자 - 전표발행일
                    dtl21.setSlipPeriodDate(parameter.get("purchaseReturnDate").toString()); //전표전기일자 - 지불예정일자
                    dtl21.setDtlNum(new BigDecimal(ii++)); //회계 전표의 개별 항목 번호
                    dtl21.setMasterAcct("11401010"); //상품_일반상품
                    dtl21.setDrCrClass("2"); //2:대변

                    dtl21.setCcCd(parameter.get("attachDeptSap").toString()); //코스트 센터 CC_CD

                    dtl21.setItemText(remark); //품목텍스트 - 적요2
                    dtl21.setAttachDept(parameter.get("attachDeptSap").toString()); //귀속부서
                    dtl21.setMgmtDept(parameter.get("attachDeptSap").toString()); //관리부서-귀속부서와 동일

                    detail.add(dtl21);

                    SlipDtlList dtlList = new SlipDtlList();
                    dtlList.setDataList(detail);

                    EAIListMap map = new EAIListMap();
                    map.addEAIList("master", mstList);
                    map.addEAIList("detail", dtlList);

                    EAIResponse res = eaiService.call(map);

                    if (res.isSuccess()) {
                        logger.debug("성공");
                    } else {
                        logger.debug(res.getErrorMsg());
                        throw processException(res.getErrorMsg());

                    }

                    //원가대체 회계번호 수정 처리한다.
                    parameter.put("releaseNum", parameter.get("releaseNum").toString());
                    parameter.put("cstSlipFiscalNum", slipNum);
                    parameter.put("cstExceptYn", "Y");	//매입원가 차감여부
                    parameter.put("cstSlipCdate", parameter.get("purchaseReturnDate").toString());

                    parameter.put("cstIncSlipFiscalNum", slipNum);
                    parameter.put("cstIncYn", "Y");	//매입원가 증감여부
                    parameter.put("cstIncSlipCdate", parameter.get("purchaseReturnDate").toString());

//                    if ("".equals(seq)) //정상건
//                    {
//                        updRowCnt += releaseMgmtDAO.updateIncCstSlipFiscalNum(parameter);
//                    } else //환입건
//                    {
                        updRowCnt += purchaseReturnMgmtDAO.updateCstSeq(parameter);
//                    }

                    if ("Y".equals(draft)) //상신
                    {
                        logger.info("------------1");
                        parameter.put("slipStatus", "9"); //상신
                    } else {
                        logger.info("------------2");
                        parameter.put("slipStatus", "A"); //전표요청
                    }
                    parameter.put("slipNum", slipNums.get(slipNumRow));
                    parameter.put("buCd", "2000");
                    parameter.put("workClass", "매입원가 증가");

                    RecordSet fsiRs = ftSapInterfaceDAO.selectList(parameter);
                    if (fsiRs.size() > 0) {
                        ftSapInterfaceDAO.update(parameter);
                    } else {
                        ftSapInterfaceDAO.insert(parameter);
                    }
                    if ( !"Y".equals(draft))	  //상신
                    {
                        parameter.put("signInstanceId", LimsUtil.checkNull(parameter.get("signInstanceId4"),""));
                        ftSapInterfaceDAO.updateSignInstanceId(parameter);	  //전자결재 아이디 update
                    }
                }
            }
        }
        logger.info("slipNums :::::::"+slipNums);
        topMap.put("slipNums", slipNums); //구매품의 번호 전달
        topMap.put("procCnt", updRowCnt); //실행건 전달
        topListMap.add(topMap);

        return topListMap;
    }


    /**
     * createFiscalSlip 설명
     * <pre>
     * 회계전표 IF 취소 버튼 클릭시 SAP
     * </pre>
     *
     * @param parameter
     * @return
     * @see com.hwfs.ft.fgp.dao.GdspaymMstDAO.cancelFiscalSlip
    */
    @Override
    @SuppressWarnings("unchecked")
    public int releaseBuyCostExceptCancel(LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap dsList
            ) throws Exception  {
        int procCnt = 0;

        //PO 후상태 - PO 확정이후의 상태(수입은 매입전표생성) Y를 UPDATE하고 확정취소 불가 처리
        if ( dsList.size() > 0 ) {
            for (int i = 0 ; i < dsList.size() ; i++) {
                Map<String, Object> parameter = dsList.get(i);

                //sap모듈 호출후 성공하면후 하단 로직 처리
                String currYymmdd = LimsUtil.getDate("yyyyMMddHHmmss");
                SlipCancelDTO mst = new SlipCancelDTO();
                mst.setSlipNum(parameter.get("slipNum").toString());	            //SAP과 연결 키 -유일키
                mst.setBuCd("2000");		                                        //회사코드
                mst.setSysCd("IFC");												//시스템코드
                mst.setFiscalSlipNum(parameter.get("fiscalSlipNum").toString());    //회계전표번호
                mst.setFiscalYear(parameter.get("fiscalYear").toString());			//회계전도
                mst.setPeriodDate(parameter.get("fiscalSlipcDate").toString());	        //전기일 - 매입전표일자
                mst.setRequestDate(currYymmdd.substring(0,8));			            //요청일자
                mst.setRequestTime(currYymmdd.substring(8));			            //요청시간
                logger.info("slipStatus ::"+LimsUtil.checkNull(parameter.get("slipStatus").toString()));
                if ( "P".equals(LimsUtil.checkNull(parameter.get("slipStatus").toString())) )
                {
                    mst.setCancelReason("1");			            					//취소사유 : 0. 임시전표삭제. 1. 회계기간내, 2 마감기간역분개
                }
                else
                {
                    mst.setCancelReason("0");			            					//취소사유 : 0. 임시전표삭제. 1. 회계기간내, 2 마감기간역분개
                }
                mst.setWriteEmpNum(loginParameter.getSabun());						//작성사원부서 : 로그인사번
                mst.setWriteEmpDept(loginParameter.getDeptId());					//작성사원부서


                List<SlipCancelDTO> master = new ArrayList<SlipCancelDTO>();
                master.add(mst);

                SlipCancelList mstList = new SlipCancelList();	  //취소
                mstList.setDataList(master);

                EAIResponse res = eaiService.call(mstList);

                if (res.isSuccess()) {
                    logger.debug("성공");
                }
                else {
                    logger.debug(res.getErrorMsg());
                    throw processException(res.getErrorMsg());

                }

                Map<String, Object> paramMap = new HashMap<String, Object>();
                paramMap.put("slipNum", parameter.get("slipNum").toString());
                paramMap.put("slipStatus", "B");
                paramMap.put("buCd", "2000");
                paramMap.put("resultMsg", "취소");
                paramMap.put("workClass", "매입원가대체 취소");
                ftSapInterfaceDAO.update(paramMap);
                procCnt++;
            }
        }
        return procCnt;
    }

    /**
     * 여신체크
     * <pre>
     * 여신체크
     * </pre>
     *
     * @param inVar
     * @return PgmAuthDTO
     * @throws Exception
     */
    @Override
    public RecordSet getLendingChk(Map<String, Object> inVar) throws Exception {
        RecordSet rs = salsplceDAO.selectList2(inVar);

        logger.info("rs.size():::"+rs.size());
        if ( rs.size() > 1 )
        {
            throw new BizException("해당 거래처와 연결된 업장이 1개이상 존재합니다. 전산팀에 확인 바랍니다.");
        }

        logger.info(rs.get(0).getString("upjang"));
        String upjang = LimsUtil.checkNull(rs.get(0).getString("upjang"), ""); //업장
        String mainUpjang = LimsUtil.checkNull(rs.get(0).getString("mainUpjang"), ""); //메인업장
        String headCreditYn = LimsUtil.checkNull(rs.get(0).getString("headCreditYn"), ""); //메인업장여부

        if ("Y".equals(headCreditYn)) //메인업장
        {
            upjang = mainUpjang;
        }


        logger.info("upjang :" + upjang);
        logger.info("mainUpjang :" + mainUpjang);
        logger.info("headCreditYn :" + headCreditYn);
        logger.info("releaseDate :" + inVar.get("releaseDate"));
        inVar.put("upjang", upjang);
        inVar.put("schUpjang", upjang);
        inVar.put("schMainUpjang", mainUpjang);
        inVar.put("schHeadCreditYn", headCreditYn);
        String currYymmdd = LimsUtil.getDate("yyyyMMdd");
//        inVar.put("schNeedDate", currYymmdd);	//현재날짜로 여신체크 필요
        logger.info("endTerm :::"+currYymmdd);
        inVar.put("schNeedDate", currYymmdd);	//현재날짜로 여신체크 필요
        inVar.put("schSysClass", "14"); //식재도매

        return orderRequestDAO.selectCreInfoFTS(inVar); //TODO 추후 작업
    }

    /**
     * 여신체크2
     * <pre>
     * 여신체크
     * </pre>
     *
     * @param inVar
     * @return PgmAuthDTO
     * @throws Exception
     */
    @Override
    public Record getLendingChk2(Map<String, Object> inVar) throws Exception {
        return releaseMgmtDAO.getLendingChk2(inVar);
    }

    /**
     * 출고증 Fax 발송
     *
     * @param mapParam
     * @return
     * @throws Exception
     * @see com.hwfs.ft.fts.service.ReleaseMgmtService#releaseFaxTransfer(java.util.Map)
    */
    public RecordSet releaseFaxTransfer(Map<String, Object> parameter) throws Exception {
        // ,로 구분되어 넘어온 parameter를 list로 변환하여 쿼리에서 IN 절에 사용 한다.
        parameter.put("releaseNums", LimsUtil.codeConvertStringToList(LimsUtil.checkNull(parameter.get("releaseNums")), ","));
        parameter.put("whCds", LimsUtil.codeConvertStringToList(LimsUtil.checkNull(parameter.get("whCds")), ","));
        return releaseMgmtDAO.releaseFaxTransfer(parameter);
    }


    /**
     * 여신체크
     * <pre>
     * 여신체크
     * </pre>
     *
     * @param inVar
     * @return PgmAuthDTO
     * @throws Exception
     */
    @Override
    public RecordSet selectLendList(Map<String, Object> inVar) throws Exception {
        RecordSet rs = releaseMgmtDAO.selectLendList(inVar);

        for (int i = 0; i < rs.size(); i++) {
            Map<String, Object> parameter = rs.get(i);
            String upjang = LimsUtil.checkNull(parameter.get("upjang"), ""); 		 	 //업장
            String mainUpjang = LimsUtil.checkNull(parameter.get("mainUpjang"), ""); 	 //메인업장
            String headCreditYn = LimsUtil.checkNull(parameter.get("headCreditYn"), ""); //메인업장여부
            logger.info("focDate :" + inVar.get("focDate"));

//            String month = inVar.get("focDate").toString().substring(0,6);
//            String lastDate = AppDataUtility.getLastDay(month);
//            logger.info("lastDate :" + lastDate);
//            if ( "10".equals(attachDept))	//축산
//            {
//                inVar.put("focDate", lastDate);
//            }
            if ("Y".equals(headCreditYn)) //메인업장
            {
                upjang = mainUpjang;
            }
            logger.info("upjang :" + upjang);
            logger.info("mainUpjang :" + mainUpjang);
            logger.info("headCreditYn :" + headCreditYn);
            logger.info("focDate :" + inVar.get("focDate"));
            inVar.put("upjang", upjang);
            inVar.put("schUpjang", upjang);
            inVar.put("schMainUpjang", mainUpjang);
            inVar.put("schHeadCreditYn", headCreditYn);
            String currYymmdd = LimsUtil.getDate("yyyyMMdd");
            inVar.put("schNeedDate", inVar.get("focDate"));
            inVar.put("schSysClass", "14"); //식재도매

            Record rd = releaseMgmtDAO.selectCreInfo(inVar);
            if (rd != null) {
                logger.info("creditAmount :" + rd.getDouble("creditAmount"));
                parameter.put("creditAmount", rd.getDouble("creditAmount"));
                parameter.put("rmnAmt", rd.getDouble("rmnAmt"));
                parameter.put("preAmt1", rd.getDouble("preAmt1"));
                parameter.put("preAmt2", rd.getDouble("preAmt2"));
                logger.info("creditOverAmount :" + rd.getDouble("creditOverAmount"));
                parameter.put("creditOverAmount", rd.getDouble("creditOverAmount"));   //임시여신

                double rmnAmt = Double.parseDouble(LimsUtil.checkNull(rd.getDouble("rmnAmt"), "0"));				//외상매출잔액
                double preAmt1 = Double.parseDouble(LimsUtil.checkNull(rd.getDouble("preAmt1"), "0"));				//선수잔액
                double preAmt2 = Double.parseDouble(LimsUtil.checkNull(rd.getDouble("preAmt2"), "0"));				//선수잔액
                double creditAmount = Double.parseDouble(LimsUtil.checkNull(rd.getDouble("creditAmount"), "0"));	//여신금액
                double creditOverAmount = Double.parseDouble(LimsUtil.checkNull(rd.getDouble("creditOverAmount"), "0"));	//임시여신
                //2019.04.03 김명섭 총여신금액에 계약이행예치금(preAmt1) 제외 (컴플라이언스 이성희과장 전산의뢰 요청사항)
                //parameter.put("totCreditAmount", -rmnAmt+preAmt1+preAmt2+creditAmount+creditOverAmount);								//총여신금액
                parameter.put("totCreditAmount", -rmnAmt+preAmt2+creditAmount+creditOverAmount);								//총여신금액
            }
        }
        return rs;
    }

    /**
     * 거래명세서 Fax 발송 거래처정보
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.fts.service.ReleaseMgmtService#dealReqDocPublishCustFaxTransfer(java.util.Map)
    */
    public Record dealReqDocPublishCustFaxTransfer(Map<String, Object> parameter) throws Exception {
        return releaseMgmtDAO.dealReqDocPublishCustFaxTransfer(parameter);
    }

    /**
     * 거래명세서 Fax 발송 리스트
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.fts.service.ReleaseMgmtService#dealReqDocPublishListFaxTransfer(java.util.Map)
    */
    public RecordSet dealReqDocPublishListFaxTransfer(Map<String, Object> parameter) throws Exception {
        // ,로 구분되어 넘어온 parameter를 list로 변환하여 쿼리에서 IN 절에 사용 한다.
        parameter.put("releaseNums", LimsUtil.codeConvertStringToList(LimsUtil.checkNull(parameter.get("releaseNums")), ","));
        return releaseMgmtDAO.dealReqDocPublishListFaxTransfer(parameter);
    }

    /**
     * 거래명세서 Fax 발송 리스트
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.fts.service.ReleaseMgmtService#dealReqDocPublishListFaxTransfer(java.util.Map)
    */
    public RecordSet dealReqDocPublishListFaxTransferChk(Map<String, Object> parameter) throws Exception {
        // ,로 구분되어 넘어온 parameter를 list로 변환하여 쿼리에서 IN 절에 사용 한다.
        parameter.put("releaseNums", LimsUtil.codeConvertStringToList(LimsUtil.checkNull(parameter.get("releaseNums")), ","));
        return releaseMgmtDAO.dealReqDocPublishListFaxTransferChk(parameter);
    }
    
    /**
     * 해당월의 마지막 일자 구하기
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.fts.service.ReleaseMgmtService#getLastdayOfMonth(java.util.Map)
    */
    public String getLastdayOfMonth(String pDate) throws Exception {
    	Map<String, Object> mapParam = new HashMap<String, Object>();		
		mapParam.put("releaseDate", pDate);

        return releaseMgmtDAO.getLastdayOfMonth(mapParam);
    }    
}
