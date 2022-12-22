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
import com.hwfs.fm.fmo.dao.OrderDecisionModifyDAO;
import com.hwfs.fm.fmo.dao.OrderRequestConfirmModifyDAO;
import com.hwfs.fm.fmo.dao.OrderRequestDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.util.Const;
import com.hwfs.sc.cmn.util.NumberUtil;
import com.hwfs.sc.cmn.util.ValidationUtil;
import com.sz.business.BusinessRuntimeException;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 주문결의수정하는 OrderDecisionModify Service Implementation
 * 
 * @ClassName OrderDecisionModifyServiceImpl.java
 * @Description OrderDecisionModifyServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.23    손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.07.23
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fmo/orderDecisionModifyService")
public class OrderDecisionModifyServiceImpl extends DefaultServiceImpl implements OrderDecisionModifyService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	/** orderDecisionModifyDAO Bean 생성 */
	@Resource(name = "/fm/fmo/orderDecisionModifyDAO")
	private OrderDecisionModifyDAO orderDecisionModifyDAO;
	
	@Resource(name = "/fm/fmo/orderRequestConfirmModifyDAO")
	private OrderRequestConfirmModifyDAO orderRequestConfirmModifyDAO;
	
	/** OrderRequestDAO Bean 생성 */
	@Resource(name = "/fm/fmo/orderRequestDAO")
	private OrderRequestDAO orderRequestDAO;
	
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
		// CENTER_CODE 다중 처리 : 2016-01-11
		mapParam.put("schCode", inCode(mapParam.get("schCode").toString()));
		return orderDecisionModifyDAO.selectList(mapParam);
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
		return orderDecisionModifyDAO.selectSub(mapParam);
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
	public RecordSet selectSubAll(Map<String, Object> mapParam, DataSetMap parameter) throws Exception {
		
		String prNumList = "";

		for (int i = 0 ; i < parameter.size() ; i++) {
			Map<String, Object> rowData = parameter.get(i);
			prNumList += ",'" + rowData.get("prNum").toString() + "'";
		}
		if (prNumList.equals(""))
			prNumList = "(NULL)";
		else
			prNumList = "(" + prNumList.substring(1) + ")";
			
		mapParam.put("prNumList", prNumList);
		
		return orderDecisionModifyDAO.selectSubAll(mapParam);
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
		return orderDecisionModifyDAO.selectSubFlag(mapParam);
	}

	
	/**
	 * 주문결의 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveResol(DataSetMap list) throws Exception {
		DataSetMap saveList = new DataSetMap();
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		/* 결의번호 생성 규칙 : 업장,업체 기준으로 결의번호 생성.*/
		String rcUpjang = "";
		String cust = "";
		String rcNum = "";
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			if(rowData.get("chk").toString().equals("1")){
				RecordSet groupList = orderDecisionModifyDAO.selectPrGroup(rowData);
				for(int row = 0; row < groupList.size(); row++){
					String poNum = orderDecisionModifyDAO.poNumseq(rowData);
					Map<String, Object> groupData = groupList.get(row);
					rowData.put("poNum", poNum);
					rowData.put("prNum", groupData.get("prNum"));
					rowData.put("rcUpjang", groupData.get("rcUpjang"));
					rowData.put("custcd", groupData.get("custcd"));
					rowData.put("needDate", groupData.get("needDate"));
					updRowCnt += orderDecisionModifyDAO.saveResol(rowData);
				}
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
		Map<String, Object> retProcItemVal = new HashMap<String, Object>();
		Map<String, Object> chngLs         = new HashMap<String, Object>();
		Map<String, Object> inParam        = null;
		RecordSet odrInfo                  = null;
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
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
				RecordSet rs = orderDecisionModifyDAO.saveItemChk(rowData);

				if(!"HK".equals(rs.get(0).get("poStatus"))){
					retProcItemVal.put("O_RTN_CD", "-1");
					retProcItemVal.put("O_RTN_MSG", "자재별 유효성체크 결과 에러가 발생하였습니다.\n자재명 : "+rs.get(0).get("itemName")+"\n"+ rs.get(0).get("poMsg"));
					throw new BizException(retProcItemVal.get("O_RTN_MSG").toString());
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
				if(chkStatus(orderRequestConfirmModifyDAO.lineStatusSelect(rowData))){
					retProcItemVal.put("O_RTN_CD", "-1");
					retProcItemVal.put("O_RTN_MSG", "배송중,입고완료,정산완료,발주취소 상태 일경우\n발주반려 할 수 없습니다.");
					throw new BizException(retProcItemVal.get("O_RTN_MSG").toString());
				} 
				updRowCnt += orderDecisionModifyDAO.update(rowData);
				
			}
		}
		if(list.size() > 0){
			retProcItemVal = ifupdate(list.get(0));
			if(!"S000".equals(retProcItemVal.get("O_RTN_CD"))){
				if(retProcItemVal.get("O_RTN_MSG") == null)retProcItemVal.put("O_RTN_MSG","오류가 발생하였습니다.\n시스템 관리자에게 문의하세요.");
				throw new BizException(retProcItemVal.get("O_RTN_MSG").toString());
			}
			
    		// 구매 프로시저 처리가 성공일 경우
    		if ( ValidationUtil.isEquals(retProcItemVal.get("O_RTN_CD").toString(), Const.PURC_PROC_SUCC) ) {
    			String p_upjang_cd      = "";  // (필수)업장코드
    			String p_apply_date     = "";  // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
    			double p_occur_amt        = 0;   // (필수)발생금액
    			double p_occur_amt_before = 0;   // (필수)발생금액(전)
    			String p_key_nm         = "";  // (필수)키명
    			double sellAmt          = 0;
    			String taxCode          = "";

    			for ( int i = 0; i < list.size(); i++ ) {
    				Map<String, Object> rowData = list.get(i);
    				int rowType                 = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
    				
    				if ( i == 0 ) {
    					p_upjang_cd  = rowData.get("rcUpjang").toString();  // (필수)업장코드
    					p_apply_date = rowData.get("needDate").toString();  // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
    					p_key_nm     = rowData.get("prNum").toString();     // (필수)키명
    				}
    				
    				if ( rowType == DataSet.ROW_TYPE_UPDATED ) {
    					taxCode      = rowData.get("taxCode").toString();
    	    			
    	    			//////////////////////////////////////////////////////////////////////////////////////////////////////////
    	    			// 발생금액(전) 셋팅
    					p_occur_amt_before += Math.round(Long.parseLong(chngLs.get(rowData.get("prId").toString()).toString()));
    					
    					//////////////////////////////////////////////////////////////////////////////////////////////////////////
    					// 발생금액 셋팅
    					sellAmt = Double.parseDouble(rowData.get("salePrice").toString()) * Double.parseDouble(rowData.get("poQty").toString());  // 소수점 반올림
    					// 과세일 경우
    					if ( ValidationUtil.isEquals(taxCode, Const.TXN_CLSS_100) ) {
    						p_occur_amt += Math.round(sellAmt * 1.1);  // 소수점 반올림
    					} else {
    						p_occur_amt += Math.round(sellAmt);
    					}
    				}
    			}
    			
    			Map<String, Object> rtnProcedure   = null;
    			Map<String, Object> procedureParam = new HashMap<String, Object>();
    			procedureParam.put("p_upjang_cd",        p_upjang_cd);            // (필수)업장코드
    			procedureParam.put("p_apply_date",       p_apply_date);           // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
    			procedureParam.put("p_occur_class",      "01");                   // (필수)발생구분(01:매입예정 02:매입확정 03:외상매출금)
    			procedureParam.put("p_occur_amt",        p_occur_amt);            // (필수)발생금액
    			procedureParam.put("p_occur_amt_before", p_occur_amt_before);     // (필수)발생금액(전)
    			procedureParam.put("p_class_cd",         "01");                   // (필수)구분코드(01:주문신청관련 02:매출보정 03:판매단가변경 04:창고 강제변경 05:현지구매 06:영업회계 일마감 07:채권이관/입금처리)
    			procedureParam.put("p_occur_table",      "SO_PR");                // (필수)발생테이블
    			procedureParam.put("p_key_nm",           "PR_NUM");               // (필수)키명
    			procedureParam.put("p_key_value01",      p_key_nm);               // (필수)키1(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
    			procedureParam.put("p_key_value02",      "");                     // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
    			procedureParam.put("p_key_value03",      "");                     // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
    			procedureParam.put("p_key_value04",      "");                     // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
    			procedureParam.put("p_key_value05",      "");                     // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
    			procedureParam.put("p_occur_prg_id",     "OrderDecisionModify");  // 프로그램ID
    			procedureParam.put("p_occur_prg_nm",     "주문결의수정");         // 프로그램 한글명
    			procedureParam.put("p_cuser",            loginDTO.getSabun());    // 생성자
    			rtnProcedure = orderRequestDAO.procLncrTtz(procedureParam);
    			
    			if ( !ValidationUtil.isEquals(rtnProcedure.get("o_rtn").toString(), Const.YN_Y) ) {
    				throw new BusinessRuntimeException(rtnProcedure.get("o_rtnmsg").toString());
    			}
    		}
		}
		
		retProcItemVal.put("Cnt", insRowCnt+updRowCnt+delRowCnt);
		return retProcItemVal;
	}
