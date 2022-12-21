package com.hwfs.rc.rcg.service;

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
import com.hwfs.rc.rcg.dao.CouponSaleDAO;
import com.hwfs.rc.rcg.dao.CouponTerminationPopDAO;
import com.hwfs.sm.cmn.dao.AdvanceCommonDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 쿠폰소멸 처리 팝업하는 CouponTerminationPop Service Implementation
 * 
 * @ClassName CouponTerminationPopServiceImpl.java
 * @Description CouponTerminationPopServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.12    유성진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유성진
 * @since 2015.06.12
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rcg/couponTerminationPopService")
public class CouponTerminationPopServiceImpl extends DefaultServiceImpl implements CouponTerminationPopService {
	
	/** CouponTerminationPopDAO Bean 생성 */
	@Resource(name = "/rc/rcg/couponTerminationPopDAO")
	private CouponTerminationPopDAO couponTerminationPopDAO;
	
	/** CouponSaleDAO Bean 생성 */
	@Resource(name = "/rc/rcg/couponSaleDAO")
	private CouponSaleDAO couponSaleDAO;
	
	/** AdvanceCommonDAO Bean 생성 */
	@Resource(name = "/sm/cmn/advanceCommonDAO")
	private AdvanceCommonDAO advanceCommonDAO;
	

	/**
	 * 쿠폰소멸 처리 팝업 목록을 조회한다.
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
		return couponTerminationPopDAO.selectList(mapParam);
	}
	
	/**
	 * 쿠폰소멸 처리 팝업 목록(소멸)을 조회한다.
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
	public RecordSet selectTerminationList(Map<String, Object> mapParam) throws Exception {
		return couponTerminationPopDAO.selectTerminationList(mapParam);
	}
	
	/**
	 * 쿠폰소멸 처리 마스터 정보를 조회한다.
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
	public RecordSet selectCouponMst(Map<String, Object> mapParam) throws Exception {
		return couponTerminationPopDAO.selectCouponMst(mapParam);
	}

	/**
	 * 쿠폰소멸 처리 팝업 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap mstData, DataSetMap listTermination) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String maxCouponProcNum = "";
		
		//입금 처리 등록
		//Map<String, Object> rowMstData = mstData.get(0);
		
		if(mstData.get(0).get("couponProcNum").equals("")){
			//쿠폰 판매 번호 MAX값 조회
			maxCouponProcNum =  couponSaleDAO.selectMaxProcNum(mstData.get(0));
						
			//쿠폰 판매(이동) 마스터 처리
			Map<String, Object> rowAddData = mstData.get(0);
			rowAddData.put("maxCouponProcNum", maxCouponProcNum);
			rowAddData.put("couponProcOccurClass", "3");                            //쿠폰처리발생구분  3:소멸
			rowAddData.put("seq", "1");			                                    //지불테이블에 순번
			rowAddData.put("sysClass", "12");                                       //시스템구분 (식자재)
			rowAddData.put("occurDate", rowAddData.get("procDate"));                //발생일자
			rowAddData.put("vatCd", listTermination.getMapValue(0, "vatCd"));       //부가세구분  1:과세
			rowAddData.put("journalzYn", "N");                                      //분개여부
			rowAddData.put("couponProcNum", maxCouponProcNum);                      //쿠폰처리번호
			
			insRowCnt = couponSaleDAO.insertMst(rowAddData);
							
			//선수금 대체처리
			int altMstInsertCnt = 0;	//선수금대체마스터 등록 건수
			int altMstUpdateCnt = 0;	//선수금대체마스터 수정 건수
			int altDtlInsertCnt = 0;	//선수금대체디테일 등록 건수
			int altDtlUpdateCnt = 0;	//선수금대체디테일 수정 건수
			int advMstUpdateCnt = 0;	//선수금마스터 수정 건수
			
			String sMaxAtlNum		= "";	//신규 선수금 대체번호

			/************************************************************************************************
			 * 선수금 대체 마스터정보 등록/수정
			************************************************************************************************/
			//선수금 대체번호 채번(신규일 경우 채번)
			Map<String,Object> rowAdvanceMst = new HashMap<String,Object>();
			rowAdvanceMst.put("altTypeCd", rowAddData.get("altTypeCd"));                        // 선수금 대체 유형 코드
			rowAdvanceMst.put("advanceAltOccurClass", "TO09");            // 선수금 대체 발생 구분(쿠폰소멸)
			rowAdvanceMst.put("altDate", rowAddData.get("procDate"));     // 대체일자
			rowAdvanceMst.put("muCd", rowAddData.get("muCd"));            // 사업부
			rowAdvanceMst.put("ccCd", rowAddData.get("ccCd"));            // 원가부서
			rowAdvanceMst.put("acctCd", rowAddData.get("acctCd"));        // 계정코드
			rowAdvanceMst.put("remark", rowAddData.get("remark"));        // 비고
			rowAdvanceMst.put("altAmt", rowAddData.get("couponAmt"));     // 대체금액
			
