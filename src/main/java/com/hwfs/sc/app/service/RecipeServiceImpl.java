package com.hwfs.sc.app.service;

import hone.hanwha.CustomAnnotaion.CustomAnnotationDefinition;
import hone.core.util.record.MetadataRecord;
import hone.core.util.record.MetadataRecordSet;
import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.sc.app.dao.RecipeDAO;
import com.hwfs.sc.cmn.util.Const;
import com.hwfs.sc.cmn.util.StringUtil;
import com.hwfs.sc.cmn.util.ValidationUtil;

 /**
 * 식재앱 자동발주 인터페이스용  ServiceImpl에 대한 설명 작성
 * @ClassName RecipeServiceImpl.java
 * @Description RecipeServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.07.21.  구승모        최초생성
 * </pre>
 * @author 푸디스트
 * @since 2022.07.21.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by 한화시스템ICT CO.,LTD. All right reserved.
 * </pre>
 */
@Service
public class RecipeServiceImpl extends DefaultServiceImpl implements RecipeService {
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	@Resource(name="/sc/app/recipeDAO")
	private RecipeDAO recipeDAO;

	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param txHeader
	 * @param txData
	 * @param txResult
	 * @return
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	@CustomAnnotationDefinition(txId="IF_RECIPE_SERVICE",Description="식재앱 자동발주 인터페이스용 Service")
	public JSONObject callService(JSONObject txHeader, JSONObject txData,JSONObject txResult) throws Exception {

		String txDiv = "";
		
		if(txHeader.has("txDiv")){
			txDiv = txHeader.getString("txDiv");
		} else {
			logger.error("txDiv is empty!");
			throw new BizException ("txDiv is empty!");
		}
		
		String sParamString;
		
		Map<String, Object> parameter = new HashMap<String, Object>();

		RecordSet rs = null;
		
		//반환할 결과 데이터를 설정 : key 값은 업무에 맞게 설정
		JSONObject result = new JSONObject();
		JSONObject procResult = new JSONObject();

		if(txDiv.equals("SELECT_TEST")){
			
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = recipeDAO.selectTest(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "조회 중 오류가 발생했습니다.");
			} else {
				
				rs = removeNull(rs);
				
				JSONArray rsArray = new JSONArray(rs);
				
				procResult.put("resultData", rsArray.toString());
				procResult.put("resultCount", rs.size());
			}
			
		}

		//신규 레시피 조회
		else if(txDiv.equals("SelectNewRecipeInfo"))
		{
			
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = recipeDAO.selectNewRecipeInfo(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "신규 레시피 조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				if(rs.size() == 0)
				{
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", "신규 레시피 정보가 존재하지 않습니다.");
				}
				else
				{
					JSONArray rsArray = new JSONArray(rs);
					
					procResult.put("resultData", rsArray.toString());
					procResult.put("resultCount", rs.size());
					
					//중복자재 조회
					rs = null;
					rsArray = null;
					rs = recipeDAO.selectDuplRecipeItem(parameter);
					rsArray = new JSONArray(rs);					
					procResult.put("resultData2", rsArray.toString());
					
				}
			}			
			
		}
		
		//발주 레시피 조회
		else if(txDiv.equals("SelectPrRecipeInfo"))
		{
			
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = recipeDAO.selectPrRecipeInfo(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "발주 레시피 조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				if(rs.size() == 0)
				{
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", "발주 레시피 정보가 존재하지 않습니다.");
				}
				else
				{
					JSONArray rsArray = new JSONArray(rs);
					
					procResult.put("resultData", rsArray.toString());
					procResult.put("resultCount", rs.size());
					
					//삭제자재 조회
					rs = null;
					rsArray = null;
					rs = recipeDAO.selectPrDelRecipeInfo(parameter);
					rsArray = new JSONArray(rs);					
					procResult.put("resultData2", rsArray.toString());
				}
			}
		}
		
		//대체자재 조회
		else if(txDiv.equals("SelectReplaceItemInfo"))
		{
			
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = recipeDAO.selectReplaceItemInfo(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "대체자재 조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				if(rs.size() == 0)
				{
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", "대체자재 정보가 존재하지 않습니다.");
				}
				else
				{
					JSONArray rsArray = new JSONArray(rs);
					
					procResult.put("resultData", rsArray.toString());
					procResult.put("resultCount", rs.size());
				}
			}
		}
		
