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
import com.hwfs.fm.fmo.dao.OrderDecisionModifyDAO;
import com.hwfs.fm.fmo.dao.OrderRequestChangeDAO;
import com.hwfs.fm.fmo.dao.OrderRequestDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.util.Const;
import com.hwfs.sc.cmn.util.NumberUtil;
import com.hwfs.sc.cmn.util.ValidationUtil;
import com.sz.business.BusinessRuntimeException;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 주문결의하는 OrderDecision Service Implementation
 * 
 * @ClassName OrderDecisionServiceImpl.java
 * @Description OrderDecisionServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.23    손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.06.23
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fmo/orderDecisionService")
public class OrderDecisionServiceImpl extends DefaultServiceImpl implements OrderDecisionService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	/** OrderDecisionDAO Bean 생성 */
	@Resource(name = "/fm/fmo/orderDecisionDAO")
	private OrderDecisionDAO orderDecisionDAO;
	
	/** OrderRequestDAO Bean 생성 */
	@Resource(name = "/fm/fmo/orderRequestDAO")
	private OrderRequestDAO orderRequestDAO;
	
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	/** orderDecisionModifyDAO Bean 생성 */
	@Resource(name = "/fm/fmo/orderDecisionModifyDAO")
	private OrderDecisionModifyDAO orderDecisionModifyDAO;

	/** OrderRequestChangeDAO Bean 생성 */
	@Resource(name = "/fm/fmo/orderRequestChangeDAO")
	private OrderRequestChangeDAO orderRequestChangeDAO;
