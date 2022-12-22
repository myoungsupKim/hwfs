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
import com.hwfs.rc.rcg.dao.CouponPaybackPopDAO;
import com.hwfs.sm.cmn.dao.AdvanceCommonDAO;

 /**
 * 쿠폰환불처리 팝업하는 CouponPaybackPop Service Implementation
 * 
 * @ClassName CouponPaybackPopServiceImpl.java
 * @Description CouponPaybackPopServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.06    김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.04.06
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rcg/couponPaybackPopService")
public class CouponPaybackPopServiceImpl extends DefaultServiceImpl implements CouponPaybackPopService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** CouponPaybackPopDAO Bean 생성 */
	@Resource(name = "/rc/rcg/couponPaybackPopDAO")
	private CouponPaybackPopDAO couponPaybackPopDAO;
	
	/** AdvanceCommonDAO Bean 생성 */
	@Resource(name = "/sm/cmn/advanceCommonDAO")
	private AdvanceCommonDAO advanceCommonDAO;
	

	/**
	 * 쿠폰환불처리 팝업 목록을 조회한다.
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
		return couponPaybackPopDAO.selectList(mapParam);
	}

	/**
	 * 쿠폰환불관리 DETAIL에 해당되는 쿠펀번호 정보 목록을 조회한다.
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
		return couponPaybackPopDAO.selectDetailList(mapParam);
	}

	/**
	 * 쿠폰환불관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap list, DataSetMap inData) throws Exception {
		int addRowCnt = 0;
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String maxCouponProcNum = "";
		String sMaxAtlNum		= "";	//신규 선수금 대체번호
		String receiveTypeCd    = "";   //쿠폰입금수단의 환불유형
		String payType          = "";   //쿠폰처리마스터의 지불형태
		logger.debug("list size : " + list.size());
		logger.debug("inData size : " + inData.size());
		if(inData.get(0).get("couponProcNum").equals("0")){
			//쿠폰환불 번호 MAX값 조회
			maxCouponProcNum =  couponPaybackPopDAO.selectMaxProcNum(inData.get(0));

			//쿠폰환불(이동) 마스터 처리
			
			Map<String, Object> rowAddData = inData.get(0);
			receiveTypeCd = (String)rowAddData.get("receiveTypeCd");      //쿠폰입금수단의 입금유형
			payType       = (String)rowAddData.get("payType");            //쿠폰처리마스타의 지불형태
			
			rowAddData.put("maxCouponProcNum", maxCouponProcNum);
			rowAddData.put("seq", "1");			//지불테이블에 순번
			rowAddData.put("payType", payType);
			
			addRowCnt = couponPaybackPopDAO.insertMst(rowAddData);
			
			//선수금 대체처리
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
			rowAdvanceMst.put("altTypeCd", receiveTypeCd);                        // 선수금 대체 유형 코드
			rowAdvanceMst.put("advanceAltOccurClass", "TO06");            // 선수금 대체 발생 구분(쿠폰환불)
			rowAdvanceMst.put("altDate", rowAddData.get("procDate"));     // 대체일자
			rowAdvanceMst.put("muCd", rowAddData.get("muCd"));            // 사업부
			rowAdvanceMst.put("ccCd", rowAddData.get("ccCd"));            // 원가부서
			rowAdvanceMst.put("remark", rowAddData.get("remark"));        // 비고
			rowAdvanceMst.put("altAmt", rowAddData.get("couponAmt"));     // 대체금액
			rowAdvanceMst.put("acctCd", rowAddData.get("acctCd"));        //계정코드
			rowAdvanceMst.put("paySchdDate", rowAddData.get("paySchdDate"));        //계정코드
			rowAdvanceMst.put("payGrp", rowAddData.get("payGrp"));        //계정코드
			rowAdvanceMst.put("payType", rowAddData.get("payType"));        //계정코드
			
			sMaxAtlNum = advanceCommonDAO.getMaxAtlNum(rowAdvanceMst);
			
			rowAdvanceMst.put("altNum", sMaxAtlNum);	//신규 선수금대체번호
			altMstInsertCnt = advanceCommonDAO.insertAdvanceAltMst(rowAdvanceMst);
			
			//선수금대체번호 추가됨
			rowAddData.put("advanceAltNum", sMaxAtlNum);
			rowAddData.put("payType", receiveTypeCd);
			couponPaybackPopDAO.insertReceiveWay(rowAddData);
			
			for (int i = 0 ; i < list.size() ; i++) {
				Map<String, Object> rowData = list.get(i);
				int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
				logger.debug("rowData : " + rowData);
				rowData.put("maxCouponProcNum", maxCouponProcNum);
				rowData.put("quantity", "1");
				rowData.put("couponStatus", "6");
				rowData.put("procDate", inData.getMapValue(0, "procDate"));
				rowData.put("recdStatus", "L");
				
				insRowCnt += couponPaybackPopDAO.insertDetail(rowData);
				
				//쿠폰 번호 마스터에 업데이트 처리 한다.
				updRowCnt += couponPaybackPopDAO.updateNumMst(rowData);
				
				/************************************************************************************************
				 * 선수금 대체 디테일 등록/수정/삭제, 선수금 마스터정보 변경
				************************************************************************************************/
				Map<String, Object> rowDataDtl = new HashMap<String,Object>();
					
				rowDataDtl.put("altNum", sMaxAtlNum);	//신규 선수금대체번호
				rowDataDtl.put("altDate", inData.getMapValue(0, "procDate"));       //대체일자
				rowDataDtl.put("advanceNum", rowData.get("advanceNum"));            //선수금번호
				rowDataDtl.put("couponProcNum", maxCouponProcNum);                  //쿠폰처리번호
				rowDataDtl.put("occurDate", inData.getMapValue(0, "procDate"));     //발생일자
				rowDataDtl.put("muCd", rowAddData.get("muCd"));                        //사업부
				rowDataDtl.put("ccCd", rowAddData.get("ccCd"));              //원가부서
				rowDataDtl.put("custCd", rowAddData.get("custCd"));              //원가부서
				if ("".equals(inData.getMapValue(0, "acctCd"))){
					rowDataDtl.put("typeGrpCd", "");                                    //
					rowDataDtl.put("altTypeCd", "");                                    //
				} else {
					rowDataDtl.put("acctCd", inData.getMapValue(0, "acctCd"));      //계정코드
				}
				rowDataDtl.put("occurAmt", rowData.get("couponAmt"));               //발생금액
				rowDataDtl.put("applyAmt", rowData.get("couponAmt"));               //적용금액
				rowDataDtl.put("altSupplyAmt", rowData.get("supplyAmt"));           //대체공급가액
				rowDataDtl.put("altVatAmt", rowData.get("vatAmt"));                 //대체부가세
				rowDataDtl.put("vatCd", rowData.get("vatCd"));                 
				rowDataDtl.put("remark", inData.getMapValue(0, "remark"));          //비고
				altDtlInsertCnt += advanceCommonDAO.insertAdvanceAltDtl(rowDataDtl);
			}	
		}else{
			//쿠폰환불(이동) 마스터 처리
			
			Map<String, Object> rowAddData = inData.get(0);
			
			receiveTypeCd = (String)rowAddData.get("receiveTypeCd");
			payType       = (String)rowAddData.get("payType");

			rowAddData.put("payType", payType);     //지불형태
			addRowCnt = couponPaybackPopDAO.updateMst(rowAddData);
			
			//쿠폰입금수단
			rowAddData.put("payType", receiveTypeCd);           //입금유형
			couponPaybackPopDAO.updateReceiveWay(rowAddData);
			
			rowAddData.put("couponStatus", "3");
			couponPaybackPopDAO.updateNumCancleMst(rowAddData);
			couponPaybackPopDAO.delete(rowAddData);
			
			
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
			rowAdvanceMst.put("altTypeCd", receiveTypeCd);                        // 선수금 대체 유형 코드
			rowAdvanceMst.put("advanceAltOccurClass", "TO06");            // 선수금 대체 발생 구분
			rowAdvanceMst.put("couponProcNum", rowAddData.get("couponProcNum"));    //쿠폰처리번호
			rowAdvanceMst.put("altNum", rowAddData.get("advanceAltNum"));        // 대체번호
			rowAdvanceMst.put("altDate", rowAddData.get("procDate"));     // 대체일자
			rowAdvanceMst.put("muCd", rowAddData.get("muCd"));            // 사업부
			rowAdvanceMst.put("ccCd", rowAddData.get("ccCd"));            // 원가부서
			rowAdvanceMst.put("remark", rowAddData.get("remark"));        // 비고
			rowAdvanceMst.put("altAmt", rowAddData.get("couponAmt"));     // 대체금액
			altMstUpdateCnt = advanceCommonDAO.updateAdvanceAltMst(rowAdvanceMst);
			//선수금대체상세 지우고 등록하자
			advanceCommonDAO.deleteAdvanceAltDtl(rowAdvanceMst);
			logger.debug("inData : " + inData);
			for (int i = 0 ; i < list.size() ; i++) {
				Map<String, Object> rowData = list.get(i);
				int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
				logger.debug("rowData : " + rowData);
				rowData.put("maxCouponProcNum", inData.get(0).get("couponProcNum"));
				rowData.put("quantity", "1");
				
				rowData.put("couponStatus", "3");
				rowData.put("procDate", inData.getMapValue(0, "procDate"));
				rowData.put("recdStatus", "L");

				insRowCnt += couponPaybackPopDAO.insertDetail(rowData);
				
				//쿠폰 번호 마스터에 업데이트 처리 한다.
				updRowCnt += couponPaybackPopDAO.updateNumMst(rowData);
				
				/************************************************************************************************
				 * 선수금 대체 디테일 등록 쿠폰상태가 판매인경우만 ("3")
				************************************************************************************************/
				Map<String, Object> rowDataDtl = new HashMap<String,Object>();
				rowDataDtl.put("altNum", inData.getMapValue(0, "advanceAltNum"));	//기존대체번호
				rowDataDtl.put("altDate", inData.getMapValue(0, "procDate"));       //대체일자
				rowDataDtl.put("advanceNum", rowData.get("advanceNum"));            //선수금번호
				rowDataDtl.put("couponProcNum", rowData.get("couponProcNum"));      //쿠폰처리번호
				rowDataDtl.put("occurDate", inData.getMapValue(0, "procDate"));     //발생일자
				rowDataDtl.put("muCd", rowData.get("muCd"));                        //사업부
				rowDataDtl.put("ccCd", rowData.get("ccCd"));                        //원가부서
				rowDataDtl.put("occurAmt", rowData.get("couponAmt"));               //발생금액
				rowDataDtl.put("applyAmt", rowData.get("couponAmt"));               //적용금액
				rowDataDtl.put("altSupplyAmt", rowData.get("supplyAmt"));           //대체공급가액
				rowDataDtl.put("altVatAmt", rowData.get("vatAmt"));                 //대체부가세
				rowDataDtl.put("remark", inData.getMapValue(0, "remark"));          //비고
				altDtlInsertCnt += advanceCommonDAO.insertAdvanceAltDtl(rowDataDtl);
			}	
		}
	
		return addRowCnt + insRowCnt + updRowCnt;
	}
	
	/**
	 * 쿠폰환불관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int cancleList(DataSetMap list, DataSetMap inData) throws Exception {
		int addRowCnt = 0;
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String maxCouponProcNum = "";
		

		//쿠폰환불(이동) 마스터 처리
		
		Map<String, Object> rowAddData = inData.get(0);

		addRowCnt = couponPaybackPopDAO.deleteMst(rowAddData);		
		
		rowAddData.put("couponStatus", "3");
		couponPaybackPopDAO.updateNumCancleMst(rowAddData);
		couponPaybackPopDAO.deleteDetail(rowAddData);
/*		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			rowData.put("maxCouponProcNum", inData.get(0).get("couponProcNum"));
			rowData.put("quantity", "1");
			
			rowData.put("couponStatus", "3");
			rowData.put("procDate", inData.getMapValue(0, "procDate"));
			rowData.put("recdStatus", "L");

			insRowCnt += couponPaybackPopDAO.insertDetail(rowData);
			
			//쿠폰 번호 마스터에 업데이트 처리 한다.
			updRowCnt += couponPaybackPopDAO.updateNumMst(rowData);
		}	
*/
        rowAddData.put("recdStatus", "D");
        rowAddData.put("altNum", rowAddData.get("advanceAltNum"));
		
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
		
		return insRowCnt + updRowCnt;
	}	
}