		//양념미곡 조회
		else if(txDiv.equals("SelectSpiceItemInfo"))
				{
					
					sParamString = txData.getString("data");
					JSONObject txParam = new JSONObject(sParamString);
					parameter = toMap(txParam);
					
					rs = recipeDAO.selectSpiceItemInfo(parameter);
					
					if(rs == null) {
						procResult.put("resultData", "");
						procResult.put("resultCount", 0);
						
						procResult.put("ErrorCode", -1); //오류
						procResult.put("ErrorMsg", "양념미곡 조회 중 오류가 발생했습니다.");
					} else {
						rs = removeNull(rs);
						
						if(rs.size() == 0)
						{
							procResult.put("resultData", "");
							procResult.put("resultCount", 0);
							procResult.put("ErrorCode", -1); //오류
							procResult.put("ErrorMsg", "양념미곡 정보가 존재하지 않습니다.");
						}
						else
						{
							JSONArray rsArray = new JSONArray(rs);
							
							procResult.put("resultData", rsArray.toString());
							procResult.put("resultCount", rs.size());
						}
					}
				}
		
//		//발주 삭제 레시피 조회
//		else if(txDiv.equals("SelectPrDelRecipeInfo"))
//		{
//			
//			sParamString = txData.getString("data");
//			JSONObject txParam = new JSONObject(sParamString);
//			parameter = toMap(txParam);
//			
//			rs = recipeDAO.selectPrDelRecipeInfo(parameter);
//			
//			if(rs == null) {
//				procResult.put("resultData", "");
//				procResult.put("resultCount", 0);
//				
//				procResult.put("ErrorCode", -1); //오류
//				procResult.put("ErrorMsg", "발주 삭제 레시피 조회 중 오류가 발생했습니다.");
//			} else {
//				rs = removeNull(rs);
//				
//				if(rs.size() == 0)
//				{
//					procResult.put("resultData", "");
//					procResult.put("resultCount", 0);
//					procResult.put("ErrorCode", -1); //오류
//					procResult.put("ErrorMsg", "발주 삭제 레시피 정보가 존재하지 않습니다.");
//				}
//				else
//				{
//					JSONArray rsArray = new JSONArray(rs);
//					
//					procResult.put("resultData", rsArray.toString());
//					procResult.put("resultCount", rs.size());
//					
//				}
//			}			
//			
//		}

