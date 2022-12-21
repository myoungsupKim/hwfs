package com.hwfs.fm.fmf.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.sz.business.BusinessRuntimeException;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.fm.fmf.dao.SaleModifyWorkDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.cmn.util.Const;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 매출을 보정하는 SaleModifyWork Service Implementation
 * 
 * @ClassName SaleModifyWorkServiceImpl.java
 * @Description SaleModifyWorkServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.20    최성연        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.05.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fmf/saleModifyWorkService")
public class SaleModifyWorkServiceImpl extends DefaultServiceImpl implements SaleModifyWorkService {
	
	/** SaleModifyWorkDAO Bean 생성 */
	@Resource(name = "/fm/fmf/saleModifyWorkDAO")
	private SaleModifyWorkDAO saleModifyWorkDAO;
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	/**
	 * 매출보정 매출내역 목록을 조회한다.
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
		return saleModifyWorkDAO.selectList(mapParam);
	}

	/**
	 * 매출보정 보정내역 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList2(Map<String, Object> mapParam) throws Exception {
		return saleModifyWorkDAO.selectList2(mapParam);
	}
	

	/**
	 * 최종 매출마감일자 정보를 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectDate(Map<String, Object> mapParam) throws Exception {
		return saleModifyWorkDAO.selectDate(mapParam);
	}
	
	/**
	 * 매출보정 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		int delCnt = 0;
		int applyAmt = 0;

// [속도개선 Project 시작] 2017. 6. 30. 최범주 매출보정이력 기능 추가
		RecordSet sale_corr_info_rs                 = null;                           // 매출보정정보
		Map<String, Object> sale_corr_info_map      = new HashMap<String, Object>();  // 매출보정정보
		Map<String, Object> sale_corr_info_temp     = new HashMap<String, Object>();  // 매출보정정보(형변환용)
		RecordSet sale_corr_info_hst_rs             = null;                           // 매출보정정보이력
		Map<String, Object> sale_corr_info_hst_map  = new HashMap<String, Object>();  // 매출보정정보이력
// [속도개선 Project   끝] 2017. 6. 30. 최범주		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);

			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			//사업장 일마감 체크
			logger.debug("rowData : " + rowData);
			rowData.put("schUpjang", rowData.get("upjang"));
			rowData.put("schSdate", rowData.get("transDate"));
			RecordSet rss = saleModifyWorkDAO.searchmagam(rowData);
			logger.debug("rs.size() : " + rss.size());
			logger.debug("rs.get(0).get('cnt') : " + Integer.parseInt(rss.get(0).get("cnt").toString()));
			if(rss.size() == 1 && Integer.parseInt(rss.get(0).get("cnt").toString()) > 0){
				throw new BizException("해당 사업장은 일마감 되어 처리가 불가능 합니다.");
			}
			
			
			if ( Double.parseDouble(rowData.get("saleAmount").toString()) > 0 ) {
				RecordSet rsCrdit = saleModifyWorkDAO.checkCredit(rowData);
				Double saleAmt = 0.0d;
				if ( "709999999997".equals(rowData.get("itemCode").toString()) ) {	// 과세
					saleAmt = Double.parseDouble(rowData.get("saleAmount").toString()) * 1.1;
				} else {
					saleAmt = Double.parseDouble(rowData.get("saleAmount").toString());
				}
				
				if ( rsCrdit.get(0).getDouble("creditAmt") - saleAmt < 0 ) {
					throw new BizException("가용여신 한도보다 보정 금액이 더 큽니다.\r\n[가용여신금액:" + LimsUtil.getCommaNumber(rsCrdit.get(0).getDouble("creditAmt"), "###,###,##0") +"]");
				}
			}
			
			
			//Insert 처리 : 2개행 생성
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				// KEY 생성(TR_NUM)
				RecordSet rs = saleModifyWorkDAO.selectTrNum(rowData);
				
				//TR_NUM을 SET한다.
				String trNum = "";
				if (rs.size() > 0) {
					Map map = rs.get(0);
					if (map.get("trNum") != null)
						trNum =  map.get("trNum").toString(); //필드명이 "trNum"인 경우임
				}
				rowData.put("trNum", trNum);
				// 입고 생성
				rowData.put("schGubun", "1");
				if("S".equals(rowData.get("dataGubun").toString())){//S: -매출등록  , B:보정등록
					insRowCnt += saleModifyWorkDAO.saleInsert(rowData);
				}else{
					insRowCnt += saleModifyWorkDAO.insert(rowData);
				}
// [속도개선 Project 시작] 2017. 6. 30. 최범주 매출보정이력 기능 추가
				//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				// 보정등록(입고)일 경우
				sale_corr_info_map.clear();
				sale_corr_info_map.put("trNum", trNum);
				sale_corr_info_map.put("transType", "I001");
				sale_corr_info_rs = saleModifyWorkDAO.inqrSaleCorrInfo(sale_corr_info_map);
				
				if ( sale_corr_info_rs.getRowCount() > 0 ) {
					sale_corr_info_temp.clear();
					sale_corr_info_map.clear();
					sale_corr_info_temp = sale_corr_info_rs.get(0);
					sale_corr_info_map.putAll(sale_corr_info_temp);  // Type 변환(Record --> Map)
					sale_corr_info_map.put("gubun", Const.PROC_CLSS_I);
					sale_corr_info_map.put("createBy", rowData.get("loginSabun"));
					sale_corr_info_map.put("updateBy", rowData.get("loginSabun"));
					
					insRowCnt += saleModifyWorkDAO.regSaleCorrInfoHst(sale_corr_info_map);
				}
// [속도개선 Project   끝] 2017. 6. 30. 최범주				
				// 출고 생성
				rowData.put("schGubun", "2");
				if("S".equals(rowData.get("dataGubun").toString())){//S: -매출등록  , B:보정등록
					insRowCnt += saleModifyWorkDAO.saleInsert(rowData);
				}else{
					insRowCnt += saleModifyWorkDAO.insert(rowData);
				}
// [속도개선 Project 시작] 2017. 6. 30. 최범주 매출보정이력 기능 추가
				//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				// 보정등록(출고)일 경우
				sale_corr_info_map.clear();
				sale_corr_info_map.put("trNum", trNum);
				sale_corr_info_map.put("transType", "O001");
				sale_corr_info_rs = saleModifyWorkDAO.inqrSaleCorrInfo(sale_corr_info_map);
				
				if ( sale_corr_info_rs.getRowCount() > 0 ) {
					sale_corr_info_temp.clear();
					sale_corr_info_map.clear();
					sale_corr_info_temp = sale_corr_info_rs.get(0);
					sale_corr_info_map.putAll(sale_corr_info_temp);  // Type 변환(Record --> Map)
					sale_corr_info_map.put("gubun", Const.PROC_CLSS_I);
					sale_corr_info_map.put("createBy", rowData.get("loginSabun"));
					sale_corr_info_map.put("updateBy", rowData.get("loginSabun"));
					
					insRowCnt += saleModifyWorkDAO.regSaleCorrInfoHst(sale_corr_info_map);
				}
// [속도개선 Project   끝] 2017. 6. 30. 최범주		
				//System.out.println(rowData);
				//여신 집계 프로시저 호출 추가 2017.08.10 김호석 시작
				applyAmt = 0;
				if (rowData.get("saleAmount") != null) {
					applyAmt = applyAmt + Integer.parseInt(rowData.get("saleAmount").toString());
				}				
				if (rowData.get("saleVat") != null) {
					applyAmt = applyAmt + Integer.parseInt(rowData.get("saleVat").toString());
				}
							
				// 구매 프로시저 처리가 성공일 경우

				if ( insRowCnt > 0 ) {
					Map<String, Object> rtnProcedure   = null;
					Map<String, Object> procedureParam = new HashMap<String, Object>();
					procedureParam.put("p_upjang_cd",        rowData.get("upjang").toString());          // (필수)업장코드
					procedureParam.put("p_apply_date",       rowData.get("transDate").toString());         // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
					procedureParam.put("p_occur_class",      "02");                 // (필수)발생구분(01:매입예정 02:매입확정 03:외상매출금)
					procedureParam.put("p_occur_amt",        applyAmt);          // (필수)발생금액
					procedureParam.put("p_occur_amt_before", 0);   // (필수)발생금액(전)
					procedureParam.put("p_class_cd",         "02");                 // (필수)구분코드(01:주문신청관련 02:매출보정 03:판매단가변경 04:창고 강제변경 05:현지구매 06:영업회계 일마감 07:채권이관/입금처리)
					procedureParam.put("p_occur_table",      "FMS_TRANSACTION");              // (필수)발생테이블
					procedureParam.put("p_key_nm",           "TR_NUM");       // (필수)키명
					procedureParam.put("p_key_value01",      rowData.get("trNum").toString());             // (필수)키1(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value02",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value03",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value04",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value05",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_occur_prg_id",     "SalesModifyWork");       // 프로그램ID
					procedureParam.put("p_occur_prg_nm",     "매출보정");           // 프로그램 한글명
					procedureParam.put("p_cuser",            rowData.get("loginSabun").toString());  // 생성자
					rtnProcedure = saleModifyWorkDAO.procCreditSum(procedureParam);
					
					if ( rtnProcedure.get("o_rtn").toString().equals("N")  ) {
						throw new BusinessRuntimeException(rtnProcedure.get("o_rtnmsg").toString());
					}				
				}
				
				//여신 집계 프로시저 호출 추가 2017.08.10 김호석 끝
				
			}
			//Update 처리 : 삭제 후 2개행 생성
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
// [속도개선 Project 시작] 2017. 6. 30. 최범주 매출보정이력 기능 추가
				//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				// 기등록된 매출보정 이력정보 갱신
				sale_corr_info_hst_map.clear();
				sale_corr_info_hst_map.put("trNum", rowData.get("trNum"));
				sale_corr_info_hst_rs = saleModifyWorkDAO.inqrSaleCorrInfo(sale_corr_info_hst_map);
				
				if ( sale_corr_info_hst_rs.getRowCount() > 0 ) {
					sale_corr_info_hst_map.clear();
					sale_corr_info_hst_map.put("gubun", Const.PROC_CLSS_U);
					sale_corr_info_hst_map.put("updateBy", rowData.get("loginSabun"));
					sale_corr_info_hst_map.put("trNum", rowData.get("trNum"));
					
					updRowCnt += saleModifyWorkDAO.chngSaleCorrInfoHst(sale_corr_info_hst_map);
				}
// [속도개선 Project   끝] 2017. 6. 30. 최범주
				
				// 기존자료 삭제
				delCnt = saleModifyWorkDAO.delete(rowData);
				
				//System.out.println("delCnt : " + delCnt);
				//System.out.println("rowData : " + rowData);
				//여신 집계 프로시저 호출 추가 2017.08.10 김호석 시작	
				applyAmt = 0;
				if (rowData.get("saleAmountOld") != null) {
					applyAmt = applyAmt + Integer.parseInt(rowData.get("saleAmountOld").toString());
				}				
				if (rowData.get("saleVatOld") != null) {
					applyAmt = applyAmt + Integer.parseInt(rowData.get("saleVatOld").toString());
				}		
				// 구매 프로시저 처리가 성공일 경우
				if ( delCnt > 0 ) {
					Map<String, Object> rtnProcedure   = null;
					Map<String, Object> procedureParam = new HashMap<String, Object>();
					procedureParam.put("p_upjang_cd",        rowData.get("upjang").toString());          // (필수)업장코드
					procedureParam.put("p_apply_date",       rowData.get("transDate").toString());         // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
					procedureParam.put("p_occur_class",      "02");                 // (필수)발생구분(01:매입예정 02:매입확정 03:외상매출금)
					procedureParam.put("p_occur_amt",        0);          // (필수)발생금액
					procedureParam.put("p_occur_amt_before", applyAmt);   // (필수)발생금액(전)
					procedureParam.put("p_class_cd",         "02");                 // (필수)구분코드(01:주문신청관련 02:매출보정 03:판매단가변경 04:창고 강제변경 05:현지구매 06:영업회계 일마감 07:채권이관/입금처리)
					procedureParam.put("p_occur_table",      "FMS_TRANSACTION");              // (필수)발생테이블
					procedureParam.put("p_key_nm",           "TR_NUM");       // (필수)키명
					procedureParam.put("p_key_value01",      rowData.get("trNum").toString());             // (필수)키1(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value02",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value03",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value04",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value05",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_occur_prg_id",     "SalesModifyWork");       // 프로그램ID
					procedureParam.put("p_occur_prg_nm",     "매출보정");           // 프로그램 한글명
					procedureParam.put("p_cuser",            rowData.get("loginSabun").toString());  // 생성자
					rtnProcedure = saleModifyWorkDAO.procCreditSum(procedureParam);
					
					if ( rtnProcedure.get("o_rtn").toString().equals("N")  ) {
						throw new BusinessRuntimeException(rtnProcedure.get("o_rtnmsg").toString());
					}				
				}
				//여신 집계 프로시저 호출 추가 2017.08.10 김호석 끝
				
				if (delCnt>0) {
					// KEY 생성(TR_NUM)
					RecordSet rs = saleModifyWorkDAO.selectTrNum(rowData);
					//TR_NUM을 SET한다.
					String trNum = "";
					if (rs.size() > 0) {
						Map map = rs.get(0);
						if (map.get("trNum") != null)
							trNum =  map.get("trNum").toString(); //필드명이 "trNum"인 경우임
					}
					rowData.put("trNum", trNum);
					// 입고 생성
					rowData.put("schGubun", "1");
					updRowCnt += saleModifyWorkDAO.insert(rowData);
// [속도개선 Project 시작] 2017. 6. 30. 최범주 매출보정이력 기능 추가
					//////////////////////////////////////////////////////////////////////////////////////////////////////////////
					// 보정등록(입고)변경일 경우
					sale_corr_info_map.clear();
					sale_corr_info_map.put("trNum", trNum);
					sale_corr_info_map.put("transType", "I001");
					sale_corr_info_rs = saleModifyWorkDAO.inqrSaleCorrInfo(sale_corr_info_map);
					
					if ( sale_corr_info_rs.getRowCount() > 0 ) {
						sale_corr_info_temp.clear();
						sale_corr_info_map.clear();
						sale_corr_info_temp = sale_corr_info_rs.get(0);
						sale_corr_info_map.putAll(sale_corr_info_temp);  // Type 변환(Record --> Map) 
						sale_corr_info_map.put("gubun", Const.PROC_CLSS_U);
						sale_corr_info_map.put("createBy", rowData.get("loginSabun"));
						sale_corr_info_map.put("updateBy", rowData.get("loginSabun"));
						
						updRowCnt += saleModifyWorkDAO.regSaleCorrInfoHst(sale_corr_info_map);
					}
// [속도개선 Project   끝] 2017. 6. 30. 최범주
					// 출고 생성
					rowData.put("schGubun", "2");
					updRowCnt += saleModifyWorkDAO.insert(rowData);
// [속도개선 Project 시작] 2017. 6. 30. 최범주 매출보정이력 기능 추가
					sale_corr_info_map.clear();
					sale_corr_info_map.put("trNum", trNum);
					sale_corr_info_map.put("transType", "O001");
					sale_corr_info_rs = saleModifyWorkDAO.inqrSaleCorrInfo(sale_corr_info_map);
					
					if ( sale_corr_info_rs.getRowCount() > 0 ) {
						sale_corr_info_temp.clear();
						sale_corr_info_map.clear();
						sale_corr_info_temp = sale_corr_info_rs.get(0);
						sale_corr_info_map.putAll(sale_corr_info_temp);  // Type 변환(Record --> Map)
						sale_corr_info_map.put("gubun", Const.PROC_CLSS_U);
						sale_corr_info_map.put("createBy", rowData.get("loginSabun"));
						sale_corr_info_map.put("updateBy", rowData.get("loginSabun"));
						
						updRowCnt += saleModifyWorkDAO.regSaleCorrInfoHst(sale_corr_info_map);
					}
// [속도개선 Project   끝] 2017. 6. 30. 최범주
				}
				
				//여신 집계 프로시저 호출 추가 2017.08.10 김호석 시작		
				applyAmt = 0;
				if (rowData.get("saleAmount") != null) {
					applyAmt = applyAmt + Integer.parseInt(rowData.get("saleAmount").toString());
				}				
				if (rowData.get("saleVat") != null) {
					applyAmt = applyAmt + Integer.parseInt(rowData.get("saleVat").toString());
				}			
				// 구매 프로시저 처리가 성공일 경우
				if ( updRowCnt > 0 ) {
					Map<String, Object> rtnProcedure   = null;
					Map<String, Object> procedureParam = new HashMap<String, Object>();
					procedureParam.put("p_upjang_cd",        rowData.get("upjang").toString());          // (필수)업장코드
					procedureParam.put("p_apply_date",       rowData.get("transDate").toString());         // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
					procedureParam.put("p_occur_class",      "02");                 // (필수)발생구분(01:매입예정 02:매입확정 03:외상매출금)
					procedureParam.put("p_occur_amt",        applyAmt);          // (필수)발생금액
					procedureParam.put("p_occur_amt_before", 0);   // (필수)발생금액(전)
					procedureParam.put("p_class_cd",         "02");                 // (필수)구분코드(01:주문신청관련 02:매출보정 03:판매단가변경 04:창고 강제변경 05:현지구매 06:영업회계 일마감 07:채권이관/입금처리)
					procedureParam.put("p_occur_table",      "FMS_TRANSACTION");              // (필수)발생테이블
					procedureParam.put("p_key_nm",           "TR_NUM");       // (필수)키명
					procedureParam.put("p_key_value01",      rowData.get("trNum").toString());             // (필수)키1(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value02",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value03",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value04",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value05",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_occur_prg_id",     "SalesModifyWork");       // 프로그램ID
					procedureParam.put("p_occur_prg_nm",     "매출보정");           // 프로그램 한글명
					procedureParam.put("p_cuser",            rowData.get("loginSabun").toString());  // 생성자
					rtnProcedure = saleModifyWorkDAO.procCreditSum(procedureParam);
					
					if ( rtnProcedure.get("o_rtn").toString().equals("N")  ) {
						throw new BusinessRuntimeException(rtnProcedure.get("o_rtnmsg").toString());
					}				
				}
				//여신 집계 프로시저 호출 추가 2017.08.10 김호석 끝
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
// [속도개선 Project 시작] 2017. 6. 30. 최범주 매출보정이력 기능 추가
				//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				// 기등록된 매출보정 이력정보 갱신
				sale_corr_info_hst_map.clear();
				sale_corr_info_hst_map.put("trNum", rowData.get("trNum"));
				sale_corr_info_hst_rs = saleModifyWorkDAO.inqrSaleCorrInfo(sale_corr_info_hst_map);
				
				if ( sale_corr_info_hst_rs.getRowCount() > 0 ) {
					sale_corr_info_hst_map.clear();
					sale_corr_info_hst_map.put("gubun", Const.PROC_CLSS_D);
					sale_corr_info_hst_map.put("updateBy", rowData.get("loginSabun"));
					sale_corr_info_hst_map.put("trNum", rowData.get("trNum"));
					
					delRowCnt += saleModifyWorkDAO.chngSaleCorrInfoHst(sale_corr_info_hst_map);
				}
// [속도개선 Project   끝] 2017. 6. 30. 최범주

				delRowCnt += saleModifyWorkDAO.delete(rowData);
				
				//여신 집계 프로시저 호출 추가 2017.08.10 김호석 시작
				applyAmt = 0;
				if (rowData.get("saleAmount") != null) {
					applyAmt = applyAmt + Integer.parseInt(rowData.get("saleAmount").toString());
				}				
				if (rowData.get("saleVat") != null) {
					applyAmt = applyAmt + Integer.parseInt(rowData.get("saleVat").toString());
				}			
				// 구매 프로시저 처리가 성공일 경우
				if ( delRowCnt > 0 ) {
					Map<String, Object> rtnProcedure   = null;
					Map<String, Object> procedureParam = new HashMap<String, Object>();
					procedureParam.put("p_upjang_cd",        rowData.get("upjang").toString());          // (필수)업장코드
					procedureParam.put("p_apply_date",       rowData.get("transDate").toString());         // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
					procedureParam.put("p_occur_class",      "02");                 // (필수)발생구분(01:매입예정 02:매입확정 03:외상매출금)
					procedureParam.put("p_occur_amt",        applyAmt);          // (필수)발생금액
					procedureParam.put("p_occur_amt_before", 0);   // (필수)발생금액(전)
					procedureParam.put("p_class_cd",         "02");                 // (필수)구분코드(01:주문신청관련 02:매출보정 03:판매단가변경 04:창고 강제변경 05:현지구매 06:영업회계 일마감 07:채권이관/입금처리)
					procedureParam.put("p_occur_table",      "FMS_TRANSACTION");              // (필수)발생테이블
					procedureParam.put("p_key_nm",           "TR_NUM");       // (필수)키명
					procedureParam.put("p_key_value01",      rowData.get("trNum").toString());             // (필수)키1(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value02",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value03",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value04",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_key_value05",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
					procedureParam.put("p_occur_prg_id",     "SalesModifyWork");       // 프로그램ID
					procedureParam.put("p_occur_prg_nm",     "매출보정");           // 프로그램 한글명
					procedureParam.put("p_cuser",            rowData.get("loginSabun").toString());  // 생성자
					rtnProcedure = saleModifyWorkDAO.procCreditSum(procedureParam);
					
					if ( rtnProcedure.get("o_rtn").toString().equals("N")  ) {
						throw new BusinessRuntimeException(rtnProcedure.get("o_rtnmsg").toString());
					}				
				}
				//여신 집계 프로시저 호출 추가 2017.08.10 김호석 끝
			}
			
			
		}		
				
		return insRowCnt + updRowCnt + delRowCnt;
	}


	/**
	 * 품의번호 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveArList(DataSetMap list) throws Exception {
		int updRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) 
		{
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			//사업장 일마감 체크
			/*
			logger.debug("rowData : " + rowData);
			rowData.put("schUpjang", rowData.get("upjang"));
			rowData.put("schSdate", rowData.get("transDate"));
			RecordSet rss = saleModifyWorkDAO.searchmagam(rowData);
			logger.debug("rs.size() : " + rss.size());
			logger.debug("rs.get(0).get('cnt') : " + Integer.parseInt(rss.get(0).get("cnt").toString()));
			
			if(rss.size() == 1 && Integer.parseInt(rss.get(0).get("cnt").toString()) > 0){
				throw new BizException("해당 사업장은 일마감 되어 처리가 불가능 합니다.");
			}
			*/
			if (rowType == DataSet.ROW_TYPE_UPDATED) 
			{
				System.out.println(rowType);
				updRowCnt += saleModifyWorkDAO.updateArNum(rowData);
			}

		}
		System.out.println("$$$$$$$$$$$$$$$$");
		System.out.println(updRowCnt);
				
		return updRowCnt;
	}	

	
	/**
	 * 매출보정 데이터를 Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int deleteRow(DataSetMap list) throws Exception {
		int delRowCnt = 0;
		int applyAmt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			logger.debug("rowData : " + rowData);
			rowData.put("schUpjang", rowData.get("upjang"));
			rowData.put("schSdate", rowData.get("transDate"));
			RecordSet rs = saleModifyWorkDAO.searchmagam(rowData);
			logger.debug("rs.size() : " + rs.size());
			logger.debug("rs.get(0).get('cnt') : " + Integer.parseInt(rs.get(0).get("cnt").toString()));
			if(rs.size() == 1 && Integer.parseInt(rs.get(0).get("cnt").toString()) > 0){
				throw new BizException("해당 사업장은 일마감 되어 처리가 불가능 합니다.");
			}
// [속도개선 Project 시작] 2017. 6. 30. 최범주 매출보정이력 기능 추가
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			Map<String, Object> sale_corr_info_hst_map = new HashMap<String, Object>();
			RecordSet sale_corr_info_hst_rs            = null;

			applyAmt = 0;
			
			// 기등록된 매출보정 이력정보 갱신
			if ( !"".equals(rowData.get("trNum").toString()) ) {
				sale_corr_info_hst_map.clear();
				sale_corr_info_hst_map.put("trNum", rowData.get("trNum"));
				sale_corr_info_hst_rs = saleModifyWorkDAO.inqrSaleCorrInfo(sale_corr_info_hst_map);
				
				if ( sale_corr_info_hst_rs.getRowCount() > 0 ) {
					sale_corr_info_hst_map.clear();
					sale_corr_info_hst_map.put("gubun", Const.PROC_CLSS_D);
					sale_corr_info_hst_map.put("updateBy", rowData.get("loginSabun"));
					sale_corr_info_hst_map.put("trNum", rowData.get("trNum"));
					
					delRowCnt += saleModifyWorkDAO.chngSaleCorrInfoHst(sale_corr_info_hst_map);
					
					//System.out.println("sale_amount : " + sale_corr_info_hst_rs.get(0).get("saleAmount"));
					//System.out.println("sale_vat : " + sale_corr_info_hst_rs.get(0).get("saleVat"));
					
					//금액가져오기 변경(0원으로 들어가는 문제 수정) 20181002 김호석
					if (sale_corr_info_hst_rs.get(0).get("saleAmount")  != null) {
						applyAmt = applyAmt + Integer.parseInt(sale_corr_info_hst_rs.get(0).get("saleAmount").toString());
					}				
					if (sale_corr_info_hst_rs.get(0).get("saleVat")  != null) {
						applyAmt = applyAmt + Integer.parseInt(sale_corr_info_hst_rs.get(0).get("saleVat").toString());
					}		
				}
			}
// [속도개선 Project   끝] 2017. 6. 30. 최범주
			// ROW TYPE 과 상관없이 Delete 처리.
			delRowCnt += saleModifyWorkDAO.delete(rowData);
			
			//여신 집계 프로시저 호출 추가 2017.08.10 김호석 시작
			//System.out.println(rowData);
			/*
			applyAmt = 0;
		
			if (rowData.get("saleAmount") != null) {
				applyAmt = applyAmt + Integer.parseInt(rowData.get("saleAmount").toString());
			}				
			if (rowData.get("saleVat") != null) {
				applyAmt = applyAmt + Integer.parseInt(rowData.get("saleVat").toString());
			}
			
			//취소시 금액을 0으로 넣는 경우가 있어 원래 값으로 넣기 20180509
			if (rowData.get("saleAmountOld") != null) {
				applyAmt = applyAmt + Integer.parseInt(rowData.get("saleAmountOld").toString());
			}				
			if (rowData.get("saleVatOld") != null) {
				applyAmt = applyAmt + Integer.parseInt(rowData.get("saleVatOld").toString());
			}	
			*/	
			// 삭제 처리가 성공일 경우
			if ( delRowCnt > 0 ) {
				Map<String, Object> rtnProcedure   = null;
				Map<String, Object> procedureParam = new HashMap<String, Object>();
				procedureParam.put("p_upjang_cd",        rowData.get("upjang").toString());          // (필수)업장코드
				procedureParam.put("p_apply_date",       rowData.get("transDate").toString());         // (필수)적용일자(발주시:입고예정일 입금처리시: 입금일자 마감시:매출일자)
				procedureParam.put("p_occur_class",      "02");                 // (필수)발생구분(01:매입예정 02:매입확정 03:외상매출금)
				procedureParam.put("p_occur_amt",        0);          // (필수)발생금액
				procedureParam.put("p_occur_amt_before", applyAmt);   // (필수)발생금액(전)
				procedureParam.put("p_class_cd",         "02");                 // (필수)구분코드(01:주문신청관련 02:매출보정 03:판매단가변경 04:창고 강제변경 05:현지구매 06:영업회계 일마감 07:채권이관/입금처리)
				procedureParam.put("p_occur_table",      "FMS_TRANSACTION");              // (필수)발생테이블
				procedureParam.put("p_key_nm",           "TR_NUM");       // (필수)키명
				procedureParam.put("p_key_value01",      rowData.get("trNum").toString());             // (필수)키1(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
				procedureParam.put("p_key_value02",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
				procedureParam.put("p_key_value03",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
				procedureParam.put("p_key_value04",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
				procedureParam.put("p_key_value05",      "");                   // (선택)키2(주문신청관련(PR_NUM), 매출보정(전자결재번호), 판매단가변경(계약 ID), 창고 강제변경(창고코드 from to, 업장코드 from to), 영업회계 일마감(업장코드, 일자), 채권이관(채권번호 from to), 입금처리(채권대체번호))
				procedureParam.put("p_occur_prg_id",     "SalesModifyWork");       // 프로그램ID
				procedureParam.put("p_occur_prg_nm",     "매출보정");           // 프로그램 한글명
				procedureParam.put("p_cuser",            rowData.get("loginSabun").toString());  // 생성자
				rtnProcedure = saleModifyWorkDAO.procCreditSum(procedureParam);
				
				if ( rtnProcedure.get("o_rtn").toString().equals("N")  ) {
					throw new BusinessRuntimeException(rtnProcedure.get("o_rtnmsg").toString());
				}
			}
			
			//여신 집계 프로시저 호출 추가 2017.08.10 김호석 끝		
			
		}
				
		return delRowCnt;
	}


	/**
	 * 보정내역 입력전 마감여부를 가져온다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet searchmagam(Map<String, Object> mapParam) throws Exception {
		return saleModifyWorkDAO.searchmagam(mapParam);
	}
	
	

}
