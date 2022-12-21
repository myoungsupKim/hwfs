package com.hwfs.fm.fmo.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.fm.fmo.dao.OrderDecisionDAO;
import com.hwfs.fm.fmo.dao.OrderRequestConfirmPopDAO;
import com.hwfs.fm.fmo.dao.OrderRequestDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.util.Const;
import com.hwfs.sc.cmn.util.NumberUtil;
import com.hwfs.sc.cmn.util.ValidationUtil;
import com.sz.business.BusinessRuntimeException;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 주문조정하는 OrderRequestConfirmPop Service Implementation
 * 
 * @ClassName OrderRequestConfirmPopServiceImpl.java
 * @Description OrderRequestConfirmPopServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.24    손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.06.24
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fmo/orderRequestConfirmPopService")
public class OrderRequestConfirmPopServiceImpl extends DefaultServiceImpl implements OrderRequestConfirmPopService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	/** OrderRequestConfirmPopDAO Bean 생성 */
	@Resource(name = "/fm/fmo/orderRequestConfirmPopDAO")
	private OrderRequestConfirmPopDAO orderRequestConfirmPopDAO;
	
	/** OrderDecisionDAO Bean 생성 */
	@Resource(name = "/fm/fmo/orderDecisionDAO")
	private OrderDecisionDAO orderDecisionDAO;
	

	/** OrderRequestDAO Bean 생성 */
	@Resource(name = "/fm/fmo/orderRequestDAO")
	private OrderRequestDAO orderRequestDAO;
	

	/**
	 * 주문조정 목록을 조회한다.
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
		if(mapParam.get("schPrNum") != null){
			String schPrNum = mapParam.get("schPrNum").toString();
			mapParam.put("schPrNum", inCode(schPrNum));
		}
		// CENTER_CODE 다중 처리 : 2016-01-11
		mapParam.put("schCode", inCode(mapParam.get("schCode").toString()));
		return orderRequestConfirmPopDAO.selectList(mapParam);
	}
	
	/**
	 * 주문조정 목록을 조회한다.
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
	public RecordSet selectCreInfo(Map<String, Object> mapParam) throws Exception {
		if(mapParam.get("shcPrIds") != null){
			String schPrNum = mapParam.get("shcPrIds").toString();
			mapParam.put("shcPrIds", inCode(schPrNum));
		}
		RecordSet upjangList = orderRequestConfirmPopDAO.selectList(mapParam);
		
		return upjangList;
	}
	
	/**
	 * 주문조정 체크박스로 선택한 데이터를 group으로 묶어 결의 한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public Map<String, Object> updateList(DataSetMap list) throws Exception {
		Map<String, Object> retProcVal = new HashMap<String, Object>();
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			//Update 처리
			if (rowType == DataSet.ROW_TYPE_UPDATED) {
				
				// update Only prRemark
				if ( !"".equals(rowData.get("prRemark").toString()) ) {
					
					updRowCnt += orderRequestConfirmPopDAO.updateRemarkList(rowData);
					retProcVal.put("O_RTN_CD", "S000"); // for ok process
					logger.debug("rowData:{} updRowCnt:{}", rowData.toString(), updRowCnt);
					
				} else {	//old section
				//	수정전 구매 상태 조회
				
					String status = orderDecisionDAO.poStatusSelect(rowData);
					if("DL".equals(status) || "GC".equals(status) || "IV".equals(status) || "PD".equals(status)){
						retProcVal.put("O_RTN_CD", "-1");
						retProcVal.put("O_RTN_MSG", "배송중,입고완료,정산완료,발주취소 상태 일경우\n수정할 수 없습니다.");
						throw new BizException(retProcVal.get("O_RTN_MSG").toString());
					}
					
					
					updRowCnt += orderRequestConfirmPopDAO.updateList(rowData);
					
					retProcVal = ifupdate(rowData);
		            if(!"S000".equals(retProcVal.get("O_RTN_CD").toString())){
		            	if(retProcVal.get("O_RTN_MSG") == null)retProcVal.put("O_RTN_MSG","시스템 오류가 발생하였습니다.\n관리자에게 문의하세요.(구매)");
		            	throw new BizException(retProcVal.get("O_RTN_MSG").toString());
					}
				}
			}
		}
		retProcVal.put("cnt", insRowCnt + updRowCnt + delRowCnt);
		retProcVal.put("O_RTN_MSG", "S000");
		retProcVal.put("O_RTN_MSG", "");		
		return retProcVal;
	}	

	/**
	 * 주문조정 체크박스로 선택한 데이터를 group으로 묶어 결의 한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public Map<String, Object> saveList(DataSetMap list) throws Exception {
		Map<String, Object> retProcVal = new HashMap<String, Object>();
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		/*
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			//Update 처리
			if (rowType == DataSet.ROW_TYPE_UPDATED || "1".equals(rowData.get("chk").toString())) {
				
				//String status = orderDecisionDAO.poStatusSelect(rowData);
				
				//if("DL".equals(status) || "GC".equals(status) || "IV".equals(status) || "PD".equals(status)){
				//	retProcVal.put("O_RTN_CD", "-1");
				//	retProcVal.put("O_RTN_MSG", "배송중,입고완료,정산완료,발주취소 상태 일경우\n수정할 수 없습니다.");
				//	return retProcVal;
				//}
				
				
				//updRowCnt += orderRequestConfirmPopDAO.updateList(rowData);
				
				//retProcVal = ifupdate(rowData);
				//rowData.put("rtnMsg", retProcVal.get("O_RTN_MSG").toString());
	            //rowData.put("rtnCd", retProcVal.get("O_RTN_CD").toString());
				//int IFupCnt = orderRequestDAO.prNumUpdateIF(rowData);//구매 IF 결과 저장
	            //if(!"S000".equals(retProcVal.get("O_RTN_CD").toString())){
	            //	return retProcVal;
	           // 	//new BizException(retProcVal.get("O_RTN_MSG").toString());
				//}
				//logger.debug("I/F = 업데이트 건수  = " + upCnt);
				
			}
		}
		*/
		
		Map<String, Object> mapParam = list.get(0);
		String schSave = mapParam.get("save").toString();
		mapParam.put("save", inCode(schSave));
		RecordSet group = orderRequestConfirmPopDAO.selectPrGroup(mapParam);
		String poNum = "";
		for (int i = 0 ; i < group.size() ; i++) {
			int updCnt = 0;
			Map<String, Object> rowData = group.get(i);
			poNum = orderRequestConfirmPopDAO.poNumseq(mapParam);
			mapParam.put("poNum", poNum);
			mapParam.put("prNum", rowData.get("prNum"));
			mapParam.put("rcUpjang", rowData.get("rcUpjang"));
			mapParam.put("custcd", rowData.get("custcd"));
			mapParam.put("prSabun", rowData.get("prSabun"));
			updRowCnt += orderRequestConfirmPopDAO.saveResol(mapParam);
			updRowCnt += updCnt;
		}
		retProcVal.put("O_RTN_CD", "S000");
		retProcVal.put("O_RTN_MSG", "정상처리");	
		return retProcVal;
	}
	
	/**
	 * 주문조정 체크박스로 선택한 데이터를 IN 으로 받아 반려 처리 한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	@SuppressWarnings("unchecked")
	public Map<String, Object> returnList(DataSetMap list, LoginDTO loginDTO) throws Exception {
		Map<String, Object> retProcVal = new HashMap<String, Object>();
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			//Update 처리
			if (rowType == DataSet.ROW_TYPE_UPDATED && "1".equals(rowData.get("chk").toString())) {
				//	수정전 구매 상태 조회
				String status = orderDecisionDAO.poStatusSelect(rowData);
				if("DL".equals(status) || "GC".equals(status) || "IV".equals(status) || "PD".equals(status)){
					retProcVal.put("O_RTN_CD", "-1");
					retProcVal.put("O_RTN_MSG", "배송중,입고완료,정산완료,발주취소 상태 일경우\n수정할 수 없습니다.");
					throw new BizException(retProcVal.get("O_RTN_MSG").toString());
				}
				
				updRowCnt += orderRequestConfirmPopDAO.returnUpdate(rowData);//반려 업데이트.
				
				retProcVal = ifdelete(rowData);
	            if(!"S000".equals(retProcVal.get("O_RTN_CD").toString())){
	            	if(retProcVal.get("O_RTN_MSG") == null)retProcVal.put("O_RTN_MSG","시스템 오류가 발생하였습니다.\n관리자에게 문의하세요.(구매)");
	            	throw new BizException(retProcVal.get("O_RTN_MSG").toString());
				}
	            rowData.put("rtnMsg", retProcVal.get("O_RTN_MSG").toString());
	            rowData.put("rtnCd", retProcVal.get("O_RTN_CD").toString());
	            orderRequestDAO.prNumUpdateIF(rowData);//구매 IF 결과 저장
	            
	    		// 구매 프로시저 처리가 성공일 경우
	    		if ( ValidationUtil.isEquals(retProcVal.get("O_RTN_CD").toString(), Const.PURC_PROC_SUCC) ) {
	    			String p_upjang_cd      = rowData.get("rcUpjang").toString();  // (필수)업장코드
	    			String p_apply_date     = rowData.get("needDate").toString();  // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
	    			double p_occur_amt        = 0;                                   // (필수)발생금액
	    			double p_occur_amt_before = 0;                                   // (필수)발생금액(전)
	    			String p_key_nm         = rowData.get("prNum").toString();     // (필수)키명
	    			double sellAmt          = 0;
	    			String taxCode          = rowData.get("taxCode").toString();
	    			
	    			//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	    			// 발생금액(전) 셋팅
					sellAmt = Double.parseDouble(rowData.get("salePrice").toString()) * Double.parseDouble(rowData.get("poQty").toString());  // 소수점 반올림
					// 과세일 경우
					if ( ValidationUtil.isEquals(taxCode, Const.TXN_CLSS_100) ) {
						p_occur_amt_before = Math.round(sellAmt * 1.1);  // 소수점 반올림
					} else {
						p_occur_amt_before = Math.round(sellAmt);
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
	    			procedureParam.put("p_occur_prg_id",     "OrderDecision");      // 프로그램ID
	    			procedureParam.put("p_occur_prg_nm",     "주문결의");           // 프로그램 한글명
	    			procedureParam.put("p_cuser",            loginDTO.getSabun());  // 생성자
	    			rtnProcedure = orderRequestDAO.procLncrTtz(procedureParam);
	    			
	    			if ( !ValidationUtil.isEquals(rtnProcedure.get("o_rtn").toString(), Const.YN_Y) ) {
	    				throw new BusinessRuntimeException(rtnProcedure.get("o_rtnmsg").toString());
	    			}
	    		}
			}
		}				
		retProcVal.put("cnt", insRowCnt + updRowCnt + delRowCnt);
		retProcVal.put("O_RTN_MSG", "S000");
		retProcVal.put("O_RTN_MSG", "");
		return retProcVal;
	}
// [속도개선 Project   끝] 2017. 8. 4. 최범주
	
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
	
	/**
	 * 구매 IF 업데이트 수량변경 등에 쓰인다.(row)
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	public Map<String, Object> ifupdate(Map<String, Object> rowData) throws Exception {
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
		pMap.put("i_req_cls", 	  String.valueOf("U")); //요청 상태 [C-신규, U-수정, D-삭제]

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
		pMap.put("i_req_typ_cd",  String.valueOf(rowData.get("poType"))); //통합영업 S/O 유형코드(07)
		pMap.put("i_req_no", 	  String.valueOf(rowData.get("prNum"))); //Sales Order 요청 번호(PO_NUM)
		pMap.put("i_req_cls", 	  status); //요청 상태 [C-신규, U-수정, D-삭제]
		return orderDecisionDAO.sp_if_sales_order(pMap);
	}
}
