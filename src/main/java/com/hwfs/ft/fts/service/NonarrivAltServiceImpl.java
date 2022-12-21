package com.hwfs.ft.fts.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.math.BigDecimal;
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
import com.hwfs.ft.fdm.dao.InventoryMgmtDeliverDAO;
import com.hwfs.ft.fsi.dao.FtSapInterfaceDAO;
import com.hwfs.ft.ftp.dao.PoOrderMstDAO;
import com.hwfs.ft.fts.dao.NonarrivAltDAO;
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
import com.tobesoft.xplatform.data.DataSet;

/**
 * 미착대체 ServiceImple Class
 *
 * @ClassName NonarrivAltServiceImple.java
 * @Description NonarrivAltServiceImple Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 06. 12.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : jshoon
 * @since 2015. 06. 12.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ft/fts/nonarrivAltService")
public class NonarrivAltServiceImpl extends DefaultServiceImpl implements NonarrivAltService {

    /** LogService */
    private final Logger logger = LoggerFactory.getLogger (this.getClass());

    @Resource(name = "/ft/fts/nonarrivAltDAO")
    private NonarrivAltDAO nonarrivAltDAO;

    /** PoOrderMstDAO Bean 생성 */
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

    /** InventoryMgmtDeliverDAO Bean 생성 */
    @Resource(name = "/ft/fdm/inventoryMgmtDeliverDAO")
    private InventoryMgmtDeliverDAO inventoryMgmtDeliverDAO;


    /**
     * PO목록을 조회한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.fts.service.NonarrivAltService#selectList(java.util.Map)
    */
    @Override
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return nonarrivAltDAO.selectList(parameter);
    }

    /**
     * PO상세 목록을 조회한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.fts.service.NonarrivAltService#selectDetailList(java.util.Map)
    */
    @Override
    public RecordSet selectDetailList(Map<String, Object> parameter) throws Exception {
        return nonarrivAltDAO.selectDetailList(parameter);
    }
    /**
     * PO상세 목록을 조회한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ft.fts.service.NonarrivAltService#selectDetailList(java.util.Map)
    */
    @Override
    public RecordSet selectDetailList2(Map<String, Object> parameter) throws Exception {
        return nonarrivAltDAO.selectDetailList2(parameter);
    }
    /**
     * 미착내역을 저장한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param param
     * @param testArticleList
     * @return
     * @throws Exception
     * @see com.hwfs.ft.fts.service.NonarrivAltService#saveList(java.util.Map, hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> saveList(Map<String, Object> param, DataSetMap detailList) throws Exception {
        int procCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;
        String strChk = "";

        for (int i = 0; i < detailList.size(); i++) {
            parameter = detailList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_UPDATED) {
                strChk = LimsUtil.checkNull(parameter.get("chk"));
                if ("1".equals(strChk)) {
                    if (LimsUtil.checkNull(parameter.get("detailGubun")).equals("PO")) {
                        procCnt += nonarrivAltDAO.updatePoList(parameter);
                    } else {
                        procCnt += nonarrivAltDAO.updateGpList(parameter);
                    }

                }
            }
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);

        return retVal;
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
            , DataSetMap detailList
            , DataSetMap detailList2
            ) throws Exception  {
        int procCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;
        String strChk = "";

        List<Map<String, Object>> topListMap = new ArrayList();
        Map<String, Object> topMap = new HashMap ();
        String draft = search.get(0).get("draft").toString();	//상신,전표처리 구분
        logger.info("draft :"+draft);
        ArrayList slipNums = new ArrayList();
        int slipCnt=0;

        //원물대
        if (detailList.size() > 0 )
        {
            String currYymmdd = LimsUtil.getDate("yyyyMMddHHmmss");
            SlipMstList mstList = new SlipMstList();
            SlipMstDTO mst = new SlipMstDTO();
            List<SlipMstDTO> master = new ArrayList<SlipMstDTO>();
            List<SlipDtlDTO> detail = new ArrayList<SlipDtlDTO>();
            
            //마스터 생성
            Map<String, Object> param = new HashMap<String, Object>();

            String slipNum = LimsUtil.checkNull(detailList.get(0).get("altFiscalSlipNum"),"").toString();
            String slipStatus = LimsUtil.checkNull(detailList.get(0).get("slipStatus"),"").toString();
            logger.info("slipNum :"+slipNum+"// slipStatus111:"+slipStatus+"//draft:"+draft);
    //      if (!"".equals(gSlipNum) && !"S".equals(slipStatus))	//신규 이거나 상태가 S
            if ( "".equals(slipNum) || "Z".equals(slipStatus) || "R".equals(slipStatus) || "E".equals(slipStatus) || "C".equals(slipStatus))	//신규 이거나 취소, 에러시 전표번호 생성
            {
                slipNum = poOrderMstDAO.selectSlipNum(param);
            }
            logger.info("slipNum111 :"+slipNum);
            slipNums.add(slipCnt++, slipNum);
            
            int firstCnt = 0;
            int ii = 0;
            
        	for (int i = 0; i < detailList.size(); i++) {
	            parameter = detailList.get(i);
	            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
	
	            if (rowType == DataSet.ROW_TYPE_UPDATED) {
	                strChk = LimsUtil.checkNull(parameter.get("chk"));
	                if ("1".equals(strChk)) {
	                	firstCnt++;
	                    parameter.put("slipNum", slipNum);
	                    if ( firstCnt == 1)	//마스터 만들기
	                    {
		                    mst.setSlipNum(slipNum);	            ///SAP과 연결 키 -유일키
		                    mst.setBuCd("2000");		            //회사코드
		                    mst.setSlipType("7M");	            //전표유형
		//                    mst.setSlipEvidenceDate(parameter.get("slipPublishDate").toString());	//전표증빙일자 - 매입전표일자
		//                    mst.setSlipPeriodDate(parameter.get("paySchdDate").toString());	//전표전기일자 - 매입전표일자
		                    mst.setSlipEvidenceDate(parameter.get("altSlipDate").toString());	//전표증빙일자 - 전표발행일		서영미: 수수료에 전표발행일	20151027
		                    mst.setSlipPeriodDate(parameter.get("altSlipDate").toString());	//전표전기일자 - 지불예정일자		서영미: 수수료에 전표전기일자
		                    mst.setCurrency("KRW");				//통화
		                	
		                	//                    mst.setElctntaxBillApprvnum(parameter.get("taxBillNum").toString());	//전자세금계산서승인번호	서영미:미착대체는 세금계산서와 상관없음 20151027
		                	
    	                    logger.info("currYymmdd :"+currYymmdd);
    	                    mst.setInputDate(currYymmdd.substring(0,8));			//입력일자
    	                    mst.setInputTime(currYymmdd.substring(8));			//입력시간 -6자리
    	                    mst.setWriteEmpSabun(loginParameter.getSabun());	//작성사원부서 : 로그인사번
    	                    mst.setWriteEmpDept(loginParameter.getDeptId());		//작성사원부서
    	                    mst.setWriteEmpMuCd(loginParameter.getMuCd());
    	                    mst.setSysCd("IFC");											//시스템코드
    	                    mst.setElctnSignId(LimsUtil.checkNull(parameter.get("signInstanceId"),"").toString());			 						//전자결재ID - 임시세팅
    	                    mst.setSignStatus(LimsUtil.checkNull(parameter.get("signProgressStatus"),"").toString());								//전표상태 - 임시세팅
    	                    mst.setSignType("1");	//결재유형:G/W 결재
    	                    mst.setSlipText("미착대체 전표 ["+loginParameter.getDeptNm()+"]");	  //(ex)상품권 청구 [FC외식사업지원팀]
    	                    if ( "Y".equals(draft))	  //상신
    	                    {
    	                        mst.setPistat("9");
    	                    }
    	                    master.add(mst);
    	                    mstList.setDataList(master);	
	                    }
	
	                    //차변 만들기 : 상품_일반상품
	                    SlipDtlDTO dtl11 = new SlipDtlDTO();	  //
	                    dtl11.setSlipNum(slipNum);	            ///SAP과 연결 키 -유일키
	                    dtl11.setBuCd("2000");
	                    dtl11.setSlipType("7M");	            //전표유형
	                    logger.info("signAmt :"+BigDecimal.valueOf(Double.parseDouble(parameter.get("signAmt").toString())));
	                    dtl11.setSlipCurrencyAmt( BigDecimal.valueOf(Double.parseDouble(parameter.get("signAmt").toString())) );					//전표통화금액 :결재금액
	
	//                    dtl11.setSlipEvidenceDate(parameter.get("slipPublishDate").toString());	//전표증빙일자 - 전표발행일
	//                    dtl11.setSlipPeriodDate(parameter.get("paySchdDate").toString());	//전표전기일자 - 지불예정일자
	//
	                    dtl11.setSlipEvidenceDate(parameter.get("altSlipDate").toString());	//전표증빙일자 - 전표발행일		서영미: 수수료에 전표발행일	20151027
	                    dtl11.setSlipPeriodDate(parameter.get("altSlipDate").toString());	//전표전기일자 - 지불예정일자		서영미: 수수료에 전표전기일자
	
	                    dtl11.setDtlNum(new BigDecimal(ii++)); 	//회계 전표의 개별 항목 번호
	                    
	                    dtl11.setMasterAcct("11401010");		//상품_일반상품
	                    
	                    dtl11.setDrCrClass("1");				//1:차변
	                    dtl11.setPayCond("F000");		            //지불조건 : 환율(외화)정보 있으면 : E000 나머지 : F000
	
	                    dtl11.setItemText(parameter.get("remarks1").toString());			//품목텍스트 - 적요2
	                    dtl11.setAttachDept(parameter.get("attachDeptSap").toString());		//귀속부서
	                    dtl11.setMgmtDept(parameter.get("attachDeptSap").toString());		//관리부서-귀속부서와 동일
	
	                    detail.add(dtl11);
	
	
	                    //대변 계정만들기 : 미착품
	                    if ( firstCnt == 1 )	//대변 만들기
                        {
	                    	
                        }
	                    SlipDtlDTO dtl21 = new SlipDtlDTO();
	                    dtl21.setSlipNum(slipNum);	            ///SAP과 연결 키 -유일키
	                    dtl21.setBuCd("2000");
	                    dtl21.setSlipType("7M");	            //전표유형
	                    dtl21.setMasterAcct("11404000");		//상품_미착품
	                    dtl21.setDrCrClass("2");				//2:대변
	//                    dtl21.setSlipEvidenceDate(parameter.get("paySchdDate").toString());	//전표증빙일자 - 매입전표일자
	//                    dtl21.setSlipPeriodDate(parameter.get("paySchdDate").toString());	//전표전기일자 - 지불예정일자
	
	                    dtl21.setSlipEvidenceDate(parameter.get("altSlipDate").toString());	//전표증빙일자 - 전표발행일		서영미: 수수료에 전표발행일	20151027
	                    dtl21.setSlipPeriodDate(parameter.get("altSlipDate").toString());	//전표전기일자 - 지불예정일자		서영미: 수수료에 전표전기일자
	
	                    dtl21.setAssignNum( parameter.get("poOrderNum").toString() );
	                    String remarks2 ="";
	
	                    String poType = parameter.get("poType").toString();
	                    logger.info("poType :"+poType);
	                    if ( "10".equals(poType))	//수입
	                    {
	                        dtl21.setPayCond("F000");		            //지불조건 : 환율(외화)정보 있으면 : E000 나머지 : F000
	                        double exchangeRate = Double.parseDouble(parameter.get("exchangeRate").toString());
	                        double payAmt = Double.parseDouble(parameter.get("signAmt").toString());
	
	
	                        String strSettleExchangeRate = LimsUtil.getCommaNumber(exchangeRate, "###,###,##0.00") ;
	                        String strPayAmt = LimsUtil.getCommaNumber(payAmt, "###,###,##0.00") ;
	                        logger.info("strSettleExchangeRate :"+strSettleExchangeRate +"// strPayAmt:"+ strPayAmt);
	                        remarks2 = parameter.get("amountUnit").toString()
	                                +" / "+strSettleExchangeRate
	                                +" / "+strPayAmt
	                                ;
	                        remarks2 = remarks2 +" / "+ parameter.get("remarks1").toString();
	                    }
	                    else
	                    {
	                        dtl21.setPayCond("E000");		            //지불조건 : 환율(외화)정보 있으면 : E000 나머지 : F000
	                        remarks2 = parameter.get("remarks1").toString();
	                    }
	                    logger.info("remarks2 :"+remarks2);
	                    logger.info("signAmt2 :"+BigDecimal.valueOf(Double.parseDouble(parameter.get("signAmt").toString())));
	
	                    dtl21.setSlipCurrencyAmt( BigDecimal.valueOf(Double.parseDouble(parameter.get("signAmt").toString())) );					//전표통화금액 :결재금액
	                    dtl21.setItemText(remarks2);			//품목텍스트 - 적요2
	                    dtl21.setLcNum(parameter.get("lcNum").toString());	//LC번호
	                    dtl21.setPoNum(parameter.get("poOrderNum").toString());	//PO번호
	                    dtl21.setAttachDept(parameter.get("attachDeptSap").toString());		//귀속부서
	                    dtl21.setMgmtDept(parameter.get("attachDeptSap").toString());		//관리부서-귀속부서와 동일
	                    //관리항목 필수(문의필요)
	                    dtl21.setMgmtArticle( parameter.get("blNum").toString() );			//관리항목 : bl번호
	                    dtl21.setBlDate(parameter.get("lshipDate").toString());	//BL일자 (선적일자로 쓴다.)
	
	                    dtl21.setLshipDate(parameter.get("lshipDate").toString());	//선적일자
	
	                    dtl21.setDtlNum(new BigDecimal(ii++)); 	//회계 전표의 개별 항목 번호
	
	                    detail.add(dtl21);
	                    
                        parameter.put("nonarrivSlipCreationYn", "Y");
                        procCnt += nonarrivAltDAO.updateEntryList(parameter);	                    
	
	                }
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

            //parameter.put("nonarrivSlipCreationYn", "Y");
            procCnt += nonarrivAltDAO.updateGpList(parameter);

            if ( "Y".equals(draft))	  //상신
            {
                logger.info("------------1");
                parameter.put("slipStatus", "9");	//상신
            }
            else
            {
                logger.info("------------2");
                parameter.put("slipStatus", "A");	//전표요청
            }
            parameter.put("slipNum", slipNum);
            parameter.put("buCd", "2000");
            parameter.put("workClass", "원물대 미착대체");

            RecordSet fsiRs = ftSapInterfaceDAO.selectList(parameter);
            if ( fsiRs.size() > 0)
            {
                ftSapInterfaceDAO.update(parameter);
            }
            else
            {
                ftSapInterfaceDAO.insert(parameter);
            }
            if ( !"Y".equals(draft))	  //상신
            {
                ftSapInterfaceDAO.updateSignInstanceId(parameter);	  //전자결재 아이디 update
            }
        	
/*        	
	        for (int i = 0; i < detailList.size(); i++) {
	            parameter = detailList.get(i);
	            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
	
	            if (rowType == DataSet.ROW_TYPE_UPDATED) {
	                strChk = LimsUtil.checkNull(parameter.get("chk"));
	                if ("1".equals(strChk)) {
	
	                    String currYymmdd = LimsUtil.getDate("yyyyMMddHHmmss");
	                    SlipMstDTO mst = new SlipMstDTO();
	
	                    //마스터 생성
	                    String slipNum = LimsUtil.checkNull(parameter.get("altFiscalSlipNum"),"").toString();
	                    String slipStatus = LimsUtil.checkNull(parameter.get("slipStatus"),"").toString();
	                    logger.info("slipNum :"+slipNum+"// slipStatus111:"+slipStatus+"//draft:"+draft);
	                    if ( "".equals(slipNum) || "Z".equals(slipStatus) || "R".equals(slipStatus) || "E".equals(slipStatus) || "C".equals(slipStatus))	//신규 이거나 취소, 에러시 전표번호 생성
	                    {
	                        slipNum = poOrderMstDAO.selectSlipNum(parameter);
	                    }
	
	                    logger.info("slipNum111 :"+slipNum);
	                    slipNums.add(slipCnt++, slipNum);
	
	                    parameter.put("slipNum", slipNum);
	                    mst.setSlipNum(slipNum);	            ///SAP과 연결 키 -유일키
	                    mst.setBuCd("2000");		            //회사코드
	                    mst.setSlipType("7M");	            //전표유형
	//                    mst.setSlipEvidenceDate(parameter.get("slipPublishDate").toString());	//전표증빙일자 - 매입전표일자
	//                    mst.setSlipPeriodDate(parameter.get("paySchdDate").toString());	//전표전기일자 - 매입전표일자
	                    mst.setSlipEvidenceDate(parameter.get("altSlipDate").toString());	//전표증빙일자 - 전표발행일		서영미: 수수료에 전표발행일	20151027
	                    mst.setSlipPeriodDate(parameter.get("altSlipDate").toString());	//전표전기일자 - 지불예정일자		서영미: 수수료에 전표전기일자
	
	                    mst.setCurrency("KRW");				//통화
	
	//                    mst.setElctntaxBillApprvnum(parameter.get("taxBillNum").toString());	//전자세금계산서승인번호	서영미:미착대체는 세금계산서와 상관없음 20151027
	
	                    logger.info("currYymmdd :"+currYymmdd);
	                    mst.setInputDate(currYymmdd.substring(0,8));			//입력일자
	                    mst.setInputTime(currYymmdd.substring(8));			//입력시간 -6자리
	                    mst.setWriteEmpSabun(loginParameter.getSabun());	//작성사원부서 : 로그인사번
	                    mst.setWriteEmpDept(loginParameter.getDeptId());		//작성사원부서
	                    mst.setWriteEmpMuCd(loginParameter.getMuCd());
	                    mst.setSysCd("IFC");											//시스템코드
	                    mst.setElctnSignId(LimsUtil.checkNull(parameter.get("signInstanceId"),"").toString());			 						//전자결재ID - 임시세팅
	                    mst.setSignStatus(LimsUtil.checkNull(parameter.get("signProgressStatus"),"").toString());								//전표상태 - 임시세팅
	                    mst.setSignType("1");	//결재유형:G/W 결재
	                    mst.setSlipText("미착대체 전표 ["+loginParameter.getDeptNm()+"]");	  //(ex)상품권 청구 [FC외식사업지원팀]
	                    if ( "Y".equals(draft))	  //상신
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
	                    dtl11.setSlipType("7M");	            //전표유형
	                    logger.info("signAmt :"+BigDecimal.valueOf(Double.parseDouble(parameter.get("signAmt").toString())));
	                    dtl11.setSlipCurrencyAmt( BigDecimal.valueOf(Double.parseDouble(parameter.get("signAmt").toString())) );					//전표통화금액 :결재금액
	
	//                    dtl11.setSlipEvidenceDate(parameter.get("slipPublishDate").toString());	//전표증빙일자 - 전표발행일
	//                    dtl11.setSlipPeriodDate(parameter.get("paySchdDate").toString());	//전표전기일자 - 지불예정일자
	//
	                    dtl11.setSlipEvidenceDate(parameter.get("altSlipDate").toString());	//전표증빙일자 - 전표발행일		서영미: 수수료에 전표발행일	20151027
	                    dtl11.setSlipPeriodDate(parameter.get("altSlipDate").toString());	//전표전기일자 - 지불예정일자		서영미: 수수료에 전표전기일자
	
	                    dtl11.setDtlNum(new BigDecimal(ii++)); 	//회계 전표의 개별 항목 번호
	                    dtl11.setMasterAcct("11401010");		//상품_일반상품
	                    dtl11.setDrCrClass("1");				//1:차변
	                    dtl11.setPayCond("F000");		            //지불조건 : 환율(외화)정보 있으면 : E000 나머지 : F000
	
	                    dtl11.setSlipCurrencyAmt( BigDecimal.valueOf(Double.parseDouble(parameter.get("signAmt").toString())) );					//전표통화금액 :결재금액
	                    dtl11.setItemText(parameter.get("remarks1").toString());			//품목텍스트 - 적요2
	                    dtl11.setAttachDept(parameter.get("attachDeptSap").toString());		//귀속부서
	                    dtl11.setMgmtDept(parameter.get("attachDeptSap").toString());		//관리부서-귀속부서와 동일
	
	                    detail.add(dtl11);
	
	
	                    //대변 계정만들기 : 미착품
	                    SlipDtlDTO dtl21 = new SlipDtlDTO();
	                    dtl21.setSlipNum(slipNum);	            ///SAP과 연결 키 -유일키
	                    dtl21.setBuCd("2000");
	                    dtl21.setSlipType("7M");	            //전표유형
	                    dtl21.setMasterAcct("11404000");		//상품_미착품
	                    dtl21.setDrCrClass("2");				//2:대변
	//                    dtl21.setSlipEvidenceDate(parameter.get("paySchdDate").toString());	//전표증빙일자 - 매입전표일자
	//                    dtl21.setSlipPeriodDate(parameter.get("paySchdDate").toString());	//전표전기일자 - 지불예정일자
	
	                    dtl21.setSlipEvidenceDate(parameter.get("altSlipDate").toString());	//전표증빙일자 - 전표발행일		서영미: 수수료에 전표발행일	20151027
	                    dtl21.setSlipPeriodDate(parameter.get("altSlipDate").toString());	//전표전기일자 - 지불예정일자		서영미: 수수료에 전표전기일자
	
	                    dtl21.setAssignNum( parameter.get("poOrderNum").toString() );
	                    String remarks2 ="";
	
	                    String poType = parameter.get("poType").toString();
	                    logger.info("poType :"+poType);
	                    if ( "10".equals(poType))	//수입
	                    {
	                        dtl21.setPayCond("F000");		            //지불조건 : 환율(외화)정보 있으면 : E000 나머지 : F000
	                        double exchangeRate = Double.parseDouble(parameter.get("exchangeRate").toString());
	                        double payAmt = Double.parseDouble(parameter.get("signAmt").toString());
	
	
	                        String strSettleExchangeRate = LimsUtil.getCommaNumber(exchangeRate, "###,###,##0.00") ;
	                        String strPayAmt = LimsUtil.getCommaNumber(payAmt, "###,###,##0.00") ;
	                        logger.info("strSettleExchangeRate :"+strSettleExchangeRate +"// strPayAmt:"+ strPayAmt);
	                        remarks2 = parameter.get("amountUnit").toString()
	                                +" / "+strSettleExchangeRate
	                                +" / "+strPayAmt
	                                ;
	                        remarks2 = remarks2 +" / "+ parameter.get("remarks1").toString();
	                    }
	                    else
	                    {
	                        dtl21.setPayCond("E000");		            //지불조건 : 환율(외화)정보 있으면 : E000 나머지 : F000
	                        remarks2 = parameter.get("remarks1").toString();
	                    }
	                    logger.info("remarks2 :"+remarks2);
	                    logger.info("signAmt2 :"+BigDecimal.valueOf(Double.parseDouble(parameter.get("signAmt").toString())));
	
	                    dtl21.setSlipCurrencyAmt( BigDecimal.valueOf(Double.parseDouble(parameter.get("signAmt").toString())) );					//전표통화금액 :결재금액
	                    dtl21.setItemText(remarks2);			//품목텍스트 - 적요2
	                    dtl21.setLcNum(parameter.get("lcNum").toString());	//LC번호
	                    dtl21.setPoNum(parameter.get("poOrderNum").toString());	//PO번호
	                    dtl21.setAttachDept(parameter.get("attachDeptSap").toString());		//귀속부서
	                    dtl21.setMgmtDept(parameter.get("attachDeptSap").toString());		//관리부서-귀속부서와 동일
	                    //관리항목 필수(문의필요)
	                    dtl21.setMgmtArticle( parameter.get("blNum").toString() );			//관리항목 : bl번호
	                    dtl21.setBlDate(parameter.get("lshipDate").toString());	//BL일자 (선적일자로 쓴다.)
	
	                    dtl21.setLshipDate(parameter.get("lshipDate").toString());	//선적일자
	
	                    dtl21.setDtlNum(new BigDecimal(ii++)); 	//회계 전표의 개별 항목 번호
	
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
	
	                    //parameter.put("nonarrivSlipCreationYn", "Y");
	                    procCnt += nonarrivAltDAO.updateGpList(parameter);
	
	                    if ( "Y".equals(draft))	  //상신
	                    {
	                        logger.info("------------1");
	                        parameter.put("slipStatus", "9");	//상신
	                    }
	                    else
	                    {
	                        logger.info("------------2");
	                        parameter.put("slipStatus", "A");	//전표요청
	                    }
	                    parameter.put("slipNum", slipNum);
	                    parameter.put("buCd", "2000");
	                    parameter.put("workClass", "원물대 미착대체");
	
	                    RecordSet fsiRs = ftSapInterfaceDAO.selectList(parameter);
	                    if ( fsiRs.size() > 0)
	                    {
	                        ftSapInterfaceDAO.update(parameter);
	                    }
	                    else
	                    {
	                        ftSapInterfaceDAO.insert(parameter);
	                    }
	                    if ( !"Y".equals(draft))	  //상신
	                    {
	                        ftSapInterfaceDAO.updateSignInstanceId(parameter);	  //전자결재 아이디 update
	                    }
	                }
	            }
	        }
*/	        
        }
        if ( detailList2.size() >0 )
        {
            //부대비
            String currYymmdd = LimsUtil.getDate("yyyyMMddHHmmss");
            SlipMstList mstList = new SlipMstList();
            SlipMstDTO mst = new SlipMstDTO();
            List<SlipMstDTO> master = new ArrayList<SlipMstDTO>();
            List<SlipDtlDTO> detail = new ArrayList<SlipDtlDTO>();



            //마스터 생성
            Map<String, Object> param = new HashMap<String, Object>();

            String slipNum = LimsUtil.checkNull(detailList2.get(0).get("altFiscalSlipNum"),"").toString();
            String slipStatus = LimsUtil.checkNull(detailList2.get(0).get("slipStatus"),"").toString();
            logger.info("slipNum :"+slipNum+"// slipStatus111:"+slipStatus+"//draft:"+draft);
    //      if (!"".equals(gSlipNum) && !"S".equals(slipStatus))	//신규 이거나 상태가 S
            if ( "".equals(slipNum) || "Z".equals(slipStatus) || "R".equals(slipStatus) || "E".equals(slipStatus) || "C".equals(slipStatus))	//신규 이거나 취소, 에러시 전표번호 생성
            {
                slipNum = poOrderMstDAO.selectSlipNum(param);
            }
            logger.info("slipNum111 :"+slipNum);
            slipNums.add(slipCnt++, slipNum);

            int firstCnt = 0;

            double totDivAmt =0;
            for (int i = 0; i < detailList2.size(); i++) {
                parameter = detailList2.get(i);
                rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

                if (rowType == DataSet.ROW_TYPE_UPDATED) {
                    strChk = LimsUtil.checkNull(parameter.get("chk"));
                    if ("1".equals(strChk)) {
                            double divAmt = Double.parseDouble(LimsUtil.checkNull(parameter.get("divAmt"),"0").toString());
                            logger.info("divAmt :"+divAmt);
                        totDivAmt +=divAmt;
                    }
                }
            }
            logger.info("totDivAmt :"+totDivAmt);
            int ii = 0;
            if ( detailList2.size() >0 )
            {
                for (int i = 0; i < detailList2.size(); i++) {
                    parameter = detailList2.get(i);
                    rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

                    if (rowType == DataSet.ROW_TYPE_UPDATED) {
                        strChk = LimsUtil.checkNull(parameter.get("chk"));
                        if ("1".equals(strChk)) {
                            firstCnt++;
                            parameter.put("slipNum", slipNum);
                            if ( firstCnt == 1 )	//마스터 만들기
                            {
                                mst.setSlipNum(slipNum);	            ///SAP과 연결 키 -유일키
                                mst.setBuCd("2000");		            //회사코드
                                mst.setSlipType("7M");	            //전표유형
//                                mst.setSlipEvidenceDate(currYymmdd.substring(0,8));	//전표증빙일자 - 매입전표일자
//                                mst.setSlipPeriodDate(currYymmdd.substring(0,8));	//전표전기일자 - 매입전표일자

                                mst.setSlipEvidenceDate(parameter.get("altSlipDate").toString());	//전표증빙일자 - 전표발행일		서영미: 수수료에 전표발행일	20151027
                                mst.setSlipPeriodDate(parameter.get("altSlipDate").toString());	//전표전기일자 - 지불예정일자		서영미: 수수료에 전표전기일자

                                mst.setCurrency("KRW");				//통화

//                                mst.setElctntaxBillApprvnum(parameter.get("taxBillNum").toString());	//전자세금계산서승인번호

                                logger.info("currYymmdd :"+currYymmdd);
                                mst.setInputDate(currYymmdd.substring(0,8));			//입력일자
                                mst.setInputTime(currYymmdd.substring(8));			//입력시간 -6자리
                                mst.setWriteEmpSabun(loginParameter.getSabun());	//작성사원부서 : 로그인사번
                                mst.setWriteEmpDept(loginParameter.getDeptId());		//작성사원부서
                                mst.setWriteEmpMuCd(loginParameter.getMuCd());
                                mst.setSysCd("IFC");											//시스템코드
                                mst.setElctnSignId(LimsUtil.checkNull(parameter.get("signInstanceId"),"").toString());			 						//전자결재ID - 임시세팅
                                mst.setSignStatus(LimsUtil.checkNull(parameter.get("signProgressStatus"),"").toString());								//전표상태 - 임시세팅
                                mst.setSignType("1");	//결재유형:G/W 결재
                                mst.setSlipText("미착대체 전표 ["+loginParameter.getDeptNm()+"]");	  //(ex)상품권 청구 [FC외식사업지원팀]
                                if ( "Y".equals(draft))	  //상신
                                {
                                    mst.setPistat("9");
                                }
                                master.add(mst);
                                mstList.setDataList(master);
                            }


                            //차변 만들기 : 상품_일반상품
                            SlipDtlDTO dtl11 = new SlipDtlDTO();	  //
                            dtl11.setSlipNum(slipNum);	            ///SAP과 연결 키 -유일키
                            dtl11.setBuCd("2000");
                            dtl11.setSlipType("7M");	            //전표유형

                            dtl11.setSlipCurrencyAmt( BigDecimal.valueOf(Double.parseDouble(parameter.get("divAmt").toString())) );					//전표통화금액 :결재금액
                            dtl11.setPayCond("F000");		            //지불조건 : 환율(외화)정보 있으면 : E000 나머지 : F000
//                            dtl11.setSlipEvidenceDate(currYymmdd.substring(0,8));	//전표증빙일자 - 전표발행일
//                            dtl11.setSlipPeriodDate(currYymmdd.substring(0,8));	//전표전기일자 - 지불예정일자
                            String billPublishdd = LimsUtil.checkNull(parameter.get("billPublishdd"),"").toString();			//세금계산서 발행일
                            if ( "".equals(billPublishdd))	//세금계산서 발행건이 아니면 전표발행일로
                            {
                                dtl11.setSlipEvidenceDate(parameter.get("slipPublishDate").toString());	//전표증빙일자 - 매입전표일자
                            }
                            else
                            {
                                dtl11.setSlipEvidenceDate(billPublishdd);	//전표증빙일자 - 세금계산서 발행일
                            }
//                            dtl11.setSlipPeriodDate(parameter.get("slipPublishDate").toString());		//전표전기일자 - 전표발행일
//                            dtl11.setSlipEvidenceDate(parameter.get("slipPublishDate").toString());	//전표증빙일자 - 전표발행일
//                            dtl11.setSlipPeriodDate(parameter.get("paySchdDate").toString());	//전표전기일자 - 지불예정일자
                            dtl11.setSlipEvidenceDate(parameter.get("altSlipDate").toString());	//전표증빙일자 - 전표발행일		서영미: 수수료에 전표발행일	20151027
                            dtl11.setSlipPeriodDate(parameter.get("altSlipDate").toString());	//전표전기일자 - 지불예정일자		서영미: 수수료에 전표전기일자


                            dtl11.setDtlNum(new BigDecimal(ii++)); 	//회계 전표의 개별 항목 번호
                            
                            dtl11.setMasterAcct("11401010");		//상품_일반상품
    	                    
                            dtl11.setDrCrClass("1");				//1:차변


                            dtl11.setSlipCurrencyAmt( BigDecimal.valueOf(Double.parseDouble(parameter.get("divAmt").toString())) );					//전표통화금액 :결재금액
                            dtl11.setItemText(parameter.get("remarks").toString());			//품목텍스트 - 적요2
                            dtl11.setAttachDept(parameter.get("attachDeptSap").toString());		//귀속부서
                            dtl11.setMgmtDept(parameter.get("attachDeptSap").toString());		//관리부서-귀속부서와 동일

                            detail.add(dtl11);

                            if ( firstCnt == 1 )	//대변 만들기
                            {

                                //대변 계정만들기 : 미착품
                                SlipDtlDTO dtl21 = new SlipDtlDTO();
                                dtl21.setSlipNum(slipNum);	            ///SAP과 연결 키 -유일키
                                dtl21.setBuCd("2000");
                                dtl21.setSlipType("7M");	            //전표유형
                                dtl21.setMasterAcct("11404000");		//상품_미착품
                                dtl21.setDrCrClass("2");				//2:대변
                                dtl21.setAssignNum( parameter.get("poOrderNum").toString() );
//                                if ( "".equals(billPublishdd))	//세금계산서 발행건이 아니면 전표발행일로
//                                {
//                                    dtl21.setSlipEvidenceDate(parameter.get("slipPublishDate").toString());	//전표증빙일자 - 매입전표일자
//                                }
//                                else
//                                {
//                                    dtl21.setSlipEvidenceDate(billPublishdd);	//전표증빙일자 - 세금계산서 발행일
//                                }
//                                dtl21.setSlipPeriodDate(parameter.get("slipPublishDate").toString());		//전표전기일자 - 전표발행일

//                                dtl21.setSlipEvidenceDate(parameter.get("paySchdDate").toString());	//전표증빙일자 - 매입전표일자
//                                dtl21.setSlipPeriodDate(parameter.get("paySchdDate").toString());	//전표전기일자 - 지불예정일자
                                dtl21.setSlipEvidenceDate(parameter.get("altSlipDate").toString());	//전표증빙일자 - 전표발행일		서영미: 수수료에 전표발행일	20151027
                                dtl21.setSlipPeriodDate(parameter.get("altSlipDate").toString());	//전표전기일자 - 지불예정일자		서영미: 수수료에 전표전기일자

                                dtl21.setPayCond("E000");		            //지불조건 : 환율(외화)정보 있으면 : E000 나머지 : F000
                                String remarks2 ="";

                                double exchangeRate = Double.parseDouble(parameter.get("exchangeRate").toString());
                                double payAmt = Double.parseDouble(parameter.get("commAmt").toString());

                                String strSettleExchangeRate = String.format("%.2f", exchangeRate);
                                String strPayAmt = String.format("%.2f", payAmt);

                                remarks2 = parameter.get("amountUnit").toString()
                                        +" / "+strSettleExchangeRate
                                        +" / "+strPayAmt
                                        ;
                                remarks2 = remarks2 +" / "+ parameter.get("remarks").toString();
                                logger.info("remarks2 :"+remarks2);
                                dtl21.setSlipCurrencyAmt( BigDecimal.valueOf(totDivAmt) );					//전표통화금액 :결재금액
                                dtl21.setItemText(remarks2);			//품목텍스트 - 적요2
                                dtl21.setLcNum(parameter.get("lcNum").toString());	//LC번호
                                dtl21.setPoNum(parameter.get("poOrderNum").toString());	//PO번호
                                dtl21.setAttachDept(parameter.get("attachDeptSap").toString());		//귀속부서
                                dtl21.setMgmtDept(parameter.get("attachDeptSap").toString());		//관리부서-귀속부서와 동일
                                //관리항목 필수(문의필요)
                                dtl21.setMgmtArticle( parameter.get("blNum").toString() );			//관리항목 : bl번호
                                dtl21.setBlDate(parameter.get("lshipDate").toString());	//BL일자 (선적일자로 쓴다.)
                                dtl21.setLshipDate(parameter.get("lshipDate").toString());	//선적일자

                                dtl21.setDtlNum(new BigDecimal(ii++)); 	//회계 전표의 개별 항목 번호

                                detail.add(dtl21);


                            }
                            parameter.put("nonarrivSlipCreationYn", "Y");
                            procCnt += nonarrivAltDAO.updateOtherList(parameter);

                        }
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
                    parameter.put("slipStatus", "9");	//상신
                }
                else
                {
                    logger.info("------------2");
                    parameter.put("slipStatus", "A");	//전표요청
                }
                parameter.put("slipNum", slipNum);
                parameter.put("buCd", "2000");
                parameter.put("workClass", "부대비 미착대체");

                RecordSet fsiRs = ftSapInterfaceDAO.selectList(parameter);
                if ( fsiRs.size() > 0)
                {
                    ftSapInterfaceDAO.update(parameter);
                }
                else
                {
                    ftSapInterfaceDAO.insert(parameter);
                }

                if ( !"Y".equals(draft))	  //상신
                {
                    ftSapInterfaceDAO.updateSignInstanceId(parameter);	  //전자결재 아이디 update
                }
            }
        }

        topMap.put("slipNums", slipNums);	//구매품의 번호 전달
        topMap.put("procCnt", procCnt);	  //실행건 전달
        topListMap.add (topMap);

        return topListMap;
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
    public List<Map<String, Object>> saveNonarrivAltDraft(LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap detailList
            , DataSetMap detailList2
            ) throws Exception  {
        int otherAmtProcCnt = 0;
        String poOrderNum = "";	//구매주문 번호

        List<Map<String, Object>> listMap = new ArrayList();
        Map<String, Object> map = new HashMap ();


        //원물대
        if ( detailList.size() > 0 ) {
            for (int i = 0 ; i < detailList.size() ; i++) {
                Map<String, Object> parameter = detailList.get(i);
                poOrderNum = parameter.get("poOrderNum").toString();

                parameter.put("cuser", loginParameter.getSabun());
                parameter.put("uuser", loginParameter.getSabun());
                parameter.put("nonarrivSlipCreationYn", "Y");
                logger.info("signInstanceId ::"+parameter.get("signInstanceId"));
                //1.품의상태:상신중 update
                otherAmtProcCnt += nonarrivAltDAO.saveNonarrivAltDraft(parameter);
                otherAmtProcCnt += nonarrivAltDAO.saveEntryDraft(parameter);

                //2.그룹웨어와 I/F - 정의 되면 구현

                //SCC_SIGN_INFO 테이블에 결재정보저장 (Insert or Update)
                gwIfDAO.saveSignInfo(parameter);

            }
        }

        //부대비
        logger.info("detailList2.size() ::"+detailList2.size());
        if ( detailList2.size() > 0 ) {
            for (int i = 0 ; i < detailList2.size() ; i++) {
                Map<String, Object> parameter = detailList2.get(i);
                poOrderNum = parameter.get("poOrderNum").toString();

                parameter.put("cuser", loginParameter.getSabun());
                parameter.put("uuser", loginParameter.getSabun());
                parameter.put("nonarrivSlipCreationYn", "Y");
                logger.info("signInstanceId ::"+parameter.get("signInstanceId"));
                //1.품의상태:상신중 update
                otherAmtProcCnt += nonarrivAltDAO.saveNonarrivAltDraft2(parameter);

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
     * @see com.hwfs.ft.ftp.service.proposalService#createFiscalSlip(java.util.Map)
    */
    @Override
    @SuppressWarnings("unchecked")
    public int cancelFiscalSlip(LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap dsDetailList
            , DataSetMap dsDetailList2
            ) throws Exception  {
        int otherAmtProcCnt = 0;

        logger.info( "flag  ::::"+search.get(0).get("flag") );

        //sap모듈 취소후 성공하면 아래 상태변경

//        //전표상태 : 전표생성 변경
//        if ( dsOtherAmtList.size() > 0 ) {
//            for (int i = 0 ; i < dsOtherAmtList.size() ; i++) {
//                Map<String, Object> parameter = dsOtherAmtList.get(i);
//                parameter.put("slipStatus", "10");	  //수수료 등록 상태로 변경
//                parameter.put("fiscalSlipNum", "");	  //회계전표번호
//                parameter.put("fiscalSlipcDate", ""); //전표생성일자
//                otherAmtProcCnt += poOrderOtherAmtDAO.cancelFiscalSlip(parameter);
//            }
//        }

        //전표상태 : 전표생성 변경
        if ( dsDetailList.size() > 0 ) {
            for (int i = 0 ; i < dsDetailList.size() ; i++) {
                Map<String, Object> parameter = dsDetailList.get(i);

                logger.info("entryNum :"+parameter.get("entryNum"));
                //int getReleaseCnt = inventoryMgmtDeliverDAO.getReleaseCnt(parameter);
                //logger.info("getReleaseCnt :"+getReleaseCnt);
                //if ( getReleaseCnt != 0 )	//판매 나 출고 된건이 있으면
                //{
                //    throw new BizException("주문 및 출고 건이 존재 합니다. 미착대체 취소 할 수 업습니다.");
                //}

                //sap모듈 호출후 성공하면후 하단 로직 처리
                String currYymmdd = LimsUtil.getDate("yyyyMMddHHmmss");
                SlipCancelDTO mst = new SlipCancelDTO();
                mst.setSlipNum(parameter.get("altFiscalSlipNum").toString());	            //SAP과 연결 키 -유일키
                mst.setBuCd("2000");		                                        //회사코드
                mst.setSysCd("IFC");												//시스템코드
                mst.setFiscalSlipNum(parameter.get("altFiscalSlipNum").toString());    //회계전표번호
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

                Map<String, Object> paramMap = new HashMap<String, Object>();
                paramMap.put("slipNum", parameter.get("altFiscalSlipNum").toString());
                paramMap.put("slipStatus", "B");
                paramMap.put("buCd", "2000");
                paramMap.put("resultMsg", "취소");
                paramMap.put("workClass", "수수료");
                ftSapInterfaceDAO.update(paramMap);
                //외부문서번호 update
//                if (LimsUtil.checkNull(parameter.get("detailGubun")).equals("PO")) {
//                    otherAmtProcCnt += poOrderOtherAmtDAO.cancelFiscalSlip(parameter);
//                } else {
//                    otherAmtProcCnt += poOrderOtherAmtDAO.cancelFiscalSlip(parameter);
//                }
                otherAmtProcCnt++;
            }
        }

        //전표상태 : 전표생성 변경
        if ( dsDetailList2.size() > 0 ) {
            for (int i = 0 ; i < dsDetailList2.size() ; i++) {
                Map<String, Object> parameter = dsDetailList2.get(i);

                logger.info("entryNum :"+parameter.get("entryNum"));
                //int getReleaseCnt = inventoryMgmtDeliverDAO.getReleaseCnt(parameter);
                //logger.info("getReleaseCnt :"+getReleaseCnt);
                //if ( getReleaseCnt != 0 )	//판매 나 출고 된건이 있으면
                //{
                //    throw new BizException("주문 및 출고 건이 존재 합니다. 미착대체 취소 할 수 업습니다.");
                //}

                //sap모듈 호출후 성공하면후 하단 로직 처리
                String currYymmdd = LimsUtil.getDate("yyyyMMddHHmmss");
                SlipCancelDTO mst = new SlipCancelDTO();
                mst.setSlipNum(parameter.get("altFiscalSlipNum").toString());	            //SAP과 연결 키 -유일키
                mst.setBuCd("2000");		                                        //회사코드
                mst.setSysCd("IFC");												//시스템코드
                mst.setFiscalSlipNum(parameter.get("altFiscalSlipNum").toString());    //회계전표번호
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

                parameter.put("nonarrivSlipCreationYn", "N");
                parameter.put("slipNum", parameter.get("altFiscalSlipNum").toString());
                otherAmtProcCnt += nonarrivAltDAO.updateOtherList(parameter);

                Map<String, Object> paramMap = new HashMap<String, Object>();
                paramMap.put("slipNum", parameter.get("altFiscalSlipNum").toString());
                paramMap.put("slipStatus", "B");
                paramMap.put("buCd", "2000");
                paramMap.put("resultMsg", "취소");
                paramMap.put("workClass", "수수료");
                ftSapInterfaceDAO.update(paramMap);


                //외부문서번호 update
//                if (LimsUtil.checkNull(parameter.get("detailGubun")).equals("PO")) {
//                    otherAmtProcCnt += poOrderOtherAmtDAO.cancelFiscalSlip(parameter);
//                } else {
//                    otherAmtProcCnt += poOrderOtherAmtDAO.cancelFiscalSlip(parameter);
//                }
            }
        }

        return otherAmtProcCnt;
    }

}