// [속도개선 Project   끝] 2017. 8. 4. 최범주
	
	/**
	 * 주문결의 목록을 조회한다.
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
		mapParam.put("schCode", inCode(mapParam.get("schCode").toString()));
		return orderDecisionDAO.selectList(mapParam);
	}
	

	/**
	 * 주문결의 목록을 체크한다.
	 * <pre>
	 * - 0단가, 불용, 중지자재를 체크한다
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectCheckList(Map<String, Object> mapParam) throws Exception {
		return orderDecisionDAO.selectCheckList(mapParam);
	}
	
	
	/**
	 * 주문결의 목록을 조회한다.
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
	public RecordSet selectSub(Map<String, Object> mapParam) throws Exception {
		return orderDecisionDAO.selectSub(mapParam);
	}
	
	/**
	 * 주문결의 목록을 조회한다.
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
	public RecordSet savechk(Map<String, Object> mapParam) throws Exception {
		mapParam.put("listPrNum", inCode(mapParam.get("listPrNum").toString()));
		// CENTER_CODE 다중 처리 : 2016-01-11
		mapParam.put("schCode", inCode(mapParam.get("schCode").toString()));
		return orderDecisionDAO.savechk(mapParam);
	}
	
	
	/**
	 * 주문결의 입고예정일 변경전 통제여부 확인.
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
	public RecordSet selectSubFlag(Map<String, Object> mapParam) throws Exception {
		return orderDecisionDAO.selectSubFlag(mapParam);
	}

	
	/**
	 * 주문결의 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.(결의)
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveResol(DataSetMap list) throws Exception {
		Map<String, Object> retProcItemVal = new HashMap<String, Object>();
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;

		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			if(rowData.get("chk").toString().equals("1")){
				String poNum = orderDecisionDAO.poNumseq(rowData);
				rowData.put("poNum", poNum);
				updRowCnt += orderDecisionDAO.saveResol(rowData);
				/** 주문결의시 구매쪽 IF  **/
				/*
				retProcItemVal = ifupdate(rowData);
	            if(!"S000".equals(retProcItemVal.get("O_RTN_CD").toString())){
	            	if(retProcItemVal.get("O_RTN_MSG") == null)retProcItemVal.put("O_RTN_MSG","오류가 발생하였습니다.\n시스템 관리자에게 문의하세요.");
	            	throw new BizException(retProcItemVal.get("O_RTN_MSG").toString());
				}
				*/
			}
		}
		return insRowCnt + updRowCnt + delRowCnt;
	}
	/**
	 * 주문결의 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public Map<String, Object> saveList(DataSetMap list, LoginDTO loginDTO) throws Exception {
		Map<String, Object> returnVal = new HashMap<String, Object>();
		Map<String, Object> chngLs    = new HashMap<String, Object>();
		Map<String, Object> inParam   = null;
		RecordSet odrInfo             = null;
		int updRowCnt = 0;
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// 판매금액 수정전 금액 셋팅
		for ( int i = 0; i < list.size(); i++ ) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			if ( rowType == DataSet.ROW_TYPE_UPDATED ) {
    			inParam = new HashMap<String, Object>();
    			inParam.put("prId", rowData.get("prId").toString());
    			odrInfo = orderDecisionModifyDAO.selectChngBefSellAmt(inParam);
    			if ( ValidationUtil.isEmpty(odrInfo) ) {
    				throw new BusinessRuntimeException("주문정보가 없습니다.");
    			} else {
    				chngLs.put(odrInfo.get(0).getString("prId"), odrInfo.get(0).getString("sellAmt"));
    			}
			}
		}

		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			// CENTER_CODE 다중 처리 : 2016-01-11
			if(rowData.get("schCode") != null) rowData.put("schCode", inCode(rowData.get("schCode").toString()));
			
			//Update 처리
			if (rowType == DataSet.ROW_TYPE_UPDATED) {
				RecordSet rs = orderDecisionDAO.saveItemChk(rowData);
				//수정전 구매 상태 조회
				String status = orderDecisionDAO.poStatusSelect(rowData);
				if("DL".equals(status) || "GC".equals(status) || "IV".equals(status) || "PD".equals(status)){
					returnVal.put("O_RTN_CD", "-1");
					returnVal.put("O_RTN_MSG", "배송중,입고완료,정산완료,발주취소 상태 일경우\n수정할 수 없습니다.");
					throw new BizException(returnVal.get("O_RTN_MSG").toString());
				}
				
				if(!"HK".equals(rs.get(0).get("poStatus"))){
					returnVal.put("O_RTN_CD", rs.get(0).get("poStatus"));
					returnVal.put("O_RTN_MSG", "자재별 유효성체크 결과 에러가 발생하였습니다.\n자재명 : "+rs.get(0).get("itemName")+"\n"+ rs.get(0).get("poMsg"));
					returnVal.put("updRowCnt", 0);
					throw new BizException(returnVal.get("O_RTN_MSG").toString());
				}
			}
		}
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			//Update 처리
			if (rowType == DataSet.ROW_TYPE_UPDATED) {

				updRowCnt += orderDecisionDAO.update(rowData);
				returnVal = ifupdate(rowData);

				rowData.put("rtnMsg", returnVal.get("O_RTN_MSG").toString());
	            rowData.put("rtnCd", returnVal.get("O_RTN_CD").toString());
				
	            orderRequestDAO.prNumUpdateIF(rowData);//구매 IF 결과 저장
	            
				if(!"S000".equals(returnVal.get("O_RTN_CD").toString())){
					if(returnVal.get("O_RTN_MSG") == null)returnVal.put("O_RTN_MSG","오류가 발생하였습니다.\n시스템 관리자에게 문의하세요.");
					throw new BizException(returnVal.get("O_RTN_MSG").toString());
				}
				
	    		// 구매 프로시저 처리가 성공일 경우
	    		if ( ValidationUtil.isEquals(returnVal.get("O_RTN_CD").toString(), Const.PURC_PROC_SUCC) ) {
	    			String p_upjang_cd      = rowData.get("rcUpjang").toString();  // (필수)업장코드
	    			String p_apply_date     = rowData.get("needDate").toString();  // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
	    			double p_occur_amt        = 0;                                   // (필수)발생금액
	    			double p_occur_amt_before = 0;                                   // (필수)발생금액(전)
	    			String p_key_nm         = rowData.get("prNum").toString();     // (필수)키명
	    			double sellAmt          = 0;
	    			String itemCode         = rowData.get("itemCode").toString();
	    			String taxCode          = "";
	    			
	    			//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	    			// 주문내역 자재의 과세구분 셋팅
	    			inParam = new HashMap<String, Object>();
	    			inParam.put("itemCode", itemCode);
	    			RecordSet mtrlsInfo = orderRequestChangeDAO.selectMtrlsTxnClss(inParam);
	    			if ( ValidationUtil.isEmpty(mtrlsInfo) ) {
	    				throw new BusinessRuntimeException("변경자재에대한 정보가 없습니다.");
	    			} else {
	    				taxCode = mtrlsInfo.get(0).getString("taxCode");
	    			}
	    			
	    			//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	    			// 발생금액(전) 셋팅	    			
					p_occur_amt_before = Math.round(Double.parseDouble(chngLs.get(rowData.get("prId").toString()).toString()));
					//////////////////////////////////////////////////////////////////////////////////////////////////////////////
					// 발생금액 셋팅
					sellAmt = Double.parseDouble(rowData.get("salePrice").toString()) * Double.parseDouble(rowData.get("poQty").toString());  // 소수점 반올림
					
					// 과세일 경우
					if ( ValidationUtil.isEquals(taxCode, Const.TXN_CLSS_100) ) {
						p_occur_amt = Math.round(sellAmt * 1.1);  // 소수점 반올림
					} else {
						p_occur_amt = Math.round(sellAmt);
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

		returnVal.put("O_RTN_CD", "HK");
		returnVal.put("O_RTN_MSG", "");
		returnVal.put("updRowCnt", updRowCnt);
		return returnVal;
	}
// [속도개선 Project   끝] 2017. 8. 4. 최범주
	
	
	/**
	 * 주문결의 하단 주문내역의 신청비고를 수정한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveRemList(DataSetMap list) throws Exception {
		int updRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			//Update 처리
			if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += orderDecisionDAO.updateRemark(rowData);
			}
		}
		return updRowCnt;
	}

	
	
	/**
	 * 주문결의 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * 주문내역의 신청비고를 수정한다 : 2015-12-14
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public Map<String, Object> saveRemList2(DataSetMap list) throws Exception {
		Map<String, Object> returnVal = new HashMap<String, Object>();
		int updRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			//Update 처리
			if (rowType == DataSet.ROW_TYPE_UPDATED) {
				//수정전 구매 상태 조회
				String status = orderDecisionDAO.poStatusSelect(rowData);
				if("DL".equals(status) || "GC".equals(status) || "IV".equals(status) || "PD".equals(status)){
					returnVal.put("O_RTN_CD", "-1");
					returnVal.put("O_RTN_MSG", "배송중,입고완료,정산완료,발주취소 상태 일경우\n수정할 수 없습니다.");
					throw new BizException(returnVal.get("O_RTN_MSG").toString());
				}
				
			}
		}
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			//Update 처리
			if (rowType == DataSet.ROW_TYPE_UPDATED) {
				// 신청(비고)란 수정
				updRowCnt += orderDecisionDAO.updateRemark(rowData);
				returnVal = ifupdateRemark(rowData);

				rowData.put("rtnMsg", returnVal.get("O_RTN_MSG").toString());
	            rowData.put("rtnCd", returnVal.get("O_RTN_CD").toString());
				
	            //orderRequestDAO.prNumUpdateIF(rowData);//구매 IF 결과 저장
	            
				if(!"S000".equals(returnVal.get("O_RTN_CD").toString())){
					if(returnVal.get("O_RTN_MSG") == null)returnVal.put("O_RTN_MSG","오류가 발생하였습니다.\n시스템 관리자에게 문의하세요.");
					throw new BizException(returnVal.get("O_RTN_MSG").toString());
				}
			}
		}

		returnVal.put("O_RTN_CD", "HK");
		returnVal.put("O_RTN_MSG", "");
		returnVal.put("updRowCnt", updRowCnt);
		return returnVal;
	}
	
	
	
	
	/**
	 * 주문결의 반려 처리한다.(List)
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
			if(rowData.get("chk").toString().equals("1")){
				//반려 리스트 조회
				RecordSet rs = orderDecisionDAO.returnList(rowData);
				for (int row = 0 ; row < rs.size() ; row++) {
					Map<String, Object> rRowData = rs.get(row);
					//수정전 구매 상태 조회
					String status = orderDecisionDAO.poStatusSelect(rRowData);
					if("DL".equals(status) || "GC".equals(status) || "IV".equals(status) || "PD".equals(status)){
						retProcVal.put("O_RTN_CD", "-1");
						retProcVal.put("O_RTN_MSG", "배송중,입고완료,정산완료,발주취소 상태 일경우\n반려할 수 없습니다.");
						throw new BizException(retProcVal.get("O_RTN_MSG").toString());
					}
					
					rRowData.put("remark", rowData.get("remark"));
					rRowData.put("schDate1", rowData.get("schDate1"));
					rRowData.put("schDate2", rowData.get("schDate2"));
					updRowCnt += orderDecisionDAO.returnUpdate(rRowData);//반려 업데이트.
					
					retProcVal = ifdelete(rRowData);
					if(!"S000".equals(retProcVal.get("O_RTN_CD").toString())){
						if(retProcVal.get("O_RTN_MSG") == null)retProcVal.put("O_RTN_MSG","시스템 오류가 발생하였습니다.\n관리자에게 문의하세요.");
						throw new BizException(retProcVal.get("O_RTN_MSG").toString());
					}
					rowData.put("rtnMsg", retProcVal.get("O_RTN_MSG").toString());
		            rowData.put("rtnCd", retProcVal.get("O_RTN_CD").toString());
					
		            orderRequestDAO.prNumUpdateIF(rowData);//구매 IF 결과 저장
		            
		    		// 구매 프로시저 처리가 성공일 경우
		    		if ( ValidationUtil.isEquals(retProcVal.get("O_RTN_CD").toString(), Const.PURC_PROC_SUCC) ) {
		    			String p_upjang_cd      = rRowData.get("rcUpjang").toString();  // (필수)업장코드
		    			String p_apply_date     = rRowData.get("needDate").toString();  // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
		    			double p_occur_amt        = 0;                                    // (필수)발생금액
		    			double p_occur_amt_before = 0;                                    // (필수)발생금액(전)
		    			String p_key_nm         = rRowData.get("prNum").toString();     // (필수)키명
		    			double sellAmt          = 0;
		    			
		    			//////////////////////////////////////////////////////////////////////////////////////////////////////////
		    			// 발생금액(전) 셋팅
						sellAmt = Double.parseDouble(rRowData.get("salePrice").toString()) * Double.parseDouble(rRowData.get("poQty").toString());  // 소수점 반올림
						// 과세일 경우
						if ( ValidationUtil.isEquals(rRowData.get("taxCode").toString(), Const.TXN_CLSS_100) ) {
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
		}
				
		return retProcVal;
	}
// [속도개선 Project   끝] 2017. 8. 4. 최범주

	
	/**
	 * 주문결의 반려 처리한다.(subList)
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	@SuppressWarnings("unchecked")
	public Map<String, Object> returnSub(DataSetMap list, LoginDTO loginDTO) throws Exception {
		Map<String, Object> retProcVal = new HashMap<String, Object>();
		Map<String, Object> chngLs     = new HashMap<String, Object>();
		Map<String, Object> inParam    = null;
		RecordSet odrInfo              = null;
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// 판매금액 셋팅
		for ( int i = 0; i < list.size(); i++ ) {
			Map<String, Object> rowData = list.get(i);
			
			if ( ValidationUtil.isEquals(rowData.get("chk").toString(), "1") ) {
    			inParam = new HashMap<String, Object>();
    			inParam.put("prId", rowData.get("prId").toString());
    			odrInfo = orderDecisionModifyDAO.selectChngBefSellAmt(inParam);
    			if ( ValidationUtil.isEmpty(odrInfo) ) {
    				throw new BusinessRuntimeException("주문정보가 없습니다.");
    			} else {
    				chngLs.put(odrInfo.get(0).getString("prId"), odrInfo.get(0).getString("sellAmt"));
    			}
			}
		}
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			if(rowData.get("chk").toString().equals("1")){
				//수정전 구매 상태 조회
				String status = orderDecisionDAO.poStatusSelect(rowData);
				if("DL".equals(status) || "GC".equals(status) || "IV".equals(status) || "PD".equals(status)){
					retProcVal.put("O_RTN_CD", "-1");
					retProcVal.put("O_RTN_MSG", "배송중,입고완료,정산완료,발주취소 상태 일경우\n반려할 수 없습니다.");
					return retProcVal;
				}
				
				updRowCnt += orderDecisionDAO.returnUpdate(rowData);//반려 업데이트.
				
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
	    			
	    			//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	    			// 발생금액(전) 셋팅
	    			p_occur_amt_before = Math.round(Double.parseDouble(chngLs.get(rowData.get("prId").toString()).toString()));

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
				
		return retProcVal;
	}
// [속도개선 Project   끝] 2017. 8. 4. 최범주
	
	/**
	 * 주문결의 입고일자 변경 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int needupdate(DataSetMap list) throws Exception {
		
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			if("1".equals(rowData.get("chk").toString())){
				updRowCnt += orderDecisionDAO.needupdate(rowData);
			}
		}
		return insRowCnt+updRowCnt+delRowCnt;
	}
	
	/**
	 * 주문결의 입고일자 변경 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	@SuppressWarnings("unchecked")
	public Map<String, Object> needupdateAll(DataSetMap list, DataSetMap sublist, LoginDTO loginDTO) throws Exception {
		logger.debug("#####");
		Map<String, Object> retProcItemVal = new HashMap<String, Object>();
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			for(int r = 0; r < sublist.size() ; r++){
				Map<String, Object> subRowData = sublist.get(r);
				logger.debug(" ### subRowData : "+ subRowData); 
				//	수정전 구매 상태 조회
				String status = orderDecisionDAO.poStatusSelect(subRowData);
				if("DL".equals(status) || "GC".equals(status) || "IV".equals(status) || "PD".equals(status)){
					//retProcItemVal.put("O_RTN_CD", "-1");
					//retProcItemVal.put("O_RTN_MSG", "배송중,입고완료,정산완료,발주취소 상태 일경우\n수정할 수 없습니다.");
					//return retProcItemVal;
					logger.debug("배송중,입고완료,정산완료,발주취소 상태 일경우\n수정할 수 없습니다.");
					continue;
				}
				
				subRowData.put("chgneedDate",rowData.get("chgneedDate"));
				subRowData.put("chgRemark",rowData.get("chgRemark"));
				updRowCnt += orderDecisionDAO.needupdate(subRowData);
				retProcItemVal = ifdelete(subRowData);
				if(!"S000".equals(retProcItemVal.get("O_RTN_CD").toString())){
					if(retProcItemVal.get("O_RTN_MSG") == null)retProcItemVal.put("O_RTN_MSG","오류가 발생하였습니다.\n시스템 관리자에게 문의하세요.");
					throw new BizException(retProcItemVal.get("O_RTN_MSG").toString());
		        }
				subRowData.put("oRtnCd", retProcItemVal.get("O_RTN_CD").toString());
				subRowData.put("oRtnMsg", retProcItemVal.get("O_RTN_MSG").toString());
				logger.debug("rowData : " + subRowData);
				orderDecisionDAO.ifReturnUpdateId(subRowData);
				
				if ( rowData.containsKey("prNum") ) {
					// 구매 프로시저 처리가 성공일 경우
					if ( ValidationUtil.isEquals(retProcItemVal.get("O_RTN_CD").toString(), Const.PURC_PROC_SUCC) ) {
						String p_upjang_cd      = rowData.get("rcUpjang").toString();
						String p_apply_date     = rowData.get("chgneedDate").toString() + "|" + subRowData.get("needDate").toString();  // 변경후입고일자 + 변경전입고일자 
						double p_occur_amt        = 0;
						double p_occur_amt_before = 0;
						String p_key_nm         = rowData.get("prNum").toString();
						String prId             = subRowData.get("prId").toString();
						
						//////////////////////////////////////////////////////////////////////////////////////////////////////////
						// 발생금액 셋팅
						Map<String, Object> inParam = new HashMap<String, Object>();
						inParam.put("prId", prId);
						RecordSet sellAmtInfo = orderDecisionDAO.selectSellAmt(inParam);
						if ( ValidationUtil.isEmpty(sellAmtInfo) ) {
							throw new BusinessRuntimeException("주문내역에대한 정보가 없습니다.");
						} else {
							p_occur_amt = Math.round(Double.parseDouble(sellAmtInfo.get(0).getString("saleAmt").toString()));
						}
						
						Map<String, Object> rtnProcedure   = null;
						Map<String, Object> procedureParam = new HashMap<String, Object>();
						procedureParam.put("p_upjang_cd",        p_upjang_cd);          // (필수)업장코드
						procedureParam.put("p_apply_date",       p_apply_date);         // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
						procedureParam.put("p_occur_class",      "11");                 // (필수)발생구분(01:매입예정 02:매입확정 03:외상매출금 11:입고일자변경(매입예정용))
						procedureParam.put("p_occur_amt",        p_occur_amt);          // (필수)발생금액
						procedureParam.put("p_occur_amt_before", p_occur_amt_before);   // (필수)발생금액(전)
						procedureParam.put("p_class_cd",         "01");                 // (필수)구분코드(01:주문신청관련 02:매출보정 03:판매단가변경 04:창고 강제변경 05:현지구매 06:영업회계 일마감 07:채권이관/입금처리)
						procedureParam.put("p_occur_table",      "SO_PR");              // (필수)발생테이블
						procedureParam.put("p_key_nm",           "PR_ID");              // (필수)키명
						procedureParam.put("p_key_value01",      prId);                 // (필수)키1(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
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
		}
		
		//PR_NUM 재생성		
		if(list.size() > 0){
			Map<String, Object> rowData = list.get(0);
			String prNum = orderDecisionDAO.selectPrNum(rowData);
			
			rowData.put("newPrNum", prNum);//신규 PR_NUM ( 저장용 )
			orderDecisionDAO.prNumUpdate(rowData);
			
				//구매 IF 재 등록.			
			rowData.put("prNum", prNum);//신규 PR_NUM ( 구매 등록 )
			retProcItemVal = ifinsert(rowData);
				
			if(!"S000".equals(retProcItemVal.get("O_RTN_CD").toString())){
				if(retProcItemVal.get("O_RTN_MSG") == null)retProcItemVal.put("O_RTN_MSG","오류가 발생하였습니다.\n시스템 관리자에게 문의하세요.");
				throw new BizException(retProcItemVal.get("O_RTN_MSG").toString());
	        }
			rowData.put("oRtnCd", retProcItemVal.get("O_RTN_CD").toString());
			rowData.put("oRtnMsg", retProcItemVal.get("O_RTN_MSG").toString());
			logger.debug("rowData : " + rowData);
			orderDecisionDAO.ifReturnUpdateNum(rowData);
		}
		if(retProcItemVal.size() == 0){
			retProcItemVal.put("O_RTN_CD", "S000");
			retProcItemVal.put("O_RTN_MSG", "");
		}
		return retProcItemVal;
	}
// [속도개선 Project   끝] 2017. 8. 4. 최범주
	
	
	/**
	 * 구매 IF 데이터 삭제.(List)
	 * 
	 * 
	 **/
	@SuppressWarnings("unchecked")
	public Map<String, Object> ifList(DataSetMap list, String gubun) throws Exception {
		Map<String, Object> retProcItemVal = new HashMap<String, Object>();
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> subRowData = list.get(i);
			if("C".equals(gubun)){
				retProcItemVal = ifinsert(subRowData);
			}else if("U".equals(gubun)){
				retProcItemVal = ifupdate(subRowData);
			}else if("D".equals(gubun)){
				retProcItemVal = ifdelete(subRowData);
			}
		}
		return retProcItemVal;
	}
	
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
		pMap.put("i_req_typ_cd",  String.valueOf(rowData.get("poType"))); //통합영업 S/O 유형코드(07)
		pMap.put("i_req_no", 	  String.valueOf(rowData.get("prNum"))); //Sales Order 요청 번호(PO_NUM)
		pMap.put("i_req_cls", 	  String.valueOf("C")); //요청 상태 [C-신규, U-수정, D-삭제]
		return orderDecisionDAO.sp_if_sales_order(pMap);
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
		logger.debug("### poPocnt : " + poPocnt);
		if(poPocnt > 1){
			status = "U";
		}else if(poPocnt <= 1){
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
		retProcItemVal  = orderDecisionDAO.sp_if_sales_order(pMap);
		
		rowData.put("rtnMsg", retProcItemVal.get("O_RTN_MSG").toString());
        rowData.put("rtnCd", retProcItemVal.get("O_RTN_CD").toString());
		
        orderRequestDAO.prNumUpdateIF(rowData);//구매 IF 결과 저장
		
		return retProcItemVal;
	}
	
	
	/**
	 * 구매 IF 업데이트 신청(비고) 수정에 쓰인다.(row) : 2015-12-14
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	public Map<String, Object> ifupdateRemark(Map<String, Object> rowData) throws Exception {
		/** 주문결의시 신청(비고)관련 구매쪽 IF  **/
		Map<String, Object> pMap = new HashMap<String, Object>();
		pMap.put("i_sys_id", 	  String.valueOf("100")); //시스템 아이디
		pMap.put("i_comp_cd", 	  String.valueOf("HFC")); //회사 코드 ('HFC')
		pMap.put("i_legcy_req_no", 	  String.valueOf(rowData.get("prNum"))); //Sales Order 요청 번호(PO_NUM)
		pMap.put("i_legcy_req_lno", 	  String.valueOf(rowData.get("prId"))); //Sales Order 요청 번호(PO_ID)
		pMap.put("i_pr_rem",  String.valueOf(rowData.get("prRemark"))); //통합영업 PR_REMARK

		return orderDecisionDAO.sp_if_sales_remarks(pMap);
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

// [속도개선 Project 시작] 2017. 7. 20. 최범주 주문결의 반려 시 CS담당자 연락처로 송신자번호 셋팅
	/**
	 * CS담당자연락처정보 조회
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
	public RecordSet selectCsChgAcaInfo(Map<String, Object> mapParam) throws Exception {
		return orderDecisionDAO.selectCsChgAcaInfo(mapParam);
	}
// [속도개선 Project   끝] 2017. 7. 20. 최범주
}
