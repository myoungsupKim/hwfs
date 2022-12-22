package com.hwfs.sm.srm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dao.GwIfDAO;
import com.hwfs.sc.cmn.sap.EAIResponse;
import com.hwfs.sc.cmn.sap.list.SlipCancelList;
import com.hwfs.sc.cmn.sap.list.SlipDtlList;
import com.hwfs.sc.cmn.sap.list.SlipMstList;
import com.hwfs.sc.cmn.sap.service.EAIService;
import com.hwfs.sm.srm.dao.SapSlipSendReptDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * SAP 전표 전송하는 SapSlipSendRept Service Implementation
 * 
 * @ClassName SapSlipSendReptServiceImpl.java
 * @Description SapSlipSendReptServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.19    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.06.19
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/srm/sapSlipSendReptService")
public class SapSlipSendReptServiceImpl extends DefaultServiceImpl implements SapSlipSendReptService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SapSlipSendReptDAO Bean 생성 */
	@Resource(name = "/sm/srm/sapSlipSendReptDAO")
	private SapSlipSendReptDAO sapSlipSendReptDAO;
	
	@Resource(name="EAIService")
	EAIService eaiService;

	/** GwIfDAO Bean 생성 */
	@Resource(name = "/sc/cmn/gwIfDAO")
	private GwIfDAO gwIfDAO;
	
	/**
	 * SAP 전표 전송 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return sapSlipSendReptDAO.selectList(mapParam);
	}

	/**
	 * 그룹웨어 상신을 위한 본문을 생성하여 연동한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectSilpList(Map<String, Object> mapParam) throws Exception {
		return sapSlipSendReptDAO.selectSilpList(mapParam);
	}
	
	/**
	 * 그룹웨어 상신을 위한 본문을 생성하여 연동한다.(계약관리)
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectContractList(Map<String, Object> mapParam) throws Exception {
		return sapSlipSendReptDAO.selectContractList(mapParam);
	}

	/**
	 * 전자결재정보를 Update 처리한다.
	 * <pre>
	 * - 업무 테이블에 Instance ID Update
	 * - 결재정보 공통 테이블에 결재정보 Insert or Update
	 * </pre>
	 *
	 * @param list
	 * @return
	 * @throws Exception
	 * @see com.hwfs.guide.sample.service.GuideSampleService#saveSign(hone.online.xplatform.map.DataSetMap)
	*/
	@SuppressWarnings("unchecked")
	public int saveSignInfo(DataSetMap list) throws Exception {
		int updateRowCnt = 0;

		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			//수정을 수행합니다. (Update만 존재)
			if (rowType == DataSet.ROW_TYPE_UPDATED) {
				//업무 테이블에 결재INSTANCE_ID update
				updateRowCnt += sapSlipSendReptDAO.updateSign(rowData);

				//SCC_SIGN_INFO 테이블에 결재정보저장 (Insert or Update)
				gwIfDAO.saveSignInfo(rowData);
			}
		}

		return updateRowCnt;
	}
	
	/**
	 * 전자결재정보를 Update 처리한다.(계약관리)
	 * <pre>
	 * - 업무 테이블에 Instance ID Update
	 * - 결재정보 공통 테이블에 결재정보 Insert or Update
	 * </pre>
	 *
	 * @param list
	 * @return
	 * @throws Exception
	 * @see com.hwfs.guide.sample.service.GuideSampleService#saveSign(hone.online.xplatform.map.DataSetMap)
	*/
	@SuppressWarnings("unchecked")
	public int saveSignInfo2(DataSetMap list) throws Exception {
		int updateRowCnt = 0;

		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			//수정을 수행합니다. (Update만 존재)
			if (rowType == DataSet.ROW_TYPE_UPDATED) {
				//업무 테이블에 결재INSTANCE_ID update
				updateRowCnt += sapSlipSendReptDAO.updateSign2(rowData);

				//SCC_SIGN_INFO 테이블에 결재정보저장 (Insert or Update)
				gwIfDAO.saveSignInfo(rowData);
			}
		}

		return updateRowCnt;
	}
	
	/**
	 * SAP I/F 연동
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveSapIfcSlip(DataSetMap list) throws Exception {
		
		int insRowCnt1 = 0;
		int insRowCnt2 = 0;
		String strChk = "";
		
//		System.out.println("※※※※※※※※※※ SAP I/F 연동 Strat ※※※※※※※※※※");
		
//		System.out.println("※※※※※※※※※※ list.size():"+list.size());
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			if(rowData.get("chk") != null)	strChk	= rowData.get("chk").toString();
			
//			System.out.println("["+i+"] ※※※※※※※※※※ slipNum:"+rowData.get("slipNum").toString());
			
			if("1".equals(strChk)){
				SlipMstList slipMstList = new SlipMstList();
				SlipDtlList slipDtlList = new SlipDtlList();
				
				RecordSet rsMst = sapSlipSendReptDAO.sapIfcSlipMst(rowData);
				RecordSet rsDtl = sapSlipSendReptDAO.sapIfcSlipDtl(rowData);
				
				slipMstList.setDataList(rsMst);
				slipDtlList.setDataList(rsDtl);
				
				EAIResponse res1 = eaiService.call(slipMstList);
				EAIResponse res2 = eaiService.call(slipDtlList);

				if (res1.isSuccess()){
					
					//SAP 전표전송 상태값을 저장한다.
					insRowCnt1 += sapSlipSendReptDAO.updateSlipStatusOfSlipMst(rowData);
				}
				if (res2.isSuccess()) insRowCnt2++;	
			}
		}
		
//		if(insRowCnt1 > 0){
//			System.out.println("※※※※※※※※※※ slipMstList 성공에 대한 처리 ※※※※※※※※※※");
//		}else{
//			System.out.println("※※※※※※※※※※ slipMstList 실패에 대한 처리 ※※※※※※※※※※");
//		}
		
//		if(insRowCnt2 > 0){
//			System.out.println("※※※※※※※※※※ slipDtlList 성공에 대한 처리 ※※※※※※※※※※");
//		}else{
//			System.out.println("※※※※※※※※※※ slipDtlList 실패에 대한 처리 ※※※※※※※※※※");
//		}		
		return insRowCnt1 + insRowCnt2;
	}
	
	/**
	 * 전표취소 SAP I/F 연동
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveSapIfcCancelSlip(DataSetMap list) throws Exception {

		int insRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			
			Map<String, Object> rowData = list.get(i);
//			System.out.println("※※※※※※※※※※ INSERT SLA_SAP_SLIP_CANCEL");
			insRowCnt += sapSlipSendReptDAO.insertSlaSapSlipCancel(rowData);	//SLA_SAP_SLIP_CANCEL	
			
			if(insRowCnt > 0){
				//condition.get(key)
				SlipCancelList slipCancelList = new SlipCancelList();
				
//				System.out.println("※※※※※※※※※※ SELECT SLA_SAP_SLIP_CANCEL");
				RecordSet rs = sapSlipSendReptDAO.selectSlaSapSlipCancel(rowData);
				
				slipCancelList.setDataList(rs);
				
				EAIResponse res = eaiService.call(slipCancelList);
		
				if (res.isSuccess()) {
					//SAP 전표전송 상태값을 저장한다.
					insRowCnt += sapSlipSendReptDAO.updateSlipCancelStatusOfSlipMst(rowData);
					//System.out.println("※※※※※※※※※※ slipCancelList 성공에 대한 처리 ※※※※※※※※※※");
					//logger.debug("※※※※※※※※※※ 성공에 대한 처리 ※※※※※※※※※※");
				}
//				else {
//					System.out.println("※※※※※※※※※※ slipCancelList 실패에 대한 처리 ※※※※※※※※※※");
//					logger.debug("※※※※※※※※※※ 실패에 대한 처리 ※※※※※※※※※※");
//				}
//			}else{
//				System.out.println("※※※※※※※※※※ slipCancelList 실패에 대한 처리(데이터 없음) ※※※※※※※※※※");
			}			
		}
		return insRowCnt;
	}
	
	/**
	 * 전표생성취소
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public String cancelSlipList(DataSetMap list) throws Exception {
		
		String nowSlipNum = "";
		String beforeSlipNum = "";
		String strRtn = "";
		String strRtnMsg = "";
		
		Map<String, Object> retVal = null;

//		System.out.println("########### 전표생성취소 Strat ############");

		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);

			if(rowData.get("slipNum") != null) nowSlipNum = rowData.get("slipNum").toString();
			
			if(!beforeSlipNum.equals(nowSlipNum)){
				
				sapSlipSendReptDAO.updateSapSlipMst(rowData);
				
//				try {
//					System.out.println("##### callProcedure Start #####");
					Map<String, Object> inParam = new HashMap<String, Object>();
					
					//입력값 Setting
					inParam.put("P_SLIP_NUM",		nowSlipNum);
					inParam.put("P_SLIP_STATUS",	"Z");
					
					//전표 생성시 분개번호 UPDATE procedure 호출
					retVal = sapSlipSendReptDAO.callProcedure(inParam, "SP_SLA_SLIP_NUM_CANCEL");
					
					//출력값 Setting
					strRtn		= String.valueOf(retVal.get("O_RTN"));
					strRtnMsg	= String.valueOf(retVal.get("O_RTNMSG"));
					
//					System.out.println("##### callProcedure End #####");
//				} catch (Exception e) {
//					logger.debug(e.getMessage());
					//strRtn    = "CALL PROCEDURE ERROR";
					//strRtnMsg = e.getMessage();
//					throw e;
//				}
			}
			//초기화
			beforeSlipNum = nowSlipNum;
		}
//		System.out.println("########### 전표생성취소 End ############");
		
		return strRtn + "|" + strRtnMsg;
	}
	
//	/**
//	 * SAP IF로 멀티자료(을)를 Insert/Update/Delete 처리한다.
//	 * <pre>
//	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
//	 * </pre>
//	 *
//	 * @param xpDto
//	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
//	 * @return
//	 *            ModelAndView XPLATFORM에 처리결과를 전달
//	 * @throws Exception
//	 */
//	@RequestMapping("saveList.xdo")
//	public ModelAndView saveList(
//			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
//
//		//XPLATFORM에 결과를 전달할 객체 생성
//		ModelAndView mav = super.createModelAndView();
//
//		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
//		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
//		DataSetMap parameter = param.get("ds_list");
//
//		//SAP IF로 멀티자료을(를) 등록, 수정, 삭제 처리한다.
//		int processCnt = sapIfMultiDataProcessService.saveList(parameter);
//
//		//처리건수를 OutVariable에 설정한다.
//		super.addOutVariable(mav, "fv_processCnt", processCnt);
//
//		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
//		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
//	}
	
