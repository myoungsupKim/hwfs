package com.hwfs.fm.fmc.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.fm.fmc.dao.ClaimAcceptDAO;
import com.hwfs.fm.fmc.dao.ClaimProcDAO;
import com.hwfs.fm.fmc.dao.ClaimRegDAO;
import com.hwfs.fm.fmo.dao.OrderRequestChangeDAO;
import com.hwfs.fm.fmo.dao.OrderRequestDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.sap.EAIRequest;
import com.hwfs.sc.cmn.sap.EAIResponse;
import com.hwfs.sc.cmn.sap.request.InOutDescRequest;
import com.hwfs.sc.cmn.sap.service.EAIService;
import com.hwfs.sc.cmn.util.Const;
import com.hwfs.sc.cmn.util.NumberUtil;
import com.hwfs.sc.cmn.util.StringUtil;
import com.hwfs.sc.cmn.util.ValidationUtil;
import com.sz.business.BusinessRuntimeException;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 클레임처리하는 ClaimProc Service Implementation
 * 
 * @ClassName ClaimProcServiceImpl.java
 * @Description ClaimProcServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.21    최영준        최초생성
 *  2021.08.17    DEV02         [PJT]주문채널통합
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015.05.21
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fmc/claimProcService")
public class ClaimProcServiceImpl extends DefaultServiceImpl implements ClaimProcService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Resource(name = "EAIService")
	EAIService eaiService;
	
	/** ClaimProcDAO Bean 생성 */
	@Resource(name = "/fm/fmc/claimProcDAO")
	private ClaimProcDAO claimProcDAO;
	
	
	/** ClaimAcceptDAO Bean 생성 */
	@Resource(name = "/fm/fmc/claimAcceptDAO")
	private ClaimAcceptDAO claimAcceptDAO;

	/** ClaimRegDAO Bean 생성 */
	@Resource(name = "/fm/fmc/claimRegDAO")
	private ClaimRegDAO claimRegDAO;
// [속도개선 Project 시작] 2017. 8. 17. 최범주 여신금액 집계 프로시저 추가
	/** OrderRequestChangeDAO Bean 생성 */
	@Resource(name = "/fm/fmo/orderRequestChangeDAO")
	private OrderRequestChangeDAO orderRequestChangeDAO;

	/** OrderRequestDAO Bean 생성 */
	@Resource(name = "/fm/fmo/orderRequestDAO")
	private OrderRequestDAO orderRequestDAO;
