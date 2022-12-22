package com.hwfs.ft.ftp.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;



//import org.apache.jasper.compiler.JspUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.ft.fsi.dao.FreezeWhCommMgmtDAO;
import com.hwfs.ft.fsi.dao.FtSapInterfaceDAO;
import com.hwfs.ft.fsi.dao.WhbyItembyChargAmtDAO;
import com.hwfs.ft.ftp.dao.EtcPrepayamtAdjustDAO;
import com.hwfs.ft.ftp.dao.PoOrderCommSalsDAO;
import com.hwfs.ft.ftp.dao.PoOrderInvoiceDAO;
import com.hwfs.ft.ftp.dao.PoOrderItemDetailDAO;
import com.hwfs.ft.ftp.dao.PoOrderMstDAO;
import com.hwfs.ft.ftp.dao.PoOrderOtherAmtDAO;
import com.hwfs.ft.ftp.dao.PoOrderPayCondDAO;
import com.hwfs.ft.ftp.dao.ProposalDAO;
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
import com.hwfs.sc.cmn.service.AttachFileService;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 구매 주문에 대한 내역을 등록 관리.하는 PoOrderMst Service Implementation
 *
 * @ClassName PoOrderMstServiceImpl.java
 * @Description PoOrderMstServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.16    김종준        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재도매 김종준
 * @since 2015.03.16
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ft/ftp/poOrderMstService")
public class PoOrderMstServiceImpl extends DefaultServiceImpl implements PoOrderMstService {

    /** LogService */
    private final Logger logger = LoggerFactory.getLogger (this.getClass());

    /** PoOrderMstDAO Bean 생성 */
    @Resource(name = "/ft/ftp/poOrderMstDAO")
    private PoOrderMstDAO poOrderMstDAO;

    @Resource(name = "/ft/ftp/poOrderItemDetailDAO")
    private PoOrderItemDetailDAO poOrderItemDetailDAO;

    @Resource(name = "/ft/ftp/poOrderPayCondDAO")
    private PoOrderPayCondDAO poOrderPayCondDAO;

    @Resource(name = "/ft/ftp/poOrderInvoiceDAO")
    private PoOrderInvoiceDAO poOrderInvoiceDAO;

    @Resource(name = "/ft/ftp/poOrderOtherAmtDAO")
    private PoOrderOtherAmtDAO poOrderOtherAmtDAO;

    @Resource(name = "/ft/ftp/etcPrepayamtAdjustDAO")
    private EtcPrepayamtAdjustDAO etcPrepayamtAdjustDAO;

    @Resource(name = "/ft/ftp/poOrderCommSalsDAO")
    private PoOrderCommSalsDAO poOrderCommSalsDAO;

    /** AttachFile Service Bean 생성 */
    @Resource(name = "/sc/cmn/attachFileService")
    private AttachFileService attachFileService;

    @Resource(name="EAIService")
    EAIService eaiService;

    /** FtSapInterfaceDAO Bean 생성 */
    @Resource(name = "/ft/fsi/ftSapInterfaceDAO")
    private FtSapInterfaceDAO ftSapInterfaceDAO;

    @Resource(name = "/ls/ltm/testEndApprvDAO")
    private TestEndApprvDAO testEndApprvDAO;

    /** GwIfDAO Bean 생성 */
    @Resource(name = "/sc/cmn/gwIfDAO")
    private GwIfDAO gwIfDAO;

    /** WhbyItembyChargAmtDAO Bean 생성 */
    @Resource(name = "/ft/fsi/whbyItembyChargAmtDAO")
    private WhbyItembyChargAmtDAO whbyItembyChargAmtDAO;

    @Resource(name = "/ft/fsi/freezeWhCommMgmtDAO")
    private FreezeWhCommMgmtDAO freezeWhCommMgmtDAO;
    
    /** AuthorityDAO */
    @Resource(name="/ft/ftp/proposalDAO")
    private ProposalDAO proposalDAO;

    /**
     * 구매 주문에 대한 내역. 목록을 조회한다.
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
        return poOrderMstDAO.selectList(mapParam);
    }

    /**
     * 구매 주문에 대한 내역. DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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

        for (int i = 0 ; i < list.size() ; i++) {
            Map<String, Object> rowData = list.get(i);
            int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            //Insert 처리
            if (rowType == DataSet.ROW_TYPE_INSERTED) {
                insRowCnt += poOrderMstDAO.insert(rowData);
            }
            //Update 처리
            else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                updRowCnt += poOrderMstDAO.update(rowData);
            }
            //Delete 처리.
            else if (rowType == DataSet.ROW_TYPE_DELETED) {
                delRowCnt += poOrderMstDAO.delete(rowData);
            }
        }

        return insRowCnt + updRowCnt + delRowCnt;
    }

    /**
     * 구매주문 삭제
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @see com.hwfs.ft.ftp.service.proposalService#proposalDraft(java.util.Map)
    */
    @Override
    @SuppressWarnings("unchecked")
    public int deletePoOrderMst(LoginDTO loginParameter, DataSetMap search, DataSetMap dsPoOrderList ) throws Exception {
        int procCnt = 0;

        if ( dsPoOrderList.size() > 0 ) {
            for (int i = 0 ; i < dsPoOrderList.size() ; i++) {
                Map<String, Object> parameter = dsPoOrderList.get(i);
                parameter.put("cuser", loginParameter.getSabun());
                parameter.put("uuser", loginParameter.getSabun());
                logger.info("delYn ::::"+parameter.get("delYn"));
                procCnt += poOrderMstDAO.deletePoOrderMst( parameter );

                procCnt += poOrderItemDetailDAO.deleteItem(parameter);

                procCnt += poOrderPayCondDAO.deletePay(parameter);

                procCnt += poOrderInvoiceDAO.deleteInvoice(parameter);

                procCnt += poOrderOtherAmtDAO.deleteOtherAmt(parameter);

                procCnt += etcPrepayamtAdjustDAO.deleteEtcPrepay(parameter);
            }
        }

        return procCnt;
    }

    /**
     * 구매주문 확정한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @see com.hwfs.ft.ftp.service.proposalService#updatePoOrderStatus(java.util.Map)
    */
    @Override
    @SuppressWarnings("unchecked")
    public int updatePoOrderStatus(LoginDTO loginParameter, DataSetMap search, DataSetMap dsPoOrderList ) throws Exception {
        int procCnt = 0;

        if ( dsPoOrderList.size() > 0 ) {
            for (int i = 0 ; i < dsPoOrderList.size() ; i++) {
                Map<String, Object> parameter = dsPoOrderList.get(i);
                parameter.put("cuser", loginParameter.getSabun());
                parameter.put("uuser", loginParameter.getSabun());

                if ( "N".equals(parameter.get("poOrderStatus")) ) 	//확정취소일 경우
                {
                    String selectPoAfterstatus = poOrderMstDAO.selectPoAfterstatus(parameter);	//확정 취소는 PO후상태가 확정이면 취소 불가
                    if ( "Y".equals(selectPoAfterstatus) )
                    {
                        throw processException("ft.ftp.fail.poOrder.confirm.poAfterstatus");	//PO후 상태가 확정상태는 취소가 불가합니다.
                    }

                    int cnt = poOrderMstDAO.chkGdspaymCnt(parameter);
                    logger.info("cnt :"+cnt);
                    if ( cnt > 0 )
                    {
                        throw processException("ft.ftp.fail.poOrder.confirm.income.cancel");	//확정취소는 매입전표 발행전까지 가능합니다.
                    }

//                    if ( "20".equals(parameter.get("poType")) ) 	//내수일 경우 창고정보 조회
//                    {
//                        int cnt2 = poOrderMstDAO.chkWhCdCnt(parameter);
//                        logger.info("cnt2 :"+cnt2);
//                        if ( cnt2 > 0 )
//                        {
//                            throw processException("ft.ftp.fail.poOrder.confirm.dmt.cancel");	//내수 확정취소는 창고정보가 존재합니다.
//                        }
//                    }
                }

                procCnt += poOrderMstDAO.updatePoOrderStatus( parameter );
            }
        }

        return procCnt;
    }


