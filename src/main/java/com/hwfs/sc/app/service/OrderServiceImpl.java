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
import com.hwfs.sc.app.dao.OrderDAO;
import com.hwfs.sc.cmn.util.Const;
import com.hwfs.sc.cmn.util.ValidationUtil;

 /**
 * 식재앱 주문 인터페이스용  ServiceImpl에 대한 설명 작성
 * @ClassName OrderServiceImpl.java
 * @Description OrderServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.06.20.  김명섭        최초생성
 * </pre>
 * @author 푸디스트
 * @since 2022.06.20.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by 한화시스템ICT CO.,LTD. All right reserved.
 * </pre>
 */
@Service
public class OrderServiceImpl extends DefaultServiceImpl implements OrderService {
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	@Resource(name="/sc/app/orderDAO")
	private OrderDAO orderDAO;

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
	@CustomAnnotationDefinition(txId="IF_ORDER_SERVICE",Description="식재앱 주문 인터페이스용 Service")
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
			
			rs = orderDAO.selectTest(parameter);

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
		
		//자재이미지조회
		else if(txDiv.equals("SelectImgInfo"))
		{

			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);

			rs = orderDAO.selectImgInfo(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "자재이미지 조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				if(rs.size() == 0) //사용자정보없는경우
				{
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", "자재이미지 정보가 존재하지 않습니다.");
				}
				else
				{
					JSONArray rsArray = new JSONArray(rs);
					
					procResult.put("resultData", rsArray.toString());
					procResult.put("resultCount", rs.size());
					
				}
			}			
			
		}

		//즐겨찾기조회
		else if(txDiv.equals("SelectFavInfo"))
		{
		
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = orderDAO.selectFavInfo(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "즐겨찾기 조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				if(rs.size() == 0) //사용자정보없는경우
				{
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", "즐겨찾기 정보가 존재하지 않습니다.");
				}
				else
				{
					JSONArray rsArray = new JSONArray(rs);
					
					procResult.put("resultData", rsArray.toString());
					procResult.put("resultCount", rs.size());
					
				}
			}			
			
		}
		
		//즐겨찾기조회
		else if(txDiv.equals("SelectFavInfoV2"))
		{
		
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			// 즐겨찾기 그룹조회 (업장기준)
			rs = orderDAO.selectFavGrpInfo(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "즐겨찾기 조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				if(rs.size() == 0) //즐겨찾기 그룹 정보없는경우
				{
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", "즐겨찾기 정보가 존재하지 않습니다.");
				}
				else
				{
					JSONArray rsArray = new JSONArray(rs);
					
					procResult.put("resultData", rsArray.toString());
					procResult.put("resultCount", rs.size());
					
					//즐겨찾기 상품조회 (업장기준)
					rs = null;
					rsArray = null;
					rs = orderDAO.selectFavItemInfo(parameter);
					rsArray = new JSONArray(rs);					
					procResult.put("resultData2", rsArray.toString());
				}
			}			
			
		}
		
		//즐겨찾기 상품조회 페이징적용
		else if(txDiv.equals("SelectFavItemInfoPage"))
		{
		
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			// 즐겨찾기 상품조회 페이징 적용
			rs = orderDAO.selectFavItemInfoPage(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "즐겨찾기 조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				if(rs.size() == 0) //즐겨찾기 상품 정보없는경우
				{
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", "즐겨찾기 상품 정보가 존재하지 않습니다.");
				}
				else
				{
					JSONArray rsArray = new JSONArray(rs);
					
					procResult.put("resultData", rsArray.toString());
					procResult.put("resultCount", rs.size());
				}
			}			
			
		}

		//즐겨찾기그룹코드채번
		else if(txDiv.equals("NewFavgrpNum"))
		{
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			String grpCode = orderDAO.favgrpNextval(parameter);

			procResult.put("resultData", grpCode);
			procResult.put("resultCount", 1);

		}

		//즐겨찾기관리
		else if(txDiv.equals("FavoriteAdmin"))
		{
			int procCnt = 0; //처리건수

			boolean bOK = true;
			
			JSONArray datas = txData.getJSONArray("datas");
			
			procResult.put("resultData", "");
			procResult.put("resultCount", 0);

			for (int i=0 ; i < datas.length() ; i++) {
				if(isNull(datas.getJSONObject(i).getString("userid"))){
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", "아이디가 없습니다.");
					bOK = false;
					break;
				}
				if(isNull(datas.getJSONObject(i).getString("upjangCd"))){
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", "업장코드가 없습니다.");
					bOK = false;
					break;
				}
				if(isNull(datas.getJSONObject(i).getString("procGb"))){
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", "처리구분이 없습니다.");
					bOK = false;
					break;
				}
				if(isNull(datas.getJSONObject(i).getString("grpName"))){
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", "그룹명이 없습니다.");
					bOK = false;
					break;
				}
			}
			
			if (bOK)
			{
    			for (int i=0 ; i < datas.length() ; i++) {
    				Map<String, Object> rowData = new HashMap<String, Object>();
    				
    				if (!chkIsNull(datas,i,"procGb").equals("G") && !chkIsNull(datas,i,"procGb").equals("I")){
    					procResult.put("ErrorCode", -1); //오류
    					procResult.put("ErrorMsg", "처리구분값이 유효하지 않습니다.");
    					bOK = false;
    					break;
    				}
    				if (!chkIsNull(datas,i,"delYn").equals("Y") && !chkIsNull(datas,i,"delYn").equals("N")){
    					procResult.put("ErrorCode", -1); //오류
    					procResult.put("ErrorMsg", "삭제구분값이 유효하지 않습니다.");
    					bOK = false;
    					break;
    				}
					if (chkIsNull(datas,i,"procGb").equals("G")){	//즐겨찾기그룹등록
						rowData.put("userid", chkIsNull(datas,i,"userid"));
						rowData.put("upjangCd", chkIsNull(datas,i,"upjangCd"));
						rowData.put("grpCode", chkIsNull(datas,i,"grpCode"));
						rowData.put("grpName", chkIsNull(datas,i,"grpName"));
						rowData.put("grpSortSeq", chkIsNull(datas,i,"grpSortSeq"));
						rowData.put("delYn", chkIsNull(datas,i,"delYn"));
						rowData.put("appUserGroup", chkIsNull(datas,i,"appUserGroup"));
						procCnt += orderDAO.favgrpProc(rowData);
					}else{ //즐겨찾기그룹상품등록
						rowData.put("userid", chkIsNull(datas,i,"userid"));
						rowData.put("upjangCd", chkIsNull(datas,i,"upjangCd"));
						rowData.put("grpCode", chkIsNull(datas,i,"grpCode"));
						rowData.put("itemCode", chkIsNull(datas,i,"itemCode"));
						rowData.put("delYn", chkIsNull(datas,i,"delYn"));
						rowData.put("appUserGroup", chkIsNull(datas,i,"appUserGroup"));
						procCnt += orderDAO.favgrpItemProc(rowData);
					}
    			}
			}
			procResult.put("resultData", "");
			procResult.put("resultCount", procCnt);
		}
		
		//지난발주상품조회
		else if(txDiv.equals("SelectPreOrder"))
		{
		
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = orderDAO.selectPreOrder(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "지난발주상품 조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				if(rs.size() == 0) //사용자정보없는경우
				{
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", "지난발주 정보가 존재하지 않습니다.");
				}
				else
				{
					JSONArray rsArray = new JSONArray(rs);
					
					procResult.put("resultData", rsArray.toString());
					procResult.put("resultCount", rs.size());
					
				}
			}			
			
		}
		
		//발주가능금액
		else if(txDiv.equals("SelectCtrlAmt"))
		{
		
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			// 발주가능금액, 채권잔액
			rs = orderDAO.selectCtrlAmt(parameter);
			rs = removeNull(rs);
			
			JSONArray rsArray = new JSONArray(rs);
			procResult.put("resultData", rsArray.toString());
			procResult.put("resultCount", rs.size());

			//통제창고여부, 타창고발주sum금액, 최소발주금액
			rs = null;
			rsArray = null;
			rs = orderDAO.selectSubinvCtrlAmt(parameter);
			rsArray = new JSONArray(rs);
			procResult.put("resultData2", rsArray.toString());
//			
//			if(rs == null) {
//				procResult.put("resultData", "");
//				procResult.put("resultCount", 0);
//				
//				procResult.put("ErrorCode", -1); //오류
//				procResult.put("ErrorMsg", "발주가능금액 조회 중 오류가 발생했습니다.");
//			} else {
//				rs = removeNull(rs);
//				
//				if(rs.size() == 0) //사용자정보없는경우
//				{
//					procResult.put("resultData", "");
//					procResult.put("resultCount", 0);
//					procResult.put("ErrorCode", -1); //오류
//					procResult.put("ErrorMsg", "발주가능금액 정보가 존재하지 않습니다.");
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
		}
		
		//발주내역조회
		else if(txDiv.equals("SelectOrderInfo"))
		{
		
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			String[] docuSource = {"07 FM(상품)", "07 FM", "01 BO", "07 FM(모바일)", "07 FM(식단)", "07 FM(주요)"};  // 상품발주, 구푸드엠주문, 통합영업주문, 모바일주문, 식단주문, 주요상품발주
			
	        // 상품발주, 식재장바구니일 경우
	        if ("M_01".equals(parameter.get("scrnId").toString())) {
	        	parameter.put("docuSource", docuSource[0]);
	        	parameter.put("docuSource1", docuSource[1]);
	        	parameter.put("docuSource2", docuSource[2]);
	        	parameter.put("docuSource3", docuSource[3]);
			// 식단발주일 경우
			} else if ("M_02".equals(parameter.get("scrnId").toString())) {
				parameter.put("docuSource4", docuSource[4]);
	        // 주요상품발주일 경우
			} else if ("M_05".equals(parameter.get("scrnId").toString())) {
				parameter.put("docuSource5", docuSource[5]);
			}
			
			rs = orderDAO.selectOrderInfo(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "발주내역 조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				if(rs.size() == 0) //발주내역정보없는경우
				{
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //발주내역 없을경우
					procResult.put("ErrorMsg", "발주내역 정보가 존재하지 않습니다.");
				}
				else
				{
					JSONArray rsArray = new JSONArray(rs);
					
					procResult.put("resultData", rsArray.toString());
					procResult.put("resultCount", rs.size());
					
				}
			}			
			
		}
		
		// 수발주 제한 체크 (모바일 장바구니 저장전 체크)
		else if(txDiv.equals("SaveOrderPreChk"))
		{
		
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = orderDAO.saveOrderPreChk(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "발주불가 체크 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				if(rs.size() > 0) //발주불가 체크 정보없는경우
				{
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1);
					procResult.put("ErrorMsg", "발주불가 - 수발주 스케쥴에 따른 유효성 체크 오류");
				}
				else
				{
					JSONArray rsArray = new JSONArray(rs);
					
					procResult.put("resultData", rsArray.toString());
					procResult.put("resultCount", rs.size());
				}
			}			
			
		}
		
		//주문저장
		else if(txDiv.equals("SaveOrderInfo"))
		{
			JSONArray rsChkArray = null; //발주불가 데이터
			int rsCnt = 0;
			String reloadYn = "N";
			try {
		        int iInsCnt = 0;
				int iAddCnt = 0; //추가 처리 건수
				int iUpdateCnt = 0; //수정 처리 건수
				int iDeleteCnt = 0; //수정 처리 건수
				int procCnt = 0; //처리건수
				String sPrNum = ""; //신규생성주문번호
		        String sOtcustPrNum = "";
		        String sPrApprNum = "";
		        String sOtcustCD = "";
		        String sStatus = "";
		        String sRowStatus = ""; // I,U,D(신규,수정,삭제)
		        String purcProcRslt = ""; // 구매처리결과
		        String credProcRslt = ""; // 여신처리결과
		        RecordSet rsPreChk = null; //저장 전 유효성체크 (발주가능금액체크)
		        RecordSet rsPreChk2 = null; //저장 전 유효성체크 (주문자재상태변경 체크)
		        String sChkPrNum = "";
		        String sChkPrId = "";
		        String sChkItemCode = "";
		        String sChkPoLineStatus = "";
		        String sChkPrNum2 = "";
		        String sChkPrId2 = "";
		        String sChkItemCode2 = "";
		        String sChkPoLineStatus2 = "";
		        int totAmount = 0; // 화면단에서 넘어온 발주금액 합계 (여신체크용)
		        int totAmountOld = 0; // 화면단에서 넘어온 저장전 발주금액 합계 (여신체크용)
		        int totAmountNew = 0; // 신규 발생된 발주금액 합계 (여신체크용)
				RecordSet rs1 = null; //prNum
				RecordSet rs2 = null; //발주합계 조회
				RecordSet rs3 = null; //유효성체크
				RecordSet rs4 = null; //prId
				String[] docuSource = {"07 FM(상품)", "07 FM", "01 BO", "07 FM(모바일)", "07 FM(식단)", "07 FM(주요)"};  // 상품발주, 구푸드엠주문, 통합영업주문, 모바일주문, 식단주문, 주요상품발주
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
				rowData.put("needDate2", chkIsNull(datas,0,"needDate"));
				rowData.put("subinvCd", chkIsNull(datas,0,"subinvCd"));
				rowData.put("upjangCd", chkIsNull(datas,0,"rcUpjangCd"));
				sStatus = chkIsNull(datas,0,"status");
				
				
				totAmount = Integer.parseInt(chkIsNull(datas,0,"totAmount"));
				totAmountOld = Integer.parseInt(chkIsNull(datas,0,"totAmountOld"));
				
				totAmountNew = totAmount - totAmountOld;
				
				//저장 전 유효성체크 (여신통제 Y인 경우 발주가능금액 체크)
				rsPreChk = orderDAO.selectCtrlAmt(rowData);
				
				if(rsPreChk == null){
					throw new Exception("여신정보 조회 중 오류가 발생했습니다.");
				}
				
				if(rsPreChk.size() == 0){
					throw new Exception("업장 여신정보를 확인할 수 없습니다.\n\n관리자에게 문의하십시오.");
				} 
				
				// 여신금액 체크
				if("Y".equals(rsPreChk.get(0).getString("creditCtrlYn"))){
					if((totAmountNew != 0) && ((totAmountNew) > Integer.parseInt(rsPreChk.get(0).getString("creditAvailAmt")))){
						throw new Exception("주문가능한 여신한도를 초과하여 주문이 불가합니다.");
					}
				}
				
				// 여신회전일 체크
				if("Y".equals(rsPreChk.get(0).getString("creditTurnControlYn"))){
					if(Integer.parseInt(rsPreChk.get(0).getString("lastTurnCnt")) >= 0){
						if(Integer.parseInt(rsPreChk.get(0).getString("lastTurnCnt")) > Integer.parseInt(rsPreChk.get(0).getString("creditTurnDaysTot"))){
							throw new Exception(rsPreChk.get(0).getString("lBillDateDisp") + "에 매출채권이 존재하여 주문이 불가합니다.");
						}
					}
				}
				
				//저장 전 유효성체크 (주문상태 변경자재 여부 체크)
				rsPreChk2 = orderDAO.saveOrderPreChk2(rowData);
				
    			for (int i=0 ; i < datas.length() ; i++) {
    				sChkPrNum = chkIsNull(datas,i,"prNum");
    				sChkPrId = chkIsNull(datas,i,"prId");
    				sChkItemCode = chkIsNull(datas,i,"itemCd");
    				sChkPoLineStatus = chkIsNull(datas,i,"poLineStatus");
    				if(!"".equals(sChkPrNum) && !"".equals(sChkPrId)){
	    				for (int k=0 ; k < rsPreChk2.size() ; k++) {
	        				sChkPrNum2 = rsPreChk2.get(k).getString("prNum");
	        				sChkPrId2 = rsPreChk2.get(k).getString("prId");
	        				sChkItemCode2 = rsPreChk2.get(k).getString("itemCode");
	        				sChkPoLineStatus2 = rsPreChk2.get(k).getString("poLineStatus");
	    					if(sChkPrNum.equals(sChkPrNum2) && sChkPrId.equals(sChkPrId2) && sChkItemCode.equals(sChkItemCode2) && !sChkPoLineStatus.equals(sChkPoLineStatus2)){
	    						reloadYn = "Y";
	    						throw new Exception(sChkItemCode2+":"+ rsPreChk2.get(k).getString("itemName")+" 상품의 발주상태가 ["+sChkPoLineStatus2+"]로 변경되어 수정할 수 없습니다.");
	    					}
	    				}
    				}
    			}
				
				logger.debug(">>>>>>>>>>>>>> 저장전 유효성 체크완료");
				
				//주문번호, 승인번호생성
				rs1 = orderDAO.selectPrSeq(rowData);
				sOtcustPrNum = rs1.get(0).getString("otcustPrnum");
				//기존 발주내역 없을경우.. (기존발주내역이 있으면 신규자재 추가건도 발주번호 들고옴)
				if("".equals(chkIsNull(datas,0,"maxPrNum"))){
					sPrNum = rs1.get(0).getString("prnum");
					sPrApprNum = rs1.get(0).getString("prApprNum");
					//sPrNum = datas.getJSONObject(0).getString("prNum");
				} else {
					sStatus = "OLD";
					sPrNum = chkIsNull(datas,0,"maxPrNum");
		        	if("".equals(chkIsNull(datas,0,"maxPrApprNum")))
		        	{
		        		sPrApprNum = rs1.get(0).getString("prApprNum");
		        	}
		        	else
		        	{
		        		sPrApprNum = chkIsNull(datas,0,"maxPrApprNum");
		        	} 
				}
				
		        // 발주 전 상품발주합계 조회
				rowData.put("scrnId", chkIsNull(datas,0,"scrnId"));
				rowData.put("scrnName", chkIsNull(datas,0,"scrnName"));
				rowData.put("prNum", sPrNum);
				
				logger.debug(">>>>>>>>>>>>PRNUM         : [" + sPrNum + "]");
				
		        // 상품발주, 식재장바구니일 경우
		        if ("M_01".equals(chkIsNull(datas,0,"scrnId"))) {
		        	rowData.put("docuSource", docuSource[0]);
		        	rowData.put("docuSource1", docuSource[1]);
		        	rowData.put("docuSource2", docuSource[2]);
		        	rowData.put("docuSource3", docuSource[3]);
				// 식단발주일 경우
				} else if ("M_02".equals(chkIsNull(datas,0,"scrnId"))) {
					rowData.put("docuSource4", docuSource[4]);
		        // 주요상품발주일 경우
				} else if ("M_05".equals(chkIsNull(datas,0,"scrnId"))) {
					rowData.put("docuSource5", docuSource[5]);
				}
				
		        rowData.put("isBfYn", "Y"); // 발주전후 여부
				rs2 = orderDAO.selectGdsGnvTot(rowData);
				for (int i = 0; i < rs2.size(); i++) {
					Record rec = rs2.get(i);
				
			       	befGdsGnvAmtTot = rec.getBigDecimal("gdsGnvTot").doubleValue();
			       	
			       	Map<String, Object> before_rowData = new HashMap<String,Object>();
			       	before_rowData.put("prUpjang", chkIsNull(datas,0,"rcUpjangCd"));
			       	before_rowData.put("needDate", chkIsNull(datas,0,"needDate"));
			       	before_rowData.put("scrnId", chkIsNull(datas,0,"scrnId"));
			       	before_rowData.put("scrnName", chkIsNull(datas,0,"scrnName"));
			       	before_rowData.put("empNo", chkIsNull(datas,0,"sabun"));
			       	before_rowData.put("prNum", rec.getString("prNum"));
			       	before_rowData.put("befGdsGnvAmtTot", befGdsGnvAmtTot);
			       	before_rowData.put("aftrGdsGnvAmtTot", null);
			    	
			    	beforelistMap.add(before_rowData);
		        }
	
				if (bOK)
				{
	    			for (int i=0 ; i < datas.length() ; i++) {
						Map<String, Object> rowData1 = new HashMap<String, Object>();
						sOtcustCD  = chkIsNull(datas,i,"otcustcd");
						sRowStatus = chkIsNull(datas,i,"rowStatus");
	
						rowData1.put("prUpjangCd", chkIsNull(datas,i,"prUpjangCd"));
						rowData1.put("rcUpjangCd", chkIsNull(datas,i,"rcUpjangCd"));
						rowData1.put("subinvCd", chkIsNull(datas,i,"subinvCd"));
						rowData1.put("needDate", chkIsNull(datas,i,"needDate"));
						rowData1.put("prNum", sPrNum);
						rowData1.put("prId", chkIsNull(datas,i,"prId")); // 추가일땐 새로 채번
						rowData1.put("sabun", chkIsNull(datas,i,"sabun"));
						rowData1.put("prApprNum", sPrApprNum);
						rowData1.put("docuGb", chkIsNull(datas,i,"docuGb"));
						rowData1.put("custcd", chkIsNull(datas,i,"custcd"));
						rowData1.put("centerCd", chkIsNull(datas,i,"centerCd"));
						rowData1.put("itemCd", chkIsNull(datas,i,"itemCd"));
						rowData1.put("itemNm", chkIsNull(datas,i,"itemNm"));
						rowData1.put("itemSize", chkIsNull(datas,i,"itemSize"));
						rowData1.put("poUom", chkIsNull(datas,i,"poUom"));
						rowData1.put("taxCode", chkIsNull(datas,i,"taxCode"));
						rowData1.put("centerFlag", chkIsNull(datas,i,"centerFlag"));
						rowData1.put("unitPrice", chkIsNull(datas,i,"unitPrice"));
						rowData1.put("salePrice", chkIsNull(datas,i,"salePrice"));
						rowData1.put("prQty", chkIsNull(datas,i,"prQty"));
						rowData1.put("invatFlag", "N");
						rowData1.put("outvatFlag", "N");
						rowData1.put("prRemark", chkIsNull(datas,i,"prRemark").replaceAll("'", "''"));
						rowData1.put("lineStatus", "002");
						rowData1.put("applySd", chkIsNull(datas,i,"applySd"));
						rowData1.put("upjangGrp", chkIsNull(datas,i,"upjangGrp"));
						rowData1.put("vdSn", chkIsNull(datas,i,"vdSn"));
						rowData1.put("mobileGubun", chkIsNull(datas,i,"mobileGubun"));
						rowData1.put("opPrice", chkIsNull(datas,i,"opPrice"));
						rowData1.put("opRate", chkIsNull(datas,i,"opRate"));
						rowData1.put("otcustPrNum", sOtcustPrNum);
						rowData1.put("otcustCd", sOtcustCD);
						rowData1.put("rowType", sRowStatus);
						rowData1.put("eventId", chkIsNull(datas,i,"eventId"));
	
						if("I".equals(sRowStatus)){
							//주문상세번호 채번
							rs4 = orderDAO.selectPrIdSeq(rowData);
							rowData1.remove("prId");
							rowData1.put("prId", rs4.get(0).getString("prId"));
							
							if(sOtcustCD.equals("0000")){
								iInsCnt = orderDAO.saveOrderInfo(rowData1);
								iAddCnt++;
								logger.debug(">>>>>>>>>>>>>> 주문정보 생성");
							} else {
								iInsCnt = orderDAO.saveOtcustOrderInfo(rowData1);
								logger.debug(">>>>>>>>>>>>>> 공급업체 주문정보 생성");
							}
							
						} else if("U".equals(sRowStatus)){
							if(sOtcustCD.equals("0000")){
								iInsCnt = orderDAO.updateOrderInfo(rowData1);
								logger.debug(">>>>>>>>>>>>>> 주문정보 수정");
								// 구매 인터페이스용 DS
			                    if (!chkIsNull(datas,i,"prNum").equals(chkIsNull(datas,i-1,"prNum")))
			                    {
			                    	Map<String, Object> poif_rowData = new HashMap<String,Object>();
			                    	poif_rowData.put("PR_NUM", chkIsNull(datas,i,"prNum"));
			                    	poif_rowData.put("ROW_STATUS", "U");
			                    	
			                    	poIflistMap.add(poif_rowData);
			                    }
								
								iUpdateCnt++;
							} else {
								iInsCnt = orderDAO.updateOtcustOrderInfo(rowData1);
								logger.debug(">>>>>>>>>>>>>> 공급업체 주문정보 수정");
							}
						}
						
						procCnt += iInsCnt;
						
			            //추가 또는 수정시 PR_ID 및 ROW_TYPE값을 임시 테이블에 저장한다.
			            //구매 자재신청 유효성 체크시 해당 동일 PR_NUM중에서 해당 테이블에 있는 PR_ID신청 및 수정건만 체크하기 위함
						if("I".equals(sRowStatus) || "U".equals(sRowStatus)){
							orderDAO.saveOrderTempInfo(rowData1);
							logger.debug(">>>>>>>>>>>>>> 임시테이블 데이터 생성");
						}
						
						if (iInsCnt <= 0){continue;}
						
	    			}
					
	    			//삭제로직 추가해야댐!!!
	    			
	    			//식단발주 추가해야댐!!!
						
					// 유효성 체크	    			
					if(!"".equals(chkIsNull(datas,0,"rcUpjangCd")))
					{
						rowData.put("apUnitpriceUpjang", chkIsNull(datas,0,"apUnitpriceUpjang"));
						rowData.put("centerCd", chkIsNull(datas,0,"centerCd"));
						rowData.put("docuGb", chkIsNull(datas,0,"docuGb"));
						rs3 = orderDAO.selectValidChk1(rowData); // 수발주 스케쥴에 따른 유효성 체크
						if(rs3.size() > 0){
							rsChkArray = new JSONArray(rs3);
							rsCnt = rs3.size();
							throw new Exception("발주 불가 자재가 존재합니다.");
						}
						logger.debug(">>>>>>>>>>>>>> 발주 불가 자재 체크완료");
						
						rs3 = orderDAO.selectValidChk2(rowData); // 구매 자재신청 유효성 체크
						if(rs3.size() > 0){
							rsChkArray = new JSONArray(rs3);
							rsCnt = rs3.size();
							throw new Exception("구매신청 불가 자재가 존재합니다.");
						}
						logger.debug(">>>>>>>>>>>>>> 구매신청 불가 자재 체크완료");
					}
					
					//임시테이블 데이터 삭제
					orderDAO.deleteOrderTempInfo(rowData);
					logger.debug(">>>>>>>>>>>>>> 임시테이블 데이터 삭제");
					
					
			        /**************************************
					구매발주 프로시져 호출
					신규 저장할때 마다 PR_NUM을 채번한다.
					상태값 : 신규(C), 수정(U), 자재삭제(U)
			        ***************************************/

					Map<String, Object> retProcItemVal = new HashMap<String, Object>();
			        //추가건이 존재하는경우					
			        if(iAddCnt > 0)
			        {
						Map<String, Object> param = new HashMap<String, Object>();
						
						param.put("I_SYS_ID", "100"); //신청업장
						param.put("I_COMP_CD", "HFC"); //신청업장
						param.put("I_REQ_SYS_CD", "FR"); //신청업장
						param.put("I_PURC_TYP_CD", "MT"); //신청업장
						param.put("I_SHOP_CD", chkIsNull(datas,0,"rcUpjangCd")); //신청업장
						param.put("I_REQ_USR_ID", chkIsNull(datas,0,"sabun")); //신청자
						param.put("I_REQ_TYP_CD", "07"); //신청업장
						param.put("I_REQ_NO", sPrNum); //주문번호
			            if("NEW".equals(sStatus))
			            {
			            	param.put("I_REQ_CLS","C");
			            }
			            else if("OLD".equals(sStatus))
			            {
			            	param.put("I_REQ_CLS","U");
			            } 
			            else
			            {
			            	param.put("I_REQ_CLS","C");
			            }
						
		                retProcItemVal  = orderDAO.sp_If_Sales_Order(param);
		                
		                purcProcRslt = retProcItemVal.get("O_RTN_CD").toString();  // 구매처리결과
		                
		                if(!"S000".equals(purcProcRslt)){
		                	throw new Exception(retProcItemVal.get("O_RTN_MSG").toString());
		                }
			        }
			        
			        // 변경건이 존재할경우
			        if(iUpdateCnt > 0 || iDeleteCnt > 0)
			        {
			        	for (int i = 0 ; i < poIflistMap.size() ; i++) {
							Map<String, Object> param = new HashMap<String, Object>();
							
							param.put("I_SYS_ID", "100");
							param.put("I_COMP_CD", "HFC");
							param.put("I_REQ_SYS_CD", "FR");
							param.put("I_PURC_TYP_CD", "MT");
							param.put("I_SHOP_CD", chkIsNull(datas,0,"rcUpjangCd"));
							param.put("I_REQ_USR_ID", chkIsNull(datas,0,"sabun"));
							param.put("I_REQ_TYP_CD", "07");
							param.put("I_REQ_NO", poIflistMap.get(i).get("PR_NUM").toString());
							param.put("I_REQ_CLS","U");
							
			                retProcItemVal  = orderDAO.sp_If_Sales_Order(param);
			                
			                purcProcRslt = retProcItemVal.get("O_RTN_CD").toString();  // 구매처리결과
			                
			                if(!"S000".equals(purcProcRslt)){
			                	throw new Exception(retProcItemVal.get("O_RTN_MSG").toString());
			                }
			        	}
			        }
			        
			        logger.debug(">>>>>>>>>>>>>> 구매프로시저 종료");
			        
			        // 구매 프로시저 처리가 성공일 경우
			        if ( ValidationUtil.isEquals(purcProcRslt, Const.PURC_PROC_SUCC) ) {
				        rowData.put("isBfYn", "N"); // 발주전후 여부
						rs2 = orderDAO.selectGdsGnvTot(rowData);
						for (int i = 0; i < rs2.size(); i++) {
							Record rec = rs2.get(i);
						
							aftrGdsGnvAmtTot = rec.getBigDecimal("gdsGnvTot").doubleValue();
							prNum = rec.getString("prNum");
					       	
					       	Map<String, Object> after_rowData = new HashMap<String,Object>();
					       	after_rowData.put("prUpjang", chkIsNull(datas,0,"rcUpjangCd"));
					       	after_rowData.put("needDate", chkIsNull(datas,0,"needDate"));
					       	after_rowData.put("scrnId", chkIsNull(datas,0,"scrnId"));
					       	after_rowData.put("scrnName", chkIsNull(datas,0,"scrnName"));
					       	after_rowData.put("empNo", chkIsNull(datas,0,"sabun"));
					       	after_rowData.put("prNum", prNum);
					       	after_rowData.put("befGdsGnvAmtTot", null);
					       	after_rowData.put("aftrGdsGnvAmtTot", aftrGdsGnvAmtTot);
					    	
					       	afterlistMap.add(after_rowData);
				        }
			        }

					//PR_NUM이 수정 후 적어진 경우(취소로 인한) 발생전 맵의 수만큼 LOOP
					//발생후MAP 기준으로 LOOP
			        if (afterlistMap.size() >= beforelistMap.size()) { 
						
				        for (int i = 0 ; i < afterlistMap.size() ; i++) {
				        	
				        	Map<String, Object> aMap = afterlistMap.get(i);
				        	
				        	prNum = aMap.get("prNum").toString();
				        	aftrGdsGnvAmtTot = 0;
				        	aftrGdsGnvAmtTot = (Double) aMap.get("aftrGdsGnvAmtTot");
				        	
				        	//발생전 금액 초기화 
				        	befGdsGnvAmtTot = 0;
				        	for (int j = 0 ; j < beforelistMap.size() ; j++) {
				        		Map<String, Object> bMap = beforelistMap.get(j);
								if ( prNum.equals(bMap.get("prNum").toString())) {
									//befGdsGnvAmtTot = bMap.get("befGdsGnvAmtTot");					
									befGdsGnvAmtTot = (Double) bMap.get("befGdsGnvAmtTot");
								}       
				        	}
				        	
							//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
							// 여신금액 집계 프로시저 호출
							//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
							if (ValidationUtil.isEquals(purcProcRslt, Const.PURC_PROC_SUCC) ) {
								Map<String, Object> param = new HashMap<String, Object>();
								
				                param.put("p_upjang_cd", chkIsNull(datas,0,"rcUpjangCd"));                   // (필수)업장코드
				                param.put("p_apply_date", chkIsNull(datas,0,"needDate"));                  // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
				                param.put("p_occur_class", "01");                       // (필수)발생구분(01:매입예정 02:매입확정 03:외상매출금)
				                param.put("p_occur_amt", aftrGdsGnvAmtTot);             // (필수)발생금액
				                param.put("p_occur_amt_before", befGdsGnvAmtTot);              // (필수)발생금액(전)
				                param.put("p_class_cd", "01");                       // (필수)구분코드(01:주문신청관련 02:매출보정 03:판매단가변경 04:창고 강제변경 05:현지구매 06:영업회계 일마감 07:채권이관/입금처리)
				                param.put("p_occur_table", "(01)SO_PR, FMP_OTCUST_PR");     // (필수)발생테이블
				                param.put("p_key_nm", "PR_NUM");             // (필수)키명
				                param.put("p_key_value01", prNum);                      // (필수)키1(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
				                param.put("p_key_value02", "");                        // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
				                param.put("p_key_value03", "");                        // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
				                param.put("p_key_value04", "");                        // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
				                param.put("p_key_value05", "");                        // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
				                param.put("p_occur_prg_id", chkIsNull(datas,0,"scrnId"));                    // 프로그램ID
				                param.put("p_occur_prg_nm", chkIsNull(datas,0,"scrnName"));                  // 프로그램 한글명
				                param.put("p_cuser", chkIsNull(datas,0,"sabun"));                   // 생성자
								
				                retProcItemVal  = orderDAO.fms_Credit_Sum_Pro(param);
				                
				                credProcRslt = retProcItemVal.get("O_RTN").toString();  // 구매처리결과
								
				                if(!ValidationUtil.isEquals(credProcRslt, Const.YN_Y)){
				                	throw new Exception(retProcItemVal.get("O_RTNMSG").toString());
				                }
							}
				        }
				        
				    //발생전MAP 기준으로 LOOP
					} else {
						for (int i = 0 ; i < beforelistMap.size() ; i++) {
				        	
				        	Map<String, Object> bMap = beforelistMap.get(i);
				        	
				        	prNum = bMap.get("prNum").toString();		
				        	befGdsGnvAmtTot = 0;
							befGdsGnvAmtTot = (Double) bMap.get("befGdsGnvAmtTot");
				        	
				        	//발생후 금액 초기화 
				        	aftrGdsGnvAmtTot = 0;
				        	for (int j = 0 ; j < afterlistMap.size() ; j++) {
				        		Map<String, Object> aMap = afterlistMap.get(j);
								if ( prNum.equals(aMap.get("prNum").toString())) {
				        			aftrGdsGnvAmtTot = (Double) aMap.get("aftrGdsGnvAmtTot");
								}       
				        	}
				        	/*
				        	if (beforelistMap.size() == 0) {
				        		befGdsGnvAmtTot = 0;
				        	}
				        	*/
				        	
							//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
							// 여신금액 집계 프로시저 호출
							//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
							if ( ValidationUtil.isEquals(purcProcRslt, Const.PURC_PROC_SUCC) ) {
								//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
								// 여신금액 집계 프로시저 호출
								//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
								if (ValidationUtil.isEquals(purcProcRslt, Const.PURC_PROC_SUCC) ) {
									Map<String, Object> param = new HashMap<String, Object>();
									
					                param.put("p_upjang_cd", chkIsNull(datas,0,"rcUpjangCd"));                   // (필수)업장코드
					                param.put("p_apply_date", chkIsNull(datas,0,"needDate"));                  // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
					                param.put("p_occur_class", "01");                       // (필수)발생구분(01:매입예정 02:매입확정 03:외상매출금)
					                param.put("p_occur_amt", aftrGdsGnvAmtTot);             // (필수)발생금액
					                param.put("p_occur_amt_before", befGdsGnvAmtTot);              // (필수)발생금액(전)
					                param.put("p_class_cd", "01");                       // (필수)구분코드(01:주문신청관련 02:매출보정 03:판매단가변경 04:창고 강제변경 05:현지구매 06:영업회계 일마감 07:채권이관/입금처리)
					                param.put("p_occur_table", "(01)SO_PR, FMP_OTCUST_PR");     // (필수)발생테이블
					                param.put("p_key_nm", "PR_NUM");             // (필수)키명
					                param.put("p_key_value01", prNum);                      // (필수)키1(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					                param.put("p_key_value02", "");                        // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					                param.put("p_key_value03", "");                        // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					                param.put("p_key_value04", "");                        // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					                param.put("p_key_value05", "");                        // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					                param.put("p_occur_prg_id", chkIsNull(datas,0,"scrnId"));                    // 프로그램ID
					                param.put("p_occur_prg_nm", chkIsNull(datas,0,"scrnName"));                  // 프로그램 한글명
					                param.put("p_cuser", chkIsNull(datas,0,"sabun"));                   // 생성자
									
					                retProcItemVal  = orderDAO.fms_Credit_Sum_Pro(param);
					                
					                credProcRslt = retProcItemVal.get("O_RTN").toString();  // 구매처리결과
									
					                if(!ValidationUtil.isEquals(credProcRslt, Const.YN_Y)){
					                	throw new Exception(retProcItemVal.get("O_RTNMSG").toString());
					                }
								}								
							}
				        }
					}
//			        if(ValidationUtil.isEquals(credProcRslt, Const.YN_Y)){
//			        	rowData.put("p_upjang_cd", chkIsNull(datas,0,"rcUpjangCd"));                   // (필수)업장코드
//			        	rowData.put("p_apply_date", chkIsNull(datas,0,"needDate"));                  // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
//			        	rowData.put("p_cuser", chkIsNull(datas,0,"sabun"));                   // 생성자
//			        	// 여신 로그테이블 저장
//			        	orderDAO.saveOrderCreditLog(rowData);
//			        }
				}
				procResult.put("resultData", "");
				procResult.put("resultCount", procCnt);
			} catch (Exception e) {
				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
				
				if(rsChkArray == null){
					if("Y".equals(reloadYn)){
						procResult.put("resultData", "");
						procResult.put("resultCount", 0);
						procResult.put("ErrorCode", -92); //화면 reload
						procResult.put("ErrorMsg", e.getMessage());    	
					} else {
						procResult.put("resultData", "");
						procResult.put("resultCount", 0);
						procResult.put("ErrorCode", -1); //오류
						procResult.put("ErrorMsg", e.getMessage());
					}
				}
				else{
					procResult.put("resultData", rsChkArray.toString());
					procResult.put("resultCount", rsCnt);
					procResult.put("ErrorCode", -91); //발주불가 오류
					procResult.put("ErrorMsg", e.getMessage());    	
				}
			}
		}
		
		//주문삭제
		else if(txDiv.equals("DeleteOrderInfo"))
		{
			String reloadYn = "N";
			try {
				int procCnt = 0; //처리건수
		        String purcProcRslt = ""; // 구매처리결과
		        String credProcRslt = ""; // 여신처리결과
		        RecordSet rs1 = null; //발주합계 조회
				String[] docuSource = {"07 FM(상품)", "07 FM", "01 BO", "07 FM(모바일)", "07 FM(식단)", "07 FM(주요)"};  // 상품발주, 구푸드엠주문, 통합영업주문, 모바일주문, 식단주문, 주요상품발주
		        double befGdsGnvAmtTot = 0;                                                                                 // 전상품발주금액합계
		        double aftrGdsGnvAmtTot = 0;
				String prNum = ""; //주문번호
		        String sChkPrNum = "";
		        String sChkPrId = "";
		        String sChkItemCode = "";
		        String sChkPoLineStatus = "";
		        String sChkPrNum2 = "";
		        String sChkPrId2 = "";
		        String sChkItemCode2 = "";
		        String sChkPoLineStatus2 = "";
		        RecordSet rsPreChk2 = null; //저장 전 유효성체크 (주문자재상태변경 체크)
		        
				sParamString = txData.getString("data");
				JSONObject txParam = new JSONObject(sParamString);
				parameter = toMap(txParam);
				
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				//저장 전 유효성체크 (주문상태 변경자재 여부 체크)
				rsPreChk2 = orderDAO.saveOrderPreChk2(parameter);
				
				sChkPrNum = parameter.get("prNum").toString();
				sChkPrId = parameter.get("prId").toString();
				sChkItemCode = parameter.get("itemCd").toString();
				sChkPoLineStatus = parameter.get("poLineStatus").toString();
				if(!"".equals(sChkPrNum) && !"".equals(sChkPrId)){
					for (int k=0 ; k < rsPreChk2.size() ; k++) {
						sChkPrNum2 = rsPreChk2.get(k).getString("prNum");
						sChkPrId2 = rsPreChk2.get(k).getString("prId");
						sChkItemCode2 = rsPreChk2.get(k).getString("itemCode");
						sChkPoLineStatus2 = rsPreChk2.get(k).getString("poLineStatus");
						if(sChkPrNum.equals(sChkPrNum2) && sChkPrId.equals(sChkPrId2) && sChkItemCode.equals(sChkItemCode2) && !sChkPoLineStatus.equals(sChkPoLineStatus2)){
							reloadYn = "Y";
							throw new Exception(sChkItemCode2+":"+ rsPreChk2.get(k).getString("itemName")+" 상품의 발주상태가 ["+sChkPoLineStatus2+"]로 변경되어 수정할 수 없습니다.");
						}
					}
				}
				
		        // 발주 전 상품발주합계 조회
				logger.debug(">>>>>>>>>>>>PRNUM         : [" + parameter.get("prNum").toString() + "]");
				
		        // 상품발주, 식재장바구니일 경우
		        if ("M_01".equals(parameter.get("scrnId").toString())) {
		        	parameter.put("docuSource", docuSource[0]);
		        	parameter.put("docuSource1", docuSource[1]);
		        	parameter.put("docuSource2", docuSource[2]);
		        	parameter.put("docuSource3", docuSource[3]);
				// 식단발주일 경우
				} else if ("M_02".equals(parameter.get("scrnId").toString())) {
					parameter.put("docuSource4", docuSource[4]);
		        // 주요상품발주일 경우
				} else if ("M_05".equals(parameter.get("scrnId").toString())) {
					parameter.put("docuSource5", docuSource[5]);
				}
				
		        parameter.put("isBfYn", "Y"); // 발주전후 여부
		        parameter.put("needDate2", parameter.get("needDate").toString());
		        prNum = parameter.get("prNum").toString();
				rs1 = orderDAO.selectGdsGnvTot(parameter);
				if(rs1.size() > 0 ){
					befGdsGnvAmtTot = (Double) rs1.get(0).getBigDecimal("gdsGnvTot").doubleValue();
					prNum           = rs1.get(0).getString("prNum");
				}
				
				if ("0000".equals(parameter.get("otcustcd").toString()))
				{
					orderDAO.deleteOrderInfo(parameter);
					logger.debug(">>>>>>>>>>>>>> 주문정보 삭제");
				} else {
					orderDAO.deleteOtcustOrderInfo(parameter);
					logger.debug(">>>>>>>>>>>>>> 공급업체주문정보 삭제");
				}
				
				procCnt++;
					
	    		//식단삭제 추가해야댐!!!
					
		        /**************************************
				구매발주 프로시져 호출
				신규 저장할때 마다 PR_NUM을 채번한다.
				상태값 : 신규(C), 수정(U), 자재삭제(U)
		        ***************************************/

				Map<String, Object> retProcItemVal = new HashMap<String, Object>();
				Map<String, Object> param = new HashMap<String, Object>();
				
				param.put("I_SYS_ID", "100"); 
				param.put("I_COMP_CD", "HFC"); 
				param.put("I_REQ_SYS_CD", "FR"); 
				param.put("I_PURC_TYP_CD", "MT"); 
				param.put("I_SHOP_CD", parameter.get("rcUpjangCd").toString()); 
				param.put("I_REQ_USR_ID", parameter.get("sabun").toString()); 
				param.put("I_REQ_TYP_CD", "07"); 
				param.put("I_REQ_NO", parameter.get("prNum").toString()); //주문번호
				param.put("I_REQ_CLS","U");
				
                retProcItemVal  = orderDAO.sp_If_Sales_Order(param);
                
                purcProcRslt = retProcItemVal.get("O_RTN_CD").toString();  // 구매처리결과
                
                if(!"S000".equals(purcProcRslt)){
                	throw new Exception(retProcItemVal.get("O_RTN_MSG").toString());
                }
		        
		        logger.debug(">>>>>>>>>>>>>> 구매프로시저 종료");
			        
		        // 구매 프로시저 처리가 성공일 경우
		        if ( ValidationUtil.isEquals(purcProcRslt, Const.PURC_PROC_SUCC) ) {
			        parameter.put("isBfYn", "N"); // 발주전후 여부
					rs1 = orderDAO.selectGdsGnvTot(parameter);
					if (rs1.size() > 0){
						aftrGdsGnvAmtTot = (Double) rs1.get(0).getBigDecimal("gdsGnvTot").doubleValue();
					}
		        }

				//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				// 여신금액 집계 프로시저 호출
				//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				if (ValidationUtil.isEquals(purcProcRslt, Const.PURC_PROC_SUCC) ) {
					Map<String, Object> param1 = new HashMap<String, Object>();
					
	                param1.put("p_upjang_cd", parameter.get("rcUpjangCd").toString());                   // (필수)업장코드
	                param1.put("p_apply_date", parameter.get("needDate").toString());                  // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
	                param1.put("p_occur_class", "01");                       // (필수)발생구분(01:매입예정 02:매입확정 03:외상매출금)
	                param1.put("p_occur_amt", aftrGdsGnvAmtTot);             // (필수)발생금액
	                param1.put("p_occur_amt_before", befGdsGnvAmtTot);              // (필수)발생금액(전)
	                param1.put("p_class_cd", "01");                       // (필수)구분코드(01:주문신청관련 02:매출보정 03:판매단가변경 04:창고 강제변경 05:현지구매 06:영업회계 일마감 07:채권이관/입금처리)
	                param1.put("p_occur_table", "(03)SO_PR, FMP_OTCUST_PR");     // (필수)발생테이블
	                param1.put("p_key_nm", "PR_NUM");             // (필수)키명
	                param1.put("p_key_value01", prNum);                      // (필수)키1(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
	                param1.put("p_key_value02", "");                        // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
	                param1.put("p_key_value03", "");                        // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
	                param1.put("p_key_value04", "");                        // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
	                param1.put("p_key_value05", "");                        // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
	                param1.put("p_occur_prg_id", parameter.get("scrnId").toString());                    // 프로그램ID
	                param1.put("p_occur_prg_nm", parameter.get("scrnName").toString());                  // 프로그램 한글명
	                param1.put("p_cuser", parameter.get("sabun").toString());                   // 생성자
					
	                retProcItemVal  = orderDAO.fms_Credit_Sum_Pro(param1);
	                
	                credProcRslt = retProcItemVal.get("O_RTN").toString();  // 구매처리결과
					
	                if(!ValidationUtil.isEquals(credProcRslt, Const.YN_Y)){
	                	throw new Exception(retProcItemVal.get("O_RTNMSG").toString());
	                }
//	                else {
//	                	// 여신 로그테이블 저장
//	                	orderDAO.saveOrderCreditLog(param1);
//	                }
				}
				
				logger.debug(">>>>>>>>>>>>>> 여신집계프로시저 종료");
				
				procResult.put("resultData", "");
				procResult.put("resultCount", procCnt);
			} catch (Exception e) {
				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
				
				if("Y".equals(reloadYn)){
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -92); //화면 reload
					procResult.put("ErrorMsg", e.getMessage());    	
				} else {
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", e.getMessage());    		
				}
			}
		}
		
		//발주이력조회
		else if(txDiv.equals("SelectOrderHistInfo"))
		{
		
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = orderDAO.selectOrderHistInfo(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "발주내역 조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				if(rs.size() == 0) //발주내역정보없는경우
				{
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //발주내역 없을경우
					procResult.put("ErrorMsg", "발주내역 정보가 존재하지 않습니다.");
				}
				else
				{
					JSONArray rsArray = new JSONArray(rs);
					
					procResult.put("resultData", rsArray.toString());
					procResult.put("resultCount", rs.size());
				}
			}			
		}
		
		//발주이력조회
		else if(txDiv.equals("SelectOrderHistItemInfo"))
		{
		
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = orderDAO.selectOrderHistItemInfo(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "발주이력상세 조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				if(rs.size() == 0) //발주내역정보없는경우
				{
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //발주내역 없을경우
					procResult.put("ErrorMsg", "발주이력상세 정보가 존재하지 않습니다.");
				}
				else
				{
					JSONArray rsArray = new JSONArray(rs);
					
					procResult.put("resultData", rsArray.toString());
					procResult.put("resultCount", rs.size());
				}
			}			
		}
		
		//배송이력조회
		else if(txDiv.equals("SelectDelvHistInfo"))
		{
		
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = orderDAO.selectDelvHistInfo(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "배송이력 조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				if(rs.size() == 0) //배송이력정보없는경우
				{
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //배송이력정보없는경우
					procResult.put("ErrorMsg", "배송이력 정보가 존재하지 않습니다.");
				}
				else
				{
					JSONArray rsArray = new JSONArray(rs);
					
					procResult.put("resultData", rsArray.toString());
					procResult.put("resultCount", rs.size());
					
				}
			}			
			
		}
		
		//배송이력상세조회
		else if(txDiv.equals("SelectDelvHistItemInfo"))
		{
		
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = orderDAO.selectDelvHistItemInfo(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "배송이력상세 조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				if(rs.size() == 0) //배송이력정보없는경우
				{
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //배송이력정보없는경우
					procResult.put("ErrorMsg", "배송이력상세 정보가 존재하지 않습니다.");
				}
				else
				{
					JSONArray rsArray = new JSONArray(rs);
					
					procResult.put("resultData", rsArray.toString());
					procResult.put("resultCount", rs.size());
					
				}
			}			
			
		}
		
		//반환추가정보조회
		else if(txDiv.equals("SelectRtnNeedInfo"))
		{
		
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = orderDAO.selectRtnOrderYn(parameter); //반환가능업장 확인
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "반환가능업장여부 조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				if(rs.size() == 0) //정보없는경우
				{
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", "반환 주문이 가능한 업장이 아닙니다.");
				}
				else
				{
					JSONArray rsArray = new JSONArray(rs);
					
					procResult.put("resultData", rsArray.toString());
					procResult.put("resultCount", rs.size());
					
					//반환유형
					rs = null;
					rsArray = null;
					rs = orderDAO.selectRtnType(parameter);
					rsArray = new JSONArray(rs);					
					procResult.put("resultData2", rsArray.toString());
					
					//반환발주마감시간 (time)
					rs = null;
					rsArray = null;
					rs = orderDAO.selectRtnDtime(parameter);
					rsArray = new JSONArray(rs);					
					procResult.put("resultData3", rsArray.toString());
					
				}
			}			
			
		}
		
		//정상주문일자(반환회수일) 조회
		else if(txDiv.equals("SelectSoPrGetNeedDate"))
		{
		
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = orderDAO.selectSoPrGetNeedDate(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "반환회수일 조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				if(rs.size() == 0) //정보없는경우
				{
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", "주문한 이력이 없어, 반환발주가 불가능합니다.");
				}
				else
				{
					JSONArray rsArray = new JSONArray(rs);
					
					procResult.put("resultData", rsArray.toString());
					procResult.put("resultCount", rs.size());
				}
			}			
		}
		
		//반환저장
		else if(txDiv.equals("SaveRtnOrderInfo"))
		{
			String reloadYn = "N";
			try {
		        int iInsCnt = 0;
				int iAddCnt = 0; //추가 처리 건수
				int iUpdateCnt = 0; //수정 처리 건수
				int iDeleteCnt = 0; //수정 처리 건수
				int procCnt = 0; //처리건수
				String sPrNum = ""; //신규생성주문번호
		        String sStatus = "";
		        String sRowStatus = ""; // I,U,D(신규,수정,삭제)
		        String purcProcRslt = ""; // 구매처리결과
		        String credProcRslt = ""; // 여신처리결과
				RecordSet rs1 = null; //prNum
				RecordSet rs2 = null; //발주합계 조회
				RecordSet rs3 = null; //유효성체크
				RecordSet rs4 = null; //prId
		        RecordSet rsPreChk2 = null; //저장 전 유효성체크 (주문자재상태변경 체크)
		        String sChkPrNum = "";
		        String sChkPrId = "";
		        String sChkItemCode = "";
		        String sChkPoLineStatus = "";
		        String sChkPrNum2 = "";
		        String sChkPrId2 = "";
		        String sChkItemCode2 = "";
		        String sChkPoLineStatus2 = "";
//				String[] docuSource = {"07 FM(상품)", "07 FM", "01 BO", "07 FM(모바일)", "07 FM(식단)", "07 FM(주요)"};  // 상품발주, 구푸드엠주문, 통합영업주문, 모바일주문, 식단주문, 주요상품발주
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
				rowData.put("needDate2", chkIsNull(datas,0,"needDate"));
				rowData.put("subinvCd", chkIsNull(datas,0,"subinvCd"));		
				sStatus = chkIsNull(datas,0,"status");
				
//				// 유효성 체크 (모바일화면단 체크)
//				if(!"".equals(chkIsNull(datas,0,"rcUpjangCd")))
//				{
//					rowData.put("apUnitpriceUpjang", chkIsNull(datas,0,"apUnitpriceUpjang"));
//					rowData.put("centerCd", chkIsNull(datas,0,"centerCd"));
//					rowData.put("upjangCd", chkIsNull(datas,0,"rcUpjangCd"));
//					
//					rs3 = orderDAO.selectSoPrGetNeedDate(rowData);
//					if(rs3.size() < 1){
//						throw new Exception("반환주문 가능 일자가 아닙니다.");
//					}
//				}
				
				//저장 전 유효성체크 (주문상태 변경자재 여부 체크)
				rsPreChk2 = orderDAO.saveOrderPreChk2(rowData);
				
    			for (int i=0 ; i < datas.length() ; i++) {
    				sChkPrNum = chkIsNull(datas,i,"prNum");
    				sChkPrId = chkIsNull(datas,i,"prId");
    				sChkItemCode = chkIsNull(datas,i,"itemCd");
    				sChkPoLineStatus = chkIsNull(datas,i,"poLineStatus");
    				if(!"".equals(sChkPrNum) && !"".equals(sChkPrId)){
	    				for (int k=0 ; k < rsPreChk2.size() ; k++) {
	        				sChkPrNum2 = rsPreChk2.get(k).getString("prNum");
	        				sChkPrId2 = rsPreChk2.get(k).getString("prId");
	        				sChkItemCode2 = rsPreChk2.get(k).getString("itemCode");
	        				sChkPoLineStatus2 = rsPreChk2.get(k).getString("poLineStatus");
	    					if(sChkPrNum.equals(sChkPrNum2) && sChkPrId.equals(sChkPrId2) && sChkItemCode.equals(sChkItemCode2) && !sChkPoLineStatus.equals(sChkPoLineStatus2)){
	    						reloadYn = "Y";
	    						throw new Exception(sChkItemCode2+":"+ rsPreChk2.get(k).getString("itemName")+" 상품의 발주상태가 ["+sChkPoLineStatus2+"]로 변경되어 수정할 수 없습니다.");
	    					}
	    				}
    				}
    			}
				
				//주문번호, 승인번호생성
				rs1 = orderDAO.selectGetPrNum(rowData);
				//기존 발주내역 없을경우.. (기존발주내역이 있으면 신규자재 추가건도 발주번호 들고옴)
				if("".equals(chkIsNull(datas,0,"maxPrNum"))){
					sPrNum = rs1.get(0).getString("prNum");
				} else {
					sStatus = "OLD";
					sPrNum = chkIsNull(datas,0,"maxPrNum"); 
				}
				
		        // 발주 전 상품발주합계 조회
				rowData.put("scrnId", chkIsNull(datas,0,"scrnId"));
				rowData.put("scrnName", chkIsNull(datas,0,"scrnName"));
				rowData.put("prNum", sPrNum);
				
				logger.debug(">>>>>>>>>>>>PRNUM         : [" + sPrNum + "]");
				
				if (bOK)
				{
	    			for (int i=0 ; i < datas.length() ; i++) {
						Map<String, Object> rowData1 = new HashMap<String, Object>();
//						sOtcustCD  = chkIsNull(datas,i,"otcustcd");
						sRowStatus = chkIsNull(datas,i,"rowStatus");
	
						rowData1.put("prUpjangCd", chkIsNull(datas,i,"prUpjangCd"));
						rowData1.put("rcUpjangCd", chkIsNull(datas,i,"rcUpjangCd"));
						rowData1.put("subinvCd", chkIsNull(datas,i,"subinvCd"));
						rowData1.put("needDate", chkIsNull(datas,i,"needDate"));
						rowData1.put("prNum", sPrNum);
						rowData1.put("prId", chkIsNull(datas,i,"prId")); // 추가일땐 새로 채번
						rowData1.put("sabun", chkIsNull(datas,i,"sabun"));
//						rowData1.put("docuGb", chkIsNull(datas,i,"docuGb"));
						rowData1.put("custcd", chkIsNull(datas,i,"custcd"));
						rowData1.put("centerCd", chkIsNull(datas,i,"centerCd"));
						rowData1.put("itemCd", chkIsNull(datas,i,"itemCd"));
						rowData1.put("itemNm", chkIsNull(datas,i,"itemNm"));
						rowData1.put("itemSize", chkIsNull(datas,i,"itemSize"));
						rowData1.put("poUom", chkIsNull(datas,i,"poUom"));
						rowData1.put("taxCode", chkIsNull(datas,i,"taxCode"));
						rowData1.put("centerFlag", chkIsNull(datas,i,"centerFlag"));
						rowData1.put("unitPrice", chkIsNull(datas,i,"unitPrice"));
						rowData1.put("salePrice", chkIsNull(datas,i,"salePrice"));
						rowData1.put("prQty", chkIsNull(datas,i,"prQty"));
						rowData1.put("invatFlag", "N");
						rowData1.put("outvatFlag", "N");
						rowData1.put("prRemark", chkIsNull(datas,i,"prRemark").replaceAll("'", "''"));
						rowData1.put("lineStatus", "001");
						rowData1.put("applySd", chkIsNull(datas,i,"applySd"));
						rowData1.put("upjangGrp", chkIsNull(datas,i,"upjangGrp"));
						rowData1.put("vdSn", chkIsNull(datas,i,"vdSn"));
						rowData1.put("mobileGubun", chkIsNull(datas,i,"mobileGubun"));
						rowData1.put("opPrice", chkIsNull(datas,i,"opPrice"));
						rowData1.put("opRate", chkIsNull(datas,i,"opRate"));
						rowData1.put("rowType", sRowStatus);
						rowData1.put("rtnOrdType", chkIsNull(datas,i,"rtnOrdType"));
	
						if("I".equals(sRowStatus)){
							//주문상세번호 채번
							rs4 = orderDAO.selectGetPrId(rowData);
							rowData1.remove("prId");
							rowData1.put("prId", rs4.get(0).getString("prId"));
							
							iInsCnt = orderDAO.saveRtnOrderInfo(rowData1);
							iAddCnt++;
							logger.debug(">>>>>>>>>>>>>> 주문정보 생성");
							
						} else if("U".equals(sRowStatus)){
							iInsCnt = orderDAO.updateRtnOrderInfo(rowData1);
							logger.debug(">>>>>>>>>>>>>> 주문정보 수정");
							
							iUpdateCnt++;
						}
						
						procCnt += iInsCnt;
						
	    			}
					
				}
				procResult.put("resultData", "");
				procResult.put("resultCount", procCnt);
			} catch (Exception e) {
				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
				
				if("Y".equals(reloadYn)){
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -92); //화면 reload
					procResult.put("ErrorMsg", e.getMessage());    	
				} else {
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", e.getMessage());
				}
			}
		}
		
		//반환삭제
		else if(txDiv.equals("DeleteRtnOrderInfo"))
		{
			String reloadYn = "N";
			try {
				int procCnt = 0; //처리건수
				RecordSet rs3 = null; //유효성체크
		        String sChkPrNum = "";
		        String sChkPrId = "";
		        String sChkItemCode = "";
		        String sChkPoLineStatus = "";
		        String sChkPrNum2 = "";
		        String sChkPrId2 = "";
		        String sChkItemCode2 = "";
		        String sChkPoLineStatus2 = "";
		        RecordSet rsPreChk2 = null; //저장 전 유효성체크 (주문자재상태변경 체크)
				
				sParamString = txData.getString("data");
				JSONObject txParam = new JSONObject(sParamString);
				parameter = toMap(txParam);
				
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);

//				// 유효성 체크 (모바일화면단 체크로 변경)
//				parameter.put("upjangCd", parameter.get("rcUpjangCd").toString());
//				rs3 = orderDAO.selectSoPrGetNeedDate(parameter);
//				if(rs3.size() < 1){
//					throw new Exception("반환주문 가능 일자가 아닙니다.");
//				}
				
				//저장 전 유효성체크 (주문상태 변경자재 여부 체크)
				rsPreChk2 = orderDAO.saveOrderPreChk2(parameter);
				
				sChkPrNum = parameter.get("prNum").toString();
				sChkPrId = parameter.get("prId").toString();
				sChkItemCode = parameter.get("itemCd").toString();
				sChkPoLineStatus = parameter.get("poLineStatus").toString();
				if(!"".equals(sChkPrNum) && !"".equals(sChkPrId)){
					for (int k=0 ; k < rsPreChk2.size() ; k++) {
						sChkPrNum2 = rsPreChk2.get(k).getString("prNum");
						sChkPrId2 = rsPreChk2.get(k).getString("prId");
						sChkItemCode2 = rsPreChk2.get(k).getString("itemCode");
						sChkPoLineStatus2 = rsPreChk2.get(k).getString("poLineStatus");
						if(sChkPrNum.equals(sChkPrNum2) && sChkPrId.equals(sChkPrId2) && sChkItemCode.equals(sChkItemCode2) && !sChkPoLineStatus.equals(sChkPoLineStatus2)){
							reloadYn = "Y";
							throw new Exception(sChkItemCode2+":"+ rsPreChk2.get(k).getString("itemName")+" 상품의 발주상태가 ["+sChkPoLineStatus2+"]로 변경되어 수정할 수 없습니다.");
						}
					}
				}
				
				orderDAO.deleteRtnOrderInfo(parameter);
				logger.debug(">>>>>>>>>>>>>> 주문정보 삭제");
				
				procCnt++;
				
				procResult.put("resultData", "");
				procResult.put("resultCount", procCnt);
			} catch (Exception e) {
				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
				
				if("Y".equals(reloadYn)){
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -92); //화면 reload
					procResult.put("ErrorMsg", e.getMessage());    	
				} else {
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //오류
					procResult.put("ErrorMsg", e.getMessage());
				}
			}
		}

		//반환내역조회
		else if(txDiv.equals("SelectRtnOrderInfo"))
		{
		
			sParamString = txData.getString("data");
			JSONObject txParam = new JSONObject(sParamString);
			parameter = toMap(txParam);
			
			rs = orderDAO.selectRtnOrderInfo(parameter);
			
			if(rs == null) {
				procResult.put("resultData", "");
				procResult.put("resultCount", 0);
				
				procResult.put("ErrorCode", -1); //오류
				procResult.put("ErrorMsg", "반환내역 조회 중 오류가 발생했습니다.");
			} else {
				rs = removeNull(rs);
				
				if(rs.size() == 0) //반환내역정보없는경우
				{
					procResult.put("resultData", "");
					procResult.put("resultCount", 0);
					procResult.put("ErrorCode", -1); //반환내역 없을경우
					procResult.put("ErrorMsg", "반환내역 정보가 존재하지 않습니다.");
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
		/* 발주 시 넘어오는 파라미터 값이 너무 길어 tData 저장시 오류발생 */
		insLogCnt += orderDAO.logInsert(parameter);
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
