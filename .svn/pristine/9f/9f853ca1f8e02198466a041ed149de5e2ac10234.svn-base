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
import com.hwfs.fm.fmo.dao.OrderRequestChangeDAO;
import com.hwfs.fm.fmo.dao.OrderRequestConfirmModifyDAO;
import com.hwfs.fm.fmo.dao.OrderRequestDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.util.Const;
import com.hwfs.sc.cmn.util.NumberUtil;
import com.hwfs.sc.cmn.util.StringUtil;
import com.hwfs.sc.cmn.util.ValidationUtil;
import com.sz.business.BusinessRuntimeException;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 주문확정수정하는 OrderRequestConfirmModify Service Implementation
 * 
 * @ClassName OrderRequestConfirmModifyServiceImpl.java
 * @Description OrderRequestConfirmModifyServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.07    손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.07.07
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fmo/orderRequestConfirmModifyService")
public class OrderRequestConfirmModifyServiceImpl extends DefaultServiceImpl implements OrderRequestConfirmModifyService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** OrderRequestConfirmModifyDAO Bean 생성 */
	@Resource(name = "/fm/fmo/orderRequestConfirmModifyDAO")
	private OrderRequestConfirmModifyDAO orderRequestConfirmModifyDAO;
	
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	/** OrderRequestChangeDAO Bean 생성 */
	@Resource(name = "/fm/fmo/orderRequestChangeDAO")
	private OrderRequestChangeDAO orderRequestChangeDAO;
	
	/** orderDecisionModifyDAO Bean 생성 */
	@Resource(name = "/fm/fmo/orderDecisionModifyDAO")
	private OrderDecisionModifyDAO orderDecisionModifyDAO;
