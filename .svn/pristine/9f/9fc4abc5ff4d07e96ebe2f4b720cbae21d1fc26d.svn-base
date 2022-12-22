package com.hwfs.ft.fgp.service;

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

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.ft.fgp.dao.GdspaymMstDAO;
import com.hwfs.ft.fsi.dao.FreezeWhCommMgmtDAO;
import com.hwfs.ft.fsi.dao.FtSapInterfaceDAO;
import com.hwfs.ft.ftp.dao.PoOrderMstDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
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
import com.hwfs.sc.cmn.service.SlipNumService;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 물품대금 마스터하는 GdspaymMst Service Implementation
 *
 * @ClassName GdspaymMstServiceImpl.java
 * @Description GdspaymMstServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.06    kjj        최초생성
 * </pre>
 * @author FC종합전산구축 : 물품대금 마스터 kjj
 * @since 2015.04.06
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ft/fgp/gdspaymMstService")
public class GdspaymMstServiceImpl extends DefaultServiceImpl implements GdspaymMstService {

    /** LogService */
    private final Logger logger = LoggerFactory.getLogger (this.getClass());

    /** GdspaymMstDAO Bean 생성 */
    @Resource(name = "/ft/fgp/gdspaymMstDAO")
    private GdspaymMstDAO gdspaymMstDAO;

    @Resource(name = "/ft/ftp/poOrderMstDAO")
    private PoOrderMstDAO poOrderMstDAO;

    @Resource(name="EAIService")
    EAIService eaiService;

    /** FtSapInterfaceDAO Bean 생성 */
    @Resource(name = "/ft/fsi/ftSapInterfaceDAO")
    private FtSapInterfaceDAO ftSapInterfaceDAO;

    /** GwIfDAO Bean 생성 */
    @Resource(name = "/sc/cmn/gwIfDAO")
    private GwIfDAO gwIfDAO;

    @Resource(name = "/ft/fsi/freezeWhCommMgmtDAO")
    private FreezeWhCommMgmtDAO freezeWhCommMgmtDAO;