//    /**
//     * createFiscalSlip 설명
//     * <pre>
//     * 회계전표 IF 버튼 클릭시 SAP
//     * </pre>
//     *
//     * @param parameter
//     * @return
//     * @see com.hwfs.ft.fgp.dao.GdspaymMstDAO.createFiscalSlip
//    */
//    @Override
//    @SuppressWarnings("unchecked")
//    public int createFiscalSlip(LoginDTO loginParameter
//            , DataSetMap search
//            , DataSetMap dsGdspaymList
//            ) throws Exception  {
//        int procCnt = 0;
//
//        ArrayList slipNums = new ArrayList();
//
//        for (int i = 0 ; i < dsGdspaymList.size() ; i++) {
//            Map<String, Object> rowData = dsGdspaymList.get(i);
//            int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
//
//            System.out.println("######################## orgPoOrderNum :"+rowData.get("orgPoOrderNum"));
//            System.out.println("######################## seq :"+rowData.get("seq"));
//            String seq = LimsUtil.checkNull(rowData.get("seq"),"");
//            //Update 처리
//            if (rowType == DataSet.ROW_TYPE_UPDATED)
//            {
//                if ( "".equals(seq) )
//                {
//                    String slipNum = sapSlipSendReptDAO.selectSlipNum(rowData);
//                    System.out.println("######################## slipNum :"+slipNum);
//                    slipNums.add(i, slipNum);
//                    System.out.println("####insert####");
//                    rowData.put("slipNum", slipNum);	//외부문서번호
//                    rowData.put("slipStatus", "10");	//전표 등록
//                    int maxSeq = sapSlipSendReptDAO.getMaxSeq(rowData);
//                    System.out.println("######################## maxSeq :"+maxSeq);
//                    rowData.put("seq", maxSeq);
//                    procCnt += sapSlipSendReptDAO.insert(rowData);
//
//                }
//                else
//                {
//                    System.out.println("####update####");
//                    procCnt += sapSlipSendReptDAO.update(rowData);
//                }
//            }
//        }
//
//        //PO 후상태 - PO 확정이후의 상태(수입은 매입전표생성) Y를 UPDATE하고 확정취소 불가 처리
//        if ( dsGdspaymList.size() > 0 ) {
//            for (int i = 0 ; i < dsGdspaymList.size() ; i++) {
//                Map<String, Object> parameter = dsGdspaymList.get(i);
//
//
//                //sap모듈 호출후 성공하면후 하단 로직 처리
//
//                if ( "".equals(parameter.get("seq")) )
//                {
//                    System.out.println("####insert####");
//                    System.out.println("######################## payCondSeq :"+parameter.get("payCondSeq"));
//                    //parameter.put("seq", parameter.get("payCondSeq"));
//
//                    parameter.put("slipNum", slipNums.get(i));
//                    System.out.println("######################## slipNum :"+slipNums.get(i));
//                }
//
//                String currYymmdd = LimsUtil.getDate("yyyyMMddHHmmss");
//                SlipMstDTO mst = new SlipMstDTO();
//
////                String slipNum = sapSlipSendReptDAO.selectSlipNum(parameter);
////                System.out.println("slipNum :"+slipNum);
//
//                mst.setSlipNum(slipNums.get(i).toString());	            ///SAP과 연결 키 -유일키
//                mst.setBuCd("2000");		            //회사코드
//                mst.setSlipType("7K");	            //전표유형
//                mst.setSlipEvidenceDate(parameter.get("buySlipDate").toString());	//전표증빙일자 - 매입전표일자
//                mst.setSlipPeriodDate(parameter.get("buySlipDate").toString());	//전표전기일자 - 매입전표일자
//                mst.setCurrency("KRW");				//통화
//
//                System.out.println("######################## currYymmdd :"+currYymmdd);
//                mst.setInputDate(currYymmdd.substring(0,8));			//입력일자
//                mst.setInputTime(currYymmdd.substring(8));			//입력시간 -6자리
//                mst.setWriteEmpSabun(parameter.get("slipPublisher").toString());	//작성사원부서 : 로그인사번
//                mst.setWriteEmpDept(parameter.get("empDept").toString());		//작성사원부서
//                mst.setWriteEmpMuCd(parameter.get("empMuCd").toString());
//                mst.setSysCd("IFC");											//시스템코드
//                mst.setElctnSignId("12345");									//전자결재ID - 임시세팅
//                mst.setSignStatus("COMPLETE");								//전표상태 - 임시세팅
//
//                List<SlipMstDTO> master = new ArrayList<SlipMstDTO>();
//                master.add(mst);
//
//                SlipMstList mstList = new SlipMstList();
//                mstList.setDataList(master);
//
//                int ii = 0;
//                List<SlipDtlDTO> detail = new ArrayList<SlipDtlDTO>();
//                //차변 만들기 : 상품_일반상품
//                SlipDtlDTO dtl1_1 = new SlipDtlDTO();	  //
//                dtl1_1.setSlipNum(slipNums.get(i).toString());	            ///SAP과 연결 키 -유일키
//                dtl1_1.setBuCd("2000");
//                dtl1_1.setSlipType("7K");	            //전표유형
//                dtl1_1.setMasterAcct("11404000");		//상품_미착품
//                dtl1_1.setDrCrClass("1");				//1:차변
//                dtl1_1.setSlipEvidenceDate(parameter.get("buySlipDate").toString());	//전표증빙일자 - 매입전표일자
//                dtl1_1.setSlipPeriodDate(parameter.get("paySchdDate").toString());	//전표전기일자 - 지불예정일자
//
//                dtl1_1.setSlipCurrencyAmt( BigDecimal.valueOf(Long.parseLong(parameter.get("signAmt").toString())) );					//전표통화금액 :결재금액
//                dtl1_1.setItemText(parameter.get("remarks2").toString());			//품목텍스트 - 적요2
//                dtl1_1.setLcNum(parameter.get("lcNum").toString());	//LC번호
//                dtl1_1.setPoNum(parameter.get("poOrderNum").toString());	//PO번호
//                dtl1_1.setAttachDept(parameter.get("attachDept").toString());		//귀속부서
//                dtl1_1.setMgmtDept(parameter.get("attachDept").toString());		//관리부서-귀속부서와 동일
//                //관리항목 필수(문의필요)
//                dtl1_1.setMgmtArticle( parameter.get("salsplceCd").toString() );			//관리항목 : 거래처: 확인필요
//                dtl1_1.setBlDate(parameter.get("blAcceptDate").toString());	//BL일자
//                dtl1_1.setLshipDate(parameter.get("lshipDate").toString());	//선적일자
//
//                dtl1_1.setDtlNum(new BigDecimal(ii++)); 	//회계 전표의 개별 항목 번호
//
//                detail.add(dtl1_1);
//
//
//                //대변 계정만들기 : 외상매입금_거래처
//                SlipDtlDTO dtl2_1 = new SlipDtlDTO();
//                dtl2_1.setSlipNum(slipNums.get(i).toString());	                                                    //SAP과 연결 키 -유일키
//                dtl2_1.setBuCd("2000");					                                        //회사 코드
//                dtl2_1.setSlipType("7K");	            	                                    //전표유형
//                dtl2_1.setSlipEvidenceDate(parameter.get("buySlipDate").toString());	        //전표증빙일자 - 매입전표일자
//                dtl2_1.setSlipPeriodDate(parameter.get("paySchdDate").toString());	            //전표전기일자 - 매입전표일자
//                dtl2_1.setDtlNum(BigDecimal.valueOf(ii++)); 	                                //회계 전표의 개별 항목 번호
//                dtl2_1.setMasterAcct("21101010");			                                    //외상매입금_거래처
//                dtl2_1.setDrCrClass("2");					                                    //2:대변
//
//                dtl2_1.setSlipCurrencyAmt( BigDecimal.valueOf(Long.parseLong(parameter.get("signAmt").toString())) );					//전표통화금액 :결재금액
//                dtl2_1.setSupplyplceNum( "" );					//공급처번호
//                dtl2_1.setItemText(parameter.get("remarks2").toString());			                //품목텍스트 - 적요2
//                dtl2_1.setPayCond(parameter.get("payCondNm").toString());			                //지급조건
//                dtl2_1.setAttachDept(parameter.get("attachDept").toString());		                //귀속부서
//                dtl2_1.setMgmtDept(parameter.get("attachDept").toString());		                //관리부서-귀속부서와 동일
//
//                detail.add(dtl2_1);
//
//                SlipDtlList dtlList = new SlipDtlList();
//                dtlList.setDataList(detail);
//
//                EAIListMap map = new EAIListMap();
//                map.addEAIList("master", mstList);
//                map.addEAIList("detail", dtlList);
//
//                EAIResponse res = eaiService.call(map);
//
//                if (res.isSuccess()) {
//                    logger.debug("성공");
//                }
//                else {
//                    logger.debug(res.getErrorMsg());
//                    throw processException(res.getErrorMsg());
//
//                }
//
//                //1.전표상태 등록 update
//                parameter.put("slipStatus", "20");	  //전표상태(생성)
//                procCnt += sapSlipSendReptDAO.createFiscalSlip(parameter);
//
//                //2.PO후 상태 Y 업데이트
//                parameter.put("poAfterstatus", "Y");	  //PO 후상태 - PO 확정이후의 상태(수입은 매입전표생성) Y를 UPDATE하고 확정취소 불가 처리
//                procCnt += poOrderMstDAO.updatePoAfterstatus(parameter);
//            }
//        }
//
//        return procCnt;
//    }
//
//    /**
//     * createFiscalSlip 설명
//     * <pre>
//     * 회계전표 IF 취소 버튼 클릭시 SAP
//     * </pre>
//     *
//     * @param parameter
//     * @return
//     * @see com.hwfs.ft.fgp.dao.GdspaymMstDAO.cancelFiscalSlip
//    */
//    @Override
//    @SuppressWarnings("unchecked")
//    public int cancelFiscalSlip(LoginDTO loginParameter
//            , DataSetMap search
//            , DataSetMap dsGdspaymList
//            ) throws Exception  {
//        int procCnt = 0;
//
//        //PO 후상태 - PO 확정이후의 상태(수입은 매입전표생성) Y를 UPDATE하고 확정취소 불가 처리
//        if ( dsGdspaymList.size() > 0 ) {
//            for (int i = 0 ; i < dsGdspaymList.size() ; i++) {
//                Map<String, Object> parameter = dsGdspaymList.get(i);
//
//                RecordSet rs = sapSlipSendReptDAO.selectChkCancelInfo(parameter);
//                //전표 I/F 취소는 매입대금결제일과, 결제환율,결제금액이 공백일 때만 가능하다.
//                String buyPaymSettledd = LimsUtil.checkNull(rs.get(0).getString("buyPaymSettledd"),"");
//                String settleExchangeRate = LimsUtil.checkNull(rs.get(0).getString("settleExchangeRate"),"");
//                String signAmt = LimsUtil.checkNull(rs.get(0).getString("signAmt"),"");
//                System.out.println("########################  buyPaymSettledd :::"+buyPaymSettledd+"//"+settleExchangeRate+"//"+signAmt);
////                if ( "".equals(buyPaymSettledd) &&  "".equals(settleExchangeRate) &&  "".equals(signAmt)  )
////                {
//                    System.out.println("#### 1");
//                    //sap모듈 취소후 성공하면후 하단 로직 처리
//
//                    parameter.put("slipStatus", "10");	  //전표상태(등록)
//                    procCnt += sapSlipSendReptDAO.cancelFiscalSlip(parameter);
////                }
////                else
////                {
////                    System.out.println("####2");
////                    throw processException("ft.fgp.fail.gdspaym");	//전표 확정상태에서는 전표 I/F 취소가 불가합니다.
////                }
//
//                RecordSet slitrs = sapSlipSendReptDAO.selectChkSlitCnt(parameter);
//                System.out.println("########################  cnt ::"+slitrs.get(0).getInt("cnt") );
//                if ( slitrs.get(0).getInt("cnt") ==  0 )	  //전표생성 단계가 없으면 po후 생태 N로 업데이트
//                {
//                    parameter.put("poAfterstatus", "N");
//                    procCnt += poOrderMstDAO.updatePoAfterstatus(parameter);
//                }
//            }
//        }
//        return procCnt;
//    }
    

	
}
