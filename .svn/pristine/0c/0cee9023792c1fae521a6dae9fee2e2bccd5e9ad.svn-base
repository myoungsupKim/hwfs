package com.hwfs.ft.fdm.service;

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
import com.hwfs.ft.fdm.dao.InventoryAssetDisuseLossDAO;
import com.hwfs.ft.fdm.dao.InventoryControlLogDAO;
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
import com.hwfs.sc.cmn.sap.service.EAIService;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 재고자산 폐기손실하는 InventoryAssetDisuseLoss Service Implementation
 *
 * @ClassName InventoryAssetDisuseLossServiceImpl.java
 * @Description InventoryAssetDisuseLossServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.07    KJJ        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재도매 KJJ
 * @since 2015.07.07
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ft/fdm/inventoryAssetDisuseLossService")
public class InventoryAssetDisuseLossServiceImpl extends DefaultServiceImpl implements InventoryAssetDisuseLossService {

    /** LogService */
    private final Logger logger = LoggerFactory.getLogger (this.getClass());

    /** InventoryAssetDisuseLossDAO Bean 생성 */
    @Resource(name = "/ft/fdm/inventoryAssetDisuseLossDAO")
    private InventoryAssetDisuseLossDAO inventoryAssetDisuseLossDAO;

    /** PoOrderMstDAO Bean 생성 */
    @Resource(name = "/ft/ftp/poOrderMstDAO")
    private PoOrderMstDAO poOrderMstDAO;

    @Resource(name="EAIService")
    EAIService eaiService;

    /** FtSapInterfaceDAO Bean 생성 */
    @Resource(name = "/ft/fsi/ftSapInterfaceDAO")
    private FtSapInterfaceDAO ftSapInterfaceDAO;