// [속도개선 Project   끝] 2017. 8. 4. 최범주

	/** OrderRequestDAO Bean 생성 */
	@Resource(name = "/fm/fmo/orderRequestDAO")
	private OrderRequestDAO orderRequestDAO;
	/**
	 * 주문확정수정 목록을 조회한다.
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
		
		if ( "Y".equals(mapParam.get("schTestYn").toString()) ) {
			return orderRequestConfirmModifyDAO.selectListT(mapParam);
		} else {
			return orderRequestConfirmModifyDAO.selectList(mapParam);
		}
	}
	
	/**
	 * 주문확정수정 목록을 조회한다.
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
		if ( "Y".equals(mapParam.get("schTestYn").toString()) ) {
			return orderRequestConfirmModifyDAO.selectSubT(mapParam);
		} else {
			return orderRequestConfirmModifyDAO.selectSub(mapParam);
		}
		
	}

	/**
	 * 주문확정수정 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public Map<String, Object> saveSub(DataSetMap list, LoginDTO loginDTO) throws Exception {
		Map<String, Object> retProcItemVal = new HashMap<String, Object>();
		Map<String, Object> rowData        = new HashMap<String, Object>();
		Map<String, Object> chngLs         = new HashMap<String, Object>();
		Map<String, Object> inParam        = null;
		RecordSet odrInfo                  = null;

		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String prIds = "";
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// 판매금액 수정전 금액 셋팅
		for ( int i = 0; i < list.size(); i++ ) {
			rowData = list.get(i);
			
			
			if ( ValidationUtil.isEquals(rowData.get("rowStatus").toString(), Const.PROC_CLSS_U) ) {
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
			rowData = list.get(i);
			//Update 처리
			if (rowData.get("rowStatus") != null && "U".equals(rowData.get("rowStatus").toString())) {
				String status = orderRequestConfirmModifyDAO.lineStatusSelect(rowData);
				if("DL".equals(status) || "GC".equals(status) || "IV".equals(status) || "PD".equals(status)){
					retProcItemVal.put("O_RTN_CD", "-1");
					retProcItemVal.put("O_RTN_MSG", "배송중,입고완료,정산완료,발주취소 상태 일경우\n수정할 수 없습니다.");
					throw new BizException(retProcItemVal.get("O_RTN_MSG").toString());
				}
				updRowCnt += orderRequestConfirmModifyDAO.update(rowData);
				prIds+=rowData.get("prId")+",";
			}
		}
		if(prIds.length() > 0){
			rowData.put("prIds", inCode(prIds.substring(0, prIds.length()-1)));
			RecordSet iFList = orderRequestConfirmModifyDAO.selectIFList(rowData);
			if(iFList.size() > 0){
				for (int i = 0 ; i < iFList.size() ; i++) {
					rowData = iFList.get(i);
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
					
		            retProcItemVal  = orderRequestConfirmModifyDAO.sp_if_sales_order(pMap);
		            if(!"S000".equals(retProcItemVal.get("O_RTN_CD").toString())){
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
		    			String itemCode         = "";
		    			String taxCode          = "";
		    			
		    			Map<String, Object> listData  = null;
		    			
		    			for (int j = 0; j < list.size(); j++ ) {
		    				listData = list.get(j);
		    				
		    				// 수정건이고 동일 주문신청번호, 사업장, 신청자, 구매유형에 대한 구매신청라인ID별로 여신금액 집계 프로시저 호출
		    				if (    ValidationUtil.isEquals( listData.get("rowStatus").toString(), Const.PROC_CLSS_U                  )
		    					 && ValidationUtil.isEquals( listData.get("prNum").toString(),     rowData.get("prNum").toString()    )
		    					 && ValidationUtil.isEquals( listData.get("rcUpjang").toString(),  rowData.get("rcUpjang").toString() )
		    					 && ValidationUtil.isEquals( listData.get("prSabun").toString(),   rowData.get("prSabun").toString()  )
		    					 && ValidationUtil.isEquals( listData.get("poType").toString(),    rowData.get("poType").toString()   )
		    				   ) {
		    					p_upjang_cd  = listData.get("rcUpjang").toString();
		    					p_apply_date = listData.get("needDate").toString();
		    					p_key_nm     = listData.get("prNum").toString();
		    					itemCode     = listData.get("itemCode").toString();
		    					
		    	    			//////////////////////////////////////////////////////////////////////////////////////////////////
		    	    			// 주문내역 자재의 과세구분 셋팅
		    	    			inParam = new HashMap<String, Object>();
		    	    			inParam.put("itemCode", itemCode);
		    	    			RecordSet mtrlsInfo = orderRequestChangeDAO.selectMtrlsTxnClss(inParam);
		    	    			if ( ValidationUtil.isEmpty(mtrlsInfo) ) {
		    	    				throw new BusinessRuntimeException("변경자재에대한 정보가 없습니다.");
		    	    			} else {
		    	    				taxCode = mtrlsInfo.get(0).getString("taxCode");
		    	    			}
		    	    			
		    	    			//////////////////////////////////////////////////////////////////////////////////////////////////
		    	    			// 발생금액(전) 셋팅
		    	    			p_occur_amt_before = Math.round(Double.parseDouble(chngLs.get(listData.get("prId").toString()).toString()));
		    					
		    					//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		    					// 발생금액 셋팅
		    					sellAmt = Double.parseDouble(listData.get("salePrice").toString()) * Double.parseDouble(listData.get("poQty").toString());  // 소수점 반올림
		    					// 과세일 경우
		    					if ( ValidationUtil.isEquals(taxCode, Const.TXN_CLSS_100) ) {
		    						p_occur_amt = Math.round(sellAmt * 1.1);  // 소수점 반올림
		    					} else {
		    						p_occur_amt = Math.round(sellAmt);
		    					}

		    	    			Map<String, Object> rtnProcedure   = null;
		    	    			Map<String, Object> procedureParam = new HashMap<String, Object>();
		    	    			procedureParam.put("p_upjang_cd",        p_upjang_cd);                  // (필수)업장코드
		    	    			procedureParam.put("p_apply_date",       p_apply_date);                 // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
		    	    			procedureParam.put("p_occur_class",      "01");                         // (필수)발생구분(01:매입예정 02:매입확정 03:외상매출금)
		    	    			procedureParam.put("p_occur_amt",        p_occur_amt);                  // (필수)발생금액
		    	    			procedureParam.put("p_occur_amt_before", p_occur_amt_before);           // (필수)발생금액(전)
		    	    			procedureParam.put("p_class_cd",         "01");                         // (필수)구분코드(01:주문신청관련 02:매출보정 03:판매단가변경 04:창고 강제변경 05:현지구매 06:영업회계 일마감 07:채권이관/입금처리)
		    	    			procedureParam.put("p_occur_table",      "SO_PR");                      // (필수)발생테이블
		    	    			procedureParam.put("p_key_nm",           "PR_NUM");                     // (필수)키명
		    	    			procedureParam.put("p_key_value01",      p_key_nm);                     // (필수)키1(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
		    	    			procedureParam.put("p_key_value02",      "");                           // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
		    	    			procedureParam.put("p_key_value03",      "");                           // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
		    	    			procedureParam.put("p_key_value04",      "");                           // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
		    	    			procedureParam.put("p_key_value05",      "");                           // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
		    	    			procedureParam.put("p_occur_prg_id",     "OrderRequestConfirmModify");  // 프로그램ID
		    	    			procedureParam.put("p_occur_prg_nm",     "주문확정수정");               // 프로그램 한글명
		    	    			procedureParam.put("p_cuser",            loginDTO.getSabun());          // 생성자
		    	    			rtnProcedure = orderRequestDAO.procLncrTtz(procedureParam);
		    	    			
		    	    			if ( !ValidationUtil.isEquals(rtnProcedure.get("o_rtn").toString(), Const.YN_Y) ) {
		    	    				throw new BusinessRuntimeException(rtnProcedure.get("o_rtnmsg").toString());
		    	    			}
		    				}
		    			}
		    		}
				}
			}
		}
		retProcItemVal.put("O_RTN_CD", "S000");
		retProcItemVal.put("Cnt", insRowCnt+updRowCnt+delRowCnt);
		return retProcItemVal;
	}
// [속도개선 Project   끝] 2017. 8. 4. 최범주
	
	/**
	 * 주문확정수정 PO_QTY를 수정전으로 다시 업데이트한다.(OLD_PO_QTY = > PO_QTY)  
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
	 * 주문확정수정 DataSetMap의 발주 반려 처리한다.
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
	public Map<String, Object> saveStatus(DataSetMap list, LoginDTO loginDTO) throws Exception {
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
			
			if ( ValidationUtil.isEquals(rowData.get("status").toString(), Const.PROC_CLSS_D) ) {
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
			if("D".equals(rowData.get("status").toString())){
				String linestatus = orderRequestConfirmModifyDAO.lineStatusSelect(rowData);
				if("DL".equals(linestatus) || "GC".equals(linestatus) || "IV".equals(linestatus)|| "PD".equals(linestatus)){
					retProcItemVal.put("O_RTN_CD", "-1");
					retProcItemVal.put("O_RTN_MSG", "배송중,입고완료,정산완료,배송취소 상태 일경우\n발주반려 할 수 없습니다.");
					throw new BizException(retProcItemVal.get("O_RTN_MSG").toString());
				}
				
				int poPocnt = orderRequestConfirmModifyDAO.poPoCnt(rowData);
				if(poPocnt > 1){
					status = "U";
				}else if(poPocnt == 1){
					/*마지막 행을 삭제 할경우 프로시저 D 호출.*/
					status = "D";
				}
				rowData.put("soStatus", "005");
				rowData.put("lineStatus", "005");
				updRowCnt += orderRequestConfirmModifyDAO.updateStatus(rowData);
					
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

				if(!"S000".equals(retProcItemVal.get("O_RTN_CD").toString())){
					if(retProcItemVal.get("O_RTN_MSG") == null)retProcItemVal.put("O_RTN_MSG","오류가 발생하였습니다.\n시스템 관리자에게 문의하세요.");
					throw new BizException(retProcItemVal.get("O_RTN_MSG").toString());
				}
				rowData.put("rtnMsg", nvls(retProcItemVal.get("O_RTN_MSG")));
		        rowData.put("rtnCd", nvls(retProcItemVal.get("O_RTN_CD")));
				
		        orderRequestDAO.prNumUpdateIF(rowData);//구매 IF 결과 저장
		        
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
	    			procedureParam.put("p_upjang_cd",        p_upjang_cd);                  // (필수)업장코드
	    			procedureParam.put("p_apply_date",       p_apply_date);                 // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
	    			procedureParam.put("p_occur_class",      "01");                         // (필수)발생구분(01:매입예정 02:매입확정 03:외상매출금)
	    			procedureParam.put("p_occur_amt",        p_occur_amt);                  // (필수)발생금액
	    			procedureParam.put("p_occur_amt_before", p_occur_amt_before);           // (필수)발생금액(전)
	    			procedureParam.put("p_class_cd",         "01");                         // (필수)구분코드(01:주문신청관련 02:매출보정 03:판매단가변경 04:창고 강제변경 05:현지구매 06:영업회계 일마감 07:채권이관/입금처리)
	    			procedureParam.put("p_occur_table",      "SO_PR");                      // (필수)발생테이블
	    			procedureParam.put("p_key_nm",           "PR_NUM");                     // (필수)키명
	    			procedureParam.put("p_key_value01",      p_key_nm);                     // (필수)키1(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
	    			procedureParam.put("p_key_value02",      "");                           // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
	    			procedureParam.put("p_key_value03",      "");                           // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
	    			procedureParam.put("p_key_value04",      "");                           // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
	    			procedureParam.put("p_key_value05",      "");                           // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
	    			procedureParam.put("p_occur_prg_id",     "OrderRequestConfirmModify");  // 프로그램ID
	    			procedureParam.put("p_occur_prg_nm",     "주문확정수정");               // 프로그램 한글명
	    			procedureParam.put("p_cuser",            loginDTO.getSabun());          // 생성자
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
	 * 발주 수정 전 구매 수발주 체크.
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
	public Map<String, Object> subitemchk(DataSetMap list) throws Exception {
		Map<String, Object> retProcItemVal = new HashMap<String, Object>();
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String prIds = "";
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			//Update 처리
			if (rowType == DataSet.ROW_TYPE_UPDATED) {
				RecordSet rs = orderRequestConfirmModifyDAO.subItemChk(rowData);
				/*
				if(!"HK".equals(rs.get(0).get("poStatus"))){
					retProcItemVal.put("O_RTN_CD", "-1");
					retProcItemVal.put("O_RTN_MSG", "구매 수발주 제한이 있습니다.\n자재명 : "+rs.get(0).get("itemName")+"\n"+ rs.get(0).get("poMsg"));
					throw new BizException(retProcItemVal.get("O_RTN_MSG").toString());
				}
				*/
			}
		}
		retProcItemVal.put("O_RTN_CD", "S000");
		retProcItemVal.put("O_RTN_MSG", "");
		retProcItemVal.put("updRowCnt", 0);
		return retProcItemVal;
	}
	
	/**
	 * 주문확정 확정전 [통제여부]를 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectSubFlag(Map<String, Object> mapParam) throws Exception {
		return orderRequestConfirmModifyDAO.selectSubFlag(mapParam);
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
	
	public String nvls(Object col) throws Exception{
		if(col == null)
			return "";
		else
			return StringUtil.null2string(col.toString(), "");
	}
}