// [속도개선 Project   끝] 2017. 8. 17. 최범주
	/**
	 * 클레임처리 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		// CENTER_CODE 다중 처리 : 2016-01-11
		mapParam.put("schCode", inCode(mapParam.get("schCode").toString()));
		
		if (!LimsUtil.checkNull(mapParam.get("schMuCd")).equals("")) {
			mapParam.put("schMuCd", inCode(mapParam.get("schMuCd").toString()));
		}
		
		if (!LimsUtil.checkNull(mapParam.get("schTmCd")).equals("")) {
			mapParam.put("schTmCd", inCode(mapParam.get("schTmCd").toString()));
		}
		return claimProcDAO.selectList(mapParam);
	}

	/**
	 * 클레임처리 목록을 조회한다.
	 * [PJT]주문채널통합
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectBrandList(Map<String, Object> mapParam) throws Exception {
		// CENTER_CODE 다중 처리 : 2016-01-11
		mapParam.put("schCode", inCode(mapParam.get("schCode").toString()));
		
		if (!LimsUtil.checkNull(mapParam.get("schMuCd")).equals("")) {
			mapParam.put("schMuCd", inCode(mapParam.get("schMuCd").toString()));
		}
		
		if (!LimsUtil.checkNull(mapParam.get("schTmCd")).equals("")) {
			mapParam.put("schTmCd", inCode(mapParam.get("schTmCd").toString()));
		}
		return claimProcDAO.selectBrandList(mapParam);
	}
	
	/**
	 * 자재 목록을 조회한다.
	 *
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	public RecordSet returnItemSearch(Map <String, Object> parm,Map <String, Object> inVar) throws Exception {
		parm.put("schFromDate", inVar.get("schFromDate"));
		parm.put("schToDate", inVar.get("schToDate"));
		if(!inVar.get("schCenterCode").equals("*"))	parm.put("schCenterCode", inVar.get("schCenterCode"));
		if(!inVar.get("ctKind").equals("undefined"))	parm.put("ctKind", inVar.get("ctKind"));
		// CENTER_CODE 다중 처리 : 2016-01-11
		if(!inVar.get("schCode").equals("undefined"))	parm.put("schCode", inCode(inVar.get("schCode").toString()));
		return claimProcDAO.returnItemSearch(parm);
	}

	/**
	 * 클레임처리 DataSetMap의 데이터를 Update 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	@SuppressWarnings("unchecked")
	public Map<String, Object> saveList(DataSetMap list, LoginDTO loginDTO) throws Exception {
		Map<String, Object> retProcItemVal = new HashMap<String, Object>();
		int updRowCnt = 0;
		List<Map<String, Object>> eailist = null;
				
		// 리조트 IF 관련 세팅
		//String hnrUrl = "http://172.16.1.121:8092/login.ctest.json"; // 성공 url (SAMPLE)
		//String hnrUrl = "http://172.16.1.121:8092/login.ctest1.json"; // 실패 url (SAMPLE)
		String hnrUrl = propertiesService.getString("hnrFicsClaim.url");
		
	try{	
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			//Update 처리
			if (rowType == DataSet.ROW_TYPE_UPDATED) {
				
				// 처리상태 재확인
				RecordSet rs = claimProcDAO.selectPrcsStatus(rowData);
				if ( rs.size() != 1 ) {
					throw new BizException("클레임 진행상태를 확인할 수 없습니다.["+rowData.get("itemCode")+":"+rowData.get("itemName")+"]");
				} else {
					if ( "09".equals(rs.get(0).getString("prcsStatus").toString()) ){
						throw new BizException("["+rs.get(0).getString("itemCode")+"]"+rs.get(0).getString("itemName")+"는 이미 처리완료됐습니다.");
					}
				}
				
				//  C0519 : 업체주의요청(식재사업부 전용)
				if("1".equals(rowData.get("chk").toString()) && "09".equals(rowData.get("prcsStatus").toString()) && !"C0519".equals(rowData.get("ctClaimKind").toString()) ){
					
					logger.debug("procRtQty : "+BigDecimal.valueOf(Double.valueOf(rowData.get("procRtQty").toString())));		//반품수량
					logger.debug("unitPrice : "+BigDecimal.valueOf(Double.valueOf(rowData.get("unitPrice").toString())));	//구매단가
					logger.debug("poAmt : "+Double.valueOf(rowData.get("procRtQty").toString()) * Double.valueOf(rowData.get("unitPrice").toString()));//반품금액
					
					/* ******************************************************************************* */
					/* 식권 클레임처리. */
					/* ******************************************************************************* */
					String ticketFlag = claimAcceptDAO.ticketFlag(rowData);
					
					if(!"TRUE".equals(ticketFlag)){
						throw new BizException("매출 또는 선수금 등록 건이 있어 식권 전량폐기가 불가능 합니다.");
					}
					
					logger.debug("rowData : " + rowData);
					Map<String, Object> pTicketMap = new HashMap<String, Object>();//TICKET
					pTicketMap.put("p_upjang", 	  	String.valueOf(rowData.get("upjang")));
					pTicketMap.put("p_item_code", 	  	String.valueOf(rowData.get("itemCode")));
					
					retProcItemVal  = claimProcDAO.sp_fs_claim_ticket_del(pTicketMap);
					
					if(!"S".equals(retProcItemVal.get("O_RTN_CD").toString())) {
						throw new BizException(retProcItemVal.get("O_RTN_MSG").toString());
					}
					
					/* ******************************************************************************* */
					/* 구매 및 입출고 내역 */
					/* ******************************************************************************* */
				
					Map<String, Object> pMap = new HashMap<String, Object>();
					pMap.put("p_po_no", 	  	String.valueOf(rowData.get("poNo")));
					pMap.put("p_po_lno", 	  	String.valueOf(rowData.get("poLno")));
					pMap.put("p_trans_date",  	String.valueOf(rowData.get("transDate")));
					pMap.put("p_trans_qty", 	rowData.get("procRtQty"));
					pMap.put("p_item_cd", 	 	String.valueOf(rowData.get("itemCode")));
					pMap.put("p_wh_cd", 		String.valueOf(rowData.get("subinvCode")));
					pMap.put("p_claim_id",  	String.valueOf(rowData.get("loginSabun")));
					pMap.put("p_prog_claim",  	String.valueOf(rowData.get("ctKind")));
					pMap.put("p_comp_claim",  	String.valueOf(rowData.get("ctClaimKind")));
					pMap.put("p_resp_claim",  	String.valueOf(rowData.get("linkDept")));				
					pMap.put("p_req_cont",  	String.valueOf(rowData.get("reqKindNm")));
					pMap.put("p_dtl_cont",  	String.valueOf(rowData.get("claimMemo")));
					pMap.put("p_etc_cont",  	String.valueOf(rowData.get("etcMemo")));
					pMap.put("p_prog_dtl_cont",  	String.valueOf(rowData.get("ctMemo")));
					
					logger.debug("클레임 처리 구매 I/F : " + pMap.toString());
		            retProcItemVal  = claimProcDAO.pk_excute(pMap);
		            logger.debug("클레임 처리 구매 I/F  결과: " + retProcItemVal.toString());
		            
		            if("S".equals(retProcItemVal.get("O_RTN_CD").toString())) {
		            	
		            	rowData.put("claimRemark", retProcItemVal.toString());
		            	updRowCnt += claimProcDAO.update(rowData);
		            	
		            	// EPROCUSR.ESISALP trigger 유발
		            	if ( retProcItemVal.get("O_RTN_MG_NO") != null ) {
		            		String mgNoTrg = retProcItemVal.get("O_RTN_MG_NO").toString();
		            		if ( mgNoTrg.indexOf("MG") == 0 ) {
			            		rowData.put("mgNoTrg", mgNoTrg);
			            		claimProcDAO.transDate2Update(rowData);
		            		}
		            	}
		            	logger.debug("[rowData_trigger]" + rowData);
		            	
		            	//////////////////////////////////////////////////////////////////////////////////////////////////////////
		            	// 클레임 처리결과가 감량, 반품일 경우
		            	if ( ValidationUtil.isEqualsOr(rowData.get("ctKind").toString(), StringUtil.concatStrListByDelim("|", Const.CLM_PROC_C0301, Const.CLM_PROC_C0303)) ) {
		            		String p_upjang_cd      = rowData.get("upjang").toString();    // (필수)업장코드
		            		String p_apply_date     = rowData.get("needDate").toString();  // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
		            		double p_occur_amt        = 0;                                   // (필수)발생금액
		            		double p_occur_amt_before = 0;                                   // (필수)발생금액(전)
		            		String p_key_value01    = rowData.get("poId").toString();      // 키1
		            		String p_key_value02    = rowData.get("poNum").toString();     // 키2
		            		String p_key_value03    = rowData.get("claimNum").toString();  // 키3
		            		double sellAmt          = 0;
		            		String itemCode         = rowData.get("itemCode").toString();
		            		String taxCode          = "";
		            		
		            		//////////////////////////////////////////////////////////////////////////////////////////////////////
		            		// 주문내역 자재의 과세구분 셋팅
		            		Map<String, Object> inParam = new HashMap<String, Object>();
		            		inParam.put("itemCode", itemCode);
		            		RecordSet mtrlsInfo = orderRequestChangeDAO.selectMtrlsTxnClss(inParam);
		            		if ( ValidationUtil.isEmpty(mtrlsInfo) ) {
		            			throw new BusinessRuntimeException("변경자재에대한 정보가 없습니다.");
		            		} else {
		            			taxCode = mtrlsInfo.get(0).getString("taxCode");
		            		}
		            		
		            		//////////////////////////////////////////////////////////////////////////////////////////////////////
		            		// 발생금액(전) 셋팅 (판매단가로 변경)
		            		if (taxCode.equals("100")) {
		            			sellAmt = Double.parseDouble(rowData.get("salePrice").toString()) * Double.parseDouble(rowData.get("procRtQty").toString()) * 1.1;  
		            		} else {
		            			sellAmt = Double.parseDouble(rowData.get("salePrice").toString()) * Double.parseDouble(rowData.get("procRtQty").toString());  
		            		}
		            		p_occur_amt_before = Math.round(sellAmt);
		            				            		
		            		Map<String, Object> rtnProcedure   = null;
		            		Map<String, Object> procedureParam = new HashMap<String, Object>();
		            		procedureParam.put("p_upjang_cd",        p_upjang_cd);               // (필수)업장코드
		            		procedureParam.put("p_apply_date",       p_apply_date);              // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
		            		procedureParam.put("p_occur_class",      "02");                      // (필수)발생구분(01:매입예정 02:매입확정 03:외상매출금)
		            		procedureParam.put("p_occur_amt",        p_occur_amt);               // (필수)발생금액
		            		procedureParam.put("p_occur_amt_before", p_occur_amt_before);        // (필수)발생금액(전)
		            		procedureParam.put("p_class_cd",         "09");                      // (필수)구분코드(01:주문신청관련 02:매출보정 03:판매단가변경 04:창고 강제변경 05:현지구매 06:영업회계 일마감 07:채권이관/입금처리)
		            		procedureParam.put("p_occur_table",      "PO_CLAIM_LIST");           // (필수)발생테이블
		            		procedureParam.put("p_key_nm",           "PO_ID+PO_NUM+CLAIM_NUM");  // (필수)키명
		            		procedureParam.put("p_key_value01",      p_key_value01);             // (필수)키1(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
		            		procedureParam.put("p_key_value02",      p_key_value02);             // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
		            		procedureParam.put("p_key_value03",      p_key_value03);             // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
		            		procedureParam.put("p_key_value04",      "");                        // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
		            		procedureParam.put("p_key_value05",      "");                        // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
		            		procedureParam.put("p_occur_prg_id",     "ClaimProc");               // 프로그램ID
		            		procedureParam.put("p_occur_prg_nm",     "클레임처리");              // 프로그램 한글명
		            		procedureParam.put("p_cuser",            loginDTO.getSabun());       // 생성자
		            		rtnProcedure = orderRequestDAO.procLncrTtz(procedureParam);
		            		
		            		if ( !ValidationUtil.isEquals(rtnProcedure.get("o_rtn").toString(), Const.YN_Y) ) {
		            			throw new BusinessRuntimeException(rtnProcedure.get("o_rtnmsg").toString());
		            		}
		            		
		            	}
		            	
		            	try{
		            		logger.debug("legcyReqNo : "  + rowData.get("legcyReqNo").toString());
			            	if("EAI".equals(rowData.get("legcyReqNo").toString()) && retProcItemVal.get("O_RTN_MG_NO") != null && retProcItemVal.get("O_RTN_MOVEMENT") != null){ // 일반자재만 예산체크 실행.
								logger.debug("procRtQty : "+BigDecimal.valueOf(Double.valueOf(rowData.get("procRtQty").toString())));		//반품수량
								logger.debug("unitPrice : "+BigDecimal.valueOf(Double.valueOf(rowData.get("unitPrice").toString())));	//구매단가
								double poamt = Double.valueOf(rowData.get("procRtQty").toString()) * Double.valueOf(rowData.get("unitPrice").toString());
								logger.debug("poAmt : "+poamt);//반품금액
								rowData.put("poAmt", poamt);
			            		rowData.put("mgNo", retProcItemVal.get("O_RTN_MG_NO").toString());
				            	rowData.put("movement", retProcItemVal.get("O_RTN_MOVEMENT").toString());
				            	logger.debug(rowData.get("poAmt").toString());
				            	logger.debug("EAI Call S");
				            	eailist = eaiCall(rowData);//예산체크
				            	logger.debug("EAI Call E");
				            	retProcItemVal.put("ret", eailist.get(0).get("ret").toString());
			            		retProcItemVal.put("msg", eailist.get(0).get("msg").toString());
			            	}
		            	} catch(BizException e){
		            		logger.debug("EAI ERROR : " + e.getMessage());
			            	retProcItemVal.put("ret", -1);
		            		retProcItemVal.put("msg", e.getMessage());
		            	}
		            	
		            } else {
		            	throw new BizException(retProcItemVal.get("O_RTN_MSG").toString());
		            }
	
				} 
				
				else if("1".equals(rowData.get("chk").toString()) && "10".equals(rowData.get("prcsStatus").toString())){ //취소
					claimRegDAO.claimHistorySave(rowData);//히스토리 저장.
					updRowCnt += claimProcDAO.delete(rowData);
				}else{
					updRowCnt += claimProcDAO.update(rowData);//처리중
				}
				
				
				// 입고일 7월 이후건만 HNR 인터페이스 대상 / 리조트픽스 IF 단건씩 처리 필요 
				if(Integer.parseInt(rowData.get("needDate").toString()) > 20220630) {
					// 체크 + 저장 + 리조트 업장 
					if("1".equals(rowData.get("chk").toString()) && "09".equals(rowData.get("prcsStatus").toString()) && "Y".equals(rowData.get("hnrUpjangYn").toString()) ){
						// 처리결과 유형 (C0301;감량  C0303;반품  C0309;리조트감량) 
						if(rowData.get("ctKind").toString().equals("C0301")||rowData.get("ctKind").toString().equals("C0303")||rowData.get("ctKind").toString().equals("C0309")) {
							
							// 인터페이스 시 리조트감량-> 감량으로 치환 후 전달 / 우리쪽 저장은 리조트감량으로
							String ctKindRep = "C0309".equals(rowData.get("ctKind").toString())  ? "C0301" : rowData.get("ctKind").toString();
							
							
							JSONObject data = new JSONObject();
							JSONArray req_array = new JSONArray();
							JSONObject jsonObject = new JSONObject();
							String inputLine = null; 
							StringBuffer outResult = new StringBuffer();
							
							URL url = new URL(hnrUrl);
							HttpURLConnection conn = (HttpURLConnection) url.openConnection();
							conn.setDoOutput(true);
							conn.setRequestMethod("POST");
							conn.setRequestProperty("Content-Type", "application/json");
							conn.setRequestProperty("Accept-Charset", "UTF-8");
							OutputStream os = conn.getOutputStream();
							
							data.put("prNum", rowData.get("poNum")); // 발주번호
							data.put("prId", rowData.get("poId")); // 발주항번
							data.put("claimNum", rowData.get("claimNum")); // 클레임번호
							data.put("itemCode", rowData.get("hnrItemCode")); // 리조트 자재코드
							data.put("subinvCode", rowData.get("hnrSubinvCode")); // 리조트 창고코드
							data.put("subulDate", rowData.get("transDate")); // 회계수정일
							data.put("qty", rowData.get("reqQty")); // 수량
							data.put("userId", rowData.get("mngSabun")); // 클레임요청사번
							data.put("claimType1", ctKindRep); // 처리클레임유형 
							data.put("rstYN", ""); // 결과상태 
							data.put("rstMSG", ""); // 결과메시지 
							
							//System.out.println("data : " + data);
							req_array.put(data);
							
							String json = jsonObject.put("claimlist", req_array).toString();
							//System.out.println("CLAIM IF RQ JSON ==> "+ json) ;
							
							os.write(json.getBytes("UTF-8"));
							os.flush();
							os.close();
							
							//System.out.println("ResponseCode : " + conn.getResponseCode());
							
							if (conn.getResponseCode() != 200) { 
					            throw new BizException("Failed: HNR CLAIM I/F HTTP error code : " + conn.getResponseCode());
					        } 
							
					        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
							
					        while ((inputLine = in.readLine()) != null) {
								outResult.append(inputLine);
							}
							
							
							in.close();
							
							conn.disconnect();
							String res=outResult.toString(); //API 호출 결과 string
							
							JSONObject resObject = new JSONObject(res); //API 호출결과 string -> json
							
							//System.out.println("CLAIM IF RS JSON ==> " + resObject);
							
							String apiResult = resObject.getString("success"); // 통신성공여부
							String totalRst = resObject.getString("totalRst"); // 전체결과여부
							
							if(apiResult.equals("true")) {
								//System.out.println("api 호출 성공");
								
								JSONArray resArray = resObject.getJSONArray("claimlist");
	
								for(int z=0; z<resArray.length(); z++) {
									
									JSONObject resObj = resArray.getJSONObject(z);
									Map<String, Object> paramMap = new ObjectMapper().readValue(resObj.toString(), Map.class); // json -> map
									paramMap.put("uuser", loginDTO.getSabun());
									//System.out.println("resObj cast to Param ==> " + paramMap);
									
									// API RS ARR 한줄 씩 인터페이스 결과 테이블에 update
									if(totalRst.equals("Y")) { // 전체결과가 성공일 경우
										//System.out.println("SUCCESS : API totalRst return Y ");
										claimProcDAO.updateInterfaceClaim(paramMap);
									} else { // 전체결과가 실패일 경우
										//System.out.println("Failed: API totalRst return N ");
										String returnMsg = paramMap.get("prNum") + "^" + paramMap.get("prId") + "^" + paramMap.get("claimType1") +  "^" + paramMap.get("rstYN") + "^" + paramMap.get("rstMSG");
										throw new BizException(returnMsg);
									}
								}
							} else {
								//System.out.println("Failed: API success return false");
					        	throw new BizException("Failed: HNR API success return false ");
							}
						}
					}
				}
			}
		}
	} finally {
		// 자원해제 필요 
		// System.out.println("자원해제");
		// os.close();
		// conn.disconnect();
	}
		
		return retProcItemVal;
	}
