package com.hwfs.ft.fsi.service;

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
import com.hwfs.ft.fsi.dao.FreezeWhCommMgmtDAO;
import com.hwfs.ft.fsi.dao.FtSapInterfaceDAO;
import com.hwfs.ft.ftp.dao.PoOrderMstDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.sap.EAIListMap;
import com.hwfs.sc.cmn.sap.EAIResponse;
import com.hwfs.sc.cmn.sap.dto.SlipCancelDTO;
import com.hwfs.sc.cmn.sap.dto.SlipDtlDTO;
import com.hwfs.sc.cmn.sap.dto.SlipMstDTO;
import com.hwfs.sc.cmn.sap.list.SlipCancelList;
import com.hwfs.sc.cmn.sap.list.SlipDtlList;
import com.hwfs.sc.cmn.sap.list.SlipMstList;
import com.hwfs.sc.cmn.sap.request.ElctnTaxShetInqueryRequest;
import com.hwfs.sc.cmn.sap.service.EAIService;
import com.tobesoft.xplatform.data.DataSet;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

/**
* 냉동창고수수료 내역을 Service Implementation
*
* @ClassName FreezeWhCommMgmtServiceImpl.java
* @Description FreezeWhCommMgmtServiceImpl Class
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2015.08.26    jshoon        최초생성
* </pre>
* @author FC종합전산구축 : 식재도매 kjj
* @since 2015.08.26
* @version 1.0
* @see
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
@Service("/ft/fsi/freezeWhCommMgmtService")
public class FreezeWhCommMgmtServiceImpl extends DefaultServiceImpl implements FreezeWhCommMgmtService {

    /** LogService */
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource(name = "/ft/fsi/freezeWhCommMgmtDAO")
    private FreezeWhCommMgmtDAO freezeWhCommMgmtDAO;

    @Resource(name = "/ft/ftp/poOrderMstDAO")
    private PoOrderMstDAO poOrderMstDAO;

    @Resource(name = "EAIService")
    EAIService eaiService;

    /** FtSapInterfaceDAO Bean 생성 */
    @Resource(name = "/ft/fsi/ftSapInterfaceDAO")
    private FtSapInterfaceDAO ftSapInterfaceDAO;

    /**
     * 냉동창고수수료 내역을 조회한다.
     *
     * @param mapParam
     * @return
     * @throws Exception
     * @see com.hwfs.ft.fsi.service.WhService#selectList(java.util.Map)
    */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return freezeWhCommMgmtDAO.selectList(mapParam);
    }

    /**
     * 팝업에서 사용하는 거래처 계좌번호 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    @Override
    public RecordSet selectSuplierAcctNoList(Map<String, Object> parameter) throws Exception {
        return freezeWhCommMgmtDAO.selectSuplierAcctNoList(parameter);
    }

    /**
     * 냉동창고수수료 내역 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
     *
     * @param list
     * @return
     * @throws Exception
     * @see com.hwfs.ft.fsi.service.WhService#saveList(hone.online.xplatform.map.DataSetMap)
    */
    @SuppressWarnings("unchecked")
    public int saveList(Map<String, Object> param, DataSetMap list) throws Exception {
        int insRowCnt = 0;
        int updRowCnt = 0;
        int delRowCnt = 0;
        String strChk = "0";
        int chkCnt = 0;

        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> rowData = list.get(i);
            int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            strChk = LimsUtil.checkNull(rowData.get("chk"));
            if ("1".equals(strChk)) {
                if (LimsUtil.checkNull(param.get("actionGubun")).equals("DELETE")) {
                    // delete 처리
                    delRowCnt += freezeWhCommMgmtDAO.delete(rowData);
                } else {
                    // Insert 처리
                    if (rowType == DataSet.ROW_TYPE_INSERTED) {
                        // 국세청번호 중복 체크
                        chkCnt = freezeWhCommMgmtDAO.selectTaxBillNum(rowData);
                        if (chkCnt > 0) {
                            throw new BizException("중복된 국세청승인번호가 존재합니다.");
                        }

                        insRowCnt += freezeWhCommMgmtDAO.insert(rowData);
                    }
                    // Update 처리
                    else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                        updRowCnt += freezeWhCommMgmtDAO.update(rowData);
                    }
                }
            }
        }

        return insRowCnt + updRowCnt + delRowCnt;
    }

    /**
     * 냉동창고수수료 내역 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
     *
     * @param param
     * @param list
     * @return
     * @throws Exception
     * @see com.hwfs.ft.fsi.service.FreezeWhCommMgmtService#saveDraft(java.util.Map, hone.online.xplatform.map.DataSetMap)
    */
    @SuppressWarnings("unchecked")
    public int saveDraft(Map<String, Object> param, DataSetMap list) throws Exception {
        int updRowCnt = 0;
        String strChk = "0";

        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> rowData = list.get(i);
            int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_UPDATED) {
                strChk = LimsUtil.checkNull(rowData.get("chk"));
                if ("1".equals(strChk)) {
                    updRowCnt += freezeWhCommMgmtDAO.saveDraft(rowData);
                }
            }
        }

        return updRowCnt;
    }

    /**
     * 냉동창고수수료 일괄 저장
     *
     * @param param
     * @param saveList
     * @return
     * @throws Exception
     * @see com.hwfs.ft.fsi.service.FreezeWhCommMgmtService#saveListAll(java.util.Map, hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public int saveListAll(Map<String, Object> param, DataSetMap saveList) throws Exception {
        Map<String, Object> rowData = null;
        int rowType = 0;
        String strChk = "0";
        int chkCnt = 0;
        int insRowCnt = 0;
        int updRowCnt = 0;
        int delRowCnt = 0;

        for (int i = 0; i < saveList.size(); i++) {
            rowData = saveList.get(i);
            rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            strChk = LimsUtil.checkNull(rowData.get("chk"));
            if ("1".equals(strChk)) {

                rowData.put("remarks", LimsUtil.checkNull(param.get("remarks")));
                rowData.put("attachDept", LimsUtil.checkNull(param.get("attachDept1")));

                // Insert 처리
                if (rowType == DataSet.ROW_TYPE_INSERTED) {
                    // 국세청번호 중복 체크
                    chkCnt = freezeWhCommMgmtDAO.selectTaxBillNum(rowData);
                    if (chkCnt > 0) {
                        throw new BizException("중복된 국세청승인번호가 존재합니다.");
                    }

                    insRowCnt += freezeWhCommMgmtDAO.insert(rowData);
                }
                // Update 처리
                else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                    updRowCnt += freezeWhCommMgmtDAO.update(rowData);
                }
            }
        }

        return insRowCnt + updRowCnt + delRowCnt;
    }

    /**
     * 회계전표 IF -> SAP
     *
     * @param loginParameter
     * @param search
     * @param dsGdspaymList
     * @return
     * @throws Exception
     * @see com.hwfs.ft.fsi.service.FreezeWhCommMgmtService#createFiscalSlip(com.hwfs.sc.cmn.dto.LoginDTO, hone.online.xplatform.map.DataSetMap, hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> createFiscalSlip(LoginDTO loginParameter, DataSetMap searchParam, DataSetMap dsGdspaymList)
            throws Exception {
        int procCnt = 0;

        Map<String, Object> topMap = new HashMap<String, Object>();
        String slipNum = "";
        String strChk = "";
        List<String> slipNums = new ArrayList<String>();

        /////////////////////////////////////////////////////////////////
        // 화면 내역 저장
        saveList(searchParam.get(0), dsGdspaymList);
        /////////////////////////////////////////////////////////////////

        if (dsGdspaymList.size() > 0) {
            for (int i = 0; i < dsGdspaymList.size(); i++) {
                Map<String, Object> parameter = dsGdspaymList.get(i);
                int rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

                // Update 처리
                if (rowType == DataSet.ROW_TYPE_UPDATED) {
                    strChk = LimsUtil.checkNull(parameter.get("chk"));
                    if ("1".equals(strChk)) {
                        slipNum = actionSlipSapInterface(loginParameter, searchParam.get(0), parameter);


                        String slipStatus = LimsUtil.checkNull(parameter.get("slipStatus"),"").toString();
                        logger.info("slipNum1111111111 : " + slipNum+"//"+slipStatus);
//                        // 전표번호가 없으면 새로 등록한다.
//                        if ( LimsUtil.checkNull(parameter.get("fiscalSlipNum")).equals("")
//                                || "Z".equals(slipStatus) || "R".equals(slipStatus) || "E".equals(slipStatus) || "C".equals(slipStatus)
//                       ) {
//
//                        }
                        parameter.put("fiscalSlipNum", slipNum);
                        // 전표번호 Update
                        freezeWhCommMgmtDAO.slipNumUpdate(parameter);
                        slipNums.add(i, slipNum);
                        procCnt++;
                    }
                }
            }
        }

        topMap.put("slipNums", slipNums); //회계전표번호
        topMap.put("procCnt", procCnt); //실행건 전달

        return topMap;
    }

    /**
     * 전표 취소 IF -> SAP
     *
     * @param loginParameter
     * @param search
     * @param dsGdspaymList
     * @return
     * @throws Exception
     * @see com.hwfs.ft.fsi.service.FreezeWhCommMgmtService#cancelFiscalSlip(com.hwfs.sc.cmn.dto.LoginDTO, hone.online.xplatform.map.DataSetMap, hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public int cancelFiscalSlip(LoginDTO loginParameter, DataSetMap search, DataSetMap dsGdspaymList) throws Exception {
        int procCnt = 0;
        String strChk = "";
        String currYymmdd = "";

        if (dsGdspaymList.size() > 0) {
            for (int i = 0; i < dsGdspaymList.size(); i++) {
                Map<String, Object> parameter = dsGdspaymList.get(i);
                int rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

                if (rowType == DataSet.ROW_TYPE_UPDATED) {
                    strChk = LimsUtil.checkNull(parameter.get("chk"));
                    if ("1".equals(strChk)) {
                        // sap모듈 호출후 성공하면후 하단 로직 처리
                        currYymmdd = LimsUtil.getDate("yyyyMMddHHmmss");

                        SlipCancelDTO mst = new SlipCancelDTO();

                        mst.setSlipNum(LimsUtil.checkNull(parameter.get("fiscalSlipNum"))); // SAP과 연결 키 -유일키
                        mst.setBuCd("2000"); // 회사코드
                        mst.setSysCd("IFC"); // 시스템코드
                        mst.setFiscalSlipNum(LimsUtil.checkNull(parameter.get("fiscalSlipNum"))); // 회계전표번호
                        mst.setFiscalYear(LimsUtil.checkNull(parameter.get("fiscalYear"))); // 회계전도
                        mst.setPeriodDate(LimsUtil.checkNull(parameter.get("slipPublishDate"))); // 전기일 - 매입전표일자
                        mst.setRequestDate(currYymmdd.substring(0, 8)); // 요청일자
                        mst.setRequestTime(currYymmdd.substring(8)); // 요청시간
                        logger.info("slipStatus ::"+LimsUtil.checkNull(parameter.get("slipStatus").toString()));
                        if ( "P".equals(LimsUtil.checkNull(parameter.get("slipStatus").toString())) )
                        {
                            mst.setCancelReason("1");			            					//취소사유 : 0. 임시전표삭제. 1. 회계기간내, 2 마감기간역분개
                        }
                        else
                        {
                            mst.setCancelReason("0");			            					//취소사유 : 0. 임시전표삭제. 1. 회계기간내, 2 마감기간역분개
                        }
                        mst.setWriteEmpNum(loginParameter.getSabun()); // 작성사원부서 : 로그인사번
                        mst.setWriteEmpDept(loginParameter.getDeptId()); // 작성사원부서

                        List<SlipCancelDTO> master = new ArrayList<SlipCancelDTO>();
                        master.add(mst);

                        SlipCancelList mstList = new SlipCancelList(); // 취소
                        mstList.setDataList(master);

                        EAIResponse res = eaiService.call(mstList);
                        if (res.isSuccess()) {
                            logger.debug("성공");
                        } else {
                            logger.debug(res.getErrorMsg());
                            throw processException(res.getErrorMsg());
                        }

                        Map<String, Object> paramMap = new HashMap<String, Object>();
                        paramMap.put("slipNum", LimsUtil.checkNull(parameter.get("fiscalSlipNum")));
                        paramMap.put("slipStatus", "B");
                        paramMap.put("buCd", "2000");
                        paramMap.put("resultMsg", "취소");
                        paramMap.put("workClass", "냉동창고 수수료");

                        ftSapInterfaceDAO.update(paramMap);
                    }
                }
            }
        }

        return procCnt;
    }

    /**
     * 냉동창고수수료 SAP Interface
     *
     * @param loginParameter
     * @param searchParam
     * @param parameter
     * @return
     * @throws Exception
     */
    public String actionSlipSapInterface(LoginDTO loginParameter, Map<String, Object> searchParam, Map<String, Object> parameter)
            throws Exception {
        String currYymmdd = LimsUtil.getDate("yyyyMMddHHmmss");
        SlipMstDTO mst = new SlipMstDTO();

        // 전표번호 생성
        String slipNum = "";
        String draft = LimsUtil.checkNull(searchParam.get("draft")); // 상신,전표처리 구분


        String slipStatus = LimsUtil.checkNull(parameter.get("slipStatus"),"").toString();
        if ( LimsUtil.checkNull(parameter.get("fiscalSlipNum")).equals("")
                 || "Z".equals(slipStatus) || "R".equals(slipStatus) || "E".equals(slipStatus) || "C".equals(slipStatus)
        ) {
            slipNum = poOrderMstDAO.selectSlipNum(parameter);
        } else {
            slipNum = LimsUtil.checkNull(parameter.get("fiscalSlipNum"));
        }

        logger.info("slipNum :" + slipNum);
        parameter.put("slipNum", slipNum);

        mst.setSlipNum(slipNum); // SAP과 연결 키 -유일키
        mst.setBuCd("2000"); // 회사코드
        mst.setSlipType("7K"); // 전표유형
        mst.setSlipEvidenceDate(LimsUtil.checkNull(parameter.get("writeDate"))); // 전표증빙일자 - 매입전표일자 2018.11.06 김지영 세금계산서 발행일로 변경
        mst.setSlipPeriodDate(LimsUtil.checkNull(parameter.get("slipPublishDate"))); // 전표전기일자 - 매입전표일자
        mst.setCurrency("KRW"); // 통화
        mst.setElctntaxBillApprvnum(LimsUtil.checkNull(parameter.get("taxBillNum"))); // 전자세금계산서승인번호
        if ( !"".equals(LimsUtil.checkNull(parameter.get("taxBillNum"),"").toString()))		//세금계산서발행건 일때 순발행 세팅 20151026 고영범
        {
            mst.setPublishClass("F");											//발행구분 F:순발행, B:역발행
        }


        mst.setInputDate(currYymmdd.substring(0, 8)); // 입력일자
        mst.setInputTime(currYymmdd.substring(8)); // 입력시간 -6자리
        mst.setWriteEmpSabun(loginParameter.getSabun()); // 작성사원부서 : 로그인사번
        mst.setWriteEmpDept(loginParameter.getDeptId()); // 작성사원부서
        mst.setWriteEmpMuCd(loginParameter.getMuCd());
        mst.setSysCd("IFC"); // 시스템코드

        mst.setElctnSignId(LimsUtil.checkNull(parameter.get("signInstanceId"))); // 전자결재ID - 임시세팅
        mst.setSignStatus(LimsUtil.checkNull(parameter.get("signProgressStatus"))); // 전표상태 - 임시세팅
        mst.setSignType("1"); // 결재유형:G/W 결재
        mst.setSlipText("냉동창고 수수료 전표 ["+loginParameter.getDeptNm()+"]");	  //(ex)상품권 청구 [FC외식사업지원팀]
        if ("Y".equals(draft)) { // 상신
            mst.setPistat("9");
        }

        List<SlipMstDTO> master = new ArrayList<SlipMstDTO>();
        master.add(mst);

        SlipMstList mstList = new SlipMstList();
        mstList.setDataList(master);

        int ii = 0;
        List<SlipDtlDTO> detail = new ArrayList<SlipDtlDTO>();

        String taxCd = "";
        if ("Y".equals(parameter.get("nonDeducYn"))) //불공제 여부
        {
            taxCd = "70"; //전자불공제
        }

        // 차변 만들기 : 지급수수료_기타수수료
        SlipDtlDTO dtl11 = new SlipDtlDTO(); //
        dtl11.setSlipNum(slipNum); // SAP과 연결 키 -유일키
        dtl11.setBuCd("2000");
        dtl11.setSlipType("7K"); // 전표유형
        //전표발행 10/15 지불에정 10/16 증빙일자 10/5
        dtl11.setSlipEvidenceDate(LimsUtil.checkNull(parameter.get("writeDate"))); // 전표증빙일자 - 전표발행일 2018.11.06 김지영 세금계산서 발행일로 변경
        dtl11.setSlipPeriodDate(LimsUtil.checkNull(parameter.get("slipPublishDate"))); // 전표전기일자 - 지불예정일자 
        dtl11.setMasterAcct("43216050"); // 지급수수료_기타수수료
        dtl11.setDrCrClass("1"); // 1:차변

        dtl11.setCcCd(LimsUtil.checkNull(parameter.get("costCenterCd"))); // 코스트 센터 CC_CD

        dtl11.setSlipCurrencyAmt(BigDecimal.valueOf(LimsUtil.checkNull(parameter.get("amt"), 0.0))); // 전표통화금액 :결재금액

        String remarks = LimsUtil.checkNull(parameter.get("remarks"));
        if ("Y".equals(parameter.get("nonDeducYn"))) //불공제 여부
        {
            remarks = remarks+" (불공제)";
        }
        dtl11.setItemText(remarks); // 품목텍스트 - 적요
        dtl11.setAttachDept(LimsUtil.checkNull(parameter.get("costCenterCd"))); // 귀속부서
        //dtl11.setMgmtDept(LimsUtil.checkNull(parameter.get("costCenterCd"))); // 관리부서-귀속부서와 동일
        dtl11.setMgmtDept(LimsUtil.checkNull(parameter.get("mgmtCcCd"))); // 관리부서
        dtl11.setUpjang(parameter.get("rcvr").toString()); //AP거래처 : 신고업장:종사업자번호
        dtl11.setDtlNum(new BigDecimal(ii++)); // 회계 전표의 개별 항목 번호
        dtl11.setAssetNum(""); // 지정 : 전표번호
        dtl11.setVatCd(taxCd); //부가가치세 코드
        dtl11.setExpireCalBasisDate(LimsUtil.checkNull(parameter.get("paySchdDate"))); //통관예정일 +3개월 = 입금예정일 ->지불예정일
        dtl11.setSupplyplceNum(LimsUtil.checkNull(parameter.get("supplier"))); // AP거래처 : 매입처.
        dtl11.setPayCond("F000"); //지불조건
        dtl11.setReasonCd("A00"); //사유코드: A00:발생
        detail.add(dtl11);

        logger.info("nonDeducYn :" + parameter.get("nonDeducYn"));
        if ("Y".equals(parameter.get("nonDeducYn"))) //불공제 여부
        {
            logger.info("###불공제####");
            SlipDtlDTO dtl12 = new SlipDtlDTO();
            dtl12.setSlipNum(slipNum); //SAP과 연결 키 -유일키
            dtl12.setBuCd("2000");
            dtl12.setSlipType("7K"); //전표유형
            dtl12.setSlipEvidenceDate(parameter.get("writeDate").toString()); //전표증빙일자 - 전표발행일 2018.11.06 김지영 세금계산서 발행일로 변경
            dtl12.setSlipPeriodDate(parameter.get("slipPublishDate").toString()); //전표전기일자 - 지불예정일자
            dtl12.setMasterAcct("90007010"); //매입부가세 가계정
            dtl12.setDrCrClass("1"); //1:차변
            //            double slipCurrencyAmt = Double.parseDouble(LimsUtil.checkNull(parameter.get("supplyAmt"),"0").toString());
            double supplyPrice = Double.parseDouble(LimsUtil.checkNull(parameter.get("supplyAmt"), "0").toString()); //공급가액
            double vatAmt = Double.parseDouble(LimsUtil.checkNull(parameter.get("vatAmt"), "0").toString());

            dtl12.setAttachDept(LimsUtil.checkNull(parameter.get("costCenterCd"))); // 귀속부서
            //dtl12.setMgmtDept(LimsUtil.checkNull(parameter.get("costCenterCd"))); // 관리부서-귀속부서와 동일
            dtl12.setMgmtDept(LimsUtil.checkNull(parameter.get("mgmtCcCd"))); // 관리부서
            dtl12.setSlipCurrencyAmt(null); //공급가액
            dtl12.setStdAmt(BigDecimal.valueOf(supplyPrice)); //공급가액
            dtl12.setTaxAmt(BigDecimal.valueOf(vatAmt)); //세액(전표 통화)
            logger.info("taxCd :" + taxCd);
            dtl12.setVatCd(taxCd); //부가가치세 코드
            dtl12.setSupplyplceNum(LimsUtil.checkNull(parameter.get("supplier"), "").toString()); //공급처번호
            dtl12.setMgmtArticle(LimsUtil.checkNull(parameter.get("supplier"), "").toString()); //관리항목 : 거래처:실거래처
            dtl12.setUpjang(parameter.get("rcvr").toString()); //AP거래처 : 신고업장:종사업자번호
            dtl12.setItemText(remarks); // 품목텍스트 - 적요
            dtl12.setPayCond("F000"); //지불조건
            dtl12.setReasonCd("A00"); //사유코드: A00:발생
            dtl12.setExpireCalBasisDate(LimsUtil.checkNull(parameter.get("paySchdDate"))); //통관예정일 +3개월 = 입금예정일 ->지불예정일
            dtl12.setDtlNum(new BigDecimal(ii++)); // 회계 전표의 개별 항목 번호
            dtl12.setCcCd(LimsUtil.checkNull(parameter.get("costCenterCd"))); // 코스트 센터 CC_CD
            detail.add(dtl12);
        }

        // 대변 계정만들기 : 미지급금_거래처
        SlipDtlDTO dtl21 = new SlipDtlDTO();
        dtl21.setSlipNum(slipNum); // SAP과 연결 키 -유일키
        dtl21.setBuCd("2000"); // 회사 코드
        dtl21.setSlipType("7K"); // 전표유형
        dtl21.setSlipEvidenceDate(LimsUtil.checkNull(parameter.get("writeDate"))); // 전표증빙일자 - 매입전표일자 2018.11.06 김지영 세금계산서 발행일로 변경
        dtl21.setSlipPeriodDate(LimsUtil.checkNull(parameter.get("slipPublishDate"))); // 전표전기일자 - 매입전표일자
        dtl21.setDtlNum(BigDecimal.valueOf(ii++)); // 회계 전표의 개별 항목 번호
        dtl21.setMasterAcct("21102010"); // 미지급금_거래처
        dtl21.setDrCrClass("2");
        dtl21.setSlipCurrencyAmt(BigDecimal.valueOf(LimsUtil.checkNull(parameter.get("amt"), 0.0))); // 전표통화금액 :결재금액
        dtl21.setSupplyplceNum(LimsUtil.checkNull(parameter.get("supplier"))); // AP거래처 : 매입처.
        dtl21.setItemText(remarks); // 품목텍스트 - 적요
        dtl21.setAttachDept(LimsUtil.checkNull(parameter.get("costCenterCd"))); // 귀속부서
        //dtl21.setMgmtDept(LimsUtil.checkNull(parameter.get("costCenterCd"))); // 관리부서-귀속부서와 동일
        dtl21.setMgmtDept(LimsUtil.checkNull(parameter.get("mgmtCcCd"))); // 관리부서
        dtl21.setAssignNum(""); // 지정 : 전표번호
        dtl21.setPayCond("F000"); //지불조건
        dtl21.setReasonCd("A00"); // 사유코드: A00:발생
        dtl21.setUpjang(parameter.get("rcvr").toString()); //AP거래처 : 신고업장:종사업자번호
        dtl21.setVatCd(taxCd); //부가가치세 코드
        dtl21.setAssignNum(parameter.get("slipPublishDate").toString().substring(0, 6)); ////지정 : 미지급금_거래처 :년월
        dtl21.setExpireCalBasisDate(LimsUtil.checkNull(parameter.get("paySchdDate"))); //통관예정일 +3개월 = 입금예정일 ->지불예정일
        dtl21.setCcCd(LimsUtil.checkNull(parameter.get("costCenterCd"))); // 코스트 센터 CC_CD

        String snglfootlstNmYn = (LimsUtil.checkNull(parameter.get("snglfootlstNmYn")).equals("1") ? "X" : "");
//        dtl21.setSinglePayYn(snglfootlstNmYn); // 단발성여부

        // 단발성이면...
        if (snglfootlstNmYn.equals("X")) {
            dtl21.setTempCustNm(""); // 공급자명
        }

        dtl21.setBankAcctNo(LimsUtil.checkNull(parameter.get("bankAcctNoEnc"))); // 공급자 계좌번호 - 암호화된 계좌번호
        dtl21.setBankAcctOwnr(LimsUtil.checkNull(parameter.get("bankAcctOwnr"))); // 공급자 예금주
        dtl21.setBankCd(LimsUtil.checkNull(parameter.get("bankCd"))); // 공급자 은행코드
        dtl21.setCrgleftClass(LimsUtil.checkNull(parameter.get("bankType")));	// 계좌구분코드(Bank type)

        detail.add(dtl21);

        logger.info("detail.size() :" + detail.size());
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

        if ("Y".equals(draft)) { // 상신
            logger.info("------------1");
            parameter.put("slipStatus", "9"); // 상신
        } else {
            logger.info("------------2");
            parameter.put("slipStatus", "A"); // 전표요청
        }

        parameter.put("slipNum", slipNum);
        parameter.put("buCd", "2000");
        parameter.put("workClass", "냉동창고 수수료");

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

        return slipNum;
    }

    /**
     * 매입 전자세금계산서 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public List<Map<String, Object>> selectElctnTexShetList(Map<String, Object> parameter) throws Exception {
        List<Map<String, Object>> list = null;
        List<Map<String, Object>> tmpList = new ArrayList<Map<String, Object>>();
        Map<String, Object> tmpMap = new HashMap<String, Object>();

        /* ******************************************************************************* */
        /* 전자세금계산서 조회 (식재도매용)                                                */
        /* ******************************************************************************* */
        ElctnTaxShetInqueryRequest request = new ElctnTaxShetInqueryRequest();

        request.setBukrs("1000");	// 회사코드
        request.setSuName(LimsUtil.checkNull(parameter.get("upjangNm")));	// 공급자명
        request.setFrDate(LimsUtil.checkNull(parameter.get("fromDay")));	// 작성시작일자
        request.setToDate(LimsUtil.checkNull(parameter.get("toDay")));		// 작성종료일자

        // E-Mail 검색인 경우에는 E-Mail을 넘긴다.
        if (LimsUtil.checkNull(parameter.get("attachDept")).equals("")) {
            //request.setDeptId("10");	// 처리부서코드
            request.setDeptId("");	// 처리부서코드
        } else {
            String tmpCcCd = freezeWhCommMgmtDAO.selectCcCd(parameter);
            request.setDeptId(LimsUtil.checkNull(tmpCcCd));	// 처리부서코드
        }
        request.setStatsCd("10");	// 처리상태코드 - 10:미처리,20:처리중,30:처리완료

