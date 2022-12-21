package com.hwfs.fm.fmo.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.fm.fmo.dao.OrderDecisionDAO;
import com.hwfs.fm.fmo.dao.OrderRequestChangeDAO;
import com.hwfs.fm.fmo.dao.OrderRequestDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.util.Const;
import com.hwfs.sc.cmn.util.NumberUtil;
import com.hwfs.sc.cmn.util.ValidationUtil;
import com.sz.business.BusinessRuntimeException;

 /**
 * 주문신청에 대한 자재변경하는 OrderRequestChange Service Implementation
 * 
 * @ClassName OrderRequestChangeServiceImpl.java
 * @Description OrderRequestChangeServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.29    최성연        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.07.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fmo/orderRequestChangeService")
public class OrderRequestChangeServiceImpl extends DefaultServiceImpl implements OrderRequestChangeService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** OrderRequestChangeDAO Bean 생성 */
	@Resource(name = "/fm/fmo/orderRequestChangeDAO")
	private OrderRequestChangeDAO orderRequestChangeDAO;

	/** OrderRequestDAO Bean 생성 */
	@Resource(name = "/fm/fmo/orderRequestDAO")
	private OrderRequestDAO orderRequestDAO;
	
	/** OrderDecisionDAO Bean 생성 */
	@Resource(name = "/fm/fmo/orderDecisionDAO")
	private OrderDecisionDAO orderDecisionDAO;
	
	/**
	 * 주문신청관련 대상/변경자재변경 목록을 조회한다.(팝업용)
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectItemPop(Map<String, Object> mapParam) throws Exception {
		return orderRequestChangeDAO.selectItemPop(mapParam);
	}
	public RecordSet selectItemPop2(Map<String, Object> mapParam) throws Exception {
		return orderRequestChangeDAO.selectItemPop2(mapParam);
	}
	
	
	
	/**
	 * 주문신청관련 자재변경 목록을 조회한다.
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
		return orderRequestChangeDAO.selectList(mapParam);
	}

	
	/**
	 * 변경자재의 판매단가 및 신청정보를 조회한다
	 * 
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리결과
	 * @throws Exception
	 */
	public RecordSet selectId(Map<String, Object> mapParam) throws Exception {
		return orderRequestChangeDAO.selectId(mapParam);
	}	
	
	
	/**
	 * 변경자재에 대한  여신정보를 체크한다.
	 * 기존자재에 대한 금액을 제외하고 변경자재 기준으로 여신 CHECK
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	@SuppressWarnings("unchecked")
	public String[] selectCrdCheck2(DataSetMap list) throws Exception {
		String[] rtnValue = {"", "", ""};  // 여신관련체크, 변경자재과세구분, 변경자재판매가
		
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
		String tPrice = "";
		String pPrice = "";
		
		double availAmt = 0;					// 주문가능금액
		double salePrice = 0;					// 판매단가 : 대상자재
		double salePrice2 = 0;					// 판매단가 : 변경자재
		float lastTurnCnt = 0;					// 여신회전일
		float turnDaysTot = 0;					// 총여신회전일
		float prQty = 0;
		
		String itemCode2            = "";
		Map<String, Object> inParam = null;
		RecordSet mtrlsInfo         = null;
		
		DecimalFormat df = new DecimalFormat("#,##0.00");

		// DEBUG --- 0
		logger.debug(" *** selectCrdCheck2 start ");
		
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
			itemCode2 = rowData.get("itemCode2").toString();
			
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			// 변경자재과세구분 셋팅
			inParam = new HashMap<String, Object>();
			inParam.put("itemCode", itemCode2);
			mtrlsInfo = orderRequestChangeDAO.selectMtrlsTxnClss(inParam);
			if ( (mtrlsInfo == null) || (mtrlsInfo.getRowCount() == 0) ) {
				rtnValue[0] = "변경자재에대한 정보가 없습니다.";
			} else {
				rtnValue[1] = mtrlsInfo.get(0).getString("taxCode");
			}

			// 변경된 자재의 판매단가를 조회	
			tPrice = orderRequestChangeDAO.selectPrice(rowData);

			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			// 변경자재판매가 셋팅
			rtnValue[2] = tPrice;

			logger.debug(" *** tPrice : " + tPrice);
			
			// 변경자재의 판매단가가 0 이면 에러 메시지 후 리턴
			if ("0".equals(tPrice)) {
				logger.debug(" *** 판매단가 0 LOG ");
				sMsg = "판매단가 정보 없음";	
			}

			// 변경된 자재의 구매단가를 조회
			pPrice = orderRequestChangeDAO.selectPoPrice(rowData);
			
			logger.debug(" *** pPrice : " + pPrice);
			
			// 변경자재의 구매단가가 0 이면 에러 메시지 후 리턴
			if ("0".equals(pPrice)) {
				logger.debug(" *** 구매단가 0 LOG ");
				if (!"".equals(sMsg)) {
					sMsg = sMsg + ",";
				}		
				sMsg = sMsg + "구매단가 정보 없음";	
			}
			
			salePrice2 = Double.parseDouble(tPrice);
			
			// DEBUG --- 1
			logger.debug(" - schNeedDate => " + schNeedDate);
			logger.debug(" - schMainUpjang => " + schMainUpjang);
			logger.debug(" - schHeadCreditYn => " + schHeadCreditYn);
			logger.debug(" - schUpjang => " + schUpjang);
			logger.debug(" - creditYn => " + creditYn);
			logger.debug(" - salePrice => " + df.format(salePrice));
			logger.debug(" - salePrice2 => " + df.format(salePrice2));
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
			
			
			// 여신관리여부가 "Y"인 경우 & 판매단가 정보 여부 CHECK 
			if ("Y".equals(creditYn) && "".equals(sMsg)) {
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
					logger.debug(" - saleAmt2 => " + df.format(prQty*salePrice2));
					
					// 주문가능 여신 : 대상자재에 대한 금액을 반영하여 CHECK 함
					if (("Y".equals(amountYn)) && ((availAmt + (prQty * salePrice)) < (prQty * salePrice2))) { 
						sMsg = "주문가능 여신한도 초과 (";
						sMsg = sMsg + "주문가능 : " + df.format(availAmt + (prQty * salePrice));
						sMsg = sMsg + ", 판매금액 : " + df.format(prQty * salePrice2);
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

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// 여신관련체크 셋팅
		rtnValue[0] = sMsg;
		
		return rtnValue;
	}
// [속도개선 Project   끝] 2017. 8. 4. 최범주
	
	/**
	 * 주문신청관련 자재변경 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	@SuppressWarnings("unchecked")
	public Map<String, Object> saveList(DataSetMap list, String[] rtnValue, LoginDTO loginDTO) throws Exception {
		Map<String,Object> rtnMap          = new HashMap<String, Object>();
		Map<String, Object> retProcItemVal = new HashMap<String, Object>();
		int insRowCnt                      = 0;
		int delRowCnt                      = 0;
		String prNum                       = "";
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			logger.debug("rowData : " + rowData);
			retProcItemVal = ifdelete(rowData);//구매 IF 데이터 삭제

			if(!"S000".equals(retProcItemVal.get("O_RTN_CD").toString())){
				if(retProcItemVal.get("O_RTN_MSG") == null)retProcItemVal.put("O_RTN_MSG","오류가 발생하였습니다.\n시스템 관리자에게 문의하세요.");
				throw new BizException(retProcItemVal.get("O_RTN_MSG").toString());
			}
			
			// 구매 프로시저 처리가 성공일 경우
			if ( ValidationUtil.isEquals(retProcItemVal.get("O_RTN_CD").toString(), Const.PURC_PROC_SUCC) ) {
				String p_upjang_cd      = rowData.get("rcUpjang").toString();
				String p_apply_date     = rowData.get("needDate").toString();
				double p_occur_amt        = 0;
				double p_occur_amt_before = 0;
				String p_key_nm         = rowData.get("prNum").toString();
				RecordSet mtrlsInfo     = null;
				String objMtrlsTxnClss  = "";  // 대상자재과세구분 
				double objAplcAmt       = 0;   // 대상신청금액

				//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				// 대상자재과세구분 셋팅
				Map<String, Object> inParam = new HashMap<String, Object>();
				inParam.put("itemCode", rowData.get("itemCode").toString());
				mtrlsInfo = orderRequestChangeDAO.selectMtrlsTxnClss(inParam);
				if ( ValidationUtil.isEmpty(mtrlsInfo) ) {
					rtnMap.put("O_RTN_CD", "F000");
					rtnMap.put("O_RTN_MSG", "변경자재에대한 정보가 없습니다.");
					rtnMap.put("cnt", delRowCnt);
					rtnMap.put("PR_NUM", prNum);

					return rtnMap;
				} else {
					objMtrlsTxnClss = mtrlsInfo.get(0).getString("taxCode");
				}
				
				//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				// 신청금액 계산
				// 대상신청금액
				objAplcAmt = Double.parseDouble(rowData.get("salePrice").toString()) * Double.parseDouble(rowData.get("poQty").toString());  // 소수점 반올림
				// 과세일 경우
				if ( ValidationUtil.isEquals(objMtrlsTxnClss, Const.TXN_CLSS_100) ) {
					p_occur_amt_before = Math.round(objAplcAmt * 1.1);  // 소수점 반올림
				} else {
					p_occur_amt_before = Math.round(objAplcAmt);
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
				procedureParam.put("p_occur_prg_id",     "OrderRequestChange"); // 프로그램ID
				procedureParam.put("p_occur_prg_nm",     "주문신청 자재변경");  // 프로그램 한글명
				procedureParam.put("p_cuser",            loginDTO.getSabun());  // 생성자
				rtnProcedure = orderRequestDAO.procLncrTtz(procedureParam);
				
				if ( !ValidationUtil.isEquals(rtnProcedure.get("o_rtn").toString(), Const.YN_Y) ) {
					throw new BusinessRuntimeException(rtnProcedure.get("o_rtnmsg").toString());
				}
			}
			
			// 기존 대상자재 신청자료 삭제 : PR_ID 기준 자료 삭제
			delRowCnt += orderRequestDAO.delete(rowData);
		
			// 변경자재 기준 주문신청 정보 생성
			if (delRowCnt > 0) {
				insRowCnt += orderRequestChangeDAO.insert(rowData);
				
				// PO_CONTRACT_FSALE에 OP_RATE, OP_PRICE 적용
				orderRequestChangeDAO.updateOpPrice(rowData);
			}
		}
		
		//GROUP PR_NUM 생성.
		RecordSet rs = orderRequestChangeDAO.selectPrGroup(list.get(0));
		
		//구매 IF 등록.
		for (int i = 0 ; i < rs.size() ; i++) {
			Map<String, Object> rowData = rs.get(i);
			prNum = orderDecisionDAO.selectPrNum(rowData);

			rowData.put("newPrNum", prNum);//신규 PR_NUM ( 저장용 )
			
			orderDecisionDAO.prNumUpdate(rowData);
			
			retProcItemVal = ifinsert(rowData);//구매 IF 데이터 등록
			if(!"S000".equals(retProcItemVal.get("O_RTN_CD").toString())){
				if(retProcItemVal.get("O_RTN_MSG") == null)retProcItemVal.put("O_RTN_MSG","오류가 발생하였습니다.\n시스템 관리자에게 문의하세요.");
				throw new BizException(retProcItemVal.get("O_RTN_MSG").toString());
			}
		}
		
		// 구매 프로시저 처리가 성공일 경우
		if ( ValidationUtil.isEquals(retProcItemVal.get("O_RTN_CD").toString(), Const.PURC_PROC_SUCC) ) {
			Map<String, Object> rowData = list.get(0);
			String p_upjang_cd          = rowData.get("rcUpjang").toString();
			String p_apply_date         = rowData.get("needDate").toString();
			double p_occur_amt            = 0;
			double p_occur_amt_before     = 0;
			String p_key_nm             = prNum;
			String chngMtrlsTxnClss     = rtnValue[1];  // 변경자재과세구분
			double chngAplcAmt          = 0;            // 변경신청금액

			// 변경신청금액
			chngAplcAmt = Double.parseDouble(rtnValue[2]) * Double.parseDouble(rowData.get("poQty").toString());  // 소수점 반올림
			// 과세일 경우
			if ( ValidationUtil.isEquals(chngMtrlsTxnClss, Const.TXN_CLSS_100) ) {
				p_occur_amt = Math.round(chngAplcAmt * 1.1);  // 소수점 반올림
			} else {
				p_occur_amt = Math.round(chngAplcAmt);
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
			procedureParam.put("p_occur_prg_id",     "OrderRequestChange"); // 프로그램ID
			procedureParam.put("p_occur_prg_nm",     "주문신청 자재변경");  // 프로그램 한글명
			procedureParam.put("p_cuser",            loginDTO.getSabun());  // 생성자
			rtnProcedure = orderRequestDAO.procLncrTtz(procedureParam);
			
			if ( !ValidationUtil.isEquals(rtnProcedure.get("o_rtn").toString(), Const.YN_Y) ) {
				throw new BusinessRuntimeException(rtnProcedure.get("o_rtnmsg").toString());
			}
		}
		
		rtnMap.put("O_RTN_CD", "S000");
		rtnMap.put("O_RTN_MSG", "정상 처리");
		rtnMap.put("cnt", delRowCnt);
		rtnMap.put("PR_NUM", prNum);

		return rtnMap;
	}
// [속도개선 Project   끝] 2017. 8. 4. 최범주
	
	/**
	 * 구매 IF 등록 입고일자변경, 구매등록에 쓰인다.(row)
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	public Map<String, Object> ifinsert(Map<String , Object> rowData) throws Exception {
		/** 주문결의시 구매쪽 IF  **/
		Map<String, Object> pMap = new HashMap<String, Object>();
		pMap.put("i_sys_id", 	  String.valueOf("100")); //시스템 아이디
		pMap.put("i_comp_cd", 	  String.valueOf("HFC")); //회사 코드 ('HFC')
		pMap.put("i_req_sys_cd",  String.valueOf("FR")); //신청 시스템 코드 [PR: 전사구매, FR: 통합영업, WR: WMS]
		pMap.put("i_purc_typ_cd", String.valueOf("MT")); //신청 시스템 구매유형 코드[MT:식자재, CT:상품, BT:일반자재(소모품),ST:일반자재(저장품),JT:일반자재(고정자산)]
		pMap.put("i_shop_cd", 	  String.valueOf(rowData.get("rcUpjang"))); //신청업장 코드 - > 입고업장으로 변경
		pMap.put("i_req_usr_id",  String.valueOf(rowData.get("prSabun"))); //신청자 아이디
		pMap.put("i_req_typ_cd",  String.valueOf(rowData.get("poType"))); //통합영업 S/O 유형코드(07,29)
		pMap.put("i_req_no", 	  String.valueOf(rowData.get("prNum"))); //Sales Order 요청 번호(PO_NUM)
		pMap.put("i_req_cls", 	  String.valueOf("C")); //요청 상태 [C-신규, U-수정, D-삭제]
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
			
		Map<String, Object> pMap = new HashMap<String, Object>();
		pMap.put("i_sys_id", 	  String.valueOf("100")); //시스템 아이디
		pMap.put("i_comp_cd", 	  String.valueOf("HFC")); //회사 코드 ('HFC')
		pMap.put("i_req_sys_cd",  String.valueOf("FR")); //신청 시스템 코드 [PR: 전사구매, FR: 통합영업, WR: WMS]
		pMap.put("i_purc_typ_cd", String.valueOf("MT")); //신청 시스템 구매유형 코드[MT:식자재, CT:상품, BT:일반자재(소모품),ST:일반자재(저장품),JT:일반자재(고정자산)]
		pMap.put("i_shop_cd", 	  String.valueOf(rowData.get("rcUpjang"))); //신청업장 코드 - > 입고업장으로 변경
		pMap.put("i_req_usr_id",  String.valueOf(rowData.get("prSabun"))); //신청자 아이디
		pMap.put("i_req_typ_cd",  String.valueOf(rowData.get("poType"))); //통합영업 S/O 유형코드(07,29)
		pMap.put("i_req_no", 	  String.valueOf(rowData.get("prNum"))); //Sales Order 요청 번호(PO_NUM)
		pMap.put("i_req_cls", 	  status); //요청 상태 [C-신규, U-수정, D-삭제]
		retProcItemVal  = orderDecisionDAO.sp_if_sales_order(pMap);
		

		rowData.put("rtnMsg", retProcItemVal.get("O_RTN_MSG").toString());
        rowData.put("rtnCd", retProcItemVal.get("O_RTN_CD").toString());
		
        orderRequestDAO.prNumUpdateIF(rowData);//구매 IF 결과 저장
        
        return retProcItemVal;
	}
}