    /** InventoryControlLogDAO Bean 생성 */
    @Resource(name = "/ft/fdm/inventoryControlLogDAO")
    private InventoryControlLogDAO inventoryControlLogDAO;
    /**
     * 재고자산 폐기손실 목록을 조회한다.
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
        return inventoryAssetDisuseLossDAO.selectList(mapParam);
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
        return inventoryAssetDisuseLossDAO.selectDetailList(parameter);
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
    public int createFiscalSlip(LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap detailList
            ) throws Exception  {
        int procCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;
        String strChk = "";
        Map<String, Object> paramMap = new HashMap<String, Object>();
        for (int i = 0; i < detailList.size(); i++) {
            parameter = detailList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

            if (rowType == DataSet.ROW_TYPE_UPDATED) {
                strChk = LimsUtil.checkNull(parameter.get("chk"));
                if ("1".equals(strChk)) {

                    String currYymmdd = LimsUtil.getDate("yyyyMMddHHmmss");
                    SlipMstDTO mst = new SlipMstDTO();

                    //마스터 생성
                    String slipNum = poOrderMstDAO.selectSlipNum(parameter);

                    String gSlipNum = LimsUtil.checkNull(parameter.get("slipNum"),"").toString();
                    String slipStatus = LimsUtil.checkNull(parameter.get("slipStatus"),"").toString();
                    logger.info("gSlipNum :"+gSlipNum+"// slipStatus:"+slipStatus);
                    if ("".equals(gSlipNum) || "Z".equals(slipStatus) || "R".equals(slipStatus) || "E".equals(slipStatus) || "C".equals(slipStatus))	//신규 이거나 상태가 S
                    {
                        logger.info("---------------1");
                        slipNum = poOrderMstDAO.selectSlipNum(parameter);
                    }
                    else
                    {
                        logger.info("---------------2");
                        slipNum = gSlipNum;
                    }

                    logger.info("slipNum :"+slipNum);
                    parameter.put("slipNum", slipNum);
                    mst.setSlipNum(slipNum);	            ///SAP과 연결 키 -유일키
                    mst.setBuCd("2000");		            //회사코드
                    mst.setSlipType("7Q");	            //전표유형
                    mst.setSlipEvidenceDate(parameter.get("controlDate").toString());	//전표증빙일자 - 매입전표일자
                    mst.setSlipPeriodDate(parameter.get("controlDate").toString());	//전표전기일자 - 매입전표일자
                    mst.setCurrency("KRW");				//통화

                    logger.info("currYymmdd :"+currYymmdd);
                    mst.setInputDate(currYymmdd.substring(0,8));			//입력일자
                    mst.setInputTime(currYymmdd.substring(8));			//입력시간 -6자리
                    mst.setWriteEmpSabun(loginParameter.getSabun());	//작성사원부서 : 로그인사번
                    mst.setWriteEmpDept(loginParameter.getDeptId());		//작성사원부서
                    mst.setWriteEmpMuCd(loginParameter.getMuCd());
                    mst.setSysCd("IFC");											//시스템코드
                    mst.setElctnSignId("");									//전자결재ID - 임시세팅
                    mst.setSignStatus("");								//전표상태 - 임시세팅
                    mst.setSignType("2");	//결재유형:서면결재
                    mst.setSlipText("재고자산 폐기손실 전표 ["+loginParameter.getDeptNm()+"]");	  //(ex)상품권 청구 [FC외식사업지원팀]
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
                    dtl11.setSlipType("7Q");	            //전표유형

                    dtl11.setSlipEvidenceDate(parameter.get("controlDate").toString());	//전표증빙일자 - 재고조정일자
                    dtl11.setSlipPeriodDate(parameter.get("controlDate").toString());	//전표전기일자 - 재고조정일자
                    dtl11.setDtlNum(new BigDecimal(ii++)); 	//회계 전표의 개별 항목 번호
                    dtl11.setMasterAcct("46111000");		//재고자산폐기손실
                    dtl11.setDrCrClass("1");				//1:차변

                    dtl11.setSlipCurrencyAmt( BigDecimal.valueOf(Long.parseLong(parameter.get("controlAmt").toString())) );					//전표통화금액 :조정금액
                    dtl11.setItemText(parameter.get("poOrderNum").toString() +" "+ parameter.get("controlReason").toString());			//품목텍스트 - 조정사유
                    dtl11.setAttachDept(parameter.get("attachDeptSap").toString());		//귀속부서
                    dtl11.setMgmtDept(parameter.get("attachDeptSap").toString());		//관리부서-귀속부서와 동일
                    dtl11.setCcCd( parameter.get("attachDeptSap").toString());	//코스트 센터 CC_CD
                    detail.add(dtl11);

                    //대변 계정만들기 : 상품_일반상품
                    SlipDtlDTO dtl21 = new SlipDtlDTO();
                    dtl21.setSlipNum(slipNum);	            ///SAP과 연결 키 -유일키
                    dtl21.setBuCd("2000");
                    dtl21.setSlipType("7Q");	            //전표유형

                    dtl21.setSlipCurrencyAmt( BigDecimal.valueOf(Long.parseLong(parameter.get("controlAmt").toString())) );					//전표통화금액 :결재금액
                    dtl21.setSlipEvidenceDate(parameter.get("controlDate").toString());	//전표증빙일자 - 전표발행일
                    dtl21.setSlipPeriodDate(parameter.get("controlDate").toString());	//전표전기일자 - 지불예정일자
                    dtl21.setDtlNum(new BigDecimal(ii++)); 	//회계 전표의 개별 항목 번호
                    dtl21.setMasterAcct("11401010");		//상품_일반상품
                    dtl21.setDrCrClass("2");				//2:대변
                    dtl21.setItemText(parameter.get("poOrderNum").toString() +" "+parameter.get("controlReason").toString());			//품목텍스트 - 적요2
                    dtl21.setAttachDept(parameter.get("attachDeptSap").toString());		//귀속부서
                    dtl21.setMgmtDept(parameter.get("attachDeptSap").toString());		//관리부서-귀속부서와 동일

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

                    procCnt += inventoryControlLogDAO.update(parameter);

                    paramMap.put("slipNum", slipNum);
                    paramMap.put("slipStatus", "A");
                    paramMap.put("buCd", "2000");
                    paramMap.put("workClass", "재고자산 폐기손실");

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
//                    ftSapInterfaceDAO.insert(paramMap);
                }
            }
        }

        return procCnt;
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
            ) throws Exception  {
        int procCnt = 0;

        logger.info( "flag  ::::"+search.get(0).get("flag") );

        //전표상태 : 전표생성 변경
        if ( dsDetailList.size() > 0 ) {
            for (int i = 0 ; i < dsDetailList.size() ; i++) {
                Map<String, Object> parameter = dsDetailList.get(i);

                //sap모듈 호출후 성공하면후 하단 로직 처리
                String currYymmdd = LimsUtil.getDate("yyyyMMddHHmmss");
                SlipCancelDTO mst = new SlipCancelDTO();
                mst.setSlipNum(parameter.get("slipNum").toString());	            //SAP과 연결 키 -유일키
                mst.setBuCd("2000");		                                        //회사코드
                mst.setSysCd("IFC");												//시스템코드
                mst.setFiscalSlipNum(parameter.get("slipNum").toString());    //회계전표번호
                mst.setFiscalYear(parameter.get("fiscalYear").toString());			//회계전도
                mst.setPeriodDate(parameter.get("controlDate").toString());	        //전기일 - 매입전표일자
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
                paramMap.put("slipNum", parameter.get("slipNum").toString());
                paramMap.put("slipStatus", "B");
                paramMap.put("buCd", "2000");
                paramMap.put("resultMsg", "취소");
                paramMap.put("workClass", "재고자산 폐기손실 취소");
                ftSapInterfaceDAO.update(paramMap);

                procCnt++;
            }
        }

        return procCnt;
    }

    /**
     * 재고자산 폐기손실 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
                insRowCnt += inventoryAssetDisuseLossDAO.insert(rowData);
            }
            //Update 처리
            else if (rowType == DataSet.ROW_TYPE_UPDATED) {
                updRowCnt += inventoryAssetDisuseLossDAO.update(rowData);
            }
            //Delete 처리.
            else if (rowType == DataSet.ROW_TYPE_DELETED) {
                delRowCnt += inventoryAssetDisuseLossDAO.delete(rowData);
            }
        }

        return insRowCnt + updRowCnt + delRowCnt;
    }
}