    /**
     * 물품대금 마스터 관리 목록을 조회한다.
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
        return gdspaymMstDAO.selectList(mapParam);
    }

    /**
     * 물품대금 마스터 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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

            logger.info("orgPoOrderNum :"+rowData.get("orgPoOrderNum"));
            logger.info("seq333333333333 :"+rowData.get("seq"));
            String seq = LimsUtil.checkNull(rowData.get("seq"),"");
            //Update 처리
            if (rowType == DataSet.ROW_TYPE_UPDATED)
            {
                if ( "".equals(seq) )
                {
                    logger.info("####insert####");
                    rowData.put("slipStatus", "10");	//전표 등록
                    int maxSeq = gdspaymMstDAO.getMaxSeq(rowData);
                    logger.info("maxSeq :"+maxSeq);
                    rowData.put("seq", maxSeq);
                    insRowCnt += gdspaymMstDAO.insert(rowData);

                }
                else
                {
                    logger.info("####update1####");
                    updRowCnt += gdspaymMstDAO.update(rowData);
                }
            }
        }

        return insRowCnt + updRowCnt + delRowCnt;
    }

    /**
     * createFiscalSlip 설명
     * <pre>
     * 회계전표 IF 버튼 클릭시 SAP
     * </pre>
     *
     * @param parameter
     * @return
     * @see com.hwfs.ft.fgp.dao.GdspaymMstDAO.createFiscalSlip
    */
    @Override
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> createFiscalSlip(LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap dsGdspaymList
            ) throws Exception  {
        int procCnt = 0;

        List<Map<String, Object>> topListMap = new ArrayList();
        Map<String, Object> topMap = new HashMap ();
        String draft = search.get(0).get("draft").toString();	//상신,전표처리 구분
        logger.info("draft :"+draft);
        ArrayList slipNums = new ArrayList();

        for (int i = 0 ; i < dsGdspaymList.size() ; i++) {
            Map<String, Object> rowData = dsGdspaymList.get(i);
            int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            logger.info("orgPoOrderNum :"+rowData.get("orgPoOrderNum"));
            logger.info("seq :"+rowData.get("seq"));
            String seq = LimsUtil.checkNull(rowData.get("seq"),"");
            //Update 처리
            if (rowType == DataSet.ROW_TYPE_UPDATED && "1".equals(rowData.get("chk")))
            {
//                String slipNum = LimsUtil.checkNull(rowData.get("slipNum"),"").toString();
//                String slipStatus = LimsUtil.checkNull(rowData.get("slipStatus"),"").toString();
//                logger.info("slipNum :"+slipNum+"// slipStatus:"+slipStatus);
//                if ( "".equals(slipNum))	  //상신
//                {
//                    slipNum = poOrderMstDAO.selectSlipNum(rowData);
//
//                }

//                logger.info("slipNum111 :"+slipNum);
//                slipNums.add(i, slipNum);
                if ( "".equals(seq) )
                {
                    logger.info("####insert####");
//                    rowData.put("slipNum", slipNum);	//외부문서번호
                    rowData.put("slipStatus", "10");	//전표 등록
                    int maxSeq = gdspaymMstDAO.getMaxSeq(rowData);
                    logger.info("maxSeq :"+maxSeq);
                    rowData.put("seq", maxSeq);
                    procCnt += gdspaymMstDAO.insert(rowData);

                }
                else
                {
                    logger.info("####update3####");
//                    if ( "".equals(slipNum))	  //상신
//                    {
//                        slipNum = poOrderMstDAO.selectSlipNum(rowData);
//
//                    }
//                    logger.info("slipNum112 :"+slipNum);

                    procCnt += gdspaymMstDAO.update(rowData);
                }
            }
        }
        Map<String, Object> paramMap = new HashMap<String, Object>();
        //PO 후상태 - PO 확정이후의 상태(수입은 매입전표생성) Y를 UPDATE하고 확정취소 불가 처리
        logger.info("dsGdspaymList.size() :::"+dsGdspaymList.size());
        if ( dsGdspaymList.size() > 0 ) {
            for (int i = 0 ; i < dsGdspaymList.size() ; i++) {
                Map<String, Object> parameter = dsGdspaymList.get(i);
                int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

                //Update 처리
                if (rowType == DataSet.ROW_TYPE_UPDATED && "1".equals(parameter.get("chk")))
                {
                    logger.info("poOrderNum1:::"+parameter.get("poOrderNum"));
                    //sap모듈 호출후 성공하면후 하단 로직 처리
                    String seq = LimsUtil.checkNull(parameter.get("seq"),"");


                    String slipNum = LimsUtil.checkNull(parameter.get("slipNum"),"").toString();
                    String slipStatus = LimsUtil.checkNull(parameter.get("slipStatus"),"").toString();
                    logger.info("slipNum :"+slipNum+"// slipStatus:"+slipStatus);
                    if ( "".equals(slipNum) || "Z".equals(slipStatus) || "R".equals(slipStatus) || "E".equals(slipStatus) || "C".equals(slipStatus))	//신규 이거나 취소, 에러시 전표번호 생성
                    {
                        slipNum = poOrderMstDAO.selectSlipNum(parameter);

                    }
                    slipNums.add(i, slipNum);


                    parameter.put("slipNum", slipNums.get(i));
                    logger.info("slipNum :"+slipNums.get(i));

                    if ( "".equals(seq) )
                    {
                        logger.info("####insert####");
                        logger.info("payCondSeq :"+parameter.get("payCondSeq"));

                        parameter.put("slipNum", slipNum);
                        logger.info("slipNum :"+slipNum);


                    }

                    String currYymmdd = LimsUtil.getDate("yyyyMMddHHmmss");
                    SlipMstDTO mst = new SlipMstDTO();

                    mst.setSlipNum(slipNum);	            ///SAP과 연결 키 -유일키
                    mst.setBuCd("2000");		            //회사코드
                    mst.setSlipType("7L");	            //전표유형
                    mst.setSlipEvidenceDate(parameter.get("buySlipDate").toString());	//전표증빙일자 - 매입전표일자
                    mst.setSlipPeriodDate(parameter.get("buySlipDate").toString());	//전표전기일자 - 매입전표일자
                    mst.setCurrency("KRW");				//통화

                    logger.info("currYymmdd :"+currYymmdd);
                    mst.setInputDate(currYymmdd.substring(0,8));			//입력일자
                    mst.setInputTime(currYymmdd.substring(8));			//입력시간 -6자리
                    mst.setWriteEmpSabun(parameter.get("slipPublisher").toString());	//작성사원부서 : 로그인사번
                    mst.setWriteEmpDept(parameter.get("empDept").toString());		//작성사원부서
                    mst.setWriteEmpMuCd(parameter.get("empMuCd").toString());
                    mst.setSysCd("IFC");											//시스템코드
                    mst.setElctnSignId(LimsUtil.checkNull(parameter.get("signInstanceId"),"").toString());			 						//전자결재ID - 임시세팅
                    mst.setSignStatus(LimsUtil.checkNull(parameter.get("signProgressStatus"),"").toString());								//전표상태 - 임시세팅
                    mst.setSignType("1");	//결재유형:G/W 결재
                    mst.setSlipText("물품대금(수입) 전표 ["+loginParameter.getDeptNm()+"]");	  //(ex)상품권 청구 [FC외식사업지원팀]
                    if ( "Y".equals(draft))	  //상신
                    {
                        mst.setPistat("9");
                    }

                    List<SlipMstDTO> master = new ArrayList<SlipMstDTO>();
                    master.add(mst);

                    SlipMstList mstList = new SlipMstList();
                    mstList.setDataList(master);

                    int ii = 1;
                    List<SlipDtlDTO> detail = new ArrayList<SlipDtlDTO>();
                    //차변 만들기 : 상품_일반상품
                    SlipDtlDTO dtl11 = new SlipDtlDTO();	  //
                    dtl11.setSlipNum(slipNum);	            ///SAP과 연결 키 -유일키
                    dtl11.setBuCd("2000");
                    dtl11.setSlipType("7L");	            //전표유형
                    
                    
                    dtl11.setMasterAcct("11404000");		//상품_미착품
                    
                    dtl11.setDrCrClass("1");				//1:차변
                    String cusVdCls = parameter.get("cusVdCls").toString();
                    if ("20".equals(cusVdCls))	  //해외거래처일때
                    {
                        dtl11.setPayCond("E000");		            //지불조건 : 환율(외화)정보 있으면 : E000 나머지 : F000
                    }
                    else
                    {
                        dtl11.setPayCond("F000");		            //지불조건 : 환율(외화)정보 있으면 : E000 나머지 : F000
                    }
                    dtl11.setSlipEvidenceDate(parameter.get("buySlipDate").toString());	//전표증빙일자 - 지불예정일자
                    dtl11.setSlipPeriodDate(parameter.get("buySlipDate").toString());	//전표전기일자 - 매입전표일자
                    dtl11.setExpireCalBasisDate(LimsUtil.checkNull(parameter.get("paySchdDate")));			            //통관예정일 +3개월 = 지불예정일

                    String remarks2 ="";
//                    float settleExchangeRate = Float.parseFloat(LimsUtil.checkNull(parameter.get("settleExchangeRate"),"0"));
                    double settleExchangeRate = Double.parseDouble(LimsUtil.checkNull(parameter.get("exchangeRate"),"0"));
                    logger.info("settleExchangeRate :"+settleExchangeRate);
                    double payAmt = Double.parseDouble(parameter.get("payAmt").toString());

                    String strSettleExchangeRate = String.format("%.2f", settleExchangeRate);
                    String strPayAmt = String.format("%.2f", payAmt);

                    remarks2 = parameter.get("poOrderNum").toString()
                            +" / "+parameter.get("amountUnit").toString()
                            +" / "+strSettleExchangeRate
                            +" / "+strPayAmt
                            ;
                    remarks2 = remarks2 +" / "+ parameter.get("remarks2").toString();
                    logger.info("payAmtKrw11 :"+parameter.get("payAmtKrw"));

                    dtl11.setSlipCurrencyAmt( BigDecimal.valueOf(Double.parseDouble(parameter.get("payAmtKrw").toString())) );					//전표통화금액 :결재금액 금액(KRW)
                    dtl11.setItemText(remarks2);			//품목텍스트 - 적요2
                    dtl11.setLcNum(parameter.get("lcNum").toString());	//LC번호
                    dtl11.setPoNum(parameter.get("poOrderNum").toString());	//PO번호
                    dtl11.setAttachDept(parameter.get("attachDeptSap").toString());		//귀속부서
                    dtl11.setMgmtDept(parameter.get("attachDeptSap").toString());		//관리부서-귀속부서와 동일
                    //관리항목 필수(문의필요)
                    logger.info("splrCd :"+parameter.get("splrCd").toString() );
                    dtl11.setMgmtArticle( parameter.get("splrCd").toString() );			//관리항목 : bl번호
                    dtl11.setBlDate(parameter.get("lshipDate").toString());	//BL일자 (선적일자로 쓴다.)
                    dtl11.setLshipDate(parameter.get("lshipDate").toString());	//선적일자
                    dtl11.setDtlNum(new BigDecimal(ii++)); 	//회계 전표의 개별 항목 번호
                    logger.info("splrCd :"+parameter.get("splrCd").toString() );
                    dtl11.setSupplyplceNum( parameter.get("splrCd").toString() );					//공급처번호(매입처)
                    dtl11.setAssignNum( parameter.get("poOrderNum").toString() );

                    detail.add(dtl11);

                    //dtl1_2.setMgmtArticle( parameter.get("splrCd").toString() );			//관리항목 : 거래처: 확인필요 :매입처
                    //대변 계정만들기 : 외상매입금_거래처
                    SlipDtlDTO dtl21 = new SlipDtlDTO();
                    dtl21.setSlipNum(slipNum);	                                //SAP과 연결 키 -유일키
                    dtl21.setBuCd("2000");					                                        //회사 코드
                    dtl21.setSlipType("7L");	            	                                    //전표유형


                    dtl21.setSlipEvidenceDate(parameter.get("buySlipDate").toString());	        //전표증빙일자 - 매입전표일자
                    dtl21.setSlipPeriodDate(parameter.get("buySlipDate").toString());	            //전표전기일자 - 매입전표일자
                    logger.info("paySchdDate :"+LimsUtil.checkNull(parameter.get("paySchdDate")));
                    dtl21.setExpireCalBasisDate(LimsUtil.checkNull(parameter.get("paySchdDate")));			            //통관예정일 +3개월 = 지불예정일

                    dtl21.setDtlNum(BigDecimal.valueOf(ii++)); 	                                //회계 전표의 개별 항목 번호
                    dtl21.setMasterAcct("21101010");			                                    //외상매입금_거래처
                    dtl21.setDrCrClass("2");					                                    //2:대변

                    dtl21.setSlipCurrencyAmt( BigDecimal.valueOf( Double.parseDouble(parameter.get("payAmtKrw").toString())) );					//전표통화금액 :결재금액

                    dtl21.setSupplyplceNum( parameter.get("splrCd").toString() );					//공급처번호(매입처)

                    dtl21.setItemText(remarks2);			            //품목텍스트 - 적요2
//                    dtl21.setPayCond("F000");		            //지불조건 : 환율(외화)정보 있으면 : E000 나머지 : F000
                    if ("20".equals(cusVdCls))	  //해외거래처일때
                    {
                        dtl21.setPayCond("E000");		            //지불조건 : 환율(외화)정보 있으면 : E000 나머지 : F000
                    }
                    else
                    {
                        dtl21.setPayCond("F000");		            //지불조건 : 환율(외화)정보 있으면 : E000 나머지 : F000
                    }
                    dtl21.setAttachDept(parameter.get("attachDeptSap").toString());		        //귀속부서
                    dtl21.setMgmtDept(parameter.get("attachDeptSap").toString());		        //관리부서-귀속부서와 동일
                    dtl21.setAssignNum( parameter.get("paySchdDate").toString().substring(0,6));							//지정 : 외상매입금 거래처:년
                    dtl21.setReasonCd( "A00" );													//사유코드: A00:발생

                    String snglfootlstNmYn = (LimsUtil.checkNull(parameter.get("snglfootlstNmYn")).equals("1")?"X":"");
//                    dtl21.setSinglePayYn(snglfootlstNmYn);	// 단발성여부
                    logger.info("snglfootlstNmYn :"+snglfootlstNmYn+"//"+parameter.get("bankAcctNoEnc")+"//"+parameter.get("bankAcctOwnr")+"//"+parameter.get("bankCd")+"//"+parameter.get("splrNm"));
                    // 단발성이면...
                    if (snglfootlstNmYn.equals("X")) {
                        dtl21.setTempCustNm("");	// 공급자명
                    }

                    dtl21.setBankAcctNo(LimsUtil.checkNull(parameter.get("bankAcctNoEnc")));	// 공급자 계좌번호 - 암호화된 계좌번호
                    dtl21.setBankAcctOwnr(LimsUtil.checkNull(parameter.get("bankAcctOwnr")));	// 공급자 예금주
                    dtl21.setBankCd(LimsUtil.checkNull(parameter.get("bankCd")));	// 공급자 은행코드
                    dtl21.setCrgleftClass(LimsUtil.checkNull(parameter.get("bankType")));	// 계좌구분코드(Bank type)
                    detail.add(dtl21);

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
                        throw new BizException(res.getErrorMsg());
                    }

                    //1.전표상태 등록 update
                    paramMap.put("slipNum", slipNum);
                    paramMap.put("poOrderNum", parameter.get("poOrderNum").toString());
                    paramMap.put("seq", parameter.get("seq"));
                    if ( !"Y".equals(draft))	  //전표처리시
                    {
                        paramMap.put("nonarrivSlipCreationYn", "Y");	//미착등록
                    }
                    paramMap.put("buCd", "2000");
                    paramMap.put("workClass", "원물대금(수입) 미착");
                    procCnt += gdspaymMstDAO.createFiscalSlip(paramMap);

                    //2.PO후 상태 Y 업데이트
                    parameter.put("poAfterstatus", "Y");	  //PO 후상태 - PO 확정이후의 상태(수입은 매입전표생성) Y를 UPDATE하고 확정취소 불가 처리
                    procCnt += poOrderMstDAO.updatePoAfterstatus(parameter);

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
                    paramMap.put("slipNum", slipNum);
                    paramMap.put("buCd", "2000");
                    paramMap.put("workClass", "물품대금 수입");

                    RecordSet fsiRs = ftSapInterfaceDAO.selectList(paramMap);
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
                        ftSapInterfaceDAO.updateSignInstanceId(parameter);	  //전자결재 아이디 update
                    }
                }
            }
        }

        topMap.put("slipNums", slipNums);	//구매품의 번호 전달
        topMap.put("procCnt", procCnt);	  //실행건 전달
        topListMap.add (topMap);

        return topListMap;