    /**
     * 구매 품의 마스터을 조회한다.
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
    public RecordSet selectPoOrderDtl(Map<String, Object> mapParam) throws Exception {
        return poOrderMstDAO.selectPoOrderDtl(mapParam);
    }

    /**
     * 구매 주문 품목 상세를 조회한다.
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
    public RecordSet selectPoOrderItemDetail(Map<String, Object> mapParam) throws Exception {
        return poOrderMstDAO.selectPoOrderItemDetail(mapParam);
    }

    /**
     * 구매 주문 지불 조건를 조회한다.
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
    public RecordSet selectPoOrderPayCond(Map<String, Object> mapParam) throws Exception {
        return poOrderMstDAO.selectPoOrderPayCond(mapParam);
    }

    /**
     * 구매주문 INVOICE를 조회한다.
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
    public RecordSet selectPoOrderInvoice(Map<String, Object> mapParam) throws Exception {
        return poOrderMstDAO.selectPoOrderInvoice(mapParam);
    }

    /**
     * 구매주문 첨부문서를 조회한다.
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
    public RecordSet selectPoOrderAppenddoc(Map<String, Object> mapParam) throws Exception {
        return poOrderMstDAO.selectPoOrderAppenddoc(mapParam);
    }

    /**
     * 구매주문 부대비를 조회한다.
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
    public RecordSet selectPoOrderOtherAmt(Map<String, Object> mapParam) throws Exception {
        return poOrderMstDAO.selectPoOrderOtherAmt(mapParam);
    }

    /**
     * 기타 선급금 정산를 조회한다.
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
    public RecordSet selectEtcPrepayamtAdjust(Map<String, Object> mapParam) throws Exception {
        return poOrderMstDAO.selectEtcPrepayamtAdjust(mapParam);
    }

    /**
     * savePoOrderDtl 설명
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @see com.hwfs.ft.ftp.service.proposalService#saveProposalDtl(java.util.Map)
    */
    @Override
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> savePoOrderDtl(LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap dsPoOrderInfo
            , DataSetMap dsItemList
            , DataSetMap dsPayList
            , DataSetMap dsInvoiceList
            , DataSetMap dsAppendDocList
            , DataSetMap dsOtherAmtList
            , DataSetMap dsEtcPrepayamtList
            , DataSetMap dsCommSals
            ) throws Exception  {
        int proposalProcCnt = 0;
        int itemProcCnt = 0;
        int payProcCnt = 0;
        int invoiceProcCnt = 0;
        int appendDocProcCnt = 0;
        int otherAmtProcCnt = 0;
        int etcPrepayamtProcCnt = 0;
        int commSalsProcCnt = 0;
        String poOrderNum = "";	//구매주문 번호

        List<Map<String, Object>> listMap = new ArrayList();
        Map<String, Object> map = new HashMap ();
        logger.info( "flag  ::::"+search.get(0).get("flag") );

        /*
        -	품의 금액 대비 10% 저장 초과시 메시지 처리
        1.품의서번호로 생성된 BL의 품목별 원물금액을 SUM
        2.화면상 품목별 원물금액을 SUM
        3.품의서번호로 PR테이블의 품목별 원물금액을 SUM
        4.1+2>3*10% 면 REJECT
        */
        if ( dsItemList.size() > 0 ) {	  //화면상 품목별 원물금액을 SUM
            double viewWonwtrAmtSum = 0;
            if ( dsItemList.size() > 0 ) {
                for (int i = 0 ; i < dsItemList.size() ; i++) {
                    Map<String, Object> parameter = dsItemList.get(i);
                    int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
                    if (search.get(0).get("flag").equals("CALL") )	//불러오기
                    {
                        if (rowType == DataSet.ROW_TYPE_INSERTED)
                        {
                            logger.info("wonwtrAmt1 ::::"+Double.parseDouble(parameter.get("wonwtrAmt").toString()));
                            viewWonwtrAmtSum += Double.parseDouble(parameter.get("wonwtrAmt").toString());
                        }
                    } else {	//상세 조회시
                        logger.info("wonwtrAmt2 ::::"+Double.parseDouble(parameter.get("wonwtrAmt").toString()));
                        viewWonwtrAmtSum += Double.parseDouble(parameter.get("wonwtrAmt").toString());
                    }
                }
            }

            //1.품의서번호로 생성된 BL의 품목별 원물금액을 SUM
            if ( !search.get(0).get("flag").equals("CALL") )	//불러오기
            {
                dsItemList.get(0).put("flag", "ORG");
            }
            logger.info("dsItemList.get(0):"+dsItemList.get(0));
            logger.info("poProposalNum :"+dsItemList.get(0).get("poProposalNum"));
            RecordSet wonwtrAmtSumRs = poOrderMstDAO.getWonwtrAmtSum(dsItemList.get(0));
            //2.화면상 품목별 원물금액을 SUM viewWonwtrAmtSum
            double blWonwtrAmtSum =  wonwtrAmtSumRs.get(0).getDouble("wonwtrAmt");
            double prWonwtrAmtSum =  wonwtrAmtSumRs.get(1).getDouble("wonwtrAmt");
            prWonwtrAmtSum = prWonwtrAmtSum + (prWonwtrAmtSum *0.1);
            logger.info("10% :"+blWonwtrAmtSum +"//"+viewWonwtrAmtSum+"//"+prWonwtrAmtSum);
            logger.info("10% 1:"+(blWonwtrAmtSum + viewWonwtrAmtSum ) +"//"+prWonwtrAmtSum);
            if ( blWonwtrAmtSum + viewWonwtrAmtSum > prWonwtrAmtSum )
            //if ( viewWonwtrAmtSum > prWonwtrAmtSum )
            {
                throw processException("ft.ftp.fail.poOrder.confirm.over");	  //품의금액 대비 구매주문 금액의 합이 10%를 초과할 수 없습니다.
            }
        }

        String strRefSeq = "";	//첨부참조일련번호
        if ( dsAppendDocList.size() > 0 ) {
            strRefSeq = attachFileService.save(dsAppendDocList, propertiesService.getString("ft.ftp.poorder.file.path"), false);
            logger.info("strRefSeq :::"+strRefSeq);
        }
        String currYymmdd = LimsUtil.getDate("yyyyMMdd");

        //1.구매주문 품의 마스터 저장
        if ( dsPoOrderInfo.size() > 0 || strRefSeq !=null ) {
            //첨부파일 처리 : 업무별 저장소의 상대패스를 파라미터로 전달해야 한다.

            for (int i = 0 ; i < dsPoOrderInfo.size() ; i++) {
                Map<String, Object> parameter = dsPoOrderInfo.get(i);
                parameter.put("fileRefSrlNum", strRefSeq);	//파일 참조 일련 번호
                int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
                if (rowType == DataSet.ROW_TYPE_INSERTED) {
                    //PO-300(100)-YYMM-SEQ(4):내수(300)/수입(100)
                    if ( !search.get(0).get("flag").equals("CALL") ) {	//불러오기
                        poOrderNum = parameter.get("poOrderNum").toString();
                    } else {
                        poOrderNum = poOrderMstDAO.getPoOrderMstSeq(parameter);
                        String currYymm = LimsUtil.getDate("yyMM");
                        if ( "10".equals(parameter.get("poType") )) {	//수입
                            poOrderNum = "100-"+"PO-"+currYymm+"-"+poOrderNum;
                        } else {
                            poOrderNum = "300-"+"PO-"+currYymm+"-"+poOrderNum;
                        }
                        parameter.put("poOrderNum", poOrderNum);
                    }

                    parameter.put("poOrderStatus", "N");		//구매주문상태 : 신규
                    parameter.put("poOrderDate", currYymmdd);	//구매등록일자


                    proposalProcCnt += poOrderMstDAO.insert(parameter);

                } else if (rowType == DataSet.ROW_TYPE_UPDATED){
                    proposalProcCnt += poOrderMstDAO.update(parameter);
                    poOrderNum = parameter.get("poOrderNum").toString();
                }
            }
        }

        logger.info( "poOrderNum  ::::"+poOrderNum  );

        //2.구매 품의 품목 상세 저장
        if ( dsItemList.size() > 0 ) {
            for (int i = 0 ; i < dsItemList.size() ; i++) {
                Map<String, Object> parameter = dsItemList.get(i);
                parameter.put("cuser", loginParameter.getSabun());
                parameter.put("uuser", loginParameter.getSabun());
                logger.info( "flag  ::::"+search.get(0).get("flag")  );
                int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
                if ( !search.get(0).get("flag").equals("CALL") ) {	//불러오기
                    poOrderNum = parameter.get("poOrderNum").toString();
                }
                logger.info( "poOrderNum    1::::"+poOrderNum );

                if (rowType == DataSet.ROW_TYPE_INSERTED) {
                    if ( search.get(0).get("flag").equals("CALL") ) {	//신규
                        parameter.put("poOrderNum", poOrderNum);
                    }
                    itemProcCnt += poOrderItemDetailDAO.insert(parameter);
                }
                else if (rowType == DataSet.ROW_TYPE_UPDATED){
                    itemProcCnt += poOrderItemDetailDAO.update(parameter);
                }
                else if (rowType == DataSet.ROW_TYPE_DELETED && !search.get(0).get("flag").equals("CALL")) {
                    itemProcCnt += poOrderItemDetailDAO.delete(parameter);
                }
            }
        }
        logger.info( "poOrderNum2  ::::"+poOrderNum  );

        //3.구매 품의 지불 조건 저장
        if ( dsPayList.size() > 0 ) {
            for (int i = 0 ; i < dsPayList.size() ; i++) {
                Map<String, Object> parameter = dsPayList.get(i);
                parameter.put("cuser", loginParameter.getSabun());
                parameter.put("uuser", loginParameter.getSabun());
                int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
                if ( !search.get(0).get("flag").equals("CALL") ) {	//불러오기
                    poOrderNum = parameter.get("poOrderNum").toString();
                }
                logger.info( "poOrderNum    2::::"+poOrderNum );
                if (rowType == DataSet.ROW_TYPE_INSERTED) {
                    if ( search.get(0).get("flag").equals("CALL") ) {	//신규
                        parameter.put("poOrderNum", poOrderNum);
                    }
                    payProcCnt += poOrderPayCondDAO.insert(parameter);
                }
                else if (rowType == DataSet.ROW_TYPE_UPDATED){
                    payProcCnt += poOrderPayCondDAO.update(parameter);
                }
                else if (rowType == DataSet.ROW_TYPE_DELETED) {
                    payProcCnt += poOrderPayCondDAO.delete(parameter);
                }
            }
        }
        logger.info( "poOrderNum3  ::::"+poOrderNum  );
        //4.구매주문 INVOICE
        if ( dsInvoiceList.size() > 0 ) {
            for (int i = 0 ; i < dsInvoiceList.size() ; i++) {
                Map<String, Object> parameter = dsInvoiceList.get(i);
                int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

                if ( !search.get(0).get("flag").equals("CALL") ) {	//불러오기
                    poOrderNum = parameter.get("poOrderNum").toString();
                }
                logger.info( "poOrderNum    3::::"+poOrderNum );
                if (rowType == DataSet.ROW_TYPE_INSERTED) {
                    if ( search.get(0).get("flag").equals("CALL") ) {	//신규
                        parameter.put("poOrderNum", poOrderNum);
                    }
                    invoiceProcCnt += poOrderInvoiceDAO.insert(parameter);
                }
                else if (rowType == DataSet.ROW_TYPE_UPDATED){
                    invoiceProcCnt += poOrderInvoiceDAO.update(parameter);
                }
                else if (rowType == DataSet.ROW_TYPE_DELETED) {
                    invoiceProcCnt += poOrderInvoiceDAO.delete(parameter);
                }
            }
        }
        logger.info( "poOrderNum4  ::::"+poOrderNum  );
        //5.구매주문 첨부문서

        logger.info( "poOrderNum5  ::::"+poOrderNum  );
        //6.구매주문 부대비
        if ( dsOtherAmtList.size() > 0 ) {
            for (int i = 0 ; i < dsOtherAmtList.size() ; i++) {
                Map<String, Object> parameter = dsOtherAmtList.get(i);
                int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
                String etcPrepayamtMgmtNum = "";


                if ( !search.get(0).get("flag").equals("CALL") ) {	//불러오기
                    poOrderNum = parameter.get("poOrderNum").toString();
                }
                logger.info( "poOrderNum    4::::"+poOrderNum );

                if (rowType == DataSet.ROW_TYPE_INSERTED) {
                    if ( search.get(0).get("flag").equals("CALL") ) {	//신규
                        parameter.put("poOrderNum", poOrderNum);
                    }
                    otherAmtProcCnt += poOrderOtherAmtDAO.insert(parameter);
                }
                else if (rowType == DataSet.ROW_TYPE_UPDATED){
                    etcPrepayamtMgmtNum = parameter.get("poOrderNum").toString()+parameter.get("otherAmtSeq").toString();
                    parameter.put("etcPrepayamtMgmtNum", etcPrepayamtMgmtNum);	//기타 선급금 관리 번호
                    otherAmtProcCnt += poOrderOtherAmtDAO.update(parameter);
                }
                else if (rowType == DataSet.ROW_TYPE_DELETED) {
                    otherAmtProcCnt += poOrderOtherAmtDAO.delete(parameter);
                }
            }
        }

        //7.기타 선급금 정산
        if ( dsEtcPrepayamtList.size() > 0 ) {
            for (int i = 0 ; i < dsEtcPrepayamtList.size() ; i++) {
                Map<String, Object> parameter = dsEtcPrepayamtList.get(i);
                int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
                if ( !search.get(0).get("flag").equals("CALL") ) {	//불러오기
                    poOrderNum = parameter.get("poOrderNum").toString();
                }
                logger.info( "poOrderNum    5::::"+poOrderNum );

                if (rowType == DataSet.ROW_TYPE_INSERTED) {
                    if ( search.get(0).get("flag").equals("CALL") ) {	//신규
                        parameter.put("poOrderNum", poOrderNum);
                    }
                    etcPrepayamtProcCnt += etcPrepayamtAdjustDAO.insert(parameter);
                }
                else if (rowType == DataSet.ROW_TYPE_UPDATED){
                    etcPrepayamtProcCnt += etcPrepayamtAdjustDAO.update(parameter);
                }
                else if (rowType == DataSet.ROW_TYPE_DELETED) {
                    etcPrepayamtProcCnt += etcPrepayamtAdjustDAO.delete(parameter);
                }
            }
        }
        //8.수수료매출
        if ( dsCommSals.size() > 0 ) {
            for (int i = 0 ; i < dsCommSals.size() ; i++) {
                Map<String, Object> parameter = dsCommSals.get(i);
                parameter.put("cuser", loginParameter.getSabun());
                parameter.put("uuser", loginParameter.getSabun());
                logger.info( "flag  ::::"+search.get(0).get("flag")  );
                int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
                if ( !search.get(0).get("flag").equals("CALL") ) {	//불러오기
                    poOrderNum = parameter.get("poOrderNum").toString();
                }
                logger.info( "poOrderNum    111::::"+poOrderNum );

                if (rowType == DataSet.ROW_TYPE_INSERTED) {
                    if ( search.get(0).get("flag").equals("CALL") ) {	//신규
                        parameter.put("poOrderNum", poOrderNum);
                    }
                    parameter.put("status", "A");	//매출등록
                    commSalsProcCnt += poOrderCommSalsDAO.insert(parameter);
                }
                else if (rowType == DataSet.ROW_TYPE_UPDATED){
                    commSalsProcCnt += poOrderCommSalsDAO.update(parameter);
                }
                else if (rowType == DataSet.ROW_TYPE_DELETED && !search.get(0).get("flag").equals("CALL")) {
                    commSalsProcCnt += poOrderCommSalsDAO.delete(parameter);
                }
            }
        }

        logger.info("LAST poOrderNum :"+poOrderNum);
        map.put("poOrderNum", poOrderNum);	//구매품의 번호 전달
        map.put("procCnt", proposalProcCnt+itemProcCnt+payProcCnt+invoiceProcCnt+appendDocProcCnt+otherAmtProcCnt+etcPrepayamtProcCnt+commSalsProcCnt);	  //실행건 전달
        listMap.add (map);

        return listMap;
    }

    /**
     * saveInsDtl 설명
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @see com.hwfs.ft.ftp.service.proposalService#saveInsDtl(java.util.Map)
    */
    @Override
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> saveInsDtl(LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap dsPoOrderInfo
            ) throws Exception  {
        int proposalProcCnt = 0;

        String poOrderNum = "";	//구매주문 번호

        List<Map<String, Object>> listMap = new ArrayList();
        Map<String, Object> map = new HashMap ();
        logger.info( "flag  ::::"+search.get(0).get("flag") );

        String currYymmdd = LimsUtil.getDate("yyyyMMdd");

        //1.구매주문 품의 마스터 저장
        if ( dsPoOrderInfo.size() > 0 ) {
            //첨부파일 처리 : 업무별 저장소의 상대패스를 파라미터로 전달해야 한다.

            for (int i = 0 ; i < dsPoOrderInfo.size() ; i++) {
                Map<String, Object> parameter = dsPoOrderInfo.get(i);
                int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
                proposalProcCnt += poOrderMstDAO.updateIns(parameter);
                poOrderNum = parameter.get("poOrderNum").toString();
            }
        }

        logger.info( "poOrderNum  ::::"+poOrderNum  );
        map.put("poOrderNum", poOrderNum);	//구매품의 번호 전달
        map.put("procCnt", proposalProcCnt);	  //실행건 전달
        listMap.add (map);

        return listMap;
    }