		//식단발주저장
		else if(txDiv.equals("SaveRecipeInfo"))
		{
			JSONArray rsChkArray = null; //발주불가 데이터
			int rsCnt = 0;
			try {
		        int iInsCnt = 0;
		        int iDelCnt = 0;
		        int iUpdCnt = 0;
				int iAddCnt = 0; //추가 처리 건수
				int iUpdateCnt = 0; //수정 처리 건수
				int iDeleteCnt = 0; //수정 처리 건수
				int procCnt = 0; //처리건수
				int delMenuLogCnt = 0; //메뉴로그 삭제여부
				String sPrNum = ""; //주문번호
				String sOrgPrNum = ""; //최초주문번호
				String sPrDate = ""; //최초주문신청일
		        String sPrApprNum = "";
		        String sOtcustCD = "";
		        String sStatus = ""; // 신규신청이면 NEW, 기존 주문건 있으면 OLD
		        String sLineStatus = ""; // 발주 이후 구매주문상태 (신규발주일때는 reqType 사용)
		        String sReqType = ""; // 확정인지 임시저장인지 구분자 (임시 : 001, 확정 : 002)
		        String sPoType = ""; // 신청유형 (04:자동발주, 05:추가발주)
		        String sSubinvCd = "";
		        String sRowStatus = ""; // I,U,D(신규,수정,삭제)
		        String sMaxLineStatus = ""; // 주문상태
		        String purcProcRslt = ""; // 구매처리결과
		        String strValiPrId = ""; // 구매시스템 유효성체크할 PR_ID
				RecordSet rs1 = null; //prNum
				RecordSet rs2 = null; //발주합계 조회
				RecordSet rs3 = null; //유효성체크
				RecordSet rs4 = null; //prId
				String preChkLineStatus = ""; //사전체크 (수정시 진행상태변경 체크)
//				String[] arrDocuSource = {"07 FM(상품)", "07 FM", "01 BO", "07 FM(모바일)", "07 FM(식단)", "07 FM(주요)"};  // 상품발주, 구푸드엠주문, 통합영업주문, 모바일주문, 식단주문, 주요상품발주
				String docuSource = "07 FS(모바일)"; //삭제테이블에 모바일 구분을 위해
				String prNum = "";
		        double befGdsGnvAmtTot = 0;                                                                                 // 전상품발주금액합계
		        double aftrGdsGnvAmtTot = 0;
		        List<Map> beforelistMap = new ArrayList<Map>();  // 전상품발주금액합계
		        List<Map> afterlistMap = new ArrayList<Map>();  // 후상품발주금액합계
		        List<Map> poIflistMap = new ArrayList<Map>();  // 구매인터페이스용
		        
				boolean bOK = true;
				
				JSONArray datas = txData.getJSONArray("datas");
				
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				Map<String, Object> rowData = new HashMap<String, Object>();
				rowData.put("needDate", chkIsNull(datas,0,"needDate"));
				rowData.put("needDateYm", chkIsNull(datas,0,"needDate").substring(0,6));
				sStatus = chkIsNull(datas,0,"status");
				sPoType = chkIsNull(datas,0,"poType");
				sSubinvCd = chkIsNull(datas,0,"subinvCd");
				sReqType = chkIsNull(datas,0,"reqType");
				sPrDate = chkIsNull(datas,0,"prDate");
				sMaxLineStatus = chkIsNull(datas,0,"maxLineStatus");
				sPrNum = chkIsNull(datas,0,"prNum");
				sOrgPrNum = chkIsNull(datas,0,"orgPrNum");
				sPrApprNum = chkIsNull(datas,0,"prApprNum");
				
				//기존 발주내역 없을경우.. (기존발주내역이 있으면 신규자재 추가건도 발주번호 들고옴)
				if("".equals(chkIsNull(datas,0,"orgPrNum"))){
					//주문번호, 승인번호생성
					rs1 = recipeDAO.selectPrSeq(rowData);
					sPrNum = rs1.get(0).getString("prNum");
					sOrgPrNum = rs1.get(0).getString("prNum");
					sPrApprNum = rs1.get(0).getString("approveNum");
					//sPrNum = datas.getJSONObject(0).getString("prNum");
				} else { //신규
					if("Y".equals(chkIsNull(datas,0,"prAddYn")) && ("PC".equals(sMaxLineStatus) || "DL".equals(sMaxLineStatus))){
						//주문번호, 승인번호생성
						rs1 = recipeDAO.selectPrSeq(rowData);
						sPrNum = rs1.get(0).getString("prNum");
//						sPrApprNum = rs1.get(0).getString("approveNum");
					}
				}

				rowData.put("orgPrNum", sOrgPrNum); //최초주문번호
				rowData.put("poType", sPoType); //주문유형
				rowData.put("subinvCd", sSubinvCd); //창고코드
				rowData.put("prDate", sPrDate); //신청일자
				rowData.put("prNum", sPrNum); //주문번호
				rowData.put("prReason", chkIsNull(datas,0,"prReason")); //사유상세코드
				rowData.put("reasonCd", chkIsNull(datas,0,"reasonCd")); //사유코드
				rowData.put("prUpjangCd", chkIsNull(datas,0,"prUpjangCd")); //신청자업장
				rowData.put("sabun", chkIsNull(datas,0,"sabun")); //신청자사번
				
    			// 타입별 사전 체크 (수정중 자동발주:04, 추가발주:05)
    			if((!"NEW".equals(sStatus) && "04".equals(sPoType)) || "05".equals(sPoType)){
    				rs3 = recipeDAO.selectPreChk1(rowData); // 신청서 수정중  결의 작업이 있었는지 점검
    				if(rs3.size() > 0){
    					throw new Exception("결의중인 자재가 있습니다. - " + rs3.get(0).getString("itemName"));
    				}

    				if("05".equals(sPoType)){ //수불마감,재고마감 체크
    					rs3 = recipeDAO.selectPreChk2(rowData);
    					if(rs3.size() > 0){
    						throw new Exception("구매신청 불가!! 수불 마감 완료 창고 - 마감월 : " + rs3.get(0).getString("clsMonth"));
    					}
    					rs3 = recipeDAO.selectPreChk3(rowData);
    					if(rs3.size() > 0){
    						throw new Exception("구매신청 불가!! 재고 반영 완료 창고 - 재고반영일 : " + rs3.get(0).getString("clsDate"));
    					}
    				}
    			}
    			
    			// 배송중으로 변경된 자재 있는지 체크
				if(!"NEW".equals(sStatus)){
					rs3 = recipeDAO.selectPreChk4(rowData);
					for (int i=0 ; i < datas.length() ; i++) {
						if(!"I".equals(chkIsNull(datas,i,"rowStatus"))){
							for (int k=0 ; k < rs3.size() ; k++) {
								preChkLineStatus = rs3.get(k).getString("lineStatus");
								if(chkIsNull(datas,i,"prId").equals(rs3.get(k).getString("prId")) && !chkIsNull(datas,i,"lineStatus").equals(preChkLineStatus)){
									if("DL".equals(preChkLineStatus)){
										throw new Exception("신청서 수정 중 일부 자재 배송처리됨 : " + rs3.get(k).getString("itemName"));
									}
									if("U".equals(chkIsNull(datas,i,"rowStatus"))){
										if("003".equals(preChkLineStatus) || "999".equals(preChkLineStatus) || "PD".equals(preChkLineStatus)){
											throw new Exception("신청서 수정 중 일부 자재 취소처리됨 : " + rs3.get(k).getString("itemName"));
										}
									}
								}
							}
						}
					}
				}
				
				if (bOK)
				{
	    			for (int i=0 ; i < datas.length() ; i++) {
						Map<String, Object> rowData1 = new HashMap<String, Object>();
						Map<String, Object> rowData2 = new HashMap<String, Object>();
						sRowStatus = chkIsNull(datas,i,"rowStatus");
						sLineStatus = chkIsNull(datas,i,"lineStatus");
	
						rowData1.put("prUpjangCd", chkIsNull(datas,i,"prUpjangCd"));
						rowData1.put("rcUpjangCd", chkIsNull(datas,i,"rcUpjangCd"));
						rowData1.put("subinvCd", sSubinvCd);
						rowData1.put("muCd", chkIsNull(datas,i,"muCd"));
						rowData1.put("deptId", chkIsNull(datas,i,"deptId"));
						rowData1.put("needDate", chkIsNull(datas,i,"needDate"));
						rowData1.put("prNum", sPrNum);
						rowData1.put("prDate", sPrDate);
						rowData1.put("prId", chkIsNull(datas,i,"prId")); // 추가일땐 새로 채번
						rowData1.put("sabun", chkIsNull(datas,i,"sabun"));
						rowData1.put("prApprNum", sPrApprNum);
						rowData1.put("poType", sPoType);
						rowData1.put("docuGb", chkIsNull(datas,i,"docuGb"));
						rowData1.put("custcd", chkIsNull(datas,i,"custcd"));
						rowData1.put("centerCd", chkIsNull(datas,i,"centerCd"));
						rowData1.put("itemCd", chkIsNull(datas,i,"itemCd"));
						rowData1.put("itemNm", chkIsNull(datas,i,"itemNm"));
						rowData1.put("itemSize", chkIsNull(datas,i,"itemSize"));
						rowData1.put("poUom", chkIsNull(datas,i,"poUom"));
						rowData1.put("taxCode", chkIsNull(datas,i,"taxCode"));
						rowData1.put("buddeptId", chkIsNull(datas,i,"buddeptId"));
						rowData1.put("acctcd", chkIsNull(datas,i,"acctcd"));
						rowData1.put("budCls", chkIsNull(datas,i,"budCls"));
						rowData1.put("centerFlag", chkIsNull(datas,i,"centerFlag"));
						rowData1.put("unitPrice", chkIsNull(datas,i,"unitPrice"));
						rowData1.put("marginPrice", chkIsNull(datas,i,"marginPrice"));
						rowData1.put("marginRate", chkIsNull(datas,i,"marginRate"));
						rowData1.put("prQty", chkIsNull(datas,i,"prQty"));
						rowData1.put("invatFlag", chkIsNull(datas,i,"invatFlag"));
						rowData1.put("outvatFlag", chkIsNull(datas,i,"outvatFlag"));
						rowData1.put("kgQty", chkIsNull(datas,i,"kgQty"));
						rowData1.put("prRemark", chkIsNull(datas,i,"prRemark").replaceAll("'", "''"));
						rowData1.put("lineStatus", sReqType);
						rowData1.put("applySd", chkIsNull(datas,i,"applySd"));
						rowData1.put("upjangGrp", chkIsNull(datas,i,"upjangGrp"));
						rowData1.put("vdSn", chkIsNull(datas,i,"vdSn"));
						rowData1.put("mobileGubun", chkIsNull(datas,i,"mobileGubun"));
						rowData1.put("orgPrNum", sOrgPrNum);
						rowData1.put("remark", chkIsNull(datas,i,"remark").replaceAll("'", "''")); //삭제이력관리용
						rowData1.put("rowType", sRowStatus);
						rowData1.put("isEnf", chkIsNull(datas,i,"isEnf"));
	
						if("I".equals(sRowStatus)){
							//주문상세번호 채번
							rs4 = recipeDAO.selectPrIdSeq(rowData);
							rowData1.remove("prId");
							rowData1.put("prId", rs4.get(0).getString("prId"));
							
							iInsCnt += recipeDAO.saveRecipeOrderInfo(rowData1); //발주 저장
							if("04".equals(sPoType)){
								recipeDAO.updateRecipeItem(rowData1); //식단자동일 경우 식단정보 업데이트
							}
							iAddCnt++;
							logger.debug(">>>>>>>>>>>>>> 주문정보 생성");
							
							if("".equals(strValiPrId)){
								strValiPrId = rs4.get(0).getString("prId");
							} else {
								strValiPrId = strValiPrId + "','" + rs4.get(0).getString("prId");
							}
							
						}else if("D".equals(sRowStatus) || "UD".equals(sRowStatus)){ //자동발주 (신규 -> 삭제 : D, 수정 -> 삭제 : UD) / 추가발주 (수정 -> 삭제 : UD)
							if("04".equals(sPoType) && "UD".equals(sRowStatus)){
								rowData2.put("orderYn", "N");
								rowData2.put("prNum", "");
								rowData2.put("modPrId", "");
								rowData2.put("prQty", 0);
								rowData2.put("sabun", chkIsNull(datas,i,"sabun"));
								rowData2.put("prId", chkIsNull(datas,i,"prId"));
								recipeDAO.updateExistRecipeItem(rowData2); //자동발주 수정삭제일 경우 식단정보 업데이트
							}
							
							// 신청서에서 자재가 삭제되는건은 999로 저장 (자동발주, 추가발주 동일)
							iDelCnt += recipeDAO.deleteRecipeOrderInfo(rowData1);
								
							if("UD".equals(sRowStatus)){
								if (!"DL".equals(sLineStatus) && !"001".equals(sLineStatus) ) { //배송중,신청저장인 건은 제외
									if("".equals(strValiPrId)){
										strValiPrId = chkIsNull(datas,i,"prId");
									} else {
										strValiPrId = strValiPrId + "','" + chkIsNull(datas,i,"prId");
									}
								}
							}
							
							if("04".equals(sPoType)){ //자동발주는 삭제된 자재정보 별도 테이블에 저장
								if(delMenuLogCnt == 0){
									recipeDAO.deleteRecipeMenuLog(rowData); // 최초 삭제로그 테이블 비우기
									delMenuLogCnt++;
								}
								
								rs4 = recipeDAO.selectPrMenuLogIdSeq(rowData);
								rowData1.remove("prId");
								rowData1.put("prId", rs4.get(0).getString("prId"));
								rowData1.put("docuGb", docuSource); // 모바일 작업 확인용
								
								recipeDAO.saveRecipeMenuLog(rowData1); //삭제는 별도 테이블에 저장
								logger.debug(">>>>>>>>>>>>>> 주문삭제정보 생성");
							}
							iDeleteCnt++;
							
						}else if("U".equals(sRowStatus)){
							if("04".equals(sPoType)){
								rowData2.put("orderYn", "Y");
								rowData2.put("prNum", chkIsNull(datas,i,"orgPrNum"));
								rowData2.put("modPrId", chkIsNull(datas,i,"prId"));
								rowData2.put("prQty", chkIsNull(datas,i,"prQty"));
								rowData2.put("sabun", chkIsNull(datas,i,"sabun"));
								rowData2.put("prId", chkIsNull(datas,i,"prId"));
								recipeDAO.updateExistRecipeItem(rowData2); //식단자동일 경우 식단정보 업데이트
							}
							
							iUpdCnt += recipeDAO.updateRecipeOrderInfo(rowData1); //발주 수정
//							recipeDAO.updateRecipeItem(rowData1); //식단자동일 경우 식단정보 업데이트
							iUpdateCnt++;
							logger.debug(">>>>>>>>>>>>>> 주문정보 수정");
							
							if(!"DL".equals(sLineStatus)) { //배송중인 건은 제외
								if("".equals(strValiPrId)){
									strValiPrId = chkIsNull(datas,i,"prId");
								} else {
									strValiPrId = strValiPrId + "','" + chkIsNull(datas,i,"prId");
								}
							}
						}
						
	    			}
	    			procCnt = iInsCnt + iDelCnt + iUpdCnt;
					
	    			//식자재 단가계약이면서 식단구매신청이 아닐 경우 사유 저장
	    			if("NEW".equals(sStatus) && !"04".equals(sPoType)){
	    				recipeDAO.saveRecipeOrderReason(rowData);
	    			}
	    			
//	    			if(!"NEW".equals(sStatus)){
//		    			rs3 = recipeDAO.selectResolveChk(rowData); // 신청서 수정중  결의 작업이 있었는지 점검
//	    				if(rs3.size() > 0){
//	    					throw new Exception("결의중인 자재가 있습니다. - " + rs3.get(0).getString("itemName"));
//	    				}
//	    			}
	    			
	    			// 유효성 체크1
	    			rs3 = recipeDAO.selectRecipeValidChk1(rowData); // 유형별 D_DAY, D_TIME 가능한지 체크
	    			if("Y".equals(rs3.get(0).getString("closeYn"))){
	    				throw new Exception("입고예정일 기준 "+ rs3.get(0).getString("dDays") + "일 " +rs3.get(0).getString("dTimes") +"시");
	    			}
					logger.debug(">>>>>>>>>>>>>> 마감여부 체크완료");
					

					// 유효성 체크2
					if(!"".equals(sSubinvCd))
					{
						rs3 = recipeDAO.selectRecipeValidChk2(rowData); // 중복신청여부 최종 점검(동일한 품목/수량이 5분 안에 중복저장)	
	    				if(rs3.size() > 0){
	    					throw new Exception("5분이내 동일품목 동일수량 중복신청(" + rs3.get(0).getString("itemName") + " 외) 불가");
	    				}
					}
					logger.debug(">>>>>>>>>>>>>> 중복신청여부 체크완료");
						
					if("002".equals(sReqType)){
						if(strValiPrId.length() > 0){
							rowData.put("validPrId", strValiPrId); //주문번호
							rs3 = recipeDAO.selectRecipeValidChk3(rowData); // 구매 자재신청 유효성 체크
							if(rs3.size() > 0){
								rsChkArray = new JSONArray(rs3);
								rsCnt = rs3.size();
								throw new Exception("구매신청 불가 자재가 존재합니다.");
							}
							logger.debug(">>>>>>>>>>>>>> 구매신청 불가 자재 체크완료");
						}
						
						Map<String, Object> retProcItemVal = new HashMap<String, Object>();
						//추가건이 존재하는경우					
				        if(iAddCnt > 0 || "001".equals(sMaxLineStatus)){
				        	if("001".equals(sMaxLineStatus)){
				        		rowData.put("prNum", sOrgPrNum); //이전 상태가 임시저장인 경우 최초주문번호로
				        	}
				        	rs3 = recipeDAO.selectRecipeValidChk4(rowData); // 구매 자재신청 유효성 체크
				        	if(rs3.size() > 0){
				        		throw new Exception("해당 구매신청건에 대해 중복신청 되었습니다. - 신청번호 : " + rs3.get(0).getString("prNum"));
				        	}
				        	logger.debug(">>>>>>>>>>>>>> 구매신청 불가 자재 체크완료");
				        	
				        	/**************************************
							구매발주 프로시져 호출
							신규 저장할때 마다 PR_NUM을 채번한다.
							상태값 : 신규(C), 수정(U), 자재삭제(U)
				        	 ***************************************/						
				        	Map<String, Object> param = new HashMap<String, Object>();
				        	
				        	param.put("I_SYS_ID", "100"); //신청업장
				        	param.put("I_COMP_CD", "HFC"); //신청업장
				        	param.put("I_REQ_SYS_CD", "FR"); //신청업장
				        	param.put("I_PURC_TYP_CD", "MT"); //신청업장
				        	param.put("I_SHOP_CD", chkIsNull(datas,0,"rcUpjangCd")); //신청업장
				        	param.put("I_REQ_USR_ID", chkIsNull(datas,0,"sabun")); //신청자
				        	param.put("I_REQ_TYP_CD", sPoType); //신청업장
				        	if("001".equals(sMaxLineStatus)){
				        		param.put("I_REQ_NO", sOrgPrNum); //이전 상태가 임시저장인 경우 최초주문번호로
				        	}else{
				        		param.put("I_REQ_NO", sPrNum); //주문번호
				        	}
				        	param.put("I_REQ_CLS","C");
				        	
				        	retProcItemVal  = recipeDAO.sp_If_Recipe_Sales_Order(param);
				        	
				        	purcProcRslt = retProcItemVal.get("O_RTN_CD").toString();  // 구매처리결과
				        	
				        	if(!"S000".equals(purcProcRslt)){
				        		throw new Exception(retProcItemVal.get("O_RTN_MSG").toString());
				        	}
				        }
						
				        // 변경건이 존재할경우
						String strPrNum = "";
				        if (iUpdateCnt > 0 && !"001".equals(sMaxLineStatus)) {
				        	for (int i=0 ; i < datas.length() ; i++) {
				        		if("U".equals(sRowStatus) && !strPrNum.equals(chkIsNull(datas,i,"prNum"))){
				        			strPrNum = chkIsNull(datas,i,"prNum");
				        			logger.debug("수정 구매프로시져 호출 >>>>>>>>>>>>>> "+strPrNum);
				        			
						        	Map<String, Object> param = new HashMap<String, Object>();
						        	
						        	param.put("I_SYS_ID", "100"); //신청업장
						        	param.put("I_COMP_CD", "HFC"); //신청업장
						        	param.put("I_REQ_SYS_CD", "FR"); //신청업장
						        	param.put("I_PURC_TYP_CD", "MT"); //신청업장
						        	param.put("I_SHOP_CD", chkIsNull(datas,0,"rcUpjangCd")); //신청업장
						        	param.put("I_REQ_USR_ID", chkIsNull(datas,0,"sabun")); //신청자
						        	param.put("I_REQ_TYP_CD", sPoType); //신청업장
						        	param.put("I_REQ_NO", strPrNum); //주문번호
						        	param.put("I_REQ_CLS","U");
						        	
						        	retProcItemVal  = recipeDAO.sp_If_Recipe_Sales_Order(param);
						        	
						        	purcProcRslt = retProcItemVal.get("O_RTN_CD").toString();  // 구매처리결과
						        	
						        	if(!"S000".equals(purcProcRslt)){
						        		throw new Exception(retProcItemVal.get("O_RTN_MSG").toString());
						        	}
				        		}
				        	}
				        }
				        
				        // 삭제건이 존재할경우
				        strPrNum = "";
				        if (iDeleteCnt > 0 && !"001".equals(sMaxLineStatus)) {
				        	for (int i=0 ; i < datas.length() ; i++) {
				        		if("UD".equals(sRowStatus) && !strPrNum.equals(chkIsNull(datas,i,"prNum"))){
				        			strPrNum = chkIsNull(datas,i,"prNum");
				        			logger.debug("삭제 구매프로시져 호출 >>>>>>>>>>>>>> "+strPrNum);
				        			
				        			Map<String, Object> param = new HashMap<String, Object>();
				        			
				        			param.put("I_SYS_ID", "100"); //신청업장
				        			param.put("I_COMP_CD", "HFC"); //신청업장
				        			param.put("I_REQ_SYS_CD", "FR"); //신청업장
				        			param.put("I_PURC_TYP_CD", "MT"); //신청업장
				        			param.put("I_SHOP_CD", chkIsNull(datas,0,"rcUpjangCd")); //신청업장
				        			param.put("I_REQ_USR_ID", chkIsNull(datas,0,"sabun")); //신청자
				        			param.put("I_REQ_TYP_CD", sPoType); //신청업장
				        			param.put("I_REQ_NO", strPrNum); //주문번호
				        			param.put("I_REQ_CLS","U");
				        			
				        			retProcItemVal  = recipeDAO.sp_If_Recipe_Sales_Order(param);
				        			
				        			purcProcRslt = retProcItemVal.get("O_RTN_CD").toString();  // 구매처리결과
				        			
				        			if(!"S000".equals(purcProcRslt)){
				        				throw new Exception(retProcItemVal.get("O_RTN_MSG").toString());
				        			}
				        		}
				        	}
				        }
				        
		                logger.debug(">>>>>>>>>>>>>> 구매프로시저 종료");
					}

				}
				procResult.put("resultData", "");
				procResult.put("resultCount", procCnt);
			} catch (Exception e) {
				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();

				if(rsChkArray == null){
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", e.getMessage());    		
				}
				else{
					procResult.put("resultData", rsChkArray.toString());
					procResult.put("resultCount", rsCnt);
					procResult.put("ErrorCode", -91); //발주불가 오류
					procResult.put("ErrorMsg", e.getMessage());    	
				}    		
			}
		}
		