//        request.setBukrs("1000");
//        request.setSuName("갤러리아");
//        request.setFrDate("20150603");
//        request.setToDate("20150603");
//        request.setDeptId("");
//        request.setStatsCd("10");

        EAIResponse res = eaiService.call(request);

        if (res.isSuccess()) {
            try {
                if (res.getListMap().size() > 0) {
                    list = res.getListMap();
                    for (Map<String, Object> ma : list) {
                        tmpMap = freezeWhCommMgmtDAO.selectDecAddr(ma);
                        ma.put("decSuAddr", LimsUtil.checkNull(tmpMap.get("decSuAddr")));
                        ma.put("decSuTelno", LimsUtil.checkNull(tmpMap.get("decSuTelno")));
                        ma.put("decSuHpno", LimsUtil.checkNull(tmpMap.get("decSuHpno")));
                        ma.put("decSuEmail", LimsUtil.checkNull(tmpMap.get("decSuEmail")));

                        tmpList.add(ma);
                    }
                }
            } catch (Exception e) {
                logger.error("ElctnTaxShetInqueryRequest > isSuccess ==> " + e.getMessage());
            }
        } else {
            logger.debug(res.getErrorCode() + " / " + res.getErrorMsg());
            if (res.getErrorCode() == -1) {
                logger.debug("조회된 결과가 없습니다.");
            } else {
                throw super.processException("eai.exception");
            }
        }

        return tmpList;
    }

}