// [속도개선 Project   끝] 2017. 8. 4. 최범주
	
	public List<Map<String, Object>> eaiCall(Map<String, Object> rowData) throws Exception {
		List<Map<String, Object>> eailist = null;
		logger.debug("EAI Call ing");
		List<EAIRequest> inOutDescRequestList = new ArrayList<EAIRequest>();

		InOutDescRequest inOutDescRequest1 = new InOutDescRequest();
		inOutDescRequest1.setTyp("3");	//타입   1:PR
		inOutDescRequest1.setDocNo(rowData.get("mgNo").toString());	//구매문서번호 (PR/PO/GR/GI) 구매 I/F
		inOutDescRequest1.setDocLno("");	//문서항목
		inOutDescRequest1.setPoClose(rowData.get("poCompYn").toString());	//PO완료여부 -- 구매 PO_PO
		inOutDescRequest1.setPoCancl("N"); //취소여부
		inOutDescRequest1.setSlipYn("N");  //전표화여부
		inOutDescRequest1.setCcCd(rowData.get("ccCd").toString());	//CC_CO		* IO 번호와 CC_CO는 둘중 하나만 전송.
		inOutDescRequest1.setIoNo(rowData.get("pjtNo").toString());	//오더번호		* IO 번호와 CC_CO는 둘중 하나만 전송.
		inOutDescRequest1.setAccCd(rowData.get("acctcd").toString());		//계정코드
		inOutDescRequest1.setQty(BigDecimal.valueOf(Double.valueOf(rowData.get("procRtQty").toString())));		//반품수량
		inOutDescRequest1.setUnit(rowData.get("poUom").toString());	//수량단위
		inOutDescRequest1.setUPrice(BigDecimal.valueOf(Double.valueOf(rowData.get("unitPrice").toString())));	//구매단가
		inOutDescRequest1.setAmt(BigDecimal.valueOf(Double.valueOf(rowData.get("poAmt").toString())* -1));//반품금액
		inOutDescRequest1.setCur("KRW");//통화
		inOutDescRequest1.setRegDt(rowData.get("prDate").toString());//생성일   sysdate
		inOutDescRequest1.setGrFDt(rowData.get("transDate").toString());//수정일  trans_date
		inOutDescRequest1.setMvt(rowData.get("movement").toString());//이동유형    구매 I/F
		inOutDescRequest1.setPrNo(rowData.get("prNo").toString());//원시 PR번호  구매 PO_PO
		inOutDescRequest1.setPrLno(rowData.get("prLno").toString());//원시 PR항목  구매 PO_PO
		inOutDescRequest1.setPoNo(rowData.get("poNo").toString());//원시 PO번호  구매 PO_PO
		inOutDescRequest1.setPoLno(rowData.get("poLno").toString());//원시 PO항목  구매 PO_PO
		
		inOutDescRequestList.add(inOutDescRequest1);
		
		EAIResponse res = eaiService.call(inOutDescRequestList);
		
		if (res.isSuccess()) {
			eailist = res.getListMap();
		} else {
			// TODO :: 결과가 없거나 에러인 경우에 아래를 적절히 코딩하세요....
			logger.debug(res.getErrorCode() + " / " + res.getErrorMsg());
			if (res.getErrorCode() == -1) {
				logger.debug("조회된 결과가 없습니다.");
			} else {
				throw super.processException("eai.exception");	
			}
		}
		return eailist;
	}
	
	
	
	
	
	/**
	 * 클레임처리 [처리취소] 처리된 클레임을 다시 요청상태로 변경한다.  - 교환 처리된 클레임만 가능.
	 *
	 * @return int 
	 *            업데이트 건수
	 * @throws Exception
	*/
	public int cancelList(DataSetMap list) throws Exception {
		int updRowCnt = 0;
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			if("1".equals(rowData.get("chk").toString()) && ("09".equals(rowData.get("prcsStatus").toString()) || "11".equals(rowData.get("prcsStatus").toString()))){//체크된 데이터 기준.
				updRowCnt += claimProcDAO.cancelUpdate(rowData);
			}
		}
		return updRowCnt;
	}
	
	/**
	 * 클레임처리 [요청] 처리된 클레임을 삭제 HIST 테이블에 저장한다. [요청취소] 상태가 된다.
	 *
	 * @return int 
	 *            업데이트 건수
	 * @throws Exception
	*/
	public int reqCancelList(DataSetMap list) throws Exception {
		int updRowCnt = 0;
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			if("1".equals(rowData.get("chk").toString()) && "01".equals(rowData.get("prcsStatus").toString())){//체크된 데이터 기준.
				updRowCnt += claimProcDAO.reqCancelUpdate(rowData);
				//히스토리 테이블에 등록후 삭제. 
				claimProcDAO.delete(rowData);
			}
		}
		return updRowCnt;
	}
	
	
	/**
	 * 콤마 값을 IN 처리에 맞게 변경.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	public String inCode(String schCode) throws Exception {
		
		if(schCode.indexOf(',') != -1){
			return "'"+schCode.replaceAll(",", "','")+"'";
		}else{
			return "'"+schCode+"'";
		}
	}

	

	public int saveHnrIfHist(DataSetMap list, LoginDTO loginDTO) throws Exception {
		int updRowCnt = 0;
		Map<String, Object> rowData = list.get(0);
		rowData.put("uuser", loginDTO.getSabun());
		claimProcDAO.updateInterfaceClaim(rowData);
		return updRowCnt;
	}
}