		//식단신청서 삭제
		else if(txDiv.equals("DeleteRecipePrInfo"))
		{
			try {
				int procCnt = 0; //처리건수
		        String purcProcRslt = ""; // 구매처리결과
				RecordSet rs1 = null; //유효성 체크
				RecordSet rs2 = null; //ORG_PR_NUM에 여러개의 PR_NUM이 존재할수 있으므로 ORG_PR_NUM으로 PR_NUM을 조회
		        
				sParamString = txData.getString("data");
				JSONObject txParam = new JSONObject(sParamString);
				parameter = toMap(txParam);
				
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				//needDate, prNum 사용
				rs1 = recipeDAO.selectRecipeDelValidChk(parameter);
				for (int i = 0; i < rs1.size(); i++) {
					Record rec = rs1.get(i);
					if("DL".equals(rec.getString("lineStatus"))){
						throw new Exception("배송중인 자재가 존재합니다.");
					}
					
					if(rec.getBigDecimal("diffDay").doubleValue() > 0 || (rec.getBigDecimal("diffDay").doubleValue() == 0 && rec.getBigDecimal("diffTime").doubleValue() <= 0)){
						throw new Exception("마감시간이 지난 자재가 존재합니다.");
					}
		        }
				
				if("04".equals(parameter.get("poType").toString())){
					recipeDAO.deleteRecipeItem(parameter); //식단자동일 경우 식단정보 업데이트
				}
				procCnt = recipeDAO.deletePrRecipeInfo(parameter); //발주삭제
				
				logger.debug(">>>>>>>>>>>>>> 주문정보 삭제");
				
				// 구매프로시저 호출
				if("002".equals(parameter.get("poLineStatusCd").toString()) || "PC".equals(parameter.get("poLineStatusCd").toString())){
					//org_pr_num으로 묶인 pr_num 조회
					rs2 = recipeDAO.selectRecipePrNum(parameter);
					
					Map<String, Object> retProcItemVal = new HashMap<String, Object>();
					for (int i = 0; i < rs2.size(); i++) {
						Record rec = rs2.get(i);
	        			logger.debug("구매프로시져 호출 >>>>>>>>>>>>>> "+rec.getString("prNum"));
	        			
	        			Map<String, Object> param = new HashMap<String, Object>();
	        			
	        			param.put("I_SYS_ID", "100"); //신청업장
	        			param.put("I_COMP_CD", "HFC"); //신청업장
	        			param.put("I_REQ_SYS_CD", "FR"); //신청업장
	        			param.put("I_PURC_TYP_CD", "MT"); //신청업장
	        			param.put("I_SHOP_CD", parameter.get("upjangCd").toString()); //신청업장
	        			param.put("I_REQ_USR_ID", parameter.get("sabun").toString()); //신청자
	        			param.put("I_REQ_TYP_CD", parameter.get("poType").toString()); //신청업장
	        			param.put("I_REQ_NO", rec.getString("prNum")); //주문번호
	        			param.put("I_REQ_CLS","D");
	        			
	        			retProcItemVal  = recipeDAO.sp_If_Recipe_Sales_Order(param);
	        			
	        			purcProcRslt = retProcItemVal.get("O_RTN_CD").toString();  // 구매처리결과
	        			
	        			if(!"S000".equals(purcProcRslt)){
	        				throw new Exception(retProcItemVal.get("O_RTN_MSG").toString());
	        			}
					}
				}
				
				procResult.put("resultData", "");
				procResult.put("resultCount", procCnt);
			} catch (Exception e) {
				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", e.getMessage());    		
			}
		}
		