//        return procCnt;
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
    public List<Map<String, Object>> saveIncomDraft(LoginDTO loginParameter
            , DataSetMap search
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
                logger.info("signInstanceId ::"+parameter.get("signInstanceId"));
                //1.품의상태:상신중 update
                otherAmtProcCnt += gdspaymMstDAO.updateIncomeDraft( parameter );

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
    public int cancelFiscalSlip(LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap dsGdspaymList
            ) throws Exception  {
        int procCnt = 0;

        //PO 후상태 - PO 확정이후의 상태(수입은 매입전표생성) Y를 UPDATE하고 확정취소 불가 처리
        if ( dsGdspaymList.size() > 0 ) {
            for (int i = 0 ; i < dsGdspaymList.size() ; i++) {
                Map<String, Object> parameter = dsGdspaymList.get(i);
logger.info("slipStatus ::"+parameter.get("slipStatus"));
                //sap모듈 호출후 성공하면후 하단 로직 처리
                String currYymmdd = LimsUtil.getDate("yyyyMMddHHmmss");
                SlipCancelDTO mst = new SlipCancelDTO();
                mst.setSlipNum(parameter.get("slipNum").toString());	            //SAP과 연결 키 -유일키
                mst.setBuCd("2000");		                                        //회사코드
                mst.setSysCd("IFC");												//시스템코드
                mst.setFiscalSlipNum(parameter.get("fiscalSlipNum").toString());    //회계전표번호
                mst.setFiscalYear(parameter.get("fiscalYear").toString());			//회계전도
                mst.setPeriodDate(parameter.get("buySlipDate").toString());	        //전기일 - 매입전표일자
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

                mst.setWriteEmpNum(parameter.get("slipPublisher").toString());		//작성사원부서 : 로그인사번
                mst.setWriteEmpDept(parameter.get("empDept").toString());			//작성사원부서


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
//                parameter.put("slipStatus", "10");	  //전표상태(등록)
//                procCnt += gdspaymMstDAO.cancelFiscalSlip(parameter);

                RecordSet slitrs = gdspaymMstDAO.selectChkSlitCnt(parameter);
                logger.info("cnt ::"+slitrs.get(0).getInt("cnt") );
                if ( slitrs.get(0).getInt("cnt") ==  0 )	  //전표생성 단계가 없으면 po후 생태 N로 업데이트
                {
                    parameter.put("poAfterstatus", "N");
                    procCnt += poOrderMstDAO.updatePoAfterstatus(parameter);
                }

                Map<String, Object> paramMap = new HashMap<String, Object>();
                paramMap.put("slipNum", parameter.get("slipNum").toString());
                paramMap.put("slipStatus", "B");
                paramMap.put("buCd", "2000");
                paramMap.put("resultMsg", "취소");
                paramMap.put("workClass", "물품대금 수입 취소");
                ftSapInterfaceDAO.update(paramMap);
            }
        }
        return procCnt;
    }

    /**
     * 물품대금 삭제
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @see com.hwfs.ft.ftp.service.GdspaymMstService#deleteGdspaymList(java.util.Map)
    */
    @Override
    @SuppressWarnings("unchecked")
    public int deleteGdspaymList(LoginDTO loginParameter, DataSetMap search, DataSetMap dsGdspaymList ) throws Exception {
        int procCnt = 0;

        if ( dsGdspaymList.size() > 0 ) {
            for (int i = 0 ; i < dsGdspaymList.size() ; i++) {
                Map<String, Object> parameter = dsGdspaymList.get(i);
                procCnt += gdspaymMstDAO.delete( parameter );
            }
        }

        return procCnt;
    }

    /**
     * 물품대금 마스터(내수) 관리 목록을 조회한다.
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
    public RecordSet selectList2(Map<String, Object> mapParam) throws Exception {
        return gdspaymMstDAO.selectList2(mapParam);
    }

    /**
     * 물품대금 마스터(내수) 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
    public int saveList2(DataSetMap list) throws Exception {
        int insRowCnt = 0;
        int updRowCnt = 0;
        int delRowCnt = 0;

        for (int i = 0 ; i < list.size() ; i++) {
            Map<String, Object> rowData = list.get(i);
            int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            rowData.put("slipStatus", "10");	//전표 등록
            //Update 처리

            logger.info(rowData.get("elctnTaxBillNum")+"//////elctnTaxBillNum//////"+rowData.get("orgElctnTaxBillNum"));
            if ( rowType == DataSet.ROW_TYPE_INSERTED || !rowData.get("elctnTaxBillNum").equals(rowData.get("orgElctnTaxBillNum")))		//신규,세금계산서번호가 변경될시 중복 체크
            {
                rowData.put("taxBillNum", LimsUtil.checkNull(rowData.get("elctnTaxBillNum")));
                int chkCnt = freezeWhCommMgmtDAO.selectTaxBillNum(rowData);
                if (chkCnt > 0) {
                    throw new BizException("중복된 국세청승인번호가 존재합니다.");
                }
            }

            if (rowType == DataSet.ROW_TYPE_UPDATED)
            {
                if ( "".equals(LimsUtil.checkNull(rowData.get("seq"),"")) )
                {
                    logger.info("####insert####");
                    int maxSeq = gdspaymMstDAO.getMaxSeq(rowData);
                    logger.info("maxSeq :"+maxSeq+"// elctnTaxBillNum :"+rowData.get("elctnTaxBillNum"));
                    rowData.put("seq", maxSeq);
                    insRowCnt += gdspaymMstDAO.insert(rowData);
                }
                else
                {
                    logger.info("####update#### seq :"+rowData.get("seq"));

                    updRowCnt += gdspaymMstDAO.update(rowData);
                }
            }
        }

        return insRowCnt + updRowCnt + delRowCnt;
    }

    /**
     * createDmtFiscalSlip 설명
     * <pre>
     * 회계전표 IF 버튼 클릭시 SAP
     * </pre>
     *
     * @param parameter
     * @return
     * @see com.hwfs.ft.fgp.dao.GdspaymMstDAO.createDmtFiscalSlip
    */
    @Override
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> createDmtFiscalSlip(LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap dsGdspaymList
            ) throws Exception  {
        int procCnt = 0;
        List<Map<String, Object>> topListMap = new ArrayList();
        Map<String, Object> topMap = new HashMap ();
        ArrayList slipNums = new ArrayList();
        String draft = search.get(0).get("draft").toString();	//상신,전표처리 구분
        logger.info("draft :"+draft);

        logger.info( "flag  ::::"+search.get(0).get("flag")+"//"+search.get(0).get("fiscalFlag") );

        //PO 후상태 - PO 확정이후의 상태(수입은 매입전표생성) Y를 UPDATE하고 확정취소 불가 처리
        if ( dsGdspaymList.size() > 0 ) {
//            saveList(dsGdspaymList);	//저장 후
            for (int i = 0 ; i < dsGdspaymList.size() ; i++) {
                Map<String, Object> rowData = dsGdspaymList.get(i);
                int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

                logger.info("orgPoOrderNum :"+rowData.get("orgPoOrderNum"));
                logger.info("seq :"+rowData.get("seq"));

                logger.info(rowData.get("elctnTaxBillNum")+"//////elctnTaxBillNum//////"+rowData.get("orgElctnTaxBillNum"));
                if ( rowType == DataSet.ROW_TYPE_INSERTED || !rowData.get("elctnTaxBillNum").equals(rowData.get("orgElctnTaxBillNum")))		//신규,세금계산서번호가 변경될시 중복 체크
                {

                    rowData.put("taxBillNum", LimsUtil.checkNull(rowData.get("elctnTaxBillNum")));
                    int chkCnt = freezeWhCommMgmtDAO.selectTaxBillNum(rowData);
                    if (chkCnt > 0) {
                        throw new BizException("중복된 국세청승인번호가 존재합니다.");
                    }
                }

                String payCondSeq = LimsUtil.checkNull(rowData.get("payCondSeq"),"");
                //Update 처리
                if (rowType == DataSet.ROW_TYPE_UPDATED && "1".equals(rowData.get("chk")))
                {
                    logger.info("seq :"+LimsUtil.checkNull(rowData.get("seq"),""));
                    if ( "".equals(LimsUtil.checkNull(rowData.get("seq"),"")) )
                    {
                        logger.info("####insert####");
                        rowData.put("slipStatus", "10");	//전표 등록
                        int maxSeq = gdspaymMstDAO.getMaxSeq(rowData);
                        logger.info("maxSeq :"+maxSeq);
                        logger.info("payCondSeq :"+payCondSeq);
                        rowData.put("seq", payCondSeq);

                        procCnt += gdspaymMstDAO.insert(rowData);
                    }
                    else
                    {
                        logger.info("####update2####");
                        procCnt += gdspaymMstDAO.update(rowData);
                    }

                }
            }

            Map<String, Object> paramMap = new HashMap<String, Object>();
            for (int i = 0 ; i < dsGdspaymList.size() ; i++) {
                Map<String, Object> parameter = dsGdspaymList.get(i);

                int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
                if (rowType == DataSet.ROW_TYPE_UPDATED && "1".equals(LimsUtil.checkNull(parameter.get("chk"),"")))
                {
                    //sap모듈 호출후 성공하면후 하단 로직 처리
                    String currYymmdd = LimsUtil.getDate("yyyyMMddHHmmss");
                    SlipMstDTO mst = new SlipMstDTO();


                    //마스터 생성
                    String slipNum = LimsUtil.checkNull(parameter.get("slipNum"),"").toString();
                    String slipStatus = LimsUtil.checkNull(parameter.get("slipStatus"),"").toString();
                    logger.info("slipNum :"+slipNum+"// slipStatus:"+slipStatus);
                    if ( "".equals(slipNum) || "Z".equals(slipStatus) || "R".equals(slipStatus) || "E".equals(slipStatus) || "C".equals(slipStatus))	//신규 이거나 취소, 에러시 전표번호 생성
                    {
                        slipNum = poOrderMstDAO.selectSlipNum(parameter);

                    }
                    logger.info("slipNum111 :"+slipNum);
                    slipNums.add(i, slipNum);

                    mst.setSlipNum(slipNum);	            ///SAP과 연결 키 -유일키
                    mst.setBuCd("2000");		            //회사코드
                    mst.setSlipType("7K");	            //전표유형

                    String billPublishdd = LimsUtil.checkNull(parameter.get("billPublishdd"),"").toString();			//세금계산서 발행일

                    logger.info("setSlipEvidenceDate :"+parameter.get("billPublishdd").toString());
                    logger.info("setSlipPeriodDate :"+parameter.get("buySlipDate").toString());

                    //매입전표일자 - 전기일 -2015-10-21
                    // 계산서발행일 - 증빙일 - 2015-10-16
//                    mst.setSlipEvidenceDate(parameter.get("buySlipDate").toString());	//전표증빙일자 - 계산서발행일	10/14, 계산서발행일 - 증빙일 - 2015-10-16 billPublishdd
//                    mst.setSlipPeriodDate(parameter.get("billPublishdd").toString());	//전표전기일자 - 매입전표일자	10/05, 매입전표일자 - 전기일 -2015-10-21  buySlipDate
                    mst.setSlipEvidenceDate(parameter.get("billPublishdd").toString());	//전표증빙일자 - 계산서발행일	10/14, 계산서발행일 - 증빙일 - 2015-10-16 billPublishdd
                    mst.setSlipPeriodDate(parameter.get("buySlipDate").toString());	//전표전기일자 - 매입전표일자	10/05, 매입전표일자 - 전기일 -2015-10-21  buySlipDate
                    mst.setCurrency("KRW");				//통화

                    mst.setElctntaxBillApprvnum(parameter.get("elctnTaxBillNum").toString());	//전자세금계산서승인번호
                    if ( !"".equals(LimsUtil.checkNull(parameter.get("elctnTaxBillNum"),"").toString()))		//세금계산서발행건 일때 순발행 세팅 20151026 고영범
                    {
                        mst.setPublishClass("F");											//발행구분 F:순발행, B:역발행
                    }

                    logger.info("currYymmdd :"+currYymmdd);
                    mst.setInputDate(currYymmdd.substring(0,8));			//입력일자
                    mst.setInputTime(currYymmdd.substring(8));			//입력시간 -6자리
                    mst.setWriteEmpSabun(parameter.get("slipPublisher").toString());	//작성사원부서 : 로그인사번
                    mst.setWriteEmpDept(parameter.get("empDept").toString());		//작성사원부서
                    mst.setWriteEmpMuCd(parameter.get("empMuCd").toString());
                    mst.setSysCd("IFC");											//시스템코드
                    mst.setElctnSignId(LimsUtil.checkNull(parameter.get("signInstanceId"),"").toString());			 						//전자결재ID - 임시세팅
                    mst.setSignStatus(LimsUtil.checkNull(parameter.get("signProgressStatus"),"").toString());								//전표상태 - 임시세팅
                    mst.setSignType("1");	//결재유형:G/W 결재
                    mst.setSlipText("물품대금(내수) 전표 ["+loginParameter.getDeptNm()+"]");	  //(ex)상품권 청구 [FC외식사업지원팀]

                    if ( "Y".equals(draft))	  //상신
                    {
                        mst.setPistat("9");
                    }

                    List<SlipMstDTO> master = new ArrayList<SlipMstDTO>();
                    master.add(mst);

                    SlipMstList mstList = new SlipMstList();
                    mstList.setDataList(master);

                    int ii = 1;
                    List<SlipDtlDTO> detail = new ArrayList<SlipDtlDTO>();
                    long totCrAmt = 0;
                    //차변 만들기 : 상품_일반상품
                    SlipDtlDTO dtl11 = new SlipDtlDTO();	  //
                    dtl11.setSlipNum(slipNum);	            ///SAP과 연결 키 -유일키
                    dtl11.setBuCd("2000");
                    dtl11.setSlipType("7K");	            //전표유형

//                    dtl11.setSlipEvidenceDate(parameter.get("buySlipDate").toString());	//전표증빙일자 - 계산서발행일
//                    dtl11.setSlipPeriodDate(parameter.get("billPublishdd").toString());	//전표전기일자 - 매입전표일자
                    dtl11.setSlipEvidenceDate(parameter.get("billPublishdd").toString());	//전표증빙일자 - 계산서발행일	10/14, 계산서발행일 - 증빙일 - 2015-10-16 billPublishdd
                    dtl11.setSlipPeriodDate(parameter.get("buySlipDate").toString());	//전표전기일자 - 매입전표일자	10/05, 매입전표일자 - 전기일 -2015-10-21  buySlipDate


                    dtl11.setExpireCalBasisDate(LimsUtil.checkNull(parameter.get("paySchdDate")));	//통관예정일 +3개월 = 입금예정일 ->지불예정일

                    dtl11.setDtlNum(new BigDecimal(ii++)); 	//회계 전표의 개별 항목 번호
                    
                    //1:차변
                    dtl11.setMasterAcct("11401010");		//상품_일반상품				
                    
                    dtl11.setDrCrClass("1");				//1:차변
                    long signAmt = Long.parseLong(parameter.get("signAmt").toString());
                    Long supplyPrice = Long.parseLong(parameter.get("supplyPrice").toString());	//공급가액
                    if ( "-".equals(search.get(0).get("fiscalFlag")) )
                    {
                        signAmt = -signAmt;
                    }
                    
                    if ( "Y".equalsIgnoreCase(parameter.get("taxYn").toString()) ) {	// 과세품목
                    	dtl11.setSlipCurrencyAmt(BigDecimal.valueOf(supplyPrice));	//공급가액
                    } else {	// 면세품목
                    	dtl11.setSlipCurrencyAmt(BigDecimal.valueOf(signAmt));	//결재금액
                    }
                    logger.info("vatClassCd :"+parameter.get("vatClassCd").toString());
                    String remarks = LimsUtil.checkNull(parameter.get("remarks2"));
                    if ( "70".equals(parameter.get("vatClassCd").toString() ) || "75".equals(parameter.get("vatClassCd").toString() )  )	  //불공제공제시
                    {
                        remarks = remarks+" (불공제)";
                    }
                    dtl11.setItemText(remarks);			//품목텍스트 - 적요2
                    dtl11.setVatCd( parameter.get("vatClassCd").toString() );				//부가가치세 코드
                    dtl11.setAttachDept(parameter.get("attachDeptSap").toString());		//귀속부서
                    dtl11.setMgmtDept(parameter.get("attachDeptSap").toString());		//관리부서-귀속부서와 동일
                    dtl11.setAssignNum( "" );	//지정 미착 : 없음
                    
                    if ( "Y".equalsIgnoreCase(parameter.get("taxYn").toString()) ) {	// 과세품목;공급가액
                    	totCrAmt = totCrAmt+ supplyPrice;
                    } else {		// 면세품목; 결재금액 
                    	totCrAmt = totCrAmt+ signAmt;
                    }
                    detail.add(dtl11);

                    //차변 만들기-2 : 매입부가세
                    SlipDtlDTO dtl12 = new SlipDtlDTO();
                    dtl12.setSlipNum(slipNum);	                                                    //SAP과 연결 키 -유일키
                    dtl12.setBuCd("2000");					                                        //회사 코드
                    dtl12.setSlipType("7K");	            	                                        //전표유형

//                    dtl12.setSlipEvidenceDate(parameter.get("buySlipDate").toString());	            //전표증빙일자 - 매입전표일자
//                    dtl12.setSlipPeriodDate(parameter.get("paySchdDate").toString());	            //전표전기일자 - 매입전표일자
//                    if ( "".equals(billPublishdd))	//세금계산서 발행건이 아니면 전표발행일로
//                    {
//                        dtl12.setSlipEvidenceDate(parameter.get("buySlipDate").toString());	//전표증빙일자 - 매입전표일자
//                    }
//                    else
//                    {
//                        dtl12.setSlipEvidenceDate(billPublishdd);	//전표증빙일자 - 세금계산서 발행일
//                    }

//                    dtl12.setSlipEvidenceDate(parameter.get("buySlipDate").toString());	//전표증빙일자 - 계산서발행일
//                    dtl12.setSlipPeriodDate(parameter.get("billPublishdd").toString());	//전표전기일자 - 매입전표일자
                    dtl12.setSlipEvidenceDate(parameter.get("billPublishdd").toString());	//전표증빙일자 - 계산서발행일	10/14, 계산서발행일 - 증빙일 - 2015-10-16 billPublishdd
                    dtl12.setSlipPeriodDate(parameter.get("buySlipDate").toString());	//전표전기일자 - 매입전표일자	10/05, 매입전표일자 - 전기일 -2015-10-21  buySlipDate

                    dtl12.setExpireCalBasisDate(LimsUtil.checkNull(parameter.get("paySchdDate")));	//통관예정일 +3개월 = 입금예정일 ->지불예정일


                    dtl12.setDtlNum(BigDecimal.valueOf(ii++)); 	                                        //회계 전표의 개별 항목 번호
                    String vatClassCd = parameter.get("vatClassCd").toString();
                    logger.info("vatClassCd :"+vatClassCd);
//                    dtl12.setMasterAcct("11503000");			                                        //매입부가세
                    dtl12.setDrCrClass("1");					                                        //1:차변

//                        supplyPrice = Long.parseLong(parameter.get("supplyPrice").toString());
                    Long vatAmt = Long.parseLong(parameter.get("vatAmt").toString());
                    if ( "-".equals(search.get(0).get("fiscalFlag")) )	//-전표처리시 금액만 -
                    {
                        vatAmt = -vatAmt;
                    }

logger.info("supplyPrice :::"+supplyPrice+"////"+vatAmt+"////"+vatClassCd);
//					BigDecimal slipCurrencyAmt =  dtl12.getSlipCurrencyAmt();

                    //if ( "70".equals(vatClassCd) || "75".equals(vatClassCd) )	//전자일반매입,수기일반매입
//                    if ( !"70".equals(vatClassCd) && !"75".equals(vatClassCd)  )	  //불공제공제시 대변에 부가세행 더하지 않는다 SAP에서 SKIP
//                    {
//                        logger.info("totCrAmt :::"+totCrAmt+"="+totCrAmt);
//                    }

                    if ( "50".equals(vatClassCd) || "52".equals(vatClassCd)  )	  //전자일반 자산매입 :매입부가세 가계정
                    {
                         dtl12.setMasterAcct("11503000");	//매입부가세
                    }
                    else
                    {
                        dtl12.setMasterAcct("90007010");	//매입부가세 가계정
                    }

                    if ( !"70".equals(vatClassCd) && !"75".equals(vatClassCd)  )	  //불공제공제시 대변에 부가세행 더하지 않는다 SAP에서 SKIP
                    {
                        totCrAmt = totCrAmt+ vatAmt;
                        logger.info("totCrAmt2 :::"+totCrAmt+"+"+vatAmt+"="+totCrAmt);
                        dtl12.setSlipCurrencyAmt( BigDecimal.valueOf(vatAmt) );					//전표통화금액 :결재금액
                    }
                    else	//불공제
                    {
                        dtl12.setSlipCurrencyAmt( null);					//전표통화금액 :결재금액
                    }


                    dtl12.setStdAmt( BigDecimal.valueOf(supplyPrice) );					//공급가액
                    dtl12.setTaxAmt( BigDecimal.valueOf(vatAmt) );							//세액(전표 통화)
                    dtl12.setItemText(remarks);			                //품목텍스트 - 적요2
                    dtl12.setVatCd( parameter.get("vatClassCd").toString() );				//부가가치세 코드
                    dtl12.setUpjang( parameter.get("subUpjangNum").toString() );			//AP거래처 : 신고업장:종사업자번호
                    dtl12.setSupplyplceNum( parameter.get("splrCd").toString() );			//AP거래처 : 매입처

                    //관리항목 필수(문의필요)
                    dtl12.setMgmtArticle( parameter.get("splrCd").toString() );			//관리항목 : 거래처: 확인필요 :매입처

                    dtl12.setAttachDept(parameter.get("attachDeptSap").toString());		                //귀속부서
                    dtl12.setMgmtDept(parameter.get("attachDeptSap").toString());		                //관리부서-귀속부서와 동일
                    dtl12.setAssignNum( "" );	//지정 매입부가세 : 없음
                    detail.add(dtl12);

                    //대변 계정만들기 : 외상매입금_거래처
                    SlipDtlDTO dtl21 = new SlipDtlDTO();
                    dtl21.setSlipNum(slipNum);	                                                    //SAP과 연결 키 -유일키
                    dtl21.setBuCd("2000");					                                        //회사 코드
                    dtl21.setSlipType("7K");	            	                                    //전표유형

//                    dtl21.setSlipEvidenceDate(parameter.get("buySlipDate").toString());	        //전표증빙일자 - 매입전표일자
//                    dtl21.setSlipPeriodDate(parameter.get("paySchdDate").toString());	            //전표전기일자 - 매입전표일자

                    if ( "".equals(billPublishdd))	//세금계산서 발행건이 아니면 전표발행일로
                    {
                        dtl21.setSlipEvidenceDate(parameter.get("buySlipDate").toString());	//전표증빙일자 - 매입전표일자
                    }
                    else
                    {
                        dtl21.setSlipEvidenceDate(billPublishdd);	//전표증빙일자 - 세금계산서 발행일
                    }

                    dtl21.setSlipEvidenceDate(parameter.get("buySlipDate").toString());	//전표증빙일자 - 계산서발행일	10/14
                    dtl21.setSlipPeriodDate(parameter.get("buySlipDate").toString());	//전표전기일자 - 매입전표일자	10/05
                    dtl21.setExpireCalBasisDate(LimsUtil.checkNull(parameter.get("paySchdDate")));	//통관예정일 +3개월 = 입금예정일 ->지불예정일

                    dtl21.setDtlNum(BigDecimal.valueOf(ii++)); 	                                //회계 전표의 개별 항목 번호
                    dtl21.setMasterAcct("21101010");			                                    //외상매입금_거래처
                    dtl21.setDrCrClass("2");					                                    //2:대변

                    if ( "-".equals(search.get(0).get("fiscalFlag")) )
                    {
                        totCrAmt = -totCrAmt;
                    }

                    logger.info("totCrAmt :::"+totCrAmt);

                    dtl21.setSlipCurrencyAmt( BigDecimal.valueOf(totCrAmt) );					//전표통화금액 :결재금액
                    dtl21.setItemText(remarks);			                //품목텍스트 - 적요2
                    dtl21.setVatCd( parameter.get("vatClassCd").toString() );				//부가가치세 코드
                    dtl21.setAttachDept(parameter.get("attachDeptSap").toString());		                //귀속부서
                    dtl21.setMgmtDept(parameter.get("attachDeptSap").toString());		                //관리부서-귀속부서와 동일
                    dtl21.setPayCond("F000");		            //지불조건 : 환율(외화)정보 있으면 : E000 나머지 : F000
                    dtl21.setSupplyplceNum( parameter.get("splrCd").toString() );				//AP거래처 : 매입처.
                    dtl21.setAssignNum( parameter.get("paySchdDate").toString().substring(0,6) );												//지정 : 외상매입금 거래처:년월
                    dtl21.setReasonCd( "A00" );												//사유코드: A00:발생

                    String snglfootlstNmYn = (LimsUtil.checkNull(parameter.get("snglfootlstNmYn")).equals("1")?"X":"");
//                    dtl21.setSinglePayYn(snglfootlstNmYn);	// 단발성여부
                    logger.info("snglfootlstNmYn :"+snglfootlstNmYn+"//"+parameter.get("bankAcctNoEnc")+"//"+parameter.get("bankAcctOwnr")+"//"+parameter.get("bankCd")+"//"+parameter.get("splrNm"));
                    // 단발성이면...
                    if (snglfootlstNmYn.equals("X")) {
                        dtl21.setTempCustNm("");	// 공급자명
                    }

                    dtl21.setBankAcctNo(LimsUtil.checkNull(parameter.get("bankAcctNoEnc")));	// 공급자 계좌번호 - 암호화된 계좌번호
                    dtl21.setBankAcctOwnr(LimsUtil.checkNull(parameter.get("bankAcctOwnr")));	// 공급자 예금주
                    dtl21.setBankCd(LimsUtil.checkNull(parameter.get("bankCd")));	// 공급자 은행코드
                    dtl21.setCrgleftClass(LimsUtil.checkNull(parameter.get("bankType")));	// 계좌구분코드(Bank type)

                    detail.add(dtl21);

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


                    //1.전표상태 등록 update
                    parameter.put("slipNum", slipNum);	            ///SAP과 연결 키 -유일키
                    parameter.put("slipStatus", "20");	  //전표상태(생성)
                    if ( !"Y".equals(draft))	  //전표처리시
                    {
                        parameter.put("nonarrivSlipCreationYn", "Y");	//미착등록
                    }
                    procCnt += gdspaymMstDAO.createDmtFiscalSlip(parameter);

                    //2.PO후 상태 Y 업데이트
                    parameter.put("poAfterstatus", "Y");	  //PO 후상태 - PO 확정이후의 상태(수입은 매입전표생성) Y를 UPDATE하고 확정취소 불가 처리
                    procCnt += poOrderMstDAO.updatePoAfterstatus(parameter);

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
                    paramMap.put("slipNum", slipNum);
                    paramMap.put("buCd", "2000");
                    paramMap.put("workClass", "물품대금 내수");

                    RecordSet fsiRs = ftSapInterfaceDAO.selectList(paramMap);
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
                        ftSapInterfaceDAO.updateSignInstanceId(parameter);	  //전자결재 아이디 update
                    }
                }
            }
        }

        topMap.put("slipNums", slipNums);	//구매품의 번호 전달
        topMap.put("procCnt", procCnt);	  //실행건 전달
        topListMap.add (topMap);

        return topListMap;
    }

    /**
     * cancelDmtFiscalSlip 설명
     * <pre>
     * 회계전표 IF 취소 버튼 클릭시 SAP
     * </pre>
     *
     * @param parameter
     * @return
     * @see com.hwfs.ft.fgp.dao.GdspaymMstDAO.cancelDmtFiscalSlip
    */
    @Override
    @SuppressWarnings("unchecked")
    public int cancelDmtFiscalSlip(LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap dsGdspaymList
            ) throws Exception  {
        int procCnt = 0;

        //PO 후상태 - PO 확정이후의 상태(수입은 매입전표생성) Y를 UPDATE하고 확정취소 불가 처리
        if ( dsGdspaymList.size() > 0 ) {
            for (int i = 0 ; i < dsGdspaymList.size() ; i++) {
                Map<String, Object> parameter = dsGdspaymList.get(i);

                if ( "1".equals(LimsUtil.checkNull(parameter.get("chk"),"")) )
                {

                    //sap모듈 호출후 성공하면후 하단 로직 처리
                    String currYymmdd = LimsUtil.getDate("yyyyMMddHHmmss");
                    SlipCancelDTO mst = new SlipCancelDTO();
                    mst.setSlipNum(parameter.get("fiscalSlipNum").toString());	            //SAP과 연결 키 -유일키
                    mst.setBuCd("2000");		                                        //회사코드
                    mst.setSysCd("IFC");												//시스템코드
                    mst.setFiscalSlipNum(parameter.get("fiscalSlipNum").toString());    //회계전표번호
                    mst.setFiscalYear(parameter.get("fiscalYear").toString());			//회계전도
                    mst.setPeriodDate(parameter.get("buySlipDate").toString());	        //전기일 - 매입전표일자
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
                    mst.setWriteEmpNum(parameter.get("slipPublisher").toString());	//작성사원부서 : 로그인사번
                    mst.setWriteEmpDept(parameter.get("empDept").toString());		//작성사원부서


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

                    RecordSet rs = gdspaymMstDAO.selectChkCancelInfo(parameter);
                    //전표 I/F 취소는 매입대금결제일과, 결제환율,결제금액이 공백일 때만 가능하다.
                    String buyPaymSettledd = LimsUtil.checkNull(rs.get(0).getString("buyPaymSettledd"),"");
                    String settleExchangeRate = LimsUtil.checkNull(rs.get(0).getString("settleExchangeRate"),"");
                    String signAmt = LimsUtil.checkNull(rs.get(0).getString("signAmt"),"");
                    logger.info("buyPaymSettledd :::"+buyPaymSettledd+"//"+settleExchangeRate+"//"+signAmt);
//                    if ( "".equals(buyPaymSettledd) &&  "".equals(settleExchangeRate) &&  "".equals(signAmt)  )
//                    {
//                        logger.info("####1");
//                        //sap모듈 취소후 성공하면후 하단 로직 처리
//
//                        parameter.put("slipStatus", "10");	  //전표상태(등록)
//                        procCnt += gdspaymMstDAO.cancelDmtFiscalSlip(parameter);
//
//                    }
//                    else
//                    {
//                        logger.info("####2");
//                        throw processException("ft.fgp.fail.gdspaym");	//전표 확정상태에서는 전표 I/F 취소가 불가합니다.
//                    }

                    RecordSet slitrs = gdspaymMstDAO.selectChkSlitCnt(parameter);
                    logger.info("cnt ::"+slitrs.get(0).getInt("cnt") );
                    if ( slitrs.get(0).getInt("cnt") ==  0 )	  //전표생성 단계가 없으면 po후 생태 N로 업데이트
                    {
                        parameter.put("poAfterstatus", "N");
                        procCnt += poOrderMstDAO.updatePoAfterstatus(parameter);
                    }

                    Map<String, Object> paramMap = new HashMap<String, Object>();
                    paramMap.put("slipNum", parameter.get("fiscalSlipNum").toString());
                    paramMap.put("slipStatus", "B");
                    paramMap.put("buCd", "2000");
                    paramMap.put("resultMsg", "취소");
                    paramMap.put("workClass", "물품대금 내수 취소");
                    ftSapInterfaceDAO.update(paramMap);
                }
            }
        }
        return procCnt;
    }

    /**
     * createMinusDmtFiscalSlipIf 설명
     * <pre>
     * 회계전표 IF 버튼 클릭시 SAP
     * </pre>
     *
     * @param parameter
     * @return
     * @see com.hwfs.ft.fgp.dao.GdspaymMstDAO.createMinusDmtFiscalSlipIf
    */
    @Override
    @SuppressWarnings("unchecked")
    public int createMinusDmtFiscalSlipIf(LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap dsGdspaymList
            ) throws Exception  {
        int procCnt = 0;

        logger.info( "flag  ::::"+search.get(0).get("flag") );



        //PO 후상태 - PO 확정이후의 상태(수입은 매입전표생성) Y를 UPDATE하고 확정취소 불가 처리
        if ( dsGdspaymList.size() > 0 ) {
            logger.info("####1");
        }

        return procCnt;
    }

    /**
     * cancelDmtFiscalSlip 설명
     * <pre>
     * 회계전표 IF 취소- 버튼 클릭시 SAP
     * </pre>
     *
     * @param parameter
     * @return
     * @see com.hwfs.ft.fgp.dao.GdspaymMstDAO.cancelMinusDmtFiscalSlipIf
    */
    @Override
    @SuppressWarnings("unchecked")
    public int cancelMinusDmtFiscalSlipIf(LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap dsGdspaymList
            ) throws Exception  {
        int procCnt = 0;

        //PO 후상태 - PO 확정이후의 상태(수입은 매입전표생성) Y를 UPDATE하고 확정취소 불가 처리
        if ( dsGdspaymList.size() > 0 ) {
            for (int i = 0 ; i < dsGdspaymList.size() ; i++) {

            }
        }
        return procCnt;
    }

    /**
     * 과세유형 가져오기
     * <pre>
     * 구매 품의 마스터 시퀀스을 조회한다.
     * </pre>
     *
     * @param inVar
     * @return PgmAuthDTO
     * @throws Exception
     */
    @Override
    public Record getVatClassCd(Map<String, Object> inVar)
            throws Exception {
        return gdspaymMstDAO.getVatClassCd(inVar);	//TODO 추후 작업
    }
}