			sMaxAtlNum = advanceCommonDAO.getMaxAtlNum(rowAdvanceMst);
			
			rowAdvanceMst.put("altNum", sMaxAtlNum);	//신규 선수금대체번호
			altMstInsertCnt = advanceCommonDAO.insertAdvanceAltMst(rowAdvanceMst);
						
			//쿠폰대체상세등록
			for (int i = 0 ; i < listTermination.size() ; i++) {
				Map<String, Object> rowData = listTermination.get(i);
				int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
				
				rowData.put("maxCouponProcNum", maxCouponProcNum);
				rowData.put("quantity", "1");
				rowData.put("couponStatus", "8");              //소멸
				rowData.put("couponCass", "2");                //쿠폰구분 2:소멸쿠폰
				rowData.put("disuseStatus", "2");              //폐기상태 2:소멸
				//rowData.put("procDate", mstData.getMapValue(0, "procDate"));
				rowData.put("extinctionDate", mstData.getMapValue(0, "procDate"));
				rowData.put("recdStatus", "L");
				
				insRowCnt += couponSaleDAO.insertDetail(rowData);
				
				//쿠폰 번호 마스터에 업데이트 처리 한다.
				updRowCnt += couponSaleDAO.updateNumMst(rowData);
				
				
				/************************************************************************************************
				 * 선수금 대체 디테일 등록/수정/삭제, 선수금 마스터정보 변경
				************************************************************************************************/
				Map<String, Object> rowDataDtl = new HashMap<String,Object>();
					
				rowDataDtl.put("altNum", sMaxAtlNum);	//신규 선수금대체번호
				rowDataDtl.put("altDate", mstData.getMapValue(0, "procDate"));      //대체일자
				rowDataDtl.put("advanceNum", rowData.get("advanceNum"));            //선수금번호
				rowDataDtl.put("couponProcNum", maxCouponProcNum);                  //쿠폰처리번호
				rowDataDtl.put("occurDate", mstData.getMapValue(0, "procDate"));    //발생일자
				rowDataDtl.put("muCd", rowData.get("muCd"));                        //사업부
				rowDataDtl.put("ccCd", mstData.getMapValue(0, "ccCd"));             //원가부서
				rowDataDtl.put("acctCd", mstData.getMapValue(0, "acctCd"));         //소멸계정코드
				rowDataDtl.put("applyAmt", rowData.get("couponAmt"));               //적용금액
				rowDataDtl.put("occurAmt", rowData.get("couponAmt"));               //적용금액
				rowDataDtl.put("altSupplyAmt", rowData.get("supplyAmt"));           //대체공급가액
				rowDataDtl.put("altVatAmt", rowData.get("vatAmt"));                 //대체부가세
				rowDataDtl.put("remark", mstData.getMapValue(0, "remark"));         //비고
				rowDataDtl.put("vatCd", rowData.get("vatCd"));         //vat
				
				altDtlInsertCnt += advanceCommonDAO.insertAdvanceAltDtl(rowDataDtl);
				
				//선수금 마스터정보 변경
				advMstUpdateCnt += advanceCommonDAO.updateAdvanceApplyAmtProc(rowDataDtl);
			}	
		}else{
			//쿠폰 판매(이동) 마스터 처리
			Map<String, Object> rowAddData = mstData.get(0);

			updRowCnt = couponSaleDAO.updateMst(rowAddData);
			
			rowAddData.put("couponStatus", "8");             //소멸
			//couponSaleDAO.updateNumCancleMst(rowAddData);
			couponSaleDAO.delete(rowAddData);
			
			
			//선수금 대체처리
			int altMstInsertCnt = 0;	//선수금대체마스터 등록 건수
			int altMstUpdateCnt = 0;	//선수금대체마스터 수정 건수
			int altDtlInsertCnt = 0;	//선수금대체디테일 등록 건수
			int altDtlUpdateCnt = 0;	//선수금대체디테일 수정 건수
			int advMstUpdateCnt = 0;	//선수금마스터 수정 건수
			
			/************************************************************************************************
			 * 선수금 대체 마스터정보 등록/수정
			************************************************************************************************/
			Map<String,Object> rowAdvanceMst = new HashMap<String,Object>();
			rowAdvanceMst.put("altTypeCd", "I03");                        // 선수금 대체 유형 코드
			rowAdvanceMst.put("advanceAltOccurClass", "TO09");            // 선수금 대체 발생 구분
			rowAdvanceMst.put("couponProcNum", rowAddData.get("couponProcNum"));    //쿠폰처리번호
			rowAdvanceMst.put("altNum", rowAddData.get("altNum"));        // 대체번호
			rowAdvanceMst.put("altDate", rowAddData.get("procDate"));     // 대체일자
			rowAdvanceMst.put("muCd", rowAddData.get("muCd"));            // 사업부
			rowAdvanceMst.put("ccCd", rowAddData.get("ccCd"));            // 원가부서
			rowAdvanceMst.put("acctCd", rowAddData.get("acctCd"));        // 계정코드
			rowAdvanceMst.put("remark", rowAddData.get("remark"));        // 비고
			rowAdvanceMst.put("altAmt", rowAddData.get("couponAmt"));     // 대체금액
			altMstUpdateCnt = advanceCommonDAO.updateAdvanceAltMst(rowAdvanceMst);
			
			/************************************************************************************************
			 * 선수금 대체 디테일 등록/수정/삭제, 선수금 마스터정보 변경
			************************************************************************************************/
			for (int i = 0 ; i < listTermination.size() ; i++) {
				Map<String, Object> rowData = listTermination.get(i);
				int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
				
				rowData.put("maxCouponProcNum", mstData.get(0).get("couponProcNum"));
				rowData.put("quantity", "1");
				rowData.put("couponStatus", "8");
				rowData.put("couponCass", "2");                //쿠폰구분 2:소멸쿠폰
				rowData.put("disuseStatus", "2");              //폐기상태 2:소멸
				//rowData.put("procDate", mstData.getMapValue(0, "procDate"));
				rowData.put("extinctionDate", mstData.getMapValue(0, "procDate"));   //소멸일자
				rowData.put("recdStatus", "L");

				insRowCnt += couponSaleDAO.insertDetail(rowData);
				
				//쿠폰 번호 마스터에 업데이트 처리 한다.
				updRowCnt += couponSaleDAO.updateNumMst(rowData);
				
				/************************************************************************************************
				 * 선수금 대체 디테일 등록 쿠폰상태가 판매인경우만 ("3")
				************************************************************************************************/
				if ("3".equals(rowData.get("couponStatus"))){
					Map<String, Object> rowDataDtl = new HashMap<String,Object>();
					rowDataDtl.put("altNum", mstData.getMapValue(0, "altNum"));	        //기존대체번호
					rowDataDtl.put("altDate", mstData.getMapValue(0, "procDate"));      //대체일자
					rowDataDtl.put("advanceNum", rowData.get("advanceNum"));            //선수금번호
					rowDataDtl.put("couponProcNum", rowData.get("couponProcNum"));      //쿠폰처리번호
					rowDataDtl.put("occurDate", mstData.getMapValue(0, "procDate"));    //발생일자
					rowDataDtl.put("muCd", rowData.get("muCd"));                        //사업부
					rowDataDtl.put("ccCd", rowData.get("ccCd"));                        //원가부서
					rowDataDtl.put("acctCd", mstData.getMapValue(0, "acctCd"));         //소멸계정코드
					rowDataDtl.put("applyAmt", rowData.get("couponAmt"));               //적용금액
					rowDataDtl.put("occurAmt", rowData.get("couponAmt"));               //적용금액
					rowDataDtl.put("altSupplyAmt", rowData.get("supplyAmt"));           //대체공급가액
					rowDataDtl.put("altVatAmt", rowData.get("vatAmt"));                 //대체부가세
					rowDataDtl.put("remark", mstData.getMapValue(0, "remark"));         //비고
					
					altDtlInsertCnt += advanceCommonDAO.insertAdvanceAltDtl(rowDataDtl);
					
					//선수금 마스터정보 변경
					advMstUpdateCnt += advanceCommonDAO.updateAdvanceApplyAmtProc(rowDataDtl);
				}
			}	
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 쿠폰소멸관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int cancleList(DataSetMap mstData, DataSetMap listTermination) throws Exception {
		int addRowCnt = 0;
		int insRowCnt = 0;
		int updRowCnt = 0;
		
		//쿠폰 판매(이동) 마스터 처리
		Map<String, Object> rowAddData = mstData.get(0);

		addRowCnt = couponSaleDAO.deleteMst(rowAddData);		
		
		rowAddData.put("couponStatus", "3");
		rowAddData.put("couponClass", "1");
		rowAddData.put("couponNum", listTermination.getMapValue(0, "couponNum"));
		couponTerminationPopDAO.updateNumCancleMst(rowAddData);
		couponSaleDAO.deleteDetail(rowAddData);
		
		rowAddData.put("recdStatus", "D");
		
		//선수금 대체취소처리
		int rowCnt	= 0;
		
		/************************************************************************************************
		 * 선수금대체 마스터정보 삭제
		************************************************************************************************/
		//선수금 대체 마스터 정보 삭제 (RECD_STATUS = 'D')
		rowCnt = advanceCommonDAO.cancelAdvanceAltMaster(rowAddData);

		/************************************************************************************************
		 * 선수금대체 디테일 정보 삭제
		************************************************************************************************/
		//선수금 대체 디테일 정보 삭제 (RECD_STATUS = 'D')
		rowCnt += advanceCommonDAO.cancelAdvanceAltDetail(rowAddData);
			
		return addRowCnt + insRowCnt + updRowCnt + rowCnt;
	}	
}