		//추가발주 자재 조회
		else if(txDiv.equals("SelectAddRecipeInfo"))
		{
			
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
//			if("Y".equals(parameter.get("favOrderYn").toString())){
//				parameter.put("strItemCode", StringUtil.getWhereInQuery(parameter.get("grpItemCode").toString()));
//			}
			
			// MIN, MAX 필터값
			rs = recipeDAO.selectAddRecipeFilter(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "추가발주 자재 조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				if(rs.size() == 0)
				{
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", "추가발주 자재 정보가 존재하지 않습니다.");
				}
				else
				{
					JSONArray rsArray = new JSONArray(rs);
					
					procResult.put("resultData", rsArray.toString());
					procResult.put("resultCount", rs.size());
					
					//추가발주 자재 조회 (페이징, 필터 적용)
					rs = null;
					rsArray = null;
					
					rs = recipeDAO.selectAddRecipeInfo(parameter);
					rsArray = new JSONArray(rs);					
					procResult.put("resultData2", rsArray.toString());
					
				}
			}			
			
		}
		
		//추가발주 내역 조회
		else if(txDiv.equals("SelectPrAddRecipeInfo"))
		{
			
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = recipeDAO.selectPrAddRecipeInfo(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "추가발주 내역 조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				if(rs.size() == 0)
				{
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", "추가발주 내역정보가 존재하지 않습니다.");
				}
				else
				{
					JSONArray rsArray = new JSONArray(rs);
					
					procResult.put("resultData", rsArray.toString());
					procResult.put("resultCount", rs.size());
				}
			}
		}
		