    /**
     * createFiscalSlip 설명
     * <pre>
     * 회계전표 IF 버튼 클릭시 SAP
     * </pre>
     *
     * @param parameter
     * @return
     * @see com.hwfs.ft.ftp.service.proposalService#createFiscalSlip(java.util.Map)
    */
    @Override
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> createFiscalSlip(LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap dsOtherAmtList
            ) throws Exception  {
        int otherAmtProcCnt = 0;

        List<Map<String, Object>> topListMap = new ArrayList();
        Map<String, Object> topMap = new HashMap ();
        Map<String, Object> taxBillMap = new HashMap ();

        String draft = search.get(0).get("draft").toString();	//상신,전표처리 구분
        logger.info( "draft  ::::"+draft);

        //sap모듈 호출후 성공하면
        String poOrderNum = "";	//구매주문 번호
        //6.구매주문 부대비
        if ( dsOtherAmtList.size() > 0 ) {
            for (int i = 0 ; i < dsOtherAmtList.size() ; i++) {
                Map<String, Object> parameter = dsOtherAmtList.get(i);
                int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

                String etcPrepayamtMgmtNum = "";
                logger.info("slipStatus233 :"+LimsUtil.checkNull(parameter.get("slipStatus"),"").toString());
                parameter.put("slipStatus2", LimsUtil.checkNull(parameter.get("slipStatus"),"").toString());	  //전표상태 : 전표생성 변경
                parameter.put("slipStatus", "20");	  //전표상태 : 전표생성 변경
                if ( !search.get(0).get("flag").equals("CALL") ) {	//불러오기
                    poOrderNum = parameter.get("poOrderNum").toString();
                }
                logger.info( "poOrderNum    4::::"+poOrderNum +"// chk:"+parameter.get("chk").toString());

                if ( rowType == DataSet.ROW_TYPE_INSERTED || !parameter.get("taxBillNum").equals(parameter.get("orgTaxBillNum")))		//신규,세금계산서번호가 변경될시 중복 체크
                {
                    taxBillMap.put("taxBillNum",  LimsUtil.checkNull(parameter.get("taxBillNum")));
                    logger.info( "taxBillMap   taxBillNum    4::::"+taxBillMap.get("taxBillNum"));
                    int chkCnt = freezeWhCommMgmtDAO.selectTaxBillNum(taxBillMap);
                    if (chkCnt > 0) {
                        throw new BizException("중복된 국세청승인번호가 존재합니다.");
                    }
                }

                if ("1".equals(parameter.get("chk").toString()))
                {
                    if (rowType == DataSet.ROW_TYPE_INSERTED) {
                        if ( search.get(0).get("flag").equals("CALL") ) {	//신규
                            parameter.put("poOrderNum", poOrderNum);
                        }
                        otherAmtProcCnt += poOrderOtherAmtDAO.insert(parameter);
                    }
                    else if (rowType == DataSet.ROW_TYPE_UPDATED){
                        etcPrepayamtMgmtNum = parameter.get("poOrderNum").toString()+parameter.get("otherAmtSeq").toString();
                        parameter.put("etcPrepayamtMgmtNum", etcPrepayamtMgmtNum);	//기타 선급금 관리 번호
                        otherAmtProcCnt += poOrderOtherAmtDAO.update(parameter);
                    }
                    else if (rowType == DataSet.ROW_TYPE_DELETED) {
                        otherAmtProcCnt += poOrderOtherAmtDAO.delete(parameter);
                    }
                }
            }
        }

        Map<String, Object> paramMap = new HashMap<String, Object>();
        String currYymmdd = LimsUtil.getDate("yyyyMMddHHmmss");

        String slipNums  = "";

        List<Map<String, Object>> orderListMap = new ArrayList();

        //-금액때문에 선급금,가수금 누적금액 계산시 오류 발생 -금액을 먼저 상위로 처리되게 구성
        if ( dsOtherAmtList.size() > 0 ) {
            for (int i = 0 ; i < dsOtherAmtList.size() ; i++) {
                Map<String, Object> parameter = dsOtherAmtList.get(i);
                double commAmt = Double.parseDouble(parameter.get("commAmt").toString());	//수수료금액
                if ( commAmt < 0  )		//-금액을 먼저 처리되게
                {
                    orderListMap.add(parameter);
                }
            }
            for (int i = 0 ; i < dsOtherAmtList.size() ; i++) {
                Map<String, Object> parameter = dsOtherAmtList.get(i);
                double commAmt = Double.parseDouble(parameter.get("commAmt").toString());	//수수료금액
                if ( commAmt >= 0  )	//+금액을 뒤에 처리되게
                {
                    orderListMap.add(parameter);
                }
            }
        }
        if ( orderListMap.size() > 0 ) {	  //미착생성
            logger.debug("######미착######");
            SlipMstDTO mst = new SlipMstDTO();

            for (int i = 0 ; i < orderListMap.size() ; i++) {
                Map<String, Object> parameter = orderListMap.get(i);
                if ("1".equals(parameter.get("chk").toString()))
                {

                    SlipMstList mstList = new SlipMstList();
                    List<SlipMstDTO> master = new ArrayList<SlipMstDTO>();
                    List<SlipDtlDTO> detail = new ArrayList<SlipDtlDTO>();

                    int ii = 1;

                    String slipNum = LimsUtil.checkNull(parameter.get("slipNum"),"").toString();
                    String slipStatus = LimsUtil.checkNull(parameter.get("slipStatus"),"").toString();
                    String slipStatus2 = LimsUtil.checkNull(parameter.get("slipStatus2"),"").toString();
                    logger.info("slipNum :"+slipNum+"// slipStatus222:"+LimsUtil.checkNull(parameter.get("slipStatus"),"").toString()+"//draft:"+draft+"//slipStatus2 :"+slipStatus2);

                    if ( "".equals(slipNum) || "Z".equals(slipStatus2) || "R".equals(slipStatus2) || "E".equals(slipStatus2) || "C".equals(slipStatus2))	//신규 이거나 취소, 에러시 전표번호 생성
                    {
                        slipNum = poOrderMstDAO.selectSlipNum(search.get(0));
                    }
                    logger.info("slipNum111 :"+slipNum);

                    slipNums = slipNums+slipNum+",";
                    logger.info("미착 slipNum :"+slipNum);

                    parameter.put("slipNum1", slipNum);
                    mst.setSlipNum(slipNum);	                                        ///SAP과 연결 키 -유일키
                    mst.setBuCd("2000");		                                        //회사코드
                    mst.setSlipType(parameter.get("slipClassCd").toString());	        //전표유형
                    logger.info("slipClassCd :"+parameter.get("slipClassCd").toString());
                    String commClass = LimsUtil.checkNull(parameter.get("commClass"),"").toString();	//수수료구분
                    logger.info("commClass :"+ LimsUtil.checkNull(parameter.get("commClass"),"").toString() );
                    logger.debug("billPublishdd1 :"+parameter.get("billPublishdd")+"//"+commClass.substring(0,1));

                    String billPublishdd = LimsUtil.checkNull(parameter.get("billPublishdd"),"").toString();			//세금계산서 발행일
                    if ( "".equals(billPublishdd))	//세금계산서 발행건이 아니면 전표발행일로
                    {
                        mst.setSlipEvidenceDate(parameter.get("slipPublishDate").toString());	//전표증빙일자 - 매입전표일자
                    }
                    else
                    {
                        mst.setSlipEvidenceDate(billPublishdd);	//전표증빙일자 - 세금계산서 발행일
                    }
                    mst.setSlipPeriodDate(parameter.get("slipPublishDate").toString());		//전표전기일자 - 전표발행일
                    mst.setCurrency("KRW");												//통화

                    if ( !"".equals(LimsUtil.checkNull(parameter.get("taxBillNum"),"").toString()))		//세금계산서발행건 일때 순발행 세팅 20151026 고영범
                    {
                        mst.setPublishClass("F");											//발행구분 F:순발행, B:역발행
                    }


                    mst.setElctntaxBillApprvnum(LimsUtil.checkNull(parameter.get("taxBillNum"),"").toString());	//전자세금계산서승인번호

                    logger.debug("currYymmdd :"+currYymmdd);
                    mst.setInputDate(currYymmdd.substring(0,8));			//입력일자
                    mst.setInputTime(currYymmdd.substring(8));				//입력시간 -6자리
                    mst.setWriteEmpSabun(loginParameter.getSabun());		//작성사원부서 : 로그인사번
                    mst.setWriteEmpDept(loginParameter.getDeptId());		//작성사원부서
                    mst.setWriteEmpMuCd(loginParameter.getMuCd());
                    mst.setSysCd("IFC");											//시스템코드
                    mst.setElctnSignId(LimsUtil.checkNull(parameter.get("signInstanceId"),"").toString());			 						//전자결재ID - 임시세팅
                    mst.setSignStatus(LimsUtil.checkNull(parameter.get("signProgressStatus"),"").toString());								//전표상태 - 임시세팅
                    mst.setSignType("1");	//결재유형:G/W 결재
                    mst.setSlipText("수수료 전표 ["+loginParameter.getDeptNm()+"]");	  //(ex)상품권 청구 [FC외식사업지원팀]

                    if ( "Y".equals(draft))	  //상신
                    {
                        mst.setPistat("9");
                    }
                    master.add(mst);
                    mstList.setDataList(master);

                    logger.info("commClass1 :"+parameter.get("commClass").toString().substring(0,1));
                    String taxFlag = search.get(0).get("taxFlag").toString();							//과세,면세구분
                    String taxCd = LimsUtil.checkNull(parameter.get("taxCd"),"").toString();			//과세유형
                    String commType = LimsUtil.checkNull(parameter.get("commType"),"").toString();			//유형

                    logger.info("taxFlag :"+taxFlag+" / taxCd:"+taxCd+" / commType:"+commType);
                    if ( "TAX".equals(commType)  )	//유형:TAX
                    {
                        parameter.put("viewRow", "1");	  //부가세행 생성
                    }
                    else
                    {
                        if ( !"".equals(taxCd)  )	//과세 ,  수수료구분:부가세
                        {
                            parameter.put("viewRow", "2");	  //부가세행 생성
                        }
                        else
                        {
                            parameter.put("viewRow", "1");	  //부가세행 미생성
                        }
                    }
                    logger.info("otherAmtSeq :"+parameter.get("otherAmtSeq").toString());
                    RecordSet etcRs = poOrderMstDAO.selectFocOtherAmtIfList(parameter);
                    logger.info("etcRs.size()1  :"+etcRs.size() );
                   
                    //대변 생성
                    SlipDtlDTO dtl11 = new SlipDtlDTO();
                    dtl11.setSlipNum(slipNum);	            							//SAP과 연결 키 -유일키
                    dtl11.setBuCd("2000");
                    dtl11.setSlipType(parameter.get("slipClassCd").toString());	        //전표유형
                    logger.info("billPublishdd2 :"+parameter.get("billPublishdd"));
                    logger.info("commClass22 :"+commClass.substring(0,1)+"//"+parameter.get("slipPublishDate"));

                    if ( "".equals(billPublishdd))	//세금계산서 발행건이 아니면 전표발행일로
                    {
                        dtl11.setSlipEvidenceDate(parameter.get("slipPublishDate").toString());	//전표증빙일자 - 매입전표일자
                    }
                    else
                    {
                        dtl11.setSlipEvidenceDate(billPublishdd);	//전표증빙일자 - 세금계산서 발행일
                    }
                    dtl11.setSlipPeriodDate(parameter.get("slipPublishDate").toString());	//전표전기일자 - 지불예정일자
                    dtl11.setMasterAcct(parameter.get("crAcctCd").toString());			//선급금_거래처
                    dtl11.setDrCrClass("2");
                    logger.info("crAcctCd :"+parameter.get("crAcctCd").toString());
                    //2:대변금액 구하기
                    double totSlipCurrencyAmt = 0;
                    double etcTotSlipCurrencyAmt = 0;	//선급금 털기 합계금액
                    
                    DecimalFormat df = new DecimalFormat("#.##");
                    String test = "";
                    for (int j = 0 ; j < etcRs.size() ; j++) {
                        Map<String, Object> parameter2 = etcRs.get(j);

                        logger.info("taxCd1  :"+LimsUtil.checkNull(parameter2.get("taxCd"),"") );
                        String tTaxCd = LimsUtil.checkNull(parameter2.get("taxCd"),"") ;
                        if ( !"70".equals(tTaxCd ) && !"75".equals(tTaxCd )  )	  //불공제공제시 대변에 부가세행 더하지 않는다 SAP에서 SKIP
                        {
                            double slipCurrencyAmt = Double.parseDouble(LimsUtil.checkNull(parameter2.get("slipCurrencyAmt"),"0").toString());
                            test = df.format(Double.parseDouble(LimsUtil.checkNull(parameter2.get("slipCurrencyAmt"),"0").toString()));
                            logger.info("$$$$$  :"+Double.parseDouble(test));
                            
                            totSlipCurrencyAmt +=slipCurrencyAmt;	//대변 총합계 금액 구하기
                            etcTotSlipCurrencyAmt +=slipCurrencyAmt;	//대변 총합계 금액 구하기
                        }
                    }
                    logger.info("$$$$$  :"+Double.parseDouble(test));
                    
                    logger.info("totSlipCurrencyAmt1  :"+totSlipCurrencyAmt );
                    logger.info("etcTotSlipCurrencyAmt1  :"+etcTotSlipCurrencyAmt );
                    dtl11.setSlipCurrencyAmt(BigDecimal.valueOf(totSlipCurrencyAmt));				//공급가액
                    String orgFiscalSlipNum = LimsUtil.checkNull(parameter.get("orgFiscalSlipNum")) ;

                    String assignNum = getAssignNum( dtl11.getMasterAcct() , parameter, "PRE");
                    dtl11.setAssignNum( assignNum );

                    String  expireCalBasisDate =parameter.get("paySchdDate").toString();
                    if ("".equals(LimsUtil.checkNull(parameter.get("paySchdDate"))))
                    {
                        expireCalBasisDate = parameter.get("expireCalBasisDate").toString();
                    }
                    dtl11.setExpireCalBasisDate(LimsUtil.checkNull(expireCalBasisDate));	//통관예정일 +3개월 = 입금예정일 ->지불예정일
                    logger.info("crAcctCd  1:"+parameter.get("crAcctCd").toString()  );
                    if ( "11501010".equals(parameter.get("crAcctCd").toString() ) )	//선급금거래처,대변
                    {
                        dtl11.setSupplyplceNum( LimsUtil.checkNull(parameter.get("etcRealPaymentPlce"),"").toString() );		//공급처번호
                        //2019.11.06 김명섭 환급금 전도금 증액
                    	if ( "D-02".equals(parameter.get("commClass").toString()) )
                    	{
                            dtl11.setSupplyplceNum( LimsUtil.checkNull(parameter.get("realPaymentPlce"),"").toString() );		//공급처번호
                    	}
                    }
                    else
                    {
                        dtl11.setSupplyplceNum( LimsUtil.checkNull(parameter.get("realPaymentPlce"),"").toString() );		//공급처번호
                    }
                    dtl11.setMgmtArticle( parameter.get("realPaymentPlce").toString() );			//관리항목 : 거래처:실거래처
                    dtl11.setUpjang( parameter.get("subUpjangNum").toString() );					//AP거래처 : 신고업장:종사업자번호
                    dtl11.setPayCond("F000");		            //지불조건 : 환율(외화)정보 있으면 : E000 나머지 : F000

                    logger.info("crAcctCd :"+parameter.get("crAcctCd").toString());

                    if ( "21101010".equals(parameter.get("crAcctCd").toString()) )	//외상매입금 거래처 &&  대변일때
                    {
                        dtl11.setReasonCd( "A00" );
                    }
                    else
                    {
                        dtl11.setReasonCd( "B00" );		 												//사유코드: A00:발생
                    }
                    dtl11.setVatCd( LimsUtil.checkNull(parameter.get("taxCd"),"").toString() );		//부가가치세 코드

                    String remarks2 ="";

                    //적요 : P/O NO. + 수수료구분 + 적요
                    remarks2 = parameter.get("poOrderNum").toString()
                            +" "+parameter.get("commClassNm").toString()
                            +" "+LimsUtil.checkNull(parameter.get("remarks"),"").toString()
                            ;
                    //if ( "".equals(LimsUtil.checkNull(parameter.get("taxCd"),"").toString()))
                    if ( "70".equals(parameter.get("taxCd").toString() ) || "75".equals(parameter.get("taxCd").toString() )  )	  //불공제공제시
                    {
                        remarks2 = remarks2+" (불공제)";
                    }
                    logger.info("remarks2 :"+remarks2);
                    dtl11.setItemText(remarks2);							                        //품목텍스트 - 적요2
                    dtl11.setLcNum(parameter.get("lcNum").toString());		                        //LC번호
                    dtl11.setPoNum(parameter.get("poOrderNum").toString());	                        //PO번호
                    dtl11.setAttachDept(parameter.get("attachDeptSap").toString());		            //귀속부서
                    dtl11.setCcCd(parameter.get("attachDeptSap").toString());		                //CC CD 2016.02.25
                    dtl11.setMgmtDept(parameter.get("attachDeptSap").toString());		            //관리부서-귀속부서와 동일
                    //관리항목 필수(문의필요)
                    dtl11.setMgmtArticle( LimsUtil.checkNull(parameter.get("blNum")).toString() );	//관리항목 : bl번호
                    dtl11.setBlDate( LimsUtil.checkNull(parameter.get("lshipDate")).toString());	//BL일자 (선적일자로 쓴다.)
                    dtl11.setLshipDate(LimsUtil.checkNull(parameter.get("lshipDate")).toString());	//선적일자
                    dtl11.setDtlNum(new BigDecimal(ii++)); 											//회계 전표의 개별 항목 번호

                    //if ( "21101010".equals(dtl11.getMasterAcct()))	   //외상매입금 거래처
                    //{
                        String snglfootlstNmYn = (LimsUtil.checkNull(parameter.get("snglfootlstNmYn")).equals("1")?"X":"");
    //                    dtl11.setSinglePayYn(snglfootlstNmYn);	// 단발성여부 SAP확인 필요
                        logger.info("snglfootlstNmYn :"+snglfootlstNmYn+"//"+parameter.get("bankAcctNoEnc")+"//"+parameter.get("bankAcctOwnr")+"//"+parameter.get("bankCd")+"//"+parameter.get("realPaymentPlceNm"));
                        // 단발성이면...
                        if (snglfootlstNmYn.equals("X")) {
                            dtl11.setTempCustNm("");	// 공급자명
                        }

                        dtl11.setBankAcctNo(LimsUtil.checkNull(parameter.get("bankAcctNoEnc")));	// 공급자 계좌번호 - 암호화된 계좌번호
                        dtl11.setBankAcctOwnr(LimsUtil.checkNull(parameter.get("bankAcctOwnr")));	// 공급자 예금주
                        dtl11.setBankCd(LimsUtil.checkNull(parameter.get("bankCd")));	// 공급자 은행코드
                        dtl11.setCrgleftClass(LimsUtil.checkNull(parameter.get("bankType")));	// 계좌구분코드(Bank type)
                    //}

                    detail.add(dtl11);

                    //차변생성
                    for (int j = 0 ; j < etcRs.size() ; j++) {
                        logger.info("-----J :"+j);
                        Map<String, Object> parameter2 = etcRs.get(j);

                        SlipDtlDTO dtl12 = new SlipDtlDTO();
                        dtl12.setSlipNum(slipNum);	            								//SAP과 연결 키 -유일키
                        dtl12.setBuCd("2000");
                        dtl12.setSlipType(parameter2.get("slipClassCd").toString());	        //전표유형
                        logger.info("billPublishdd3 :"+parameter2.get("billPublishdd"));
                        String billPublishdd2 = LimsUtil.checkNull(parameter2.get("billPublishdd"),"").toString();			//세금계산서 발행일
                        if ( "".equals(billPublishdd2))	//세금계산서 발행건이 아니면 전표발행일로
                        {
                            dtl12.setSlipEvidenceDate(parameter.get("slipPublishDate").toString());	//전표증빙일자 - 매입전표일자
                        }
                        else
                        {
                            dtl12.setSlipEvidenceDate(billPublishdd2);	//전표증빙일자 - 세금계산서 발행일
                        }

                        dtl12.setSlipPeriodDate(parameter2.get("slipPublishDate").toString());	    //전표전기일자 - 전표발행일
                        
                        
                    	//2019.11.05 김명섭 환급금 전도금 증액
                        //if ( "21401120".equals(parameter2.get("drAcctCd").toString()) ) {	// 가수금_가상계좌
                        if ( "21401120".equals(parameter2.get("drAcctCd").toString()) || "D-02".equals(parameter2.get("commClass").toString()) ) {	// 가수금_가상계좌 || (환급)전도금증액
                        	dtl12.setMasterAcct(parameter2.get("drAcctCd").toString());			    //미착품
                        } else {	// 가수금_수익금
                        	dtl12.setMasterAcct(parameter2.get("acctCd").toString());			    //미착품
                        }
                        
                        logger.info("drCrFlag :"+parameter2.get("drCrFlag").toString());
                        dtl12.setDrCrClass(parameter2.get("drAcctClass").toString());				//1:차변
                        logger.info("dtl12 crAcctCd :"+parameter.get("crAcctCd").toString());
                        logger.info("drAcctClass  :"+parameter2.get("drAcctClass").toString());
                        double slipCurrencyAmt = Double.parseDouble(LimsUtil.checkNull(parameter2.get("slipCurrencyAmt"),"0").toString());
                        double supplyPrice = Double.parseDouble(LimsUtil.checkNull(parameter2.get("supplyPrice"),"0").toString());	//공급가액
                        double vatAmt = Double.parseDouble(LimsUtil.checkNull(parameter2.get("vatAmt"),"0").toString());
                        taxCd = LimsUtil.checkNull(parameter2.get("taxCd"),"");
                        dtl12.setSlipCurrencyAmt(BigDecimal.valueOf(slipCurrencyAmt));		    //공급가액
                        dtl12.setStdAmt( BigDecimal.valueOf(supplyPrice) );					    //공급가액
                        dtl12.setTaxAmt( BigDecimal.valueOf(vatAmt) );							//세액(전표 통화)
                        logger.info("taxCd3333 :"+taxCd);
                        if ( !"70".equals(taxCd) && !"75".equals(taxCd)  )	  //불공제공제시 대변에 부가세행 더하지 않는다 SAP에서 SKIP
                        {
                            totSlipCurrencyAmt +=slipCurrencyAmt;	//대변 총합계 금액 구하기
                            dtl12.setSlipCurrencyAmt(BigDecimal.valueOf(slipCurrencyAmt));		    //공급가액
                        }
                        else	//불공제
                        {
                            dtl12.setSlipCurrencyAmt(null);		    //공급가액
                        }

                        logger.info("totSlipCurrencyAmt@@ :"+totSlipCurrencyAmt);
                        logger.info("slipCurrencyAmt@@ :"+slipCurrencyAmt);
                        dtl12.setVatCd( LimsUtil.checkNull(parameter2.get("realTaxCd"),"").toString() );		//부가가치세 코드

                        assignNum = getAssignNum(dtl12.getMasterAcct() , parameter, "PRE");		//지정
                        dtl12.setAssignNum( assignNum );

                        String  expireCalBasisDate2 =LimsUtil.checkNull(parameter2.get("paySchdDate"));
                        if ("".equals(LimsUtil.checkNull(parameter2.get("paySchdDate"))))
                        {
                            expireCalBasisDate2 = parameter2.get("expireCalBasisDate").toString();
                        }
                        dtl12.setExpireCalBasisDate(LimsUtil.checkNull(expireCalBasisDate2));		            		//지불예정일
                        
                        if ( "21401120".equals(parameter2.get("drAcctCd").toString()) ) {	// 가수금_가상계좌
                        	dtl12.setGuestNum(LimsUtil.checkNull(parameter2.get("realPaymentPlce"),"").toString());
                        	dtl12.setFoSupplyplceNum(LimsUtil.checkNull(parameter2.get("realPaymentPlce"),"").toString());
                        	
                        } else {
                        	dtl12.setSupplyplceNum( LimsUtil.checkNull(parameter2.get("realPaymentPlce"),"").toString() );		//공급처번호
                        }
                       
                        logger.info("realPaymentPlce  :"+ LimsUtil.checkNull(parameter2.get("realPaymentPlce"),"").toString() );
                        
                        dtl12.setUpjang( parameter2.get("subUpjangNum").toString() );			                            //AP거래처 : 신고업장:종사업자번호
                        dtl12.setPayCond("F000");	//지불조건
                        dtl12.setReasonCd( "B00" );												                            //사유코드: A00:발생
                        dtl12.setItemText(remarks2);			                                                            //품목텍스트 - 적요2
                        dtl12.setLcNum(LimsUtil.checkNull(parameter2.get("lcNum"),"").toString());	                        //LC번호
                        dtl12.setPoNum(parameter2.get("poOrderNum").toString());					                        //PO번호
                        dtl12.setAttachDept(parameter2.get("attachDeptSap").toString());			                        //귀속부서
                        dtl12.setCcCd(parameter2.get("attachDeptSap").toString());		               						//CC CD 2016.02.25
                        dtl12.setMgmtDept(parameter2.get("attachDeptSap").toString());				                        //관리부서-귀속부서와 동일
                        //관리항목 필수(문의필요)
                        if ( !"".equals(taxCd)  )	//과세
                        {
                            dtl12.setMgmtArticle( LimsUtil.checkNull(parameter2.get("realPaymentPlce"),"").toString());			//과세 :관리항목 : 거래처:실거래처 20151106 고영범
                        }
                        else
                        {
                            dtl12.setMgmtArticle( LimsUtil.checkNull(parameter2.get("blNum"),"").toString() );	                //관리항목 : bl번호
                        }

                        dtl12.setBlDate(LimsUtil.checkNull(parameter2.get("lshipDate"),"").toString());		                //BL일자 (선적일자로 쓴다.)
                        dtl12.setLshipDate(LimsUtil.checkNull(parameter2.get("lshipDate"),"").toString());	                //선적일자
                        dtl12.setDtlNum(new BigDecimal(ii++)); 	                                                            //회계 전표의 개별 항목 번호

                        detail.add(dtl12);
                    }

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

                    paramMap.put("slipNum", slipNum);
                    if ( "Y".equals(draft))	  //상신
                    {
                        logger.info("------------1");
                        paramMap.put("slipStatus", "9");	//상신
                    }
                    else
                    {
                        logger.info("------------2");
                        paramMap.put("slipStatus", "A");	//전표요청
                    }

                    String altSlipClass = LimsUtil.checkNull(parameter.get("altSlipClass"));
                    logger.debug("altSlipClass :"+altSlipClass);

                    paramMap.put("buCd", "2000");
                    if ( "1".equals(altSlipClass))	//선급금 대체 누적금액 세팅
                    {
                        paramMap.put("workClass", "A-1");
                    }
                    else
                    {
                        paramMap.put("workClass", "A-2");
                    }

                    RecordSet fsiRs = ftSapInterfaceDAO.selectList(paramMap);
                    logger.info("fsiRs.size() :"+fsiRs.size());
                    if ( fsiRs.size() > 0)
                    {
                        ftSapInterfaceDAO.update(paramMap);
                    }
                    else
                    {
                        ftSapInterfaceDAO.insert(paramMap);
                    }

                    if ( !"Y".equals(draft))	  //상신
                    {
                        parameter.put("slipNum", slipNum);
                        ftSapInterfaceDAO.updateSignInstanceId(parameter);	  //전자결재 아이디 update
                    }

                    paramMap.put("poOrderNum", parameter.get("poOrderNum").toString());
                    paramMap.put("otherAmtSeq", LimsUtil.checkNull(parameter.get("otherAmtSeq"), null).toString());
                    paramMap.put("adjustSeq", LimsUtil.checkNull(parameter.get("adjustSeq"), null));
                    paramMap.put("prepayPoOrderNum", parameter.get("prepayPoOrderNum").toString());	//원시전표번호
                    logger.debug("poOrderNum :"+parameter.get("poOrderNum").toString());
                    if ( !"Y".equals(draft))	  //전표처리시
                    {
                        paramMap.put("nonarrivSlipCreationYn", "Y");	//미착등록
                    }
                    paramMap.put("slipNum", slipNum);
                    otherAmtProcCnt += poOrderOtherAmtDAO.updateSlipNum(paramMap);

                    logger.info("slipStatus222 ::::"+slipStatus2);
                    if ( !"".equals(altSlipClass) && "N".equals(draft) && !"A".equals(commClass.substring(0,1))  && !"".equals(parameter.get("prepayPoOrderNum").toString()))	  //전표요청시만 금액 누적,지불이 아닐때
                    {


                        if ( "1".equals(altSlipClass))	//선급금 대체 누적금액 세팅
                        {
                            if ( !"Y".equals(draft))	  //전표처리시
                            {
                                double commAmt = Double.parseDouble(parameter.get("commAmt").toString());	//수수료금액
                                logger.info("commAmt ::::"+commAmt);

                                paramMap.put("poOrderNum", parameter.get("prepayPoOrderNum").toString());	//원시전표번호
                                paramMap.put("adjustSeq", parameter.get("adjustSeq"));
                                
                                logger.info("adjustSeq :::::::::"+parameter.get("adjustSeq"));
                                
                                //기준 선급금 금액 대비 누적금액 초과 체크
                                if ( "50".equals(taxCd) || "52".equals(taxCd)  )	//전자일반매입,수기일반매입 : 부가세 포함 금액누적 20151102 김은영
                                {
                                    paramMap.put("accumAltAmt", etcTotSlipCurrencyAmt);
                                }
                                else
                                {
                                    paramMap.put("accumAltAmt", commAmt);
                                }
                                logger.info("etcTotSlipCurrencyAmt ::::"+etcTotSlipCurrencyAmt+"/taxCd :"+taxCd);
                                
                                Record prepayamtInfoTest = etcPrepayamtAdjustDAO.selectAccumAltAmt(paramMap);
                                double accumAltAmtTest = prepayamtInfoTest.getDouble("accumAltAmt");	//대체누적금액
                                logger.info("accumAltAmtTest11 :::::::::"+accumAltAmtTest);
                                logger.info("accumAltAmtTest22 :::::::::"+LimsUtil.getCommaNumber(accumAltAmtTest, "###,###,##0"));
                                
                                logger.info("paramMap :::::::::"+paramMap);
                                otherAmtProcCnt += etcPrepayamtAdjustDAO.updateAccumAltAmt(paramMap);

                                logger.debug("paramMap :"+paramMap);
                                Record prepayamtInfo = etcPrepayamtAdjustDAO.selectAccumAltAmt(paramMap);
                                double prepayamtAmt = prepayamtInfo.getDouble("prepayamtAmt");	//선급금금액
                                double accumAltAmt = prepayamtInfo.getDouble("accumAltAmt");	//대체누적금액
                                logger.debug("prepayamtAmt :"+prepayamtAmt+"/ accumAltAmt::"+accumAltAmt);
                                if ( prepayamtAmt < accumAltAmt ) {
                                    throw new BizException("선급금 금액 ["+LimsUtil.getCommaNumber(prepayamtAmt, "###,###,##0") +"] 기준 누적금액 ["+LimsUtil.getCommaNumber(accumAltAmt, "###,###,##0") +"]이 초과되었습니다.");
                                }
                            }
                        }
                        else	//가수금 대체 누적금액 세팅
                        {
                            if ( !"Y".equals(draft))	  //전표처리시
                            {
                                double commAmt = Double.parseDouble(parameter.get("commAmt").toString());	//수수료금액
                                paramMap.put("accumAltAmt", commAmt);
                                paramMap.put("sapSuspenseNum", parameter.get("suspenseNum").toString());	//가수금 원시전표번호
                                paramMap.put("altNum", parameter.get("prepayPoOrderNum"));
                                //paramMap.put("altSeq", parameter.get("adjustSeq")); //adjustSeq는 선급금과 중복 사용되어 altSeq로 변경 2016.01.29
                                paramMap.put("altSeq", parameter.get("altSeq"));
                                otherAmtProcCnt += etcPrepayamtAdjustDAO.updateAccumAltAmt2(paramMap);
        //                        slaSapSuspenseAltDetail
                                logger.debug("paramMap :"+paramMap);
                                //기준 선급금 금액 대비 누적금액 초과 체크

                                double applyAmt =  0;
                                double ftAccumAmt =  0;
                                Record suspenseInfo = etcPrepayamtAdjustDAO.selectAccumAltAmt2(paramMap);
                                if ( suspenseInfo != null )
                                {
                                    applyAmt =  suspenseInfo.getDouble("applyAmt");	//가수금금액
                                    ftAccumAmt = suspenseInfo.getDouble("ftAccumAmt");	//대체누적금액

                                }

                                logger.debug("applyAmt :"+applyAmt+"/ applyAmt::"+ftAccumAmt);
                                if ( applyAmt < ftAccumAmt ) {
                                    throw new BizException("가수금 금액 ["+LimsUtil.getCommaNumber(applyAmt, "###,###,##0") +"] 기준 누적금액 ["+LimsUtil.getCommaNumber(ftAccumAmt, "###,###,##0") +"]이 초과되었습니다.");
                                }
                            }
                        }
                    }
                }
            }
        }

        logger.info("slipNums :"+slipNums);
        topMap.put("slipNums", slipNums);	//구매품의 번호 전달
        topMap.put("procCnt", otherAmtProcCnt);	  //실행건 전달
        topListMap.add (topMap);

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
     * @see com.hwfs.ft.ftp.service.proposalService#createFiscalSlip(java.util.Map)
    */
    @Override
    @SuppressWarnings("unchecked")
    public int cancelFiscalSlip(LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap dsOtherAmtList
            ) throws Exception  {
        int otherAmtProcCnt = 0;

        logger.info( "flag  ::::"+search.get(0).get("flag") );

        //전표상태 : 전표생성 변경
        if ( dsOtherAmtList.size() > 0 ) {
            for (int i = 0 ; i < dsOtherAmtList.size() ; i++) {
                Map<String, Object> parameter = dsOtherAmtList.get(i);
                if ("1".equals(parameter.get("chk").toString()))
                {
                    //sap모듈 호출후 성공하면후 하단 로직 처리
                    String currYymmdd = LimsUtil.getDate("yyyyMMddHHmmss");
                    SlipCancelDTO mst = new SlipCancelDTO();
                    mst.setSlipNum(parameter.get("slipNum").toString());	            //SAP과 연결 키 -유일키
                    mst.setBuCd("2000");		                                        //회사코드
                    mst.setSysCd("IFC");												//시스템코드
                    mst.setFiscalSlipNum(parameter.get("slipNum").toString());    //회계전표번호
                    mst.setFiscalYear(parameter.get("fiscalYear").toString());			//회계전도
                    mst.setPeriodDate(parameter.get("paySchdDate").toString());	        //전기일 - 매입전표일자
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

                    mst.setWriteEmpNum(loginParameter.getSabun());	//작성사원부서 : 로그인사번
                    mst.setWriteEmpDept(loginParameter.getDeptId());		//작성사원부서


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

                    //외부문서번호 update
                    otherAmtProcCnt += poOrderOtherAmtDAO.cancelFiscalSlip(parameter);

                    Map<String, Object> paramMap = new HashMap<String, Object>();
                    paramMap.put("slipNum", parameter.get("slipNum").toString());
                    paramMap.put("slipStatus", "B");
                    paramMap.put("buCd", "2000");
                    paramMap.put("resultMsg", "취소");
                    paramMap.put("workClass", "수수료");
                    ftSapInterfaceDAO.update(paramMap);
                }

            }
        }

        return otherAmtProcCnt;
    }


    /**
     * getAssignNum 설명
     * <pre>
     * 지정 가져오기
     * </pre>
     *
     * @param parameter
     * @return
     * @see com.hwfs.ft.ftp.service.proposalService#createFiscalSlip(java.util.Map)
    */
    public String getAssignNum(String accCd, Map<String, Object> parameter, String flag)
    {
        String assignNum = "";    //지정
        String orgFiscalSlipNum = "";
        String slipPublishDate ="";


        if ( "PRE".equals(flag))	//선급금
        {
            orgFiscalSlipNum = LimsUtil.checkNull(parameter.get("orgFiscalSlipNum")) ;
            slipPublishDate = parameter.get("slipPublishDate").toString().substring(0,6);
        }
        else
        {
            slipPublishDate = parameter.get("paySchdDate").toString().substring(0,6);
        }
        logger.info("accCd ::"+accCd);
        if ("11404000".equals(accCd) )						//지정 : 미착 : PO번호
        {
            assignNum = LimsUtil.checkNull(parameter.get("poOrderNum"));
        }
        else if ("11501010".equals(accCd) )						//지정 : 선급금_거래처:원시전표번호
        {
            if ( !"".equals(orgFiscalSlipNum) )
            {
                assignNum = LimsUtil.checkNull(parameter.get("orgFiscalSlipNum"));
            }
            else
            {
                assignNum = slipPublishDate;
            }
        }
        else if ( "11501020".equals(accCd) )					// 지정 : 선급금_임직원 : 원시전표번호
        {
        	if ( !"".equals(orgFiscalSlipNum) )
            {
                assignNum = LimsUtil.checkNull(parameter.get("orgFiscalSlipNum"));
            }
            else
            {
                assignNum = slipPublishDate;
            }
        }
        else if ("90005020".equals(accCd) )						//지정 : 채권채무가계정 :년월
        {
            assignNum = slipPublishDate;
        }

        else if ("21101010".equals(accCd) )						//지정 : 외상매입금 :년월
        {
            assignNum = slipPublishDate;
        }
        else if ("21102010".equals(accCd) )						//지정 : 미지급금_거래처 :년월
        {
            assignNum = slipPublishDate;
        }
        else if ("21102020".equals(accCd) )						//지정 : 미지급금_임직원 :년월
        {
            assignNum = slipPublishDate;
        }
        else if ("11101020".equals(accCd) )						//지정 : 전도금_사업장 :년월
        {
            assignNum = slipPublishDate;
        }
        else if ("90005100".equals(accCd) )						//지정 : 입금대체가계정 :가수금번호
        {
            if ( !"".equals(orgFiscalSlipNum) )
            {
                assignNum = LimsUtil.checkNull(parameter.get("orgFiscalSlipNum"));
            }
            else
            {
                assignNum = slipPublishDate;
            }

        }
        else if ("21401110".equals(accCd) )						//지정 : 가수금_수익금 :가수금번호
        {
            assignNum = LimsUtil.checkNull(parameter.get("suspenseNum"));
        }
        else if ("21401120".equals(accCd) )						//지정 : 가수금 가상계좌 :가수금번호
        {
            assignNum = LimsUtil.checkNull(parameter.get("suspenseNum"));
        }
        else
        {
            assignNum = "";
        }
        logger.info("accCd :"+accCd+"assignNum ::"+assignNum);
        return assignNum;
    }

    /**
     * createFiscalSlip 설명
     * <pre>
     * 기타선급금 정산 회계전표 IF 버튼 클릭시 SAP
     * </pre>
     *
     * @param parameter
     * @return
     * @see com.hwfs.ft.ftp.service.proposalService#createFiscalSlip(java.util.Map)
    */
    @Override
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> createEtcFiscalSlipIf(LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap dsEtcPrepayamtList
            ) throws Exception  {
        int etcPrepayamtProcCnt = 0;
        //기타 선급금 정산
        String poOrderNum = "";	//구매주문 번호
        if ( dsEtcPrepayamtList.size() > 0 ) {
            for (int i = 0 ; i < dsEtcPrepayamtList.size() ; i++) {
                Map<String, Object> parameter = dsEtcPrepayamtList.get(i);
                int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
                if ( !search.get(0).get("flag").equals("CALL") ) {	//불러오기
                    poOrderNum = parameter.get("poOrderNum").toString();
                }
                logger.info( "poOrderNum    5::::"+poOrderNum );

                if (rowType == DataSet.ROW_TYPE_INSERTED) {
                    if ( search.get(0).get("flag").equals("CALL") ) {	//신규
                        parameter.put("poOrderNum", poOrderNum);
                    }
                    etcPrepayamtProcCnt += etcPrepayamtAdjustDAO.insert(parameter);
                }
                else if (rowType == DataSet.ROW_TYPE_UPDATED){
                    etcPrepayamtProcCnt += etcPrepayamtAdjustDAO.update(parameter);
                }
                else if (rowType == DataSet.ROW_TYPE_DELETED) {
                    etcPrepayamtProcCnt += etcPrepayamtAdjustDAO.delete(parameter);
                }
            }
        }


        List<Map<String, Object>> topListMap = new ArrayList();
        Map<String, Object> topMap = new HashMap ();


        logger.info( "flag  ::::"+search.get(0).get("flag") );
        String currYymmdd = LimsUtil.getDate("yyyyMMddHHmmss");

        String draft = search.get(0).get("draft").toString();	//상신,전표처리 구분
        logger.info( "draft  ::::"+draft);

        RecordSet etcRs = poOrderMstDAO.selectEtcPrepayamtList(search.get(0));

        //마스터 생성
        SlipMstDTO mst = new SlipMstDTO();

        Map<String, Object> mstParameter = etcRs.get(0);



        String slipNum = LimsUtil.checkNull(mstParameter.get("slipNum"),"").toString();
        String slipStatus = LimsUtil.checkNull(mstParameter.get("slipStatus"),"").toString();
        logger.info("gSlipNum :"+slipNum);
        if ( "".equals(slipNum) || "Z".equals(slipStatus) || "R".equals(slipStatus) || "E".equals(slipStatus) || "C".equals(slipStatus))	//신규 이거나 취소, 에러시 전표번호 생성
        {
            slipNum = poOrderMstDAO.selectSlipNum(search.get(0));
        }
        logger.info("slipNum2 :"+slipNum);
        mst.setSlipNum(slipNum);	            ///SAP과 연결 키 -유일키
        mst.setBuCd("2000");		            //회사코드
        logger.info("slipClassCd :"+mstParameter.get("slipClassCd").toString());
        mst.setSlipType(mstParameter.get("slipClassCd").toString());	            //전표유형
        mst.setSlipEvidenceDate(mstParameter.get("slipPublishDate").toString());	//전표증빙일자 - 매입전표일자
        mst.setSlipPeriodDate(mstParameter.get("slipPublishDate").toString());		//전표전기일자 - 전표발행일
        mst.setCurrency("KRW");				//통화

        //mst.setElctntaxBillApprvnum(mstParameter.get("taxBillNum").toString());	//전자세금계산서승인번호

        logger.info("currYymmdd :"+currYymmdd);
        mst.setInputDate(currYymmdd.substring(0,8));			//입력일자
        mst.setInputTime(currYymmdd.substring(8));			//입력시간 -6자리
        mst.setWriteEmpSabun(loginParameter.getSabun());	//작성사원부서 : 로그인사번
        mst.setWriteEmpDept(loginParameter.getDeptId());		//작성사원부서
        mst.setWriteEmpMuCd(loginParameter.getMuCd());
        mst.setSysCd("IFC");											//시스템코드
        mst.setElctnSignId(LimsUtil.checkNull(mstParameter.get("signInstanceId"),"").toString());			 						//전자결재ID - 임시세팅
        mst.setSignStatus(LimsUtil.checkNull(mstParameter.get("signProgressStatus"),"").toString());								//전표상태 - 임시세팅
        mst.setSignType("1");	//결재유형:G/W 결재
        mst.setSlipText("선급금 전표 ["+loginParameter.getDeptNm()+"]");	  //(ex)상품권 청구 [FC외식사업지원팀]
        if ( "Y".equals(draft))	  //상신
        {
            mst.setPistat("9");
        }

        List<SlipMstDTO> master = new ArrayList<SlipMstDTO>();
        master.add(mst);

        SlipMstList mstList = new SlipMstList();
        mstList.setDataList(master);


        Map<String, Object> paramMap = new HashMap<String, Object>();
        List<SlipDtlDTO> detail = new ArrayList<SlipDtlDTO>();
        int ii = 1;
        if ( etcRs.size() > 0 ) {
            //차변생성
            for (int i = 0 ; i < etcRs.size() ; i++) {
                Map<String, Object> parameter = etcRs.get(i);
                logger.info("ii :"+parameter.get("num"));

                //차변 만들기1 : 선급금_거래처
                SlipDtlDTO dtl = new SlipDtlDTO();	  //
//                String gSlipNum = LimsUtil.checkNull(parameter.get("slipNum"),"").toString();
//                logger.info("gSlipNum :"+gSlipNum);
//                if (!"".equals(gSlipNum))
//                {
//                    slipNum = gSlipNum;
//                }

                dtl.setSlipNum(slipNum);	            ///SAP과 연결 키 -유일키
                dtl.setBuCd("2000");
                logger.info("slipNum :"+slipNum);
                logger.info("slipClassCd :"+parameter.get("slipClassCd").toString());
                dtl.setSlipType(parameter.get("slipClassCd").toString());	            //전표유형
                dtl.setSlipEvidenceDate(parameter.get("slipPublishDate").toString());	//전표증빙일자 - 전표발행일
//                dtl.setSlipPeriodDate(currYymmdd.substring(0,8));	//전표전기일자 - 지불예정일자
                dtl.setSlipPeriodDate(parameter.get("slipPublishDate").toString());		//전표전기일자 - 전표발행일
                dtl.setMasterAcct(parameter.get("drAcctCd").toString());		//선급금_거래처
                dtl.setDrCrClass(parameter.get("drAcctClass").toString());		//1:차변

                double prepayamtAmt = Double.parseDouble(parameter.get("prepayamtAmt").toString());	//공급가액
                dtl.setSlipCurrencyAmt(BigDecimal.valueOf(prepayamtAmt));	//공급가액
                dtl.setSupplyplceNum( parameter.get("realPaymentPlce").toString() );			//공급처번호

                //적요 : P/O NO. + 수수료구분 + 적요
                String remarks2 = parameter.get("poOrderNum").toString()
                        +" "+parameter.get("commClassNm").toString()
                        +" "+LimsUtil.checkNull(parameter.get("remarks"),"").toString()
                        ;
                logger.info("remarks2 :"+remarks2);
                dtl.setItemText(remarks2);			//품목텍스트 - 적요2
                if ( parameter.get("expireCalBasisDate") == null )
                {
                    throw new BizException("통관예정일을 입력하세요");
                }
                dtl.setExpireCalBasisDate(parameter.get("paySchdDate").toString());	 		                 //통관예정일 +3개월 = 입금예정일
                logger.info("attachDeptSap111 :"+parameter.get("attachDeptSap").toString());
                dtl.setAttachDept(parameter.get("attachDeptSapJun").toString());		//전도금 사업장 아닐때 귀속부서
                dtl.setMgmtDept(parameter.get("attachDeptSapJun").toString());		//전도금 사업장 아닐때 관리부서-귀속부서와 동일

                String assignNum = getAssignNum(LimsUtil.checkNull(dtl.getMasterAcct()) , parameter, "ETC" );		//지정
                dtl.setAssignNum( slipNum );	 //선급금 거래처: 자기 전표번호
                dtl.setReasonCd( parameter.get("paygrpCd").toString() );												//사유코드: A00:발생
                dtl.setPayCond("F000");		            //지불조건 : 환율(외화)정보 있으면 : E000 나머지 : F000
                dtl.setDtlNum(new BigDecimal(ii++)); 	//회계 전표의 개별 항목 번호

                detail.add(dtl);
                logger.info("ii1 ::"+ii);

                //대변생성
                for (int j= 0 ; j < etcRs.size() ; j++) {
                    Map<String, Object> parameter2 = etcRs.get(j);
                    //대변계정 만들기 : 대변에 실지급처가 있으면 생성
                    if ( parameter.get("poOrderNum").toString().equals(parameter2.get("poOrderNum").toString())
                        && parameter.get("adjustSeq").toString().equals(parameter2.get("adjustSeq").toString())
                        && !"".equals(LimsUtil.checkNull(parameter.get("crRealPaymentPlce"),""))
                        )
                    {
                        logger.info("ii2 ::"+ii);
                        //대변 계정만들기 : 전도금_FC사업장, 외상 매입금
                        SlipDtlDTO dtl21 = new SlipDtlDTO();
                        dtl21.setSlipNum(slipNum);	                                                    //SAP과 연결 키 -유일키
                        dtl21.setBuCd("2000");					                                        //회사 코드
                        dtl21.setSlipType(parameter2.get("slipClassCd").toString());	            	//전표유형
                        dtl21.setSlipEvidenceDate(parameter2.get("slipPublishDate").toString());	        //전표증빙일자 - 매입전표일자
//                        dtl21.setSlipPeriodDate(currYymmdd.substring(0,8));	            //전표전기일자 - 매입전표일자
                        logger.info("slipPublishDate ::"+parameter2.get("slipPublishDate").toString());
                        dtl21.setSlipPeriodDate(parameter2.get("slipPublishDate").toString());		//전표전기일자 - 전표발행일
                        dtl21.setDtlNum(BigDecimal.valueOf(ii++)); 	                                //회계 전표의 개별 항목 번호
                        dtl21.setMasterAcct(parameter2.get("crAcctCd").toString());			                                    //전도금_FC사업장
                        dtl21.setDrCrClass(parameter2.get("crAcctClass").toString());														//대변
                        dtl21.setSlipCurrencyAmt( BigDecimal.valueOf(Long.parseLong(parameter2.get("crPrepayamtAmt").toString())) );					//전표통화금액 :결재금액


                        dtl21.setItemText(remarks2);			                //품목텍스트 - 적요2
                        dtl21.setAttachDept(parameter2.get("attachDeptSap").toString());		                //전도금 사업장 구분 귀속부서
                        dtl21.setMgmtDept(parameter2.get("attachDeptSap").toString());		                //전도금 사업장 구분 관리부서-귀속부서와 동일
                        dtl21.setSupplyplceNum( parameter2.get("realPaymentPlce").toString() );				//AP거래처 : 매입처.
                        dtl21.setExpireCalBasisDate(parameter2.get("paySchdDate").toString());	 		                 //통관예정일 +3개월 = 입금예정일

                        assignNum = getAssignNum(LimsUtil.checkNull(parameter2.get("crAcctCd")) , parameter, "ETC");		//지정
                        dtl21.setAssignNum( assignNum );

                        logger.info("payCondSap ::"+parameter2.get("payCondSap").toString());
                        dtl21.setPayCond("F000");		            //지불조건 : 환율(외화)정보 있으면 : E000 나머지 : F000
                        dtl21.setReasonCd( parameter2.get("paygrpCd").toString()  );												//사유코드: A00:발생

                        String snglfootlstNmYn = (LimsUtil.checkNull(parameter2.get("snglfootlstNmYn")).equals("1")?"X":"");
//                        dtl21.setSinglePayYn(snglfootlstNmYn);	// 단발성여부	SAP확인 필요
                        logger.info("snglfootlstNmYn :"+snglfootlstNmYn+"//"+parameter2.get("bankAcctNoEnc")+"//"+parameter2.get("bankAcctOwnr")+"//"+parameter2.get("bankCd")+"//"+parameter2.get("realPaymentPlceNm"));
                        // 단발성이면...
                        if (snglfootlstNmYn.equals("X")) {
//                            dtl21.setTempCustNm(LimsUtil.checkNull(parameter2.get("realPaymentPlceNm")));	// 공급자명
                            dtl21.setTempCustNm("");	// 공급자명
                        }

                        dtl21.setBankAcctNo(LimsUtil.checkNull(parameter2.get("bankAcctNoEnc")));	// 공급자 계좌번호 - 암호화된 계좌번호
                        dtl21.setBankAcctOwnr(LimsUtil.checkNull(parameter2.get("bankAcctOwnr")));	// 공급자 예금주
                        dtl21.setBankCd(LimsUtil.checkNull(parameter2.get("bankCd")));	// 공급자 은행코드
                        dtl21.setCrgleftClass(LimsUtil.checkNull(parameter2.get("bankType")));	// 계좌구분코드(Bank type)

                        detail.add(dtl21);
                    }
                }

                paramMap.put("poOrderNum", parameter.get("poOrderNum").toString());
                paramMap.put("adjustSeq", parameter.get("adjustSeq").toString());
                paramMap.put("slipNum", slipNum);
                etcPrepayamtProcCnt += etcPrepayamtAdjustDAO.createEtcFiscalSlipIf(paramMap);
            }
        }

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
        if ( "Y".equals(draft))	  //상신
        {
            logger.info("------------1");
            paramMap.put("slipStatus", "9");	//상신
        }
        else
        {
            logger.info("------------2");
            paramMap.put("slipStatus", "A");	//전표요청
        }
        logger.info("REAL slipNum :"+slipNum);
        paramMap.put("slipNum", slipNum);
        paramMap.put("buCd", "2000");
        paramMap.put("workClass", "선급금");
        RecordSet fsiRs = ftSapInterfaceDAO.selectList(paramMap);
        if ( fsiRs.size() > 0)
        {
            ftSapInterfaceDAO.update(paramMap);
        }
        else
        {
            ftSapInterfaceDAO.insert(paramMap);
        }

        paramMap.put("signInstanceId", mstParameter.get("signInstanceId"));
        if ( !"Y".equals(draft))	  //상신
        {
            ftSapInterfaceDAO.updateSignInstanceId(paramMap);	  //전자결재 아이디 update
        }
        logger.info("slipNums :"+slipNum);
        topMap.put("slipNums", slipNum);	//구매품의 번호 전달
        topMap.put("procCnt", etcPrepayamtProcCnt);	  //실행건 전달
        topListMap.add (topMap);

        return topListMap;

    }

    /**
     * 식도매 선급 테스트
     * <pre>
     * 통관경비선급금지불
     * </pre>
     *
     * @param parameter
     * @return
     * @see com.hwfs.ft.ftp.service.proposalService#createFiscalSlip(java.util.Map)
    */
    public int createPreSlipEtcFiscalSlipIf( DataSetMap dsEtcPrepayamtList
            ) throws Exception  {
        int otherAmtProcCnt = 0;


        if ( dsEtcPrepayamtList.size() > 0 ) {
            for (int i = 0 ; i < dsEtcPrepayamtList.size() ; i++) {
                Map<String, Object> parameter = dsEtcPrepayamtList.get(i);


            }
        }



        return otherAmtProcCnt;
    }

    /**
     * createFiscalSlip 설명
     * <pre>
     * 기타선급금 정산 회계전표 IF 취소 버튼 클릭시 SAP
     * </pre>
     *
     * @param parameter
     * @return
     * @see com.hwfs.ft.ftp.service.proposalService#createFiscalSlip(java.util.Map)
    */
    @Override
    @SuppressWarnings("unchecked")
    public int cancelEtcFiscalSlipIf(LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap dsEtcPrepayamtList
            ) throws Exception  {
        int etcPrepayamtProcCnt = 0;

        logger.info( "flag  ::::"+search.get(0).get("flag") );

        //sap모듈 취소후 성공하면 아래 상태변경

        //전표상태 : 전표생성 변경
        if ( dsEtcPrepayamtList.size() > 0 ) {
            for (int i = 0 ; i < dsEtcPrepayamtList.size() ; i++) {
                Map<String, Object> parameter = dsEtcPrepayamtList.get(i);

                //sap모듈 호출후 성공하면후 하단 로직 처리
                String currYymmdd = LimsUtil.getDate("yyyyMMddHHmmss");
                SlipCancelDTO mst = new SlipCancelDTO();
                mst.setSlipNum(parameter.get("slipNum").toString());	            //SAP과 연결 키 -유일키
                mst.setBuCd("2000");		                                        //회사코드
                mst.setSysCd("IFC");												//시스템코드
                mst.setFiscalSlipNum(parameter.get("fiscalSlipNum").toString());    //회계전표번호
                mst.setFiscalYear(parameter.get("fiscalYear").toString());			//회계전도
                mst.setPeriodDate(parameter.get("paySchdDate").toString());	        //전기일 - 매입전표일자
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

                mst.setWriteEmpNum(loginParameter.getSabun());	//작성사원부서 : 로그인사번
                mst.setWriteEmpDept(loginParameter.getDeptId());		//작성사원부서


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

//                parameter.put("slipNum", "");	  //회계전표번호
                parameter.put("paySchdDate", ""); //지불예정일자
                etcPrepayamtProcCnt += etcPrepayamtAdjustDAO.cancelEtcFiscalSlipIf(parameter);

                Map<String, Object> paramMap = new HashMap<String, Object>();
                paramMap.put("slipNum", parameter.get("slipNum").toString());
                paramMap.put("slipStatus", "B");
                paramMap.put("buCd", "2000");
                paramMap.put("resultMsg", "취소");
                paramMap.put("workClass", "선급금");
                ftSapInterfaceDAO.update(paramMap);

            }
        }

        return etcPrepayamtProcCnt;
    }

    /**
     * saveDmtPoOrderDtl 설명
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @see com.hwfs.ft.ftp.service.proposalService#saveProposalDtl(java.util.Map)
    */
    @Override
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> saveDmtPoOrderDtl(LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap dsPoOrderInfo
            , DataSetMap dsItemList
            , DataSetMap dsPayList
            , DataSetMap dsAppendDocList
            ) throws Exception  {
        int proposalProcCnt = 0;
        int itemProcCnt = 0;
        int payProcCnt = 0;
        int invoiceProcCnt = 0;
        int appendDocProcCnt = 0;
        int otherAmtProcCnt = 0;
        int etcPrepayamtProcCnt = 0;
        String poOrderNum = "";	//구매주문 번호

        List<Map<String, Object>> listMap = new ArrayList();
        Map<String, Object> map = new HashMap ();
        logger.info( "flag  ::::"+search.get(0).get("flag") );

        /*
        -	품의 금액 대비 10% 저장 초과시 메시지 처리
        1.품의서번호로 생성된 BL의 품목별 원물금액을 SUM
        2.화면상 품목별 원물금액을 SUM
        3.품의서번호로 PR테이블의 품목별 원물금액을 SUM
        4.1+2>3*10% 면 REJECT
        */
        if ( dsItemList.size() > 0 ) {	  //화면상 품목별 원물금액을 SUM
            double viewWonwtrAmtSum = 0;
            if ( dsItemList.size() > 0 ) {
                for (int i = 0 ; i < dsItemList.size() ; i++) {
                    Map<String, Object> parameter = dsItemList.get(i);
                    int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
                    if (search.get(0).get("flag").equals("CALL") )	//불러오기
                    {
                        if (rowType == DataSet.ROW_TYPE_INSERTED)
                        {
                            logger.info("wonwtrAmt1 ::::"+Double.parseDouble(parameter.get("wonwtrAmt").toString()));
                            viewWonwtrAmtSum += Double.parseDouble(parameter.get("wonwtrAmt").toString());
                        }
                    } else {	//상세 조회시
                        logger.info("wonwtrAmt2 ::::"+Double.parseDouble(parameter.get("wonwtrAmt").toString()));
                        viewWonwtrAmtSum += Double.parseDouble(parameter.get("wonwtrAmt").toString());
                    }
                }
            }

            //1.품의서번호로 생성된 BL의 품목별 원물금액을 SUM
            if ( !search.get(0).get("flag").equals("CALL") )	//불러오기
            {
                dsItemList.get(0).put("flag", "ORG");
            }
            RecordSet wonwtrAmtSumRs = poOrderMstDAO.getWonwtrAmtSum(dsItemList.get(0));
            //2.화면상 품목별 원물금액을 SUM viewWonwtrAmtSum
            double blWonwtrAmtSum =  wonwtrAmtSumRs.get(0).getDouble("wonwtrAmt");
            double prWonwtrAmtSum =  wonwtrAmtSumRs.get(1).getDouble("wonwtrAmt");
            prWonwtrAmtSum = prWonwtrAmtSum + prWonwtrAmtSum *0.1;
            logger.info(blWonwtrAmtSum +"//"+viewWonwtrAmtSum+"//"+prWonwtrAmtSum);
            if ( blWonwtrAmtSum + viewWonwtrAmtSum > prWonwtrAmtSum )
            {
                throw processException("ft.ftp.fail.poOrder.confirm.over");	  //품의금액 대비 구매주문 금액의 합이 10%를 초과할 수 없습니다.
            }
        }

        String strRefSeq = "";	//첨부참조일련번호
        if ( dsAppendDocList.size() > 0 ) {
            strRefSeq = attachFileService.save(dsAppendDocList, propertiesService.getString("ft.file.path"), false);
            logger.info("strRefSeq :::"+strRefSeq);
        }

        //1.구매주문 품의 마스터 저장
        if ( dsPoOrderInfo.size() > 0 || strRefSeq !=null ) {
            //첨부파일 처리 : 업무별 저장소의 상대패스를 파라미터로 전달해야 한다.

            for (int i = 0 ; i < dsPoOrderInfo.size() ; i++) {
                Map<String, Object> parameter = dsPoOrderInfo.get(i);
                parameter.put("fileRefSrlNum", strRefSeq);	//파일 참조 일련 번호
                int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
                if (rowType == DataSet.ROW_TYPE_INSERTED) {
                    //PO-300(100)-YYMM-SEQ(4):내수(300)/수입(100)
                     logger.info("flag :::"+search.get(0).get("flag"));
                    if ( !search.get(0).get("flag").equals("CALL") ) {	//불러오기
                        logger.info("-------------1");
                        poOrderNum = parameter.get("poOrderNum").toString();
                    } else {
                        logger.info("-------------2-"+parameter.get("poType"));
                        poOrderNum = poOrderMstDAO.getPoOrderMstSeq(parameter);
                        String currYymm = LimsUtil.getDate("yyMM");
                        if ( "10".equals(parameter.get("poType") )) {	//수입
                            poOrderNum = "100-"+"PO-"+currYymm+"-"+poOrderNum;
                        } else {
                            poOrderNum = "300-"+"PO-"+currYymm+"-"+poOrderNum;
                        }

                        logger.info("poOrderNum :"+poOrderNum);
                        parameter.put("poOrderNum", poOrderNum);
                    }

                    parameter.put("poOrderStatus", "N");	//구매주문상태 : 신규


                    proposalProcCnt += poOrderMstDAO.insert(parameter);

                } else if (rowType == DataSet.ROW_TYPE_UPDATED){
                    proposalProcCnt += poOrderMstDAO.update(parameter);
                    poOrderNum = parameter.get("poOrderNum").toString();
                }
            }
        }

        logger.info( "poOrderNum  ::::"+poOrderNum  );

        //2.구매 품의 품목 상세 저장
        if ( dsItemList.size() > 0 ) {
            for (int i = 0 ; i < dsItemList.size() ; i++) {
                Map<String, Object> parameter = dsItemList.get(i);
                parameter.put("cuser", loginParameter.getSabun());
                parameter.put("uuser", loginParameter.getSabun());
                logger.info( "flag  ::::"+search.get(0).get("flag")  );
                int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
                if ( !search.get(0).get("flag").equals("CALL") ) {	//불러오기
                    poOrderNum = parameter.get("poOrderNum").toString();
                }
                logger.info( "poOrderNum    1::::"+poOrderNum );

                if (rowType == DataSet.ROW_TYPE_INSERTED) {
                    if ( search.get(0).get("flag").equals("CALL") ) {	//신규
                        parameter.put("poOrderNum", poOrderNum);
                    }
                    itemProcCnt += poOrderItemDetailDAO.insert(parameter);
                    itemProcCnt +=whbyItembyChargAmtDAO.mergeGvrntaxRate(parameter);	//창고 품목별 관세율 관리 insert,update
                }
                else if (rowType == DataSet.ROW_TYPE_UPDATED){
                    itemProcCnt += poOrderItemDetailDAO.update(parameter);
                    itemProcCnt +=whbyItembyChargAmtDAO.mergeGvrntaxRate(parameter);	//창고 품목별 관세율 관리 insert,update
                }
                else if (rowType == DataSet.ROW_TYPE_DELETED && !search.get(0).get("flag").equals("CALL")) {
                    itemProcCnt += poOrderItemDetailDAO.delete(parameter);
                }

            }
        }

        //3.구매 품의 지불 조건 저장
        if ( dsPayList.size() > 0 ) {
            for (int i = 0 ; i < dsPayList.size() ; i++) {
                Map<String, Object> parameter = dsPayList.get(i);
                parameter.put("cuser", loginParameter.getSabun());
                parameter.put("uuser", loginParameter.getSabun());
                int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
                if ( !search.get(0).get("flag").equals("CALL") ) {	//불러오기
                    poOrderNum = parameter.get("poOrderNum").toString();
                }
                logger.info( "poOrderNum    2::::"+poOrderNum );
                if (rowType == DataSet.ROW_TYPE_INSERTED) {
                    if ( search.get(0).get("flag").equals("CALL") ) {	//신규
                        parameter.put("poOrderNum", poOrderNum);
                    }
                    payProcCnt += poOrderPayCondDAO.insert(parameter);
                }
                else if (rowType == DataSet.ROW_TYPE_UPDATED){
                    payProcCnt += poOrderPayCondDAO.update(parameter);
                }
                else if (rowType == DataSet.ROW_TYPE_DELETED) {
                    payProcCnt += poOrderPayCondDAO.delete(parameter);
                }
            }
        }
        logger.info( "poOrderNum2  ::::"+poOrderNum  );

        logger.info("LAST poOrderNum :"+poOrderNum);
        map.put("poOrderNum", poOrderNum);	//구매품의 번호 전달
        map.put("procCnt", proposalProcCnt+itemProcCnt+payProcCnt+invoiceProcCnt+appendDocProcCnt+otherAmtProcCnt+etcPrepayamtProcCnt);	  //실행건 전달
        listMap.add (map);

        return listMap;
    }

    /**
     * 통관 수입면허번호 조회한다.
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
    public RecordSet selectbasiNumList(Map<String, Object> mapParam) throws Exception {
        return poOrderMstDAO.selectbasiNumList(mapParam);
    }

    /**
     * 매출수수료를 조회한다.
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
    public RecordSet selectCommSalsList(Map<String, Object> mapParam) throws Exception {
        return poOrderMstDAO.selectCommSalsList(mapParam);
    }

    /**
     * saveEtcPrepayamtList 설명
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @see com.hwfs.ft.ftp.service.proposalService#saveEtcPrepayamtList(java.util.Map)
    */
    @Override
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> saveEtcPrepayamtList(LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap dsPoOrderInfo
            , DataSetMap dsEtcPrepayamtList
            ) throws Exception  {
        int etcPrepayamtProcCnt = 0;
        String poOrderNum = "";	//구매주문 번호

        List<Map<String, Object>> listMap = new ArrayList();
        Map<String, Object> map = new HashMap ();


        //기타 선급금 정산
        if ( dsEtcPrepayamtList.size() > 0 ) {
            for (int i = 0 ; i < dsEtcPrepayamtList.size() ; i++) {
                Map<String, Object> parameter = dsEtcPrepayamtList.get(i);
                int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
                if ( !search.get(0).get("flag").equals("CALL") ) {	//불러오기
                    poOrderNum = parameter.get("poOrderNum").toString();
                }
                logger.info( "poOrderNum    5::::"+poOrderNum );

                if (rowType == DataSet.ROW_TYPE_INSERTED) {
                    if ( search.get(0).get("flag").equals("CALL") ) {	//신규
                        parameter.put("poOrderNum", poOrderNum);
                    }
                    etcPrepayamtProcCnt += etcPrepayamtAdjustDAO.insert(parameter);
                }
                else if (rowType == DataSet.ROW_TYPE_UPDATED){
                    etcPrepayamtProcCnt += etcPrepayamtAdjustDAO.update(parameter);
                }
                else if (rowType == DataSet.ROW_TYPE_DELETED) {
                    etcPrepayamtProcCnt += etcPrepayamtAdjustDAO.delete(parameter);
                }
            }
        }

        logger.info("LAST poOrderNum :"+poOrderNum);
        map.put("poOrderNum", poOrderNum);	//구매품의 번호 전달
        map.put("procCnt", etcPrepayamtProcCnt);	  //실행건 전달
        listMap.add (map);

        return listMap;
    }


    /**
     * saveOtherAmtList 설명
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
    public List<Map<String, Object>> saveOtherAmtList(LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap dsPoOrderInfo
            , DataSetMap dsOtherAmtList
            ) throws Exception  {
        int otherAmtProcCnt = 0;
        String poOrderNum = "";	//구매주문 번호

        List<Map<String, Object>> listMap = new ArrayList();
        Map<String, Object> map = new HashMap ();
        Map<String, Object> taxBillMap = new HashMap ();

        for (int i = 0 ; i < dsPoOrderInfo.size() ; i++) {
            Map<String, Object> parameter = dsPoOrderInfo.get(i);
            int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            otherAmtProcCnt += poOrderMstDAO.updateExchangeInfo(parameter);	//구매 주문에 대한 통관환율,일자.(을)를 수정한다.
            poOrderNum = parameter.get("poOrderNum").toString();
            logger.info( "poOrderNum    1::::"+poOrderNum );
        }

        //6.구매주문 부대비
        if ( dsOtherAmtList.size() > 0 ) {
            for (int i = 0 ; i < dsOtherAmtList.size() ; i++) {
                Map<String, Object> parameter = dsOtherAmtList.get(i);
                int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
                String etcPrepayamtMgmtNum = "";


                if ( !search.get(0).get("flag").equals("CALL") ) {	//불러오기
                    poOrderNum = parameter.get("poOrderNum").toString();
                }
                logger.info( "poOrderNum    4::::"+poOrderNum +" // "+parameter.get("taxBillNum"));


                parameter.put("taxBillNum", parameter.get("taxBillNum"));

                if ( rowType == DataSet.ROW_TYPE_INSERTED || !parameter.get("taxBillNum").equals(parameter.get("orgTaxBillNum")))		//신규,세금계산서번호가 변경될시 중복 체크
                {
                    taxBillMap.put("taxBillNum",  LimsUtil.checkNull(parameter.get("taxBillNum")));
                    logger.info( "taxBillMap   taxBillNum    4::::"+taxBillMap.get("taxBillNum"));
                    int chkCnt = freezeWhCommMgmtDAO.selectTaxBillNum(taxBillMap);
                    if (chkCnt > 0) {
                        throw new BizException("중복된 국세청승인번호가 존재합니다.");
                    }
                }


                if (rowType == DataSet.ROW_TYPE_INSERTED) {
                    logger.info( "flag    4::::"+search.get(0).get("flag") );
                    if ( search.get(0).get("flag").equals("CALL") ) {	//신규
                        parameter.put("poOrderNum", poOrderNum);
                    }

                    otherAmtProcCnt += poOrderOtherAmtDAO.insert(parameter);
/*
                    //선급금 금액 누적
                    float commAmt = Float.parseFloat(parameter.get("commAmt").toString());	//수수료금액
                    parameter.put("tempAccumAltAmt", commAmt);
                    parameter.put("poOrderNum", parameter.get("prepayPoOrderNum").toString());	//원시전표번호
                    logger.info("adjustSeq :"+parameter.get("adjustSeq"));
                    otherAmtProcCnt += etcPrepayamtAdjustDAO.updateAccumAltAmt(parameter);
*/
                }
                else if (rowType == DataSet.ROW_TYPE_UPDATED){
                    etcPrepayamtMgmtNum = parameter.get("poOrderNum").toString()+parameter.get("otherAmtSeq").toString();
                    parameter.put("etcPrepayamtMgmtNum", etcPrepayamtMgmtNum);	//기타 선급금 관리 번호
                    //parameter.put("orgFiscalSlipNum", "");	//저장시는 원시전표번호 NULL로
                    otherAmtProcCnt += poOrderOtherAmtDAO.update(parameter);
/*
                    //선급금 금액 누적
                    float commAmt = Float.parseFloat(parameter.get("commAmt").toString());	//수수료금액
                    parameter.put("tempAccumAltAmt", commAmt);
                    parameter.put("poOrderNum", parameter.get("prepayPoOrderNum").toString());	//원시전표번호
                    logger.info("adjustSeq :"+parameter.get("adjustSeq"));
                    otherAmtProcCnt += etcPrepayamtAdjustDAO.updateAccumAltAmt(parameter);
*/
                }
                else if (rowType == DataSet.ROW_TYPE_DELETED) {
                    otherAmtProcCnt += poOrderOtherAmtDAO.delete(parameter);
                }
            }
        }

        logger.info("LAST poOrderNum :"+poOrderNum);
        map.put("poOrderNum", poOrderNum);	//구매품의 번호 전달
        map.put("procCnt", otherAmtProcCnt);	  //실행건 전달
        listMap.add (map);

        return listMap;
    }

    /**
     * saveOtherAmtList 설명
     * <pre>
     * 수수료 매출 정보를 등록한다.
     * </pre>
     *
     * @param parameter
     * @return
     * @see com.hwfs.ft.ftp.service.proposalService#saveEtcPrepayamtList(java.util.Map)
    */
    @Override
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> saveCommSalsList(LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap dsPoOrderInfo
            , DataSetMap dsCommSals
            ) throws Exception  {
        int commSalsProcCnt = 0;
        String poOrderNum = "";	//구매주문 번호

        List<Map<String, Object>> listMap = new ArrayList();
        Map<String, Object> map = new HashMap ();


        //8.수수료매출
        if ( dsCommSals.size() > 0 ) {
            for (int i = 0 ; i < dsCommSals.size() ; i++) {
                Map<String, Object> parameter = dsCommSals.get(i);
                parameter.put("cuser", loginParameter.getSabun());
                parameter.put("uuser", loginParameter.getSabun());
                logger.info( "flag  ::::"+search.get(0).get("flag")  );
                int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
                if ( !search.get(0).get("flag").equals("CALL") ) {	//불러오기
                    poOrderNum = parameter.get("poOrderNum").toString();
                }
                logger.info( "poOrderNum    111::::"+poOrderNum );

                parameter.put("status", "C");	//저장
                if (rowType == DataSet.ROW_TYPE_INSERTED) {
                    if ( search.get(0).get("flag").equals("CALL") ) {	//신규
                        parameter.put("poOrderNum", poOrderNum);
                    }
                    commSalsProcCnt += poOrderCommSalsDAO.insert(parameter);
                }
                else if (rowType == DataSet.ROW_TYPE_UPDATED){
                    commSalsProcCnt += poOrderCommSalsDAO.update(parameter);
                }
                else if (rowType == DataSet.ROW_TYPE_DELETED && !search.get(0).get("flag").equals("CALL")) {
                    commSalsProcCnt += poOrderCommSalsDAO.delete(parameter);
                }
            }
        }

        logger.info("LAST poOrderNum :"+poOrderNum);
        map.put("poOrderNum", poOrderNum);	//구매품의 번호 전달
        map.put("procCnt", commSalsProcCnt);	  //실행건 전달
        listMap.add (map);

        return listMap;
    }

    /**
     * saveCommSalsConfirm 설명
     * <pre>
     * 수수료 매출 관리 상태(을)를 수정한다.
     * </pre>
     *
     * @param parameter
     * @return
     * @see com.hwfs.ft.ftp.service.proposalService#saveEtcPrepayamtList(java.util.Map)
    */
    @Override
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> saveCommSalsConfirm(LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap dsPoOrderInfo
            , DataSetMap dsCommSals
            ) throws Exception  {
        int commSalsProcCnt = 0;
        String poOrderNum = "";	//구매주문 번호

        List<Map<String, Object>> listMap = new ArrayList();
        Map<String, Object> map = new HashMap ();

        //8.수수료매출
        if ( dsCommSals.size() > 0 ) {
            for (int i = 0 ; i < dsCommSals.size() ; i++) {
                Map<String, Object> parameter = dsCommSals.get(i);
                parameter.put("cuser", loginParameter.getSabun());
                parameter.put("uuser", loginParameter.getSabun());
                logger.info( "flag  ::::"+search.get(0).get("flag")  );
                if ( !search.get(0).get("flag").equals("CALL") ) {	//불러오기
                    poOrderNum = parameter.get("poOrderNum").toString();
                }
                parameter.put("status", "A");	//확정

                commSalsProcCnt += poOrderCommSalsDAO.updateStatus(parameter);
            }
        }

        logger.info("LAST poOrderNum :"+poOrderNum);
        map.put("poOrderNum", poOrderNum);	//구매품의 번호 전달
        map.put("procCnt", commSalsProcCnt);	  //실행건 전달
        listMap.add (map);

        return listMap;
    }

    /**
     * saveCommSalsConfirm 설명
     * <pre>
     * 수수료 매출 관리 상태(을)를 수정한다.
     * </pre>
     *
     * @param parameter
     * @return
     * @see com.hwfs.ft.ftp.service.proposalService#saveEtcPrepayamtList(java.util.Map)
    */
    @Override
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> saveCommSalsConfirmCancel(LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap dsPoOrderInfo
            , DataSetMap dsCommSals
            ) throws Exception  {
        int commSalsProcCnt = 0;
        String poOrderNum = "";	//구매주문 번호

        List<Map<String, Object>> listMap = new ArrayList();
        Map<String, Object> map = new HashMap ();

        //8.수수료매출
        if ( dsCommSals.size() > 0 ) {
            for (int i = 0 ; i < dsCommSals.size() ; i++) {
                Map<String, Object> parameter = dsCommSals.get(i);
                parameter.put("cuser", loginParameter.getSabun());
                parameter.put("uuser", loginParameter.getSabun());
                logger.info( "flag  ::::"+search.get(0).get("flag")  );
                if ( !search.get(0).get("flag").equals("CALL") ) {	//불러오기
                    poOrderNum = parameter.get("poOrderNum").toString();
                }
                parameter.put("status", "C");	//저장단계로

                commSalsProcCnt += poOrderCommSalsDAO.updateStatus(parameter);
            }
        }

        logger.info("LAST poOrderNum :"+poOrderNum);
        map.put("poOrderNum", poOrderNum);	//구매품의 번호 전달
        map.put("procCnt", commSalsProcCnt);	  //실행건 전달
        listMap.add (map);

        return listMap;
    }

    /**
     * saveCommSalsConfirm 설명
     * <pre>
     * 수수료 매출 관리 상태(을)를 수정한다.
     * </pre>
     *
     * @param parameter
     * @return
     * @see com.hwfs.ft.ftp.service.proposalService#saveEtcPrepayamtList(java.util.Map)
    */
    @Override
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> saveSalsReg(LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap dsPoOrderInfo
            , DataSetMap dsCommSals
            ) throws Exception  {
        int commSalsProcCnt = 0;
        String poOrderNum = "";	//구매주문 번호
        String poProposalNum = "";	// 품의번호
        
        List<Map<String, Object>> listMap = new ArrayList();
        Map<String, Object> map = new HashMap ();

        Map<String, Object> retProcVal = new HashMap<String, Object>();
        if ( dsCommSals.size() > 0 ) {
            for (int i = 0 ; i < dsCommSals.size() ; i++) {
                Map<String, Object> parameter2 = dsCommSals.get(i);

                commSalsProcCnt += poOrderCommSalsDAO.update(parameter2);
            }
        }

        //수수료매출
        //retProcVal.put("seqs", search.get(0));

        RecordSet commSalsRs = poOrderMstDAO.selectSalsRegs(search.get(0));			//마감 대상 조회한다.
        if ( commSalsRs.size() > 0 ) {
            for (int i = 0 ; i < commSalsRs.size() ; i++) {
                Map<String, Object> parameter = commSalsRs.get(i);
                Map<String, Object> procParam = new HashMap<String, Object>();

                logger.debug("closeFlag ==> " + search.get(0).get("closeFlag"));
                logger.debug("receiptDate 11==> " + LimsUtil.checkNull(parameter.get("occurDate")));
                if ( "Y".equals(search.get(0).get("closeFlag")) )	//마감
                {
                    procParam.put("p_upmu", "FTPC");	// 업무구분 : LIMS(연구소), IFIS(고도화), FTP(식재도매), FTPC(식재도매수수료)
                    String currYymmdd = LimsUtil.getDate("yyyyMMdd");
                    procParam.put("p_occur_date", LimsUtil.checkNull(parameter.get("occurDate"))); // 발생일자
                }
                else if ("C".equals(search.get(0).get("closeFlag")))		//마감 취소
                {
                    procParam.put("p_upmu", "FTPCD");	// 업무구분 : FTPCD(식재도매수수료 취소)
                    logger.debug("receiptDate 22==> " + LimsUtil.checkNull(parameter.get("occurDate")));
                    procParam.put("p_occur_date", LimsUtil.checkNull(parameter.get("occurDate"))); // 발생일자	receiptDate
                }
                procParam.put("p_req_num", "");	// 키값 : 구분할수 있는 값 세팅

                //procParam.put("p_occur_date", "20151118"); // 발생일자

                procParam.put("p_upjang", parameter.get("upjang")); // 영업사원 업장코드
                procParam.put("p_mu_cd", parameter.get("muCd")); // mu코드
                procParam.put("p_cc_cd", parameter.get("ccCd")); // cc코드
                procParam.put("p_custcd", parameter.get("custCd")); // 거래처번호
                procParam.put("p_vat_gubun", "1"); // 과세
//                long supplyAmt = Long.parseLong(parameter.get("supplyAmt").toString());	//공급가액
//                long tax = Long.parseLong(parameter.get("tax").toString());	//세액
//                procParam.put("p_amt", supplyAmt+tax); // 총합계 : 과세여부에 따라 procedure에서 갈라치기

                logger.debug("uprice==> " + LimsUtil.checkNull(parameter.get("uprice")));
                procParam.put("p_amt", Long.parseLong(parameter.get("uprice").toString())); // 총금액
                procParam.put("p_gamang_cd", parameter.get("supplyAmt"));	//공급가액
                procParam.put("p_card_gubun", parameter.get("tax"));		//세액

                procParam.put("p_sal_quantity", parameter.get("totQuantity")); // 판매 수량
                procParam.put("p_cuser", loginParameter.getSabun()); // 처리자
                procParam.put("p_param_receipt_num", parameter.get("receiptNum")); 	//기존영수증번호
                procParam.put("p_pay_cd", "7"); 	//지불코드

                logger.debug("procParam ==> " + procParam);

                // 마감테이블에 전송
                retProcVal = testEndApprvDAO.updateTestEndApprvSLA(procParam);

                logger.debug("LTM_IF_SLA_SALESINFO_PRO Procedure ==> " + retProcVal);
                String pRetCode = retProcVal.get("P_RET_CODE").toString();
                logger.debug("P_RECEIPT_NUM Procedure ==> " + LimsUtil.checkNull(retProcVal.get("P_RECEIPT_NUM")));
                String pReceiptNum = LimsUtil.checkNull(retProcVal.get("P_RECEIPT_NUM"));


                poOrderNum = parameter.get("poOrderNum").toString();
                poProposalNum = parameter.get("poProposalNum").toString();
                
                procParam.put("poProposalNum", poProposalNum);
                procParam.put("saleType", "40");	// 40:수수료
                procParam.put("uuser", loginParameter.getSabun());
                
                logger.info("pRetCode ::::"+pRetCode);
                if ( "E".equals(pRetCode) )
                {
                    throw new BizException(retProcVal.get("P_RET_MSG").toString());
                }

                procParam.put("poOrderNum", parameter.get("poOrderNum"));
                procParam.put("custCd", parameter.get("custCd"));
                procParam.put("seqs", search.get(0).get("seqs"));
                RecordSet rs = poOrderCommSalsDAO.selectList(procParam);
                logger.info("rs.size() ::::"+rs.size());

                for (int j = 0 ; j < rs.size() ; j++) {
                    Map<String, Object> parameter2 = rs.get(j);
                    if ( "Y".equals(search.get(0).get("closeFlag")) )	//마감
                    {
                        if ( parameter.get("custCd").toString().equals(parameter2.get("cust").toString()))
                        {
                            procParam.put("receiptNum", pReceiptNum);
                            procParam.put("status", "B");	//마감
                        }
                    }
                    else if ( "C".equals(search.get(0).get("closeFlag")) )	//마감취소
                    {
                        procParam.put("receiptNum", "");
                        procParam.put("status", "A");	//확정
                    }

                    logger.info("seq ::::"+parameter2.get("seq"));
                    procParam.put("seq", parameter2.get("seq"));

                    commSalsProcCnt += poOrderCommSalsDAO.update(procParam);

                }
                
                // 판매유형변경 (수수료)
                if ( "Y".equals(search.get(0).get("closeFlag")) ) {
                	if  (!"".equals(poProposalNum) ) {
                	proposalDAO.updatePoProposaleType(procParam);
                	poOrderMstDAO.updateSaleType(procParam);
                	} else {
                		throw new BizException("품의서번호가 없습니다.");
                	}
                }
            }
            
        }

        logger.info("LAST poOrderNum :"+poOrderNum);
        map.put("poOrderNum", poOrderNum);	//구매품의 번호 전달
        map.put("procCnt", commSalsProcCnt);	  //실행건 전달
        listMap.add (map);

        return listMap;
    }

    /**
     * 원시전표 불러오기  목록을 조회한다.
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
    public RecordSet selectSlipCallPop(Map<String, Object> mapParam) throws Exception {
        return poOrderMstDAO.selectSlipCallPop(mapParam);
    }

    /**
     * 영업회계 원시전표 불러오기  목록을 조회한다.
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
    public RecordSet selectIfcSlipCallPop(Map<String, Object> mapParam) throws Exception {
        return poOrderMstDAO.selectIfcSlipCallPop(mapParam);
    }
    
    /**
     * 가수금전표 불러오기  목록을 조회한다.
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
    public RecordSet selectSuspenseCallPop(Map<String, Object> mapParam) throws Exception {
        return poOrderMstDAO.selectSuspenseCallPop(mapParam);
    }
    /**
     * saveOtherAmtList 설명
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
    public List<Map<String, Object>> saveOtherAmtDraft(LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap dsPoOrderInfo
            , DataSetMap dsOtherAmtList
            ) throws Exception  {
        int otherAmtProcCnt = 0;
        String poOrderNum = "";	//구매주문 번호

        List<Map<String, Object>> listMap = new ArrayList();
        Map<String, Object> map = new HashMap ();


        //6.구매주문 부대비
        if ( dsOtherAmtList.size() > 0 ) {
            for (int i = 0 ; i < dsOtherAmtList.size() ; i++) {
                Map<String, Object> parameter = dsOtherAmtList.get(i);
                poOrderNum = parameter.get("poOrderNum").toString();

                parameter.put("cuser", loginParameter.getSabun());
                parameter.put("uuser", loginParameter.getSabun());
                parameter.put("poProposalStatus", "20");	//상신

                logger.info("signInstanceId ::"+parameter.get("signInstanceId"));
                //1.품의상태:상신중 update
                otherAmtProcCnt += poOrderOtherAmtDAO.updateOtherAmtDraft( parameter );

                //2.그룹웨어와 I/F - 정의 되면 구현

                //SCC_SIGN_INFO 테이블에 결재정보저장 (Insert or Update)
                gwIfDAO.saveSignInfo(parameter);

            }
        }

        logger.info("LAST poOrderNum :"+poOrderNum);
        map.put("poOrderNum", poOrderNum);	//구매품의 번호 전달
        map.put("procCnt", otherAmtProcCnt);	  //실행건 전달
        listMap.add (map);

        return listMap;
    }


    /**
     * saveOtherAmtList 설명
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
    public List<Map<String, Object>> saveEtcAmtDraft(LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap dsPoOrderInfo
            , DataSetMap dsEtcPrepayamtList
            ) throws Exception  {
        int otherAmtProcCnt = 0;
        String poOrderNum = "";	//구매주문 번호

        List<Map<String, Object>> listMap = new ArrayList();
        Map<String, Object> map = new HashMap ();


        //6.구매주문 부대비
        if ( dsEtcPrepayamtList.size() > 0 ) {
            for (int i = 0 ; i < dsEtcPrepayamtList.size() ; i++) {
                Map<String, Object> parameter = dsEtcPrepayamtList.get(i);
                poOrderNum = parameter.get("poOrderNum").toString();

                parameter.put("cuser", loginParameter.getSabun());
                parameter.put("uuser", loginParameter.getSabun());
                parameter.put("poProposalStatus", "20");	//상신

                logger.info("signInstanceId ::"+parameter.get("signInstanceId"));
                //1.품의상태:상신중 update
                otherAmtProcCnt += etcPrepayamtAdjustDAO.updateEtcAmtDraft(parameter);
                //2.그룹웨어와 I/F - 정의 되면 구현

                //SCC_SIGN_INFO 테이블에 결재정보저장 (Insert or Update)
                gwIfDAO.saveSignInfo(parameter);

            }
        }

        logger.info("LAST poOrderNum :"+poOrderNum);
        map.put("poOrderNum", poOrderNum);	//구매품의 번호 전달
        map.put("procCnt", otherAmtProcCnt);	  //실행건 전달
        listMap.add (map);

        return listMap;
    }
}
