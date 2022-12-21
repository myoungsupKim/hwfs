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
import com.hwfs.rc.rcg.dao.CouponExchangePopDAO;
import com.hwfs.sm.cmn.dao.AdvanceCommonDAO;

 /**
 * 쿠폰교환처리 팝업하는 CouponExchangePop Service Implementation
 * 
 * @ClassName CouponExchangePopServiceImpl.java
 * @Description CouponExchangePopServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.07    김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.04.07
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rcg/couponExchangePopService")
public class CouponExchangePopServiceImpl extends DefaultServiceImpl implements CouponExchangePopService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** CouponExchangePopDAO Bean 생성 */
	@Resource(name = "/rc/rcg/couponExchangePopDAO")
	private CouponExchangePopDAO couponExchangePopDAO;
	
	/** AdvanceCommonDAO Bean 생성 */
	@Resource(name = "/sm/cmn/advanceCommonDAO")
	private AdvanceCommonDAO advanceCommonDAO;
	

	/**
	 * 쿠폰교환처리 팝업 목록을 조회한다.
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
		return couponExchangePopDAO.selectList(mapParam);
	}

	/**
	 * 쿠폰교환관리 DETAIL에 해당되는 쿠펀번호 정보 목록을 조회한다.
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
	public RecordSet selectDetailList(Map<String, Object> mapParam) throws Exception {
		mapParam.put("couponStatus", "6");
		mapParam.put("disuseStatus", "4");
		return couponExchangePopDAO.selectDetailList(mapParam);
	}

	/**
	 * 쿠폰교환관리 DETAIL에 해당되는 쿠펀번호 정보 목록을 조회한다.
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
	public RecordSet selectDetailListChg(Map<String, Object> mapParam) throws Exception {
		mapParam.put("couponStatus", "3");
		return couponExchangePopDAO.selectDetailList(mapParam);
	}

	/**
	 * 쿠폰교환관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap list, DataSetMap chgList, DataSetMap inData) throws Exception {
		int addRowCnt = 0;
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String maxCouponProcNum = "";
		String sMaxAtlNum		= "";	//신규 선수금 대체번호
		String maxAdvanceNum = "";      //선수금번호 생성
		
		if(inData.get(0).get("couponProcNum").toString().trim().isEmpty()){
			//쿠폰교환 번호 MAX값 조회
			maxCouponProcNum =  couponExchangePopDAO.selectMaxProcNum(inData.get(0));
			
			//선수금마스터 채번 MAX값
			maxAdvanceNum = advanceCommonDAO.getMaxAdvanceNum(inData.get(0));

			//쿠폰교환(이동) 마스터 처리
			
			Map<String, Object> rowAddData = inData.get(0);
			rowAddData.put("maxCouponProcNum", maxCouponProcNum);
			rowAddData.put("seq", "1");			//지불테이블에 순번
			
			rowAddData.put("advanceNum", maxAdvanceNum);
			
			addRowCnt = couponExchangePopDAO.insertMst(rowAddData);	//쿠폰처리마스터 발생
			couponExchangePopDAO.insertReceiveWay(rowAddData);      //쿠폰입금수단 발생
			
			/************************************************************************************************
			 *  쿠폰 교환대상(폐기)에 대해서는 선수금 대체 처리한다
			************************************************************************************************/
			int altMstInsertCnt = 0;	//선수금대체마스터 등록 건수
			int altMstUpdateCnt = 0;	//선수금대체마스터 수정 건수
			int altDtlInsertCnt = 0;	//선수금대체디테일 등록 건수
			int altDtlUpdateCnt = 0;	//선수금대체디테일 수정 건수
			int advMstUpdateCnt = 0;	//선수금마스터 수정 건수
			
			/************************************************************************************************
			 * 선수금 대체 마스터정보 등록/수정
			************************************************************************************************/
			//선수금 대체번호 채번(신규일 경우 채번)
			Map<String,Object> rowAdvanceMst = new HashMap<String,Object>();
			rowAdvanceMst.put("altTypeCd", "I03");                        // 선수금 대체 유형 코드
			rowAdvanceMst.put("advanceAltOccurClass", "TO07");            // 선수금 대체 발생 구분(쿠폰교환)
			rowAdvanceMst.put("altDate", rowAddData.get("procDate"));     // 대체일자
			rowAdvanceMst.put("muCd", rowAddData.get("muCd"));            // 사업부
			rowAdvanceMst.put("ccCd", rowAddData.get("ccCd"));            // 원가부서
			rowAdvanceMst.put("remark", rowAddData.get("remark"));        // 비고
			rowAdvanceMst.put("altAmt", rowAddData.get("altAmt"));        // 대체금액
			
			sMaxAtlNum = advanceCommonDAO.getMaxAtlNum(rowAdvanceMst);
			
			rowAdvanceMst.put("altNum", sMaxAtlNum);	//신규 선수금대체번호
			altMstInsertCnt = advanceCommonDAO.insertAdvanceAltMst(rowAdvanceMst);
			
			for (int i = 0 ; i < list.size() ; i++) {
				Map<String, Object> rowData = list.get(i);
				int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
				logger.debug("for row num = : " + i);
				logger.debug("for row num = : " + rowData);
				rowData.put("maxCouponProcNum", maxCouponProcNum);
				rowData.put("quantity", "1");
				rowData.put("couponStatus", "6");
				rowData.put("disuseStatus", "4");
				
				rowData.put("procDate", null);
				rowData.put("recdStatus", "L");
				
				insRowCnt += couponExchangePopDAO.insertDetail(rowData);
				
				//쿠폰 번호 마스터에 업데이트 처리 한다.
				rowData.put("maxCouponProcNum", "");
				updRowCnt += couponExchangePopDAO.updateNumMst(rowData);
				
				/************************************************************************************************
				 * 선수금 대체 디테일 등록/수정/삭제, 선수금 마스터정보 변경
				************************************************************************************************/
				Map<String, Object> rowDataDtl = new HashMap<String,Object>();
					
				rowDataDtl.put("altNum", sMaxAtlNum);	//신규 선수금대체번호
				rowDataDtl.put("altDate", inData.getMapValue(0, "procDate"));       //대체일자
				rowDataDtl.put("advanceNum", rowData.get("advanceNum"));            //선수금번호
				rowDataDtl.put("couponProcNum", maxCouponProcNum);                  //쿠폰처리번호
				rowDataDtl.put("occurDate", inData.getMapValue(0, "procDate"));     //발생일자
				rowDataDtl.put("muCd", rowData.get("muCd"));                        //사업부
				rowDataDtl.put("ccCd", inData.getMapValue(0, "ccCd"));              //원가부서
				
				if (!"".equals(rowData.get("extinctionAcct")) && rowData.get("extinctionAcct") != null){
					rowDataDtl.put("acctCd", rowData.get("extinctionAcct"));            //계정코드  쿠폰종류에 따른 소멸계정
				}else{
					rowDataDtl.put("acctCd", rowData.get("acctCd"));            		//계정코드  쿠폰종류에 따른 소멸계정
				}
				rowDataDtl.put("occurAmt", rowData.get("couponAmt"));               //적용금액
				rowDataDtl.put("applyAmt", rowData.get("couponAmt"));               //적용금액
				rowDataDtl.put("altSupplyAmt", rowData.get("supplyAmt"));           //대체공급가액
				rowDataDtl.put("altVatAmt", rowData.get("vatAmt"));                 //대체부가세
				rowDataDtl.put("vatCd", rowData.get("vatCd"));                 		
				rowDataDtl.put("remark", inData.getMapValue(0, "remark"));          //비고
				logger.debug("rowDataDtl : " + rowDataDtl);
				logger.debug("rowData : " + rowData);
				altDtlInsertCnt += advanceCommonDAO.insertAdvanceAltDtl(rowDataDtl);
			}
			
			//교환쿠폰은 선수금 마스터 발생
			rowAddData.put("maxAdvanceNum", maxAdvanceNum);
			rowAddData.put("occurDate", rowAddData.get("procDate"));                //발생일자
			rowAddData.put("fiscalDate", rowAddData.get("procDate"));               //회계일자
			rowAddData.put("advanceOccurClass", "AO02");                            //선수금발생구분  쿠폰판매
			rowAddData.put("advanceTypeCd", "F04");                                 //선수금유형코드  쿠폰판매
			rowAddData.put("occurAmt", rowAddData.get("couponAmt"));                //발생금액
			rowAddData.put("occurSupplyAmt", rowAddData.get("supplyAmt"));          //발생공급가액
			rowAddData.put("occurVatAmt", rowAddData.get("vatAmt"));                //발생부가세
			rowAddData.put("vatCd", chgList.getMapValue(0, "vatCd"));               //부가세구분
			rowAddData.put("journalzYn", "N");                                      //분개여부
			rowAddData.put("couponProcNum", maxCouponProcNum);                      //쿠폰처리번호
			rowAddData.put("acctCd", chgList.getMapValue(0, "acctCd"));        //소멸계정코드
			
			//선수금마스터 발생
			insRowCnt += advanceCommonDAO.insertAdvanceMaster(rowAddData);
			
			for (int i = 0 ; i < chgList.size() ; i++) {
				Map<String, Object> rowData = chgList.get(i);
				int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
				
				rowData.put("maxCouponProcNum", maxCouponProcNum);
				rowData.put("quantity", "1");
				rowData.put("couponStatus", "3");
				rowData.put("procDate", inData.getMapValue(0, "procDate"));
				rowData.put("recdStatus", "L");
				rowData.put("advanceNum", maxAdvanceNum);
				
				
				insRowCnt += couponExchangePopDAO.insertDetail(rowData);
				
				//쿠폰 번호 마스터에 업데이트 처리 한다.
				updRowCnt += couponExchangePopDAO.updateNumMst(rowData);
			}	

		}else{
			//쿠폰교환(이동) 마스터 처리
			
			Map<String, Object> rowAddData = inData.get(0);

			addRowCnt = couponExchangePopDAO.updateMst(rowAddData);		
			couponExchangePopDAO.updateReceiveWay(rowAddData);
			
			rowAddData.put("couponStatus", "3");
			couponExchangePopDAO.updateNumCancleMst(rowAddData);
			couponExchangePopDAO.delete(rowAddData);
			
			//선수금 대체상세 삭제하고 다시 등록하자
			advanceCommonDAO.deleteAdvanceAltDtl(rowAddData);
			
			/************************************************************************************************
			 *  쿠폰 교환대상(폐기)에 대해서는 선수금 대체 처리한다
			************************************************************************************************/
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
			rowAdvanceMst.put("advanceAltOccurClass", "TO07");            // 선수금 대체 발생 구분
			rowAdvanceMst.put("couponProcNum", rowAddData.get("couponProcNum"));    //쿠폰처리번호
			rowAdvanceMst.put("altNum", rowAddData.get("altNum"));        // 대체번호
			rowAdvanceMst.put("altDate", rowAddData.get("procDate"));     // 대체일자
			rowAdvanceMst.put("muCd", rowAddData.get("muCd"));            // 사업부
			rowAdvanceMst.put("ccCd", rowAddData.get("ccCd"));            // 원가부서
			rowAdvanceMst.put("remark", rowAddData.get("remark"));        // 비고
			rowAdvanceMst.put("altAmt", rowAddData.get("altAmt"));        // 대체금액
			altMstUpdateCnt = advanceCommonDAO.updateAdvanceAltMst(rowAdvanceMst);
			
			for (int i = 0 ; i < list.size() ; i++) {
				Map<String, Object> rowData = list.get(i);
				int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
				
				rowData.put("maxCouponProcNum", inData.get(0).get("couponProcNum"));
				rowData.put("quantity", "1");
				
				rowData.put("couponStatus", "6");
				rowData.put("disuseStatus", "4");
				rowData.put("procDate", null);
				rowData.put("recdStatus", "L");

				insRowCnt += couponExchangePopDAO.insertDetail(rowData);
				
				//쿠폰 번호 마스터에 업데이트 처리 한다.
				rowData.put("maxCouponProcNum", "");
				updRowCnt += couponExchangePopDAO.updateNumMst(rowData);
				
				/************************************************************************************************
				 * 선수금 대체 디테일 등록
				************************************************************************************************/
				Map<String, Object> rowDataDtl = new HashMap<String,Object>();
				rowDataDtl.put("altNum", inData.getMapValue(0, "altNum"));	        //기존대체번호
				rowDataDtl.put("altDate", inData.getMapValue(0, "procDate"));       //대체일자
				rowDataDtl.put("advanceNum", rowData.get("advanceNum"));            //선수금번호
				rowDataDtl.put("couponProcNum", rowData.get("couponProcNum"));      //쿠폰처리번호
				rowDataDtl.put("occurDate", inData.getMapValue(0, "procDate"));     //발생일자
				rowDataDtl.put("muCd", rowData.get("muCd"));                        //사업부
				rowDataDtl.put("ccCd", rowData.get("ccCd"));                        //원가부서
				rowDataDtl.put("acctCd", rowData.get("extinctionAcct"));            //계정코드  쿠폰종류에 따른 소멸계정
				rowDataDtl.put("occurAmt", rowData.get("couponAmt"));               //적용금액
				rowDataDtl.put("applyAmt", rowData.get("couponAmt"));               //적용금액
				rowDataDtl.put("altSupplyAmt", rowData.get("supplyAmt"));           //대체공급가액
				rowDataDtl.put("altVatAmt", rowData.get("vatAmt"));                 //대체부가세
				rowDataDtl.put("remark", inData.getMapValue(0, "remark"));          //비고
								
				altDtlInsertCnt += advanceCommonDAO.insertAdvanceAltDtl(rowDataDtl);
			}
			
			//선수금마스터 수정
			rowAddData.put("occurDate", rowAddData.get("procDate"));                //발생일자
			rowAddData.put("occurAmt", rowAddData.get("couponAmt"));                //발생금액
			rowAddData.put("occurSupplyAmt", rowAddData.get("supplyAmt"));          //발생공급가액
			rowAddData.put("occurVatAmt", rowAddData.get("vatAmt"));                //발생부가세
			
			insRowCnt += advanceCommonDAO.updateAdvanceMasterCoupon(rowAddData);
			
			for (int i = 0 ; i < chgList.size() ; i++) {
				Map<String, Object> rowData = chgList.get(i);
				int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
				
				rowData.put("maxCouponProcNum", inData.get(0).get("couponProcNum"));
				rowData.put("quantity", "1");
				rowData.put("couponStatus", "3");
				rowData.put("procDate", inData.getMapValue(0, "procDate"));
				rowData.put("recdStatus", "L");
				
				insRowCnt += couponExchangePopDAO.insertDetail(rowData);
				
				//쿠폰 번호 마스터에 업데이트 처리 한다.
				updRowCnt += couponExchangePopDAO.updateNumMst(rowData);
			}	
			
		}
	
		return addRowCnt + insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 쿠폰교환관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int cancleList(DataSetMap list, DataSetMap chgList, DataSetMap inData) throws Exception {
		int addRowCnt = 0;
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		//쿠폰교환(이동) 마스터 처리
		Map<String, Object> rowAddData = inData.get(0);

		addRowCnt = couponExchangePopDAO.deleteMst(rowAddData);		
		
		
		//교환 쿠폰을 배포로 처리
		rowAddData.put("couponStatus", "2");
		rowAddData.put("whereCouponStatus", "3");
		couponExchangePopDAO.updateNumCancleMst(rowAddData);
		
		//교환 대상 쿠폰을 판매로 처리
		rowAddData.put("couponStatus", "3");
		rowAddData.put("whereCouponStatus", "6");
		couponExchangePopDAO.updateNumCancleMst(rowAddData);
		
		couponExchangePopDAO.deleteDetail(rowAddData);
		
		/************************************************************************************************
		 * 선수금대체 마스터정보 삭제
		************************************************************************************************/
		//선수금 대체 마스터 정보 삭제 (RECD_STATUS = 'D')
		addRowCnt = advanceCommonDAO.cancelAdvanceAltMaster(rowAddData);

		/************************************************************************************************
		 * 선수금대체 디테일 정보 삭제
		************************************************************************************************/
		//선수금 대체 디테일 정보 삭제 (RECD_STATUS = 'D')
		addRowCnt += advanceCommonDAO.cancelAdvanceAltDetail(rowAddData);
		
		//선수금발생 취소
		updRowCnt += advanceCommonDAO.mstAdvanceCancel(rowAddData);
/*		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			rowData.put("maxCouponProcNum", inData.get(0).get("couponProcNum"));
			rowData.put("quantity", "1");
			
			rowData.put("couponStatus", "3");
			rowData.put("procDate", inData.getMapValue(0, "procDate"));
			rowData.put("recdStatus", "L");

			insRowCnt += couponExchangePopDAO.insertDetail(rowData);
			
			//쿠폰 번호 마스터에 업데이트 처리 한다.
			updRowCnt += couponExchangePopDAO.updateNumMst(rowData);
		}	
*/
		return addRowCnt + insRowCnt + updRowCnt;
	}	
}