// [속도개선 Project   끝] 2017. 8. 4. 최범주
	
	/**
	 * 주문결의수정 상단 주문목록 [반려] 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	@SuppressWarnings("unchecked")
	public Map<String, Object>  returnList(DataSetMap list, LoginDTO loginDTO) throws Exception {
		Map<String, Object> retProcItemVal = new HashMap<String, Object>();
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String status = "U";
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			if(rowData.get("chk").toString().equals("1")){

				//updRowCnt += orderDecisionModifyDAO.returnUpdate(rowData);
				//IF 할 데이터 조회
				rowData.put("schPrNum", rowData.get("prNum"));
				rowData.put("schSubStatus", "007");//결의건 대상
				RecordSet subList = orderDecisionModifyDAO.selectSub(rowData);
				
				for (int j = 0 ; j < subList.size() ; j++) {
					Map<String, Object> subRowData = subList.get(j);
					subRowData.put("remark" , rowData.get("remark"));
					if(chkStatus(orderRequestConfirmModifyDAO.lineStatusSelect(subRowData))){
						retProcItemVal.put("O_RTN_CD", "-1");
						retProcItemVal.put("O_RTN_MSG", "배송중,입고완료,정산완료,발주취소 상태 일경우\n발주반려 할 수 없습니다.");
						throw new BizException(retProcItemVal.get("O_RTN_MSG").toString());
					}
					
					updRowCnt += orderDecisionModifyDAO.returnUpdate(subRowData);//005 상태값 업데이트.
					
					int poPocnt = orderRequestConfirmModifyDAO.poPoCnt(subRowData);//HLDC_PO_PO에 데이터 존재하는지 체크.
					
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
					pMap.put("i_shop_cd", 	  String.valueOf(subRowData.get("rcUpjang"))); //신청업장 코드 - > 입고업장으로 변경
					pMap.put("i_req_usr_id",  String.valueOf(subRowData.get("prSabun"))); //신청자 아이디
					pMap.put("i_req_typ_cd",  String.valueOf(subRowData.get("poType"))); //통합영업 S/O 유형코드(07,29)
					pMap.put("i_req_no", 	  String.valueOf(subRowData.get("prNum"))); //Sales Order 요청 번호(PO_NUM)
					pMap.put("i_req_cls", 	  status); //요청 상태 [C-신규, U-수정, D-삭제]
					retProcItemVal = orderRequestConfirmModifyDAO.sp_if_sales_order(pMap);
					
					rowData.put("rtnMsg", retProcItemVal.get("O_RTN_MSG").toString());
		            rowData.put("rtnCd", retProcItemVal.get("O_RTN_CD").toString());
					
		            orderRequestDAO.prNumUpdateIF(rowData);//구매 IF 결과 저장
					
					if("!S000".equals(retProcItemVal.get("O_RTN_CD").toString())){
						if(retProcItemVal.get("O_RTN_MSG") == null)retProcItemVal.put("O_RTN_MSG","오류가 발생하였습니다.\n시스템 관리자에게 문의하세요.");
						throw new BizException(retProcItemVal.get("O_RTN_MSG").toString());
					}
					
		    		// 구매 프로시저 처리가 성공일 경우
		    		if ( ValidationUtil.isEquals(retProcItemVal.get("O_RTN_CD").toString(), Const.PURC_PROC_SUCC) ) {
		    			String p_upjang_cd      = subRowData.get("rcUpjang").toString();  // (필수)업장코드
		    			String p_apply_date     = subRowData.get("needDate").toString();  // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
		    			double p_occur_amt        = 0;                                      // (필수)발생금액
		    			double p_occur_amt_before = 0;                                      // (필수)발생금액(전)
		    			String p_key_nm         = subRowData.get("prNum").toString();     // (필수)키명
		    			double sellAmt          = 0;
		    			
		    			//////////////////////////////////////////////////////////////////////////////////////////////////////////
		    			// 발생금액(전) 셋팅
						sellAmt = Double.parseDouble(subRowData.get("salePrice").toString()) * Double.parseDouble(subRowData.get("poQty").toString());  // 소수점 반올림
						// 과세일 경우
						if ( ValidationUtil.isEquals(subRowData.get("taxCode").toString(), Const.TXN_CLSS_100) ) {
							p_occur_amt_before = Math.round(sellAmt * 1.1);  // 소수점 반올림
						} else {
							p_occur_amt_before = Math.round(sellAmt);
						}

		    			Map<String, Object> rtnProcedure   = null;
		    			Map<String, Object> procedureParam = new HashMap<String, Object>();
		    			procedureParam.put("p_upjang_cd",        p_upjang_cd);            // (필수)업장코드
		    			procedureParam.put("p_apply_date",       p_apply_date);           // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
		    			procedureParam.put("p_occur_class",      "01");                   // (필수)발생구분(01:매입예정 02:매입확정 03:외상매출금)
		    			procedureParam.put("p_occur_amt",        p_occur_amt);            // (필수)발생금액
		    			procedureParam.put("p_occur_amt_before", p_occur_amt_before);     // (필수)발생금액(전)
		    			procedureParam.put("p_class_cd",         "01");                   // (필수)구분코드(01:주문신청관련 02:매출보정 03:판매단가변경 04:창고 강제변경 05:현지구매 06:영업회계 일마감 07:채권이관/입금처리)
		    			procedureParam.put("p_occur_table",      "SO_PR");                // (필수)발생테이블
		    			procedureParam.put("p_key_nm",           "PR_NUM");               // (필수)키명
		    			procedureParam.put("p_key_value01",      p_key_nm);               // (필수)키1(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
		    			procedureParam.put("p_key_value02",      "");                     // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
		    			procedureParam.put("p_key_value03",      "");                     // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
		    			procedureParam.put("p_key_value04",      "");                     // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
		    			procedureParam.put("p_key_value05",      "");                     // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
		    			procedureParam.put("p_occur_prg_id",     "OrderDecisionModify");  // 프로그램ID
		    			procedureParam.put("p_occur_prg_nm",     "주문결의수정");         // 프로그램 한글명
		    			procedureParam.put("p_cuser",            loginDTO.getSabun());    // 생성자
		    			rtnProcedure = orderRequestDAO.procLncrTtz(procedureParam);
		    			
		    			if ( !ValidationUtil.isEquals(rtnProcedure.get("o_rtn").toString(), Const.YN_Y) ) {
		    				throw new BusinessRuntimeException(rtnProcedure.get("o_rtnmsg").toString());
		    			}
		    		}
				}
			}
		}
		
		for (int i = 0 ; i < list.size() ; i++) {//IF 성공한 데이터에 대해서 PO_FALG에 Y값 업데이트.
			Map<String, Object> rowData = list.get(i);
			if(rowData.get("chk").toString().equals("1")){
				updRowCnt += orderDecisionModifyDAO.returnFalgUpdate(rowData);
			}
		}
		
    	retProcItemVal.put("O_RTN_CD", "S000");
    	retProcItemVal.put("O_RTN_MSG", "");
		return retProcItemVal;
	}
// [속도개선 Project   끝] 2017. 8. 4. 최범주
	
	/**
	 * 주문결의수정 하단 상세 그리드 [반려] 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	@SuppressWarnings("unchecked")
	public Map<String, Object>  returnSub(DataSetMap list, LoginDTO loginDTO) throws Exception {
		Map<String, Object> retProcItemVal = new HashMap<String, Object>();
		Map<String, Object> chngLs         = new HashMap<String, Object>();
		Map<String, Object> inParam        = null;
		RecordSet odrInfo                  = null;
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String status = "U";
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// 판매금액 셋팅
		for ( int i = 0; i < list.size(); i++ ) {
			Map<String, Object> rowData = list.get(i);
			
			if ( rowData.get("chk").toString().equals("1") ) {//체크된 데이터
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
			if(rowData.get("chk").toString().equals("1")){//체크된 데이터
				updRowCnt += orderDecisionModifyDAO.returnUpdate(rowData);
				if(chkStatus(orderRequestConfirmModifyDAO.lineStatusSelect(rowData))){
					retProcItemVal.put("O_RTN_CD", "-1");
					retProcItemVal.put("O_RTN_MSG", "배송중,입고완료,정산완료,발주취소 상태 일경우\n발주반려 할 수 없습니다.");
					throw new BizException(retProcItemVal.get("O_RTN_MSG").toString());
				}
				
				int poPocnt = orderRequestConfirmModifyDAO.poPoCnt(rowData);
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
				retProcItemVal  = orderRequestConfirmModifyDAO.sp_if_sales_order(pMap);

				rowData.put("rtnMsg", retProcItemVal.get("O_RTN_MSG").toString());
	            rowData.put("rtnCd", retProcItemVal.get("O_RTN_CD").toString());
				
	            orderRequestDAO.prNumUpdateIF(rowData);//구매 IF 결과 저장
				if(!"S000".equals(retProcItemVal.get("O_RTN_CD").toString())){
					if(retProcItemVal.get("O_RTN_MSG") == null)retProcItemVal.put("O_RTN_MSG","오류가 발생하였습니다.\n시스템 관리자에게 문의하세요.");
					throw new BizException(retProcItemVal.get("O_RTN_MSG").toString());
		        }
				
				// 구매 프로시저 처리가 성공일 경우
	    		if ( ValidationUtil.isEquals(retProcItemVal.get("O_RTN_CD").toString(), Const.PURC_PROC_SUCC) ) {
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
	    			procedureParam.put("p_upjang_cd",        p_upjang_cd);            // (필수)업장코드
	    			procedureParam.put("p_apply_date",       p_apply_date);           // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
	    			procedureParam.put("p_occur_class",      "01");                   // (필수)발생구분(01:매입예정 02:매입확정 03:외상매출금)
	    			procedureParam.put("p_occur_amt",        p_occur_amt);            // (필수)발생금액
	    			procedureParam.put("p_occur_amt_before", p_occur_amt_before);     // (필수)발생금액(전)
	    			procedureParam.put("p_class_cd",         "01");                   // (필수)구분코드(01:주문신청관련 02:매출보정 03:판매단가변경 04:창고 강제변경 05:현지구매 06:영업회계 일마감 07:채권이관/입금처리)
	    			procedureParam.put("p_occur_table",      "SO_PR");                // (필수)발생테이블
	    			procedureParam.put("p_key_nm",           "PR_NUM");               // (필수)키명
	    			procedureParam.put("p_key_value01",      p_key_nm);               // (필수)키1(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
	    			procedureParam.put("p_key_value02",      "");                     // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
	    			procedureParam.put("p_key_value03",      "");                     // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
	    			procedureParam.put("p_key_value04",      "");                     // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
	    			procedureParam.put("p_key_value05",      "");                     // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
	    			procedureParam.put("p_occur_prg_id",     "OrderDecisionModify");  // 프로그램ID
	    			procedureParam.put("p_occur_prg_nm",     "주문결의수정");         // 프로그램 한글명
	    			procedureParam.put("p_cuser",            loginDTO.getSabun());    // 생성자
	    			rtnProcedure = orderRequestDAO.procLncrTtz(procedureParam);
	    			
	    			if ( !ValidationUtil.isEquals(rtnProcedure.get("o_rtn").toString(), Const.YN_Y) ) {
	    				throw new BusinessRuntimeException(rtnProcedure.get("o_rtnmsg").toString());
	    			}
	    		}
			}
		}
			
		return retProcItemVal;
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
			updRowCnt += orderDecisionModifyDAO.needupdate(rowData);
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 주문결의수정 PO_QTY를 수정전으로 다시 업데이트한다.(OLD_PO_QTY = > PO_QTY)  
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	public int backupdate(DataSetMap list) throws Exception{
		int updRowCnt = 0;
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			//Update 처리
			if (rowType == DataSet.ROW_TYPE_UPDATED) {
				rowData.put("poQty", rowData.get("oldPoQty"));
				updRowCnt += orderRequestConfirmModifyDAO.update(rowData);
			}
		}
		return updRowCnt;
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
	 * 구매 IF 업데이트 입고일자변경, 수량변경 등에 쓰인다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	public Map<String, Object> ifupdate(Map<String, Object> rowData) throws Exception {
		Map<String, Object> retProcItemVal = new HashMap<String, Object>();
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
		pMap.put("i_req_cls", 	  String.valueOf("U")); //요청 상태 [C-신규, U-수정, D-삭제]

        retProcItemVal  = orderDecisionModifyDAO.sp_if_sales_order(pMap);
		retProcItemVal.put("IF_DATA", pMap.toString());
		logger.debug("IF_SALES_ORDER : " + pMap.toString());
		return retProcItemVal;
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


}
