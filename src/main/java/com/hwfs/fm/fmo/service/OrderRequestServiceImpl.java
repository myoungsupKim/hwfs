package com.hwfs.fm.fmo.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

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
import com.hwfs.cmn.util.DTOUtil;
import com.hwfs.fm.fmo.dao.OrderDecisionDAO;
import com.hwfs.fm.fmo.dao.OrderRequestDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.util.Const;
import com.hwfs.sc.cmn.util.NumberUtil;
import com.hwfs.sc.cmn.util.ValidationUtil;
import com.sz.business.BusinessRuntimeException;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 주문신청하는 OrderRequest Service Implementation
 * 
 * @ClassName OrderRequestServiceImpl.java
 * @Description OrderRequestServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.07    최성연        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.05.07
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fmo/orderRequestService")
public class OrderRequestServiceImpl extends DefaultServiceImpl implements OrderRequestService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** OrderRequestDAO Bean 생성 */
	@Resource(name = "/fm/fmo/orderRequestDAO")
	private OrderRequestDAO orderRequestDAO;
	
	/** OrderDecisionDAO Bean 생성 */
	@Resource(name = "/fm/fmo/orderDecisionDAO")
	private OrderDecisionDAO orderDecisionDAO;
	

	/**
	 * 구매유형 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectType(Map<String, Object> mapParam) throws Exception {
		return orderRequestDAO.selectType(mapParam);
	}
	
	/**
	 * 주문신청 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return orderRequestDAO.selectList(mapParam);
	}

	/**
	 * fics주문신청 목록과 hub i/f내역을 대조한다.(fims기준)
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectHubCompareList(Map<String, Object> mapParam) throws Exception {
		return orderRequestDAO.selectHubCompareList(mapParam);
	}
	
	/**
	 * fics주문신청 목록과 hub i/f내역을 대조한다.(허브메카 기준)
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectHubCompareList2(Map<String, Object> mapParam) throws Exception {
		return orderRequestDAO.selectHubCompareList2(mapParam);
	}
	
	/**
	 * 주문신청 상세정보 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectDetail(Map<String, Object> mapParam) throws Exception {
		return orderRequestDAO.selectDetail(mapParam);
	}
	
	
	/**
	 * 주문신청 상세정보의 MAX 진행상태를 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectMaxStatus(Map<String, Object> mapParam) throws Exception {
		return orderRequestDAO.selectMaxStatus(mapParam);
	}	
	
	/**
	 * 주문신청 창고 목록을 조회한다. (COMBO)
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectSubinv(Map<String, Object> mapParam) throws Exception {
		return orderRequestDAO.selectSubinv(mapParam);
	}

	
	/**
	 * 주문신청 창고 목록을 조회한다.(1건)
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectSubinv2(Map<String, Object> mapParam) throws Exception {
		return orderRequestDAO.selectSubinv2(mapParam);
	}

	/**
	 * 주문신청 창고 목록을 조회한다. (POPUP)
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectSubinvPop(Map<String, Object> mapParam) throws Exception {
		return orderRequestDAO.selectSubinvPop(mapParam);
	}
	
	
	/**
	 * 주문신청관련 D-DAY 정보를 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectDays(Map<String, Object> mapParam) throws Exception {
		return orderRequestDAO.selectDays(mapParam);
	}
	
	/**
	 * 주문신청관련 여신관리여부를 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectCreYn(Map<String, Object> mapParam) throws Exception {
		return orderRequestDAO.selectCreYn(mapParam);
	}


	/**
	 * 본사통합 여신관리여부를 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectHeadCre(Map<String, Object> mapParam) throws Exception {
		return orderRequestDAO.selectHeadCre(mapParam);
	}
	

	/**
	 * 최종 발주일자를 조회한다.[여신체크]
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectNeedDate(Map<String, Object> mapParam) throws Exception {
		
		if(("Y").equals(mapParam.get("headCreditYn")))
			return orderRequestDAO.selectNeedDate(mapParam);
		else
			return orderRequestDAO.selectNeedDate2(mapParam);
	}
	
	
	/**
	 * 여신관리여부에 따라 여신정보를 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
// [속도개선 Project 시작] 2017. 8. 21. 최범주 여신정보조회 함수 대체
	public RecordSet selectCreInfo(Map<String, Object> mapParam) throws Exception {
//		RecordSet rs;
//		String sUpjangList = "";
//		
//		// 기준일자 SET
//		if(("Y").equals(mapParam.get("schHeadCreditYn")))
//			rs = orderRequestDAO.selectNeedDate(mapParam);
//		else
//			rs = orderRequestDAO.selectNeedDate2(mapParam);
//
//		if (rs.size() > 0)
//		{
//			Map map = rs.get(0);
//			mapParam.put("schNeedDate", map.get("needDate").toString());
//		}
//		
//		// 업장리스트 구하기
//		if(("Y").equals(mapParam.get("schHeadCreditYn"))) {
//			rs = orderRequestDAO.selectCreUpjang(mapParam);
//			
//			for (int i = 0 ; i < rs.size() ; i++) {
//				Map<String, Object> rowData = rs.get(i);
//					sUpjangList += ", " + rowData.get("upjang").toString();
//			}
//			if (sUpjangList.equals(""))
//				sUpjangList = "(NULL)";
//			else
//				sUpjangList = "(" + sUpjangList.substring(1) + ")";
//				
//			mapParam.put("sUpjangList", sUpjangList);
//		}
			
		return orderRequestDAO.selectCreInfo(mapParam);
	}
// [속도개선 Project   끝] 2017. 8. 21. 최범주
	
	/**
	 * 여신관리여부에 따라 여신정보를 조회한다.[도매유통]
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectCreInfoFTS(Map<String, Object> mapParam) throws Exception {
		RecordSet rs;
		String sUpjangList = "";
		
		// 기준일자 SET
		if(("Y").equals(mapParam.get("schHeadCreditYn")))
			rs = orderRequestDAO.selectNeedDate(mapParam);
		else
			rs = orderRequestDAO.selectNeedDate2(mapParam);

		if (rs.size() > 0)
		{
			Map map = rs.get(0);
			mapParam.put("schNeedDate", map.get("needDate").toString());
		}
		
		// 업장리스트 구하기
		if(("Y").equals(mapParam.get("schHeadCreditYn"))) {
			rs = orderRequestDAO.selectCreUpjang(mapParam);
			
			for (int i = 0 ; i < rs.size() ; i++) {
				Map<String, Object> rowData = rs.get(i);
					sUpjangList += ", " + rowData.get("upjang").toString();
			}
			if (sUpjangList.equals(""))
				sUpjangList = "(NULL)";
			else
				sUpjangList = "(" + sUpjangList.substring(1) + ")";
				
			mapParam.put("sUpjangList", sUpjangList);
		}
			
		return orderRequestDAO.selectCreInfoFTS(mapParam);
	}
	
	/**
	 * 여신관리여부에 따라 여신정보를 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectCreInfoTest(Map<String, Object> mapParam) throws Exception {
		//RecordSet rs;
		//String sUpjangList = "";
		
		// 기준일자 SET
		/*
		if(("Y").equals(mapParam.get("schHeadCreditYn")))
			rs = orderRequestDAO.selectNeedDate(mapParam);
		else
			rs = orderRequestDAO.selectNeedDate2(mapParam);

		if (rs.size() > 0)
		{
			Map map = rs.get(0);
			mapParam.put("schNeedDate", map.get("needDate").toString());
		}
		*/
		
		// 업장리스트 구하기
		/*
		if(("Y").equals(mapParam.get("schHeadCreditYn"))) {
			rs = orderRequestDAO.selectCreUpjang(mapParam);
			
			for (int i = 0 ; i < rs.size() ; i++) {
				Map<String, Object> rowData = rs.get(i);
					sUpjangList += ", " + rowData.get("upjang").toString();
			}
			if (sUpjangList.equals(""))
				sUpjangList = "(NULL)";
			else
				sUpjangList = "(" + sUpjangList.substring(1) + ")";
				
			mapParam.put("sUpjangList", sUpjangList);
		}
		*/
			
		return orderRequestDAO.selectCreInfoTest(mapParam);
	}

	/**
	 * 선택한 창고에 대한 기본정보를 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectSubinvInfo(Map<String, Object> mapParam) throws Exception {
		return orderRequestDAO.selectSubinvInfo(mapParam);
	}
	
	
	/**
	 * 구매신청자재검색 화면 조건상단 기본정보를 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectPopView(Map<String, Object> mapParam) throws Exception {
		return orderRequestDAO.selectPopView(mapParam);
	}
	
	/**
	 * 구매신청자재검색 정보를 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectPopItem(Map<String, Object> mapParam) throws Exception {
		String hnrUpjangYn = "N";
		hnrUpjangYn = orderRequestDAO.selectHnrUpjangYn(mapParam);
		mapParam.put("hnrUpjangYn", hnrUpjangYn);
		return orderRequestDAO.selectPopItem(mapParam);
	}
	
	
		
	
	/**
	 * 주문통제 일자를 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectOrdCtrlDays(Map<String, Object> mapParam) throws Exception {
		return orderRequestDAO.selectOrdCtrlDays(mapParam);
	}	
	

	/**
	 * 주문신청번호 MASTER 정보를 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectPrMaster(Map<String, Object> mapParam) throws Exception {
		return orderRequestDAO.selectPrMaster(mapParam);
	}	

	/**
	 * 주문신청번호 DETAIL 정보를 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectPrDetail(Map<String, Object> mapParam) throws Exception {
		return orderRequestDAO.selectPrDetail(mapParam);
	}	
	
	
	/**
	 * 업장별 주문통제 정보를 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectOrdCtrl(Map<String, Object> mapParam) throws Exception {
		return orderRequestDAO.selectOrdCtrl(mapParam);
	}	

	
	/**
	 * 엑셀업로드에 대한  기본정보를 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectUpload(Map<String, Object> mapParam) throws Exception {
		return orderRequestDAO.selectUpload(mapParam);
	}	
	
	/**
	 * 엑셀업로드에 대한  여신정보를 체크한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public String selectCrdCheck(DataSetMap list) throws Exception {
		// 조건변수
		String schNeedDate = "";				// 입고예정일자
		String schMainUpjang = "";			// 본사업장코드
		String schHeadCreditYn = "";			// 통합여신여부
		String schUpjang = "";					// 업장코드
		String creditYn = "";						// 여신관리여부
		// 리턴
		String sMsg = "";
		// 여신체크
		String amountYn = "";
		String turnYn = "";
		String billDate = "";
		String billDateDisp = "";
		double availAmt = 0;					// 주문가능금액
		double salePrice = 0;					// 판매단가
		float lastTurnCnt = 0;					// 여신회전일
		float turnDaysTot = 0;					// 총여신회전일
		float prQty = 0;
		
		DecimalFormat df = new DecimalFormat("#,##0.00");
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			// GET
			schNeedDate = rowData.get("needDate").toString();
			schMainUpjang = rowData.get("mainUpjang").toString();
			schHeadCreditYn = rowData.get("headYn").toString();
			schUpjang = rowData.get("rcUpjang").toString();
			creditYn = rowData.get("creditYn").toString();
			salePrice = Double.parseDouble(rowData.get("salePrice").toString()); 
			prQty = Float.parseFloat(rowData.get("prQty").toString()); 
			
			// DEBUG --- 1
			logger.debug(" - schNeedDate => " + schNeedDate);
			logger.debug(" - schMainUpjang => " + schMainUpjang);
			logger.debug(" - schHeadCreditYn => " + schHeadCreditYn);
			logger.debug(" - schUpjang => " + schUpjang);
			logger.debug(" - creditYn => " + creditYn);
			logger.debug(" - salePrice => " + df.format(salePrice));
			logger.debug(" - prQty => " + prQty);
			
			// SET
			rowData.put("schNeedDate", schNeedDate);
			rowData.put("schMainUpjang", schMainUpjang);
			rowData.put("schHeadCreditYn", schHeadCreditYn);
			rowData.put("schUpjang", schUpjang);
			
			
			//=============================================
			// 여신기준일자 CHECK 
			//=============================================
			RecordSet rsDate;
			// 기준일자 SET
			if(("Y").equals(rowData.get("schHeadCreditYn")))
				rsDate = orderRequestDAO.selectNeedDate(rowData);
			else
				rsDate = orderRequestDAO.selectNeedDate2(rowData);

			if (rsDate.size() > 0)
			{
				Map map = rsDate.get(0);
				// DEBUG --- 2
				logger.debug(" 기준일자 변경 후");
				logger.debug(" - schNeedDate => " + map.get("needDate").toString());
				
				rowData.put("schNeedDate", map.get("needDate").toString());
			}
			//=============================================
			
			// 여신관리여부가 "Y"인 경우만 처리
			if ("Y".equals(creditYn)) {
				// 여신정보 GET
				RecordSet rs;
				rs = orderRequestDAO.selectCrdCheck(rowData);
				
				if (rs == null || rs.size() < 1)
					sMsg =  "업장여신정보 확인 불가(관리자 문의)";
				else {
					Map map = rs.get(0);

					amountYn = map.get("creditAmountControlYn").toString(); 
					turnYn = map.get("creditTurnControlYn").toString(); 
					billDate = map.get("lBillDate").toString(); 
					if ("".equals(billDate)) {
						billDateDisp = "";
					} else {
						billDateDisp = billDate.substring(0, 4) + "-" + billDate.substring(4, 6) + "-" + billDate.substring(6, 8);
					}
					availAmt = Double.parseDouble(map.get("creditAvailAmt").toString()); 
					lastTurnCnt = Float.parseFloat(map.get("lastTurnCnt").toString()); 
					turnDaysTot = Float.parseFloat(map.get("creditTurnDaysTot").toString()); 

					// DEBUG --- 2
					logger.debug(" - amountYn => " + amountYn);
					logger.debug(" - turnYn => " + turnYn);
					logger.debug(" - billDate => " + billDateDisp);
					logger.debug(" - availAmt => " + df.format(availAmt));
					logger.debug(" - lastTurnCnt => " + lastTurnCnt);
					logger.debug(" - turnDaysTot => " + turnDaysTot);
					logger.debug(" - saleAmt => " + df.format(prQty*salePrice));
					
					if (("Y".equals(amountYn)) && (availAmt < (prQty * salePrice))) { 
						sMsg = "주문가능 여신한도 초과 (";
						sMsg = sMsg + "주문가능 : " + df.format(availAmt);
						sMsg = sMsg + ", 판매금액 : " + df.format(prQty * salePrice);
						sMsg = sMsg + ")";
					}

					if (("Y".equals(turnYn)) && (lastTurnCnt > 0) && (lastTurnCnt > turnDaysTot)) {
							if (!"".equals(sMsg)) sMsg = sMsg + ",";
							sMsg = sMsg + "매출채권 존재 (";
							sMsg = sMsg + "채권일자 : " + billDate;
							sMsg = sMsg + ")";
					}
					
				}
				
			} // 여신관리여부 CHECK if
		}	// end for

		return sMsg;
	}		
	

	/**
	 * 주문신청번호 정보를 조회한다.(KEY SET)
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public String selectPrNum(Map<String, Object> mapParam) throws Exception {
		return orderRequestDAO.selectPrNum(mapParam);
	}		

	
	/**
	 * 신청승인번호 정보를 조회한다.(KEY SET)
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public String selectApNum(Map<String, Object> mapParam) throws Exception {
		return orderRequestDAO.selectApNum(mapParam);
	}		
	
	
	
	/**
	 * 주문신청 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	@SuppressWarnings("unchecked")
	public Map<String, Object> saveList(DataSetMap list, LoginDTO loginDTO) throws Exception {
		Map<String, Object> retProcVal = new HashMap<String, Object>();
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String apNum = "";
		
		String p_upjang_cd      = "";  // (필수)업장코드
		String p_apply_date     = "";  // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
		double p_occur_amt        = 0;   // (필수)발생금액
		double p_occur_amt_before = 0;   // (필수)발생금액(전)
		String p_key_nm         = "";  // (필수)키명
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			// 업장코드, 적용일자, 주문신청번호 셋팅
			if ( i == 0 ) {
				p_upjang_cd  = rowData.get("rcUpjang").toString();  // 업장코드
				p_apply_date = rowData.get("needDate").toString();  // 적용일자
				p_key_nm     = rowData.get("prNum").toString();     // 주문신청번호
			}
			
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			if (i==0) {
				if ("".equals(rowData.get("approveNum"))) {
					apNum = orderRequestDAO.selectApNum(rowData);
				} else {
					apNum = rowData.get("approveNum").toString();
				}
			}
			
			//PR_NUM, APPROVE_NUM SET
			rowData.put("approveNum", apNum);
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += orderRequestDAO.insert(rowData);
				
				// PO_CONTRACT_FSALE에 OP_RATE, OP_PRICE 적용
				orderRequestDAO.updateOpPrice(rowData);
				
				//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				// 발생금액 셋팅
				// 과세일 경우
				if ( ValidationUtil.isEquals(rowData.get("taxCode").toString(), Const.TXN_CLSS_100) ) {
					p_occur_amt += Math.round(Double.parseDouble(rowData.get("prAmt").toString()) * 1.1); 
				} else {
					p_occur_amt += Math.round(Double.parseDouble(rowData.get("prAmt").toString()));
				}
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				retProcVal = new HashMap<String, Object>();
				
				updRowCnt += orderRequestDAO.update(rowData);
				
				retProcVal = ifupdate(rowData,"U");
				if(!"S000".equals(retProcVal.get("O_RTN_CD").toString())){
					if(retProcVal.get("O_RTN_MSG") == null)retProcVal.put("O_RTN_MSG","시스템 오류가 발생하였습니다.\n관리자에게 문의하세요.(구매)");
					throw new BizException(retProcVal.get("O_RTN_MSG").toString());
				}
				rowData.put("rtnMsg", retProcVal.get("O_RTN_MSG").toString());
				rowData.put("rtnCd", retProcVal.get("O_RTN_CD").toString());
				orderRequestDAO.prNumUpdateIF(rowData);//구매 IF 결과 저장
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				retProcVal = new HashMap<String, Object>();
				
				delRowCnt += orderRequestDAO.delete(rowData);
				
				retProcVal = ifdelete(rowData);
				
				if(!"S000".equals(retProcVal.get("O_RTN_CD").toString())){
					if(retProcVal.get("O_RTN_MSG") == null)retProcVal.put("O_RTN_MSG","시스템 오류가 발생하였습니다.\n관리자에게 문의하세요.(구매)");
					throw new BizException(retProcVal.get("O_RTN_MSG").toString());
				}
				rowData.put("rtnMsg", retProcVal.get("O_RTN_MSG").toString());
				rowData.put("rtnCd", retProcVal.get("O_RTN_CD").toString());
				orderRequestDAO.prNumUpdateIF(rowData);//구매 IF 결과 저장
			}
		}
		
		RecordSet groupList = orderRequestDAO.selectPrGroup((Map<String, Object>)list.get(0));
		String failcust = "";
		for (int i = 0 ; i < groupList.size() ; i++) {
			retProcVal = new HashMap<String, Object>();
			
			Map<String, Object> groupRowData = groupList.get(i);
			String prNum = orderRequestDAO.selectPrNum(groupRowData);//주문신청번호 생성
			p_key_nm = prNum;
			groupRowData.put("prNum", prNum);
			orderRequestDAO.prNumUpdate(groupRowData);

			retProcVal = ifupdate(groupRowData,"C");
			if(!"S000".equals(retProcVal.get("O_RTN_CD").toString())){
				if(retProcVal.get("O_RTN_MSG") == null)retProcVal.put("O_RTN_MSG","시스템 오류가 발생하였습니다.\n관리자에게 문의하세요.(구매)");
				throw new BizException(retProcVal.get("O_RTN_MSG").toString());
				
			}
			groupRowData.put("rtnMsg", retProcVal.get("O_RTN_MSG").toString());
			groupRowData.put("rtnCd", retProcVal.get("O_RTN_CD").toString());
			orderRequestDAO.prNumUpdateIF(groupRowData);//구매 I/F 결과 저장
		}
		
		// 구매 프로시저 처리가 성공일 경우
		if ( ValidationUtil.isEquals(retProcVal.get("O_RTN_CD").toString(), Const.PURC_PROC_SUCC) ) {
			Map<String, Object> rtnProcedure   = null;
			Map<String, Object> procedureParam = new HashMap<String, Object>();
			procedureParam.put("p_upjang_cd",        p_upjang_cd);          // (필수)업장코드
			procedureParam.put("p_apply_date",       p_apply_date);         // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
			procedureParam.put("p_occur_class",      "01");                 // (필수)발생구분(01:매입예정 02:매입확정 03:외상매출금)
			procedureParam.put("p_occur_amt",        p_occur_amt);          // (필수)발생금액
			procedureParam.put("p_occur_amt_before", p_occur_amt_before);   // (필수)발생금액(전)
			procedureParam.put("p_class_cd",         "01");                 // (필수)구분코드(01:주문신청관련 02:매출보정 03:판매단가변경 04:창고 강제변경 05:현지구매 06:영업회계 일마감 07:채권이관/입금처리)
			procedureParam.put("p_occur_table",      "SO_PR");              // (필수)발생테이블
			procedureParam.put("p_key_nm",           "PR_NUM");             // (필수)키명
			procedureParam.put("p_key_value01",      p_key_nm);             // (필수)키1(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
			procedureParam.put("p_key_value02",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
			procedureParam.put("p_key_value03",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
			procedureParam.put("p_key_value04",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
			procedureParam.put("p_key_value05",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
			procedureParam.put("p_occur_prg_id",     "OrderRequest");       // 프로그램ID
			procedureParam.put("p_occur_prg_nm",     "주문신청");           // 프로그램 한글명
			procedureParam.put("p_cuser",            loginDTO.getSabun());  // 생성자
			rtnProcedure = orderRequestDAO.procLncrTtz(procedureParam);
			
			if ( !ValidationUtil.isEquals(rtnProcedure.get("o_rtn").toString(), Const.YN_Y) ) {
				throw new BusinessRuntimeException(rtnProcedure.get("o_rtnmsg").toString());
			}
		}
		
		retProcVal.put("cnt", insRowCnt + updRowCnt + delRowCnt);
		retProcVal.put("failcust", failcust);
		return retProcVal;
	}
// [속도개선 Project   끝] 2017. 8. 4. 최범주
	
	/**
	 * 주문신청서(을)를 취소(Delete) 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	@SuppressWarnings("unchecked")
	public Map<String, Object> deletePr(DataSetMap list, LoginDTO loginDTO) throws Exception {
		Map<String, Object> retProcVal = new HashMap<String, Object>();
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			retProcVal = new HashMap<String, Object>();
			Map<String, Object> rowData = list.get(i);
			
			//int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			if(chkStatus(orderRequestDAO.lineStatusSelect(rowData))){
				retProcVal.put("O_RTN_CD", "-1");
				retProcVal.put("O_RTN_MSG", "배송중,입고완료,정산완료,발주취소 상태 일경우\n발주반려 할 수 없습니다.");
				throw new BizException(retProcVal.get("O_RTN_MSG").toString());
			}
			
			//Delete 처리 
			delRowCnt += orderRequestDAO.deletePr(rowData);
			
			//허브메카 TEMP주문 취소 처리
			orderRequestDAO.deleteHubPr(rowData);
			
			retProcVal = ifdelete(rowData);
			rowData.put("rtnMsg", retProcVal.get("O_RTN_MSG").toString());
			rowData.put("rtnCd", retProcVal.get("O_RTN_CD").toString());
			rowData.put("ifData", retProcVal.get("IF_DATA").toString());
			logger.debug("rowData : " + rowData );
			orderRequestDAO.prNumUpdateIF(rowData);//구매 IF 결과 저장
			
			// 구매 프로시저 처리가 성공일 경우
			if ( ValidationUtil.isEquals(retProcVal.get("O_RTN_CD").toString(), Const.PURC_PROC_SUCC) ) {
				String p_upjang_cd      = rowData.get("rcUpjang").toString();
				String p_apply_date     = rowData.get("needDate").toString();
				double p_occur_amt        = 0;
				double p_occur_amt_before = 0;
				String p_key_nm         = rowData.get("prNum").toString();
					 
				 // 과세일 경우
				 if ( ValidationUtil.isEquals(rowData.get("taxCode").toString(), Const.TXN_CLSS_100) ) {
					 p_occur_amt_before = Math.round(Double.parseDouble(rowData.get("amt").toString()) * 1.1);  // 소수점 반올림
				 } else {
					 p_occur_amt_before = Math.round(Double.parseDouble(rowData.get("amt").toString()));
				 }
				
				Map<String, Object> rtnProcedure   = null;
				Map<String, Object> procedureParam = new HashMap<String, Object>();
				procedureParam.put("p_upjang_cd",        p_upjang_cd);          // (필수)업장코드
				procedureParam.put("p_apply_date",       p_apply_date);         // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
				procedureParam.put("p_occur_class",      "01");                 // (필수)발생구분(01:매입예정 02:매입확정 03:외상매출금)
				procedureParam.put("p_occur_amt",        p_occur_amt);          // (필수)발생금액
				procedureParam.put("p_occur_amt_before", p_occur_amt_before);   // (필수)발생금액(전)
				procedureParam.put("p_class_cd",         "01");                 // (필수)구분코드(01:주문신청관련 02:매출보정 03:판매단가변경 04:창고 강제변경 05:현지구매 06:영업회계 일마감 07:채권이관/입금처리)
				procedureParam.put("p_occur_table",      "SO_PR");              // (필수)발생테이블
				procedureParam.put("p_key_nm",           "PR_NUM");             // (필수)키명
				procedureParam.put("p_key_value01",      p_key_nm);             // (필수)키1(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
				procedureParam.put("p_key_value02",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
				procedureParam.put("p_key_value03",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
				procedureParam.put("p_key_value04",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
				procedureParam.put("p_key_value05",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
				procedureParam.put("p_occur_prg_id",     "OrderRequest");       // 프로그램ID
				procedureParam.put("p_occur_prg_nm",     "주문신청");           // 프로그램 한글명
				procedureParam.put("p_cuser",            loginDTO.getSabun());  // 생성자
				rtnProcedure = orderRequestDAO.procLncrTtz(procedureParam);
				
				if ( !ValidationUtil.isEquals(rtnProcedure.get("o_rtn").toString(), Const.YN_Y) ) {
					throw new BusinessRuntimeException(rtnProcedure.get("o_rtnmsg").toString());
				}
			}
		}
		orderRequestDAO.soprDel(list.get(0));//SO_PR 임시번호 삭제
		retProcVal.put("cnt", delRowCnt);
		return retProcVal;
	}
// [속도개선 Project   끝] 2017. 8. 4. 최범주
	
	
	/**
	 * 주문신청서(을)를 취소(Delete) 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public Map<String, Object> saveCancelPrList(Map<String, Object> param, DataSetMap list, LoginDTO loginDTO) throws Exception {
		Map<String, Object> retVal = new HashMap<String, Object>();
		Map<String, Object> mapCond = new HashMap<String, Object>();
		String poType = param.get("schType").toString();
		
		for ( int i=0; i<list.size(); i++ ) {
			if ( "1".equals(list.get(i).get("chk").toString()) ) {
				
				mapCond.put("schPrNum", list.get(i).get("prNum").toString());
				mapCond.put("schGubun", param.get("schGubun").toString());
				mapCond.put("schDate1", param.get("schDate1").toString());
				mapCond.put("schDate2", param.get("schDate2").toString());
				mapCond.put("schType", param.get("schType").toString());
				
				if ( poType != param.get("schType").toString() ) {
					throw new BizException("구매유형정보가 일치하지 않습니다.");
				}
			
				RecordSet rs = orderRequestDAO.selectDetail(mapCond);
				DataSetMap dsMap = new DataSetMap();
				for ( int x=0; x<rs.size(); x++ ) {
					Map<String, Object> rwData = rs.get(x);
					dsMap.add(rwData);
				}
				
				retVal = deletePr(dsMap, loginDTO);
			}
		}
				
		return retVal;
	}
		
	/**
	 * 주문신청내역을 삭제(Delete) 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public Map<String, Object> deleteItem(DataSetMap list, LoginDTO loginDTO) throws Exception {
		Map<String, Object> retProcVal = new HashMap<String, Object>();
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			retProcVal = new HashMap<String, Object>();
			Map<String, Object> rowData = list.get(i);
			//int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			if(chkStatus(orderRequestDAO.lineStatusSelect(rowData))){
				retProcVal.put("O_RTN_CD", "-1");
				retProcVal.put("O_RTN_MSG", "배송중,입고완료,정산완료,발주취소 상태 일경우\n발주반려 할 수 없습니다.");
				throw new BizException(retProcVal.get("O_RTN_MSG").toString());
			}
			//Delete 처리 
			delRowCnt += orderRequestDAO.delete(rowData);
			
			logger.debug("rowData : " + rowData );
			retProcVal = ifdelete(rowData);
			if(!"S000".equals(retProcVal.get("O_RTN_CD").toString())){
				if(retProcVal.get("O_RTN_MSG") == null)retProcVal.put("O_RTN_MSG","시스템 오류가 발생하였습니다.\n관리자에게 문의하세요.(구매)");
				throw new BizException(retProcVal.get("O_RTN_MSG").toString());
			}
			rowData.put("rtnCd", retProcVal.get("O_RTN_CD").toString());
			rowData.put("rtnMsg", retProcVal.get("O_RTN_MSG").toString());
			orderRequestDAO.prNumUpdateIF(rowData);//구매 IF 결과 저장
			
			// 구매 프로시저 처리가 성공일 경우
			if ( ValidationUtil.isEquals(retProcVal.get("O_RTN_CD").toString(), Const.PURC_PROC_SUCC) ) {
				String p_upjang_cd      = rowData.get("rcUpjang").toString();
				String p_apply_date     = rowData.get("needDate").toString();
				double p_occur_amt        = 0;
				double p_occur_amt_before = 0;
				String p_key_nm         = rowData.get("prNum").toString();
					 
				 // 과세일 경우
				 if ( ValidationUtil.isEquals(rowData.get("taxCode").toString(), Const.TXN_CLSS_100) ) {
					 p_occur_amt_before = Math.round(Double.parseDouble(rowData.get("amt").toString()) * 1.1);  // 소수점 반올림
				 } else {
					 p_occur_amt_before = Math.round(Double.parseDouble(rowData.get("amt").toString()));
				 }
				
				Map<String, Object> rtnProcedure   = null;
				Map<String, Object> procedureParam = new HashMap<String, Object>();
				procedureParam.put("p_upjang_cd",        p_upjang_cd);          // (필수)업장코드
				procedureParam.put("p_apply_date",       p_apply_date);         // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
				procedureParam.put("p_occur_class",      "01");                 // (필수)발생구분(01:매입예정 02:매입확정 03:외상매출금)
				procedureParam.put("p_occur_amt",        p_occur_amt);          // (필수)발생금액
				procedureParam.put("p_occur_amt_before", p_occur_amt_before);   // (필수)발생금액(전)
				procedureParam.put("p_class_cd",         "01");                 // (필수)구분코드(01:주문신청관련 02:매출보정 03:판매단가변경 04:창고 강제변경 05:현지구매 06:영업회계 일마감 07:채권이관/입금처리)
				procedureParam.put("p_occur_table",      "SO_PR");              // (필수)발생테이블
				procedureParam.put("p_key_nm",           "PR_NUM");             // (필수)키명
				procedureParam.put("p_key_value01",      p_key_nm);             // (필수)키1(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
				procedureParam.put("p_key_value02",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
				procedureParam.put("p_key_value03",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
				procedureParam.put("p_key_value04",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
				procedureParam.put("p_key_value05",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
				procedureParam.put("p_occur_prg_id",     "OrderRequest");       // 프로그램ID
				procedureParam.put("p_occur_prg_nm",     "주문신청");           // 프로그램 한글명
				procedureParam.put("p_cuser",            loginDTO.getSabun());  // 생성자
				rtnProcedure = orderRequestDAO.procLncrTtz(procedureParam);
				
				if ( !ValidationUtil.isEquals(rtnProcedure.get("o_rtn").toString(), Const.YN_Y) ) {
					throw new BusinessRuntimeException(rtnProcedure.get("o_rtnmsg").toString());
				}
			}

		}
		retProcVal.put("cnt", delRowCnt);
		return retProcVal;
	}
		
	
	
	/**
	 * (엑셀업로드용) 주문신청 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveUpload(DataSetMap list) throws Exception {
		Map<String, Object> retProcVal = new HashMap<String, Object>();
		int insRowCnt = 0;
		int updRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			//Insert 처리
			insRowCnt += orderRequestDAO.insert2(rowData);
			
			// PO_CONTRACT_FSALE에 OP_RATE, OP_PRICE 적용
			//orderRequestDAO.updateOpPrice2(rowData);
		}
				
		return insRowCnt + updRowCnt;
	}	
	
	/**
	 * (엑셀업로드용) 저장된 엑셀 업로드 자료를 GROUP으로 묶어서 IF 처리 한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	public Map<String, Object> saveGroup(DataSetMap list) throws Exception {
		Map<String, Object> retProcVal = new HashMap<String, Object>();
		
		RecordSet groupList = orderRequestDAO.selectPrGroup((Map<String, Object>)list.get(0));
		for (int i = 0 ; i < groupList.size() ; i++) {
			retProcVal = new HashMap<String, Object>();
			Map<String, Object> groupRowData = groupList.get(i);
			String prNum = orderRequestDAO.selectPrNum(groupRowData);//주문신청번호 생성
			groupRowData.put("prNum", prNum);
			int upCnt = orderRequestDAO.prNumUpdate(groupRowData);
			logger.debug("업데이트 건수  = " + upCnt);

 			retProcVal = ifupdate(groupRowData,"C");
 			if(!"S000".equals(retProcVal.get("O_RTN_CD").toString())){
 				if(retProcVal.get("O_RTN_MSG") == null)retProcVal.put("O_RTN_MSG","시스템 오류가 발생하였습니다.\n관리자에게 문의하세요.(구매)");
				throw new BizException(retProcVal.get("O_RTN_MSG").toString());
			}
			groupRowData.put("rtnMsg", retProcVal.get("O_RTN_MSG").toString());
			groupRowData.put("rtnCd", retProcVal.get("O_RTN_CD").toString());
			orderRequestDAO.prNumUpdateIF(groupRowData);//구매 IF 결과 저장

		}
		retProcVal.put("O_RTN_CD","S000");
		return retProcVal;
	}
	
	
	/**
	 * 주문신청 관련 구매수발주 제한을 체크한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public String selectPoQtyCheck(DataSetMap list) throws Exception {
		// 리턴
		String sMsg = "";
		// 체크
		String valEvtCnt = "";
		String valCtrCnt = "";
		String ivtYn = "";
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);

			// 구매 신청관련 수발주제한 CHECK
			RecordSet rs;
			rs = orderRequestDAO.selectPoQtyCheck(rowData);
			
			if (rs == null || rs.size() < 1)
				sMsg =  "구매수량관련 체크 확인 불가(관리자 문의)";
			else 
			{
				Map map = rs.get(0);
			
				valEvtCnt = map.get("valEvtCnt").toString(); 
				valCtrCnt = map.get("valCtrCnt").toString(); 
				ivtYn = map.get("ivtYn").toString(); 
				
				logger.debug(" - valEvtCnt => " + valEvtCnt);
				logger.debug(" - valCtrCnt => " + valCtrCnt);
				logger.debug(" - ivtYn => " + ivtYn);

				// 기획자재 한정수량 CHECK
				if ("VE".equals(valEvtCnt)) {
					sMsg = "기획자재 한정수량(수량부족)";
				} else if ("NN".equals(valEvtCnt)) {
					sMsg = "기획자재 한정수량(DATA NOT FOUND)";
				}

				// SPOT계약 발주횟수 CHECK
				if ("SE".equals(valCtrCnt)) {
					if (!"".equals(sMsg)) {
						sMsg = sMsg + ",";
					}		
					sMsg = sMsg + "SPOT계약 발주횟수 발주불가(사용불가)";
				} else if ("NN".equals(valCtrCnt)) {
					if (!"".equals(sMsg)) {
						sMsg = sMsg + ",";
					}		
					sMsg = sMsg + "SPOT계약 발주횟수(DATA NOT FOUND)";
				}
				
				// DC자재 수량 CHECK
				if (!"Y".equals(ivtYn)) {
					if (!"".equals(sMsg)) {
						sMsg = sMsg + ",";
					}		
					sMsg = sMsg + "DC자재 재고수량 부족";
				}

			} // 구매수발주 제한 CHECK if
		}	// end for

		return sMsg;
	}		
	
	/**
	 * 구매 IF (row)
	 *
	 * @param Map ,String
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return Map
	 * @throws Exception
	*/
	public Map<String, Object> ifupdate(Map<String, Object> rowData, String gubun) throws Exception {
		/** 주문결의시 구매쪽 IF  **/
		Map<String, Object> pMap = new HashMap<String, Object>();
		pMap.put("i_sys_id", 	  String.valueOf("100")); //시스템 아이디
		pMap.put("i_comp_cd", 	  String.valueOf("HFC")); //회사 코드 ('HFC')
		pMap.put("i_req_sys_cd",  String.valueOf("FR")); //신청 시스템 코드 [PR: 전사구매, FR: 통합영업, WR: WMS]
		pMap.put("i_purc_typ_cd", String.valueOf("MT")); //신청 시스템 구매유형 코드[MT:식자재, CT:상품, BT:일반자재(소모품),ST:일반자재(저장품),JT:일반자재(고정자산)]
		pMap.put("i_shop_cd", 	  String.valueOf(rowData.get("rcUpjang"))); //신청업장 코드 - > 입고업장으로 변경
		pMap.put("i_req_usr_id",  String.valueOf(rowData.get("prSabun"))); //신청자 아이디
		pMap.put("i_req_typ_cd",  String.valueOf(rowData.get("poType"))); //통합영업 S/O 유형코드(07)
		pMap.put("i_req_no", 	  String.valueOf(rowData.get("prNum"))); //Sales Order 요청 번호(PO_NUM)
		pMap.put("i_req_cls", 	  gubun); //요청 상태 [C-신규, U-수정, D-삭제]
		logger.debug("IF_SALES_ORDER : " + pMap.toString());
		return orderDecisionDAO.sp_if_sales_order(pMap);
	}
	
	/**
	 * 구매 IF 데이터 삭제.(row)
	 * 
	 * 
	 **/
	public Map<String, Object> ifdelete(Map<String, Object> rowData) throws Exception {
		Map<String, Object> retProcItemVal = new HashMap<String, Object>();
		String status = "U";
		int poPocnt = orderDecisionDAO.poPoCnt(rowData);//HLDC_PO_PO에 데이터 존재하는지 체크.
		if(poPocnt > 1){
			status = "U";
		}else if(poPocnt == 1){
			/*마지막 행을 삭제 할경우 프로시저 D 호출.*/
			status = "D";
		}
		try {
			Map<String, Object> pMap = new HashMap<String, Object>();
			pMap.put("i_sys_id", 	  String.valueOf("100")); //시스템 아이디
			pMap.put("i_comp_cd", 	  String.valueOf("HFC")); //회사 코드 ('HFC')
			pMap.put("i_req_sys_cd",  String.valueOf("FR")); //신청 시스템 코드 [PR: 전사구매, FR: 통합영업, WR: WMS]
			pMap.put("i_purc_typ_cd", String.valueOf("MT")); //신청 시스템 구매유형 코드[MT:식자재, CT:상품, BT:일반자재(소모품),ST:일반자재(저장품),JT:일반자재(고정자산)]
			pMap.put("i_shop_cd", 	  String.valueOf(rowData.get("rcUpjang"))); //신청업장 코드 - > 입고업장으로 변경
			pMap.put("i_req_usr_id",  String.valueOf(rowData.get("prSabun"))); //신청자 아이디
			pMap.put("i_req_typ_cd",  String.valueOf(rowData.get("poType"))); //통합영업 S/O 유형코드(07)
			pMap.put("i_req_no", 	  String.valueOf(rowData.get("prNum"))); //Sales Order 요청 번호(PO_NUM)
			pMap.put("i_req_cls", 	  status); //요청 상태 [C-신규, U-수정, D-삭제]
			retProcItemVal  = orderDecisionDAO.sp_if_sales_order(pMap);
			logger.debug("IF_SALES_ORDER : " + pMap.toString());
			retProcItemVal.put("IF_DATA", pMap.toString());
			if(!"S000".equals(retProcItemVal.get("O_RTN_CD").toString())){
				if(retProcItemVal.get("O_RTN_MSG") == null)retProcItemVal.put("O_RTN_MSG","오류가 발생하였습니다.\n시스템 관리자에게 문의하세요.");
				throw new BizException(retProcItemVal.get("O_RTN_MSG").toString());
			}
		} catch (BizException e) {
        	retProcItemVal.put("O_RTN_CD", -1);
        	retProcItemVal.put("O_RTN_MSG", e.getMessage());
        	return retProcItemVal;
        }
		return retProcItemVal;
	}
	
	/**
	 * 구매 상태값 체크
	 * <pre>
	 * 수정, 반려 불가 상태일경우 true
	 * 수정, 반려 가능 일경우 false
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	public boolean chkStatus(String status) throws Exception {
		if("DL".equals(status) || "GC".equals(status) || "IV".equals(status) || "PD".equals(status)){
			return true;
		}
		return false;
	}
	
	/**
	 * 구매 전송하지 못한 SO_PR을 삭제한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int deleteSoPr(DataSetMap list) throws Exception {
		return orderRequestDAO.soprDel(list.get(0));
	}
	
}