		else
		{
			procResult.put("resultData", "");
			procResult.put("resultCount", 0);
			procResult.put("ErrorCode", -99); //오류
			procResult.put("ErrorMsg", "서비스ID가 올바르지 않습니다.");    									
		}
		
		procResult.put("txDiv", txDiv);

		result.put("data", procResult);

		//로그저장start
		int insLogCnt = 0;
		String tHeader = "";
		String tData = "";
		String tResult = "";
		tHeader = txHeader.toString();
		tData = txData.toString();
		tResult = result.getJSONObject("data").toString();
		parameter.put("txId", txHeader.getString("txId"));
		parameter.put("txDiv", txDiv);
		parameter.put("tHeader", tHeader);
		parameter.put("tData", tData);
		parameter.put("tResult", tResult);
		insLogCnt += recipeDAO.logInsert(parameter);
		//로그저장end
		
		return result;
	}
	
	/**
	 * 데이터 널 여부 체크
	 * isNull 기능 설명
	 *
	 * @param data
	 * @return
	 */
	public boolean isNull(String data){
		if(data == null || data.equals("")){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 데이터의 길이 체크
	 * isLength 기능 설명
	 *
	 * @param data
	 * @param lengthSize
	 * @return
	 */
	public boolean isLength(String data, int lengthSize){
		if(data.length() > lengthSize)return true;
		return false;
	}
	
	/**
	 * 데이터의 날짜 길이 체크
	 *
	 * @param data
	 * @return
	 */
	public boolean isDate(String data){
		if(data.length() == 8)return true;
		return false;
	}
	
	public String chkIsNull(JSONArray datas,int row,String col) throws Exception{
		String data = "";
		try{
			data = datas.getJSONObject(row).getString(col);
		}catch(Exception e){
			return "";
		}
		return data;
	}

    @SuppressWarnings("unchecked")
	public static Map<String, Object> toMap(JSONObject object) throws JSONException {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		Iterator <String> keys = object.keys();
		while(keys.hasNext()){
			String key = keys.next();
			Object value = object.get(key);
			
			if(value instanceof JSONArray){
				value = toList((JSONArray)value);
			}else if (value instanceof JSONObject){
				value = toMap((JSONObject)value);
			}
			map.put(key, value);
			
		}
		
		return map;
	}

	public static List<Object> toList(JSONArray array) throws JSONException {
		List<Object> list = new ArrayList<Object>();
		
		for(int i=0; i< array.length();i++){
			Object value = array.get(i);
			if(value instanceof JSONArray){
				value = toList((JSONArray)value);
			}else if(value instanceof JSONObject){
				value = toMap((JSONObject)value);
			}
			list.add(value);
		}
		return list;
	}

    public static RecordSet removeNull(RecordSet rs) {
    	
    	MetadataRecordSet result = new MetadataRecordSet(rs.getMetadata());
    	
		for(int i = 0; i < rs.size(); i++){
    		
			MetadataRecord metadataRecord = new MetadataRecord(rs.getMetadata());
			Iterator<String> meta = rs.getMetadata().getKeys();
			
			while(meta.hasNext()){
    			
				String key = meta.next();
    		
    			String value = rs.get(i).getString(key);
    			
    			if(value == null || "null".equals(value)){
    				value = "";
    			}
    			
    			metadataRecord.put(key, value);
			}
			
			result.add(metadataRecord);
    	}
    	return result;
    	
    }
	
}
