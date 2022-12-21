package com.hwfs.rc.rcg.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rcg.dao.CouponSaleDAO;
import com.hwfs.sm.cmn.dao.AdvanceCommonDAO;
import com.hwfs.sm.sar.dao.ArMstProcessDAO;
import com.hwfs.sm.sar.dao.CardApprvPopupDAO;
import com.hwfs.sm.sar.dao.SaleCashAlterDAO;
import com.hwfs.sm.ssi.dao.SalesTypeMgntDAO;

 /**
 * 쿠폰판매관리하는 CouponSale Service Implementation
 * 
 * @ClassName CouponSaleServiceImpl.java
 * @Description CouponSaleServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.31    김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.03.31
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rcg/couponSaleService")
public class CouponSaleServiceImpl extends DefaultServiceImpl implements CouponSaleService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** CouponSaleDAO Bean 생성 */
	@Resource(name = "/rc/rcg/couponSaleDAO")
	private CouponSaleDAO couponSaleDAO;
	
	/** SaleCashAlterDAO Bean 생성 */
	@Resource(name = "/sm/sar/saleCashAlterDAO")
	private SaleCashAlterDAO saleCashAlterDAO;
	
	/** AdvanceCommonDAO Bean 생성 */
	@Resource(name = "/sm/cmn/advanceCommonDAO")
	private AdvanceCommonDAO advanceCommonDAO;
	
	/** ArMstProcessDAO Bean 생성 */
	@Resource(name = "/sm/sar/arMstProcessDAO")
	private ArMstProcessDAO arMstProcessDAO;
	
	/** CardApprvPopupDAO Bean 생성 */
	@Resource(name = "/sm/sar/cardApprvPopupDAO")
	private CardApprvPopupDAO cardApprvPopupDAO;
	
	/** SalesTypeMgntDAO Bean 생성 */
	@Resource(name = "/sm/ssi/salesTypeMgntDAO")
	private SalesTypeMgntDAO salesTypeMgntDAO;
	

	/**
	 * 쿠폰판매관리 목록을 조회한다.
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
		return couponSaleDAO.selectList(mapParam);
	}

	/**
	 * 쿠폰판매관리 DETAIL에 해당되는 쿠펀번호 정보 목록을 조회한다.
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
		return couponSaleDAO.selectDetailList(mapParam);
	}

	/**
	 * 쿠폰판매관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap list, DataSetMap inData, DataSetMap listAdvance, DataSetMap advanceData) throws Exception {
		int addRowCnt = 0;
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String maxCouponProcNum = "";
		String maxAdvanceNum = "";
		String maxArNum      = "";
		String maxSalesCashNum = "";
		
		if(inData.get(0).get("couponProcNum").equals("0") || inData.get(0).get("couponProcNum").equals("")){
			//쿠폰 판매 번호 MAX값 조회
			maxCouponProcNum =  couponSaleDAO.selectMaxProcNum(inData.get(0));
			
			//선수금마스터 채번 MAX값
			maxAdvanceNum = advanceCommonDAO.getMaxAdvanceNum(inData.get(0));
			
			//쿠폰 판매(이동) 마스터 처리
			
			Map<String, Object> rowAddData = inData.get(0);
			rowAddData.put("maxCouponProcNum", maxCouponProcNum);
			rowAddData.put("seq", "1");			                                    //지불테이블에 순번
			rowAddData.put("sysClass", "12");                                       //시스템구분 (식자재)
			rowAddData.put("occurDate", rowAddData.get("procDate"));                //발생일자
			rowAddData.put("fiscalDate", rowAddData.get("procDate"));               //회계일자
			rowAddData.put("occurAmt", rowAddData.get("couponAmt"));                //발생금액	
			rowAddData.put("maxAdvanceNum", maxAdvanceNum);
			rowAddData.put("advanceNum", maxAdvanceNum);
			rowAddData.put("advanceOccurClass", "AO02");                            //선수금발생구분  쿠폰판매
			//rowAddData.put("advanceTypeCd", "F04");                                 //선수금유형코드  쿠폰판매
			//선수금판매계정에 따라 유형 설정 추가(선수금_선매출 계정인 경우 선수금유형코드F09) 2016.11.08
			if (list.get(0).get("acctCd").equals("21401070")) {
				rowAddData.put("advanceTypeCd", "F09");   
			} else {
				rowAddData.put("advanceTypeCd", "F04");
			}
			rowAddData.put("occurSupplyAmt", rowAddData.get("supplyAmt"));          //발생공급가액
			rowAddData.put("occurVatAmt", rowAddData.get("vatAmt"));                //발생부가세
			rowAddData.put("vatCd", rowAddData.get("vatCd"));                                           //부가세구분  20:과세
			rowAddData.put("journalzYn", "N");                                      //분개여부
			rowAddData.put("couponProcNum", maxCouponProcNum);                      //쿠폰처리번호
			
			//카드,후불인 경우만 채권발생
			if ("2".equals(rowAddData.get("payType")) || "7".equals(rowAddData.get("payType"))){
				//채권마스터 채권번호 MAX값 가져오기
				maxArNum      = arMstProcessDAO.selectMaxArNum(rowAddData);
				
				rowAddData.put("arNum", maxArNum);
				rowAddData.put("arOccurClass", "AO04");   //채권발생구분  : 5:쿠폰채권
			}
			
			rowAddData.put("arTypeCd", "A06");   //쿠폰외상판매
			addRowCnt = couponSaleDAO.insertMst(rowAddData);
			couponSaleDAO.insertReceiveWay(rowAddData);
			
			//영업유형 을(를) 조회한다.(계정코드 가져오자)
			Map<String,Object> mapData = new HashMap<String,Object>();
			
			//지불유형에 따른 처리 1:현금 2:카드 7:후불 P2:선수금
			if ("1".equals(rowAddData.get("payType"))){
				//영업현금발생
				rowAddData.put("modifySalsYn", "N");                      //데이타구분 "N" :정상분  "Y":조정분
				rowAddData.put("dealType", "4");                          //거래유형 "1":정상매출분 "2":선수금입금 "3":후불입금 "4":쿠폰판매분 "5":MEMBER가입 "6":식권판매
				rowAddData.put("dataClass", "C");                         //자동수기구분  "C":자동  "A":수기발생
				rowAddData.put("acctCd", "11101012");                	  //계정코드 추가 2016.09.05 김호석	
				
				maxSalesCashNum = saleCashAlterDAO.selectMaxSalesCashNum(rowAddData);
				
				rowAddData.put("maxSalesCashNum", maxSalesCashNum);
				insRowCnt += saleCashAlterDAO.insertSaleCash(rowAddData);
				
			//선수금마스터 발생
			//	insRowCnt += advanceCommonDAO.insertAdvanceMaster(rowAddData);
			} else if ("2".equals(rowAddData.get("payType"))){
				//채권발생
				rowAddData.put("arTypeCd", "A03");                      //채권유형코드
				//rowAddData.put("acctCd", "11204014");                   //계정코드  미수금_신용카드_청구(-)
				
				mapData.put("typeGrpCdDtl", "001");
				mapData.put("typeCd", rowAddData.get("arTypeCd"));
				RecordSet rs = salesTypeMgntDAO.selectDtlList(mapData);
								
				for (int i = 0; i < rs.size(); i++){
					mapData.put("acctCd", rs.get(i).get("acctCd"));
				}
				rowAddData.put("acctCd", mapData.get("acctCd"));           //계정코드 셋팅  미수금_신용카드_청구(-)
				
				rowAddData.put("arAmt", rowAddData.get("couponAmt"));   //채권금액
				insRowCnt += arMstProcessDAO.insert(rowAddData);
				
				//선수금마스터 발생
			//	insRowCnt += advanceCommonDAO.insertAdvanceMaster(rowAddData);
				
				//카드승인정보 발생
				rowAddData.put("ediInputClass", "2");                          //쿠폰
				rowAddData.put("cardProcType", "4");                           //카드처리유형  4:쿠폰판매분
				rowAddData.put("cardComCd", rowAddData.get("buycpnyCd"));      //카드사코드
				rowAddData.put("cardNum", rowAddData.get("creditCardNum"));    //카드번호
				rowAddData.put("apprvDate", rowAddData.get("procDate"));       //승인일자
				rowAddData.put("useAmt", rowAddData.get("couponAmt"));         //승인금액
				
				insRowCnt += cardApprvPopupDAO.insert(rowAddData);
			} else if ("7".equals(rowAddData.get("payType"))){
				//채권발생
				rowAddData.put("arTypeCd", "A06");                      //채권유형코드
				//rowAddData.put("acctCd", "11204030");                   //계정코드  미수금_식권및쿠폰
				
				mapData.put("typeGrpCdDtl", "001");
				mapData.put("typeCd", rowAddData.get("arTypeCd"));
				RecordSet rs = salesTypeMgntDAO.selectDtlList(mapData);
								
				for (int i = 0; i < rs.size(); i++){
					mapData.put("acctCd", rs.get(i).get("acctCd"));
				}
				rowAddData.put("acctCd", mapData.get("acctCd"));           //계정코드 셋팅  미수금_식권및쿠폰
				
				rowAddData.put("arAmt", rowAddData.get("couponAmt"));   //채권금액
				insRowCnt += arMstProcessDAO.insert(rowAddData);
				
			//선수금마스터 발생
			//	rowAddData.put("acctCd", "21401020");                   //계정코드 : 선수금_사업장
			//	insRowCnt += advanceCommonDAO.insertAdvanceMaster(rowAddData);
			} else if ("P2".equals(rowAddData.get("payType"))){
				//선수금 대체처리
				int altMstInsertCnt = 0;	//선수금대체마스터 등록 건수
				int altMstUpdateCnt = 0;	//선수금대체마스터 수정 건수
				int altDtlInsertCnt = 0;	//선수금대체디테일 등록 건수
				int altDtlUpdateCnt = 0;	//선수금대체디테일 수정 건수
				int advMstUpdateCnt = 0;	//선수금마스터 수정 건수
				
				int iApplyAmt		= 0;	//적용금액
				int advTransCnt		= 0;	//거래처/업장이관 건수(선수금마스터 등록건수)

				String sRowStatusMst	= "";	//마스터 상태
				String sRowStatusDtl	= "";	//디테일 상태
				String sAtlNum			= "";	//선수금 대체번호
				String sMaxAtlNum		= "";	//신규 선수금 대체번호
				String sMaxAdvanceNum	= "";	//신규 선수금번호
				String sTransYn			= "";	//이관여부
				Map<String, Object> rowDataMst = advanceData.get(0);
				
				if(rowDataMst.get("rowStatus") == null) sRowStatusMst = "";
				else sRowStatusMst = rowDataMst.get("rowStatus").toString();
				

				/************************************************************************************************
				 * 선수금 대체 마스터정보 등록/수정
				************************************************************************************************/
				//선수금 대체 마스터 등록
				if("INSERT".equals(sRowStatusMst)){

					//선수금 대체번호 채번(신규일 경우 채번)
					sMaxAtlNum = advanceCommonDAO.getMaxAtlNum(rowDataMst);
					
					rowDataMst.put("altNum", sMaxAtlNum);	//신규 선수금대체번호
					altMstInsertCnt = advanceCommonDAO.insertAdvanceAltMst(rowDataMst);
				}
				
				/************************************************************************************************
				 * 선수금 대체 디테일 등록/수정/삭제, 선수금 마스터정보 변경
				************************************************************************************************/
				for (int i = 0 ; i < listAdvance.size() ; i++) {
					Map<String, Object> rowDataDtl = listAdvance.get(i);
					
					//상태
					if(rowDataDtl.get("rowStatus") == null) sRowStatusDtl = "";
					else sRowStatusDtl = rowDataDtl.get("rowStatus").toString();
					
					//적용금액
					if(rowDataDtl.get("applyAmt") == null) iApplyAmt = 0;
					else iApplyAmt = Integer.parseInt(rowDataDtl.get("applyAmt").toString());

					//선수금대체번호
					if(rowDataDtl.get("altNum") == null) sAtlNum = "";
					else sAtlNum = rowDataDtl.get("altNum").toString();			
					
					//선수금대체 디테일정보 등록(적용금액을 입력했을 경우)
					if("INSERT".equals(sRowStatusDtl) && iApplyAmt > 0){
						rowDataDtl.put("altNum", sMaxAtlNum);	//신규 선수금대체번호
						
						altDtlInsertCnt += advanceCommonDAO.insertAdvanceAltDtl(rowDataDtl);
					}
										
					//선수금 마스터정보 변경
					advMstUpdateCnt += advanceCommonDAO.updateAdvanceApplyAmtProc(rowDataDtl);
					
					Map<String,Object> mapDataAdvance = new HashMap<String,Object>();
					//대체번호 셋팅
					mapDataAdvance.put("couponProcNum", maxCouponProcNum);
					mapDataAdvance.put("atlNum", sMaxAtlNum);
					//쿠폰입금수단에 선수금대체번호 업데이트
					altDtlUpdateCnt += couponSaleDAO.updateReceiveWayAtlNum(mapDataAdvance);
				}
				//=============================================================================
				//선수금마스터 발생
				//insRowCnt += advanceCommonDAO.insertAdvanceMaster(rowAddData);
			}
			
			//=============================================================================
			//선수금마스터 발생
			mapData.put("typeGrpCdDtl", "006");
			//선수금판매계정에 따라 유형 설정 추가(선수금_선매출 계정인 경우 선수금유형코드F09) 2016.11.08
			if (list.get(0).get("acctCd").equals("21401070")) {
				mapData.put("typeCd", "F09");
			} else {
				mapData.put("typeCd", "F04");
			}
			
			RecordSet rs = salesTypeMgntDAO.selectDtlList(mapData);
			
			rowAddData.put("acctCd", rs.get(0).get("acctCd"));
			rowAddData.put("receiveTypeCd", "AO02");
			rowAddData.put("adjustAmt", rowAddData.get("couponAmt"));   //정산금액
			rowAddData.put("advanceNum", maxAdvanceNum);   //정산금액
			insRowCnt += advanceCommonDAO.insertAdvanceMaster(rowAddData);
			//현금번호 추가 2016.09.05 김호석
			rowAddData.put("salesCashNum", maxSalesCashNum);   //현금번호
			insRowCnt += advanceCommonDAO.insertOriAdvanceReceiveWay(rowAddData);
			
			
			for (int i = 0 ; i < list.size() ; i++) {
				Map<String, Object> rowData = list.get(i);
				int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
				
				rowData.put("maxCouponProcNum", maxCouponProcNum);
				rowData.put("quantity", "1");
				rowData.put("couponStatus", "3");
				rowData.put("procDate", inData.getMapValue(0, "procDate"));
				rowData.put("recdStatus", "L");
				
				insRowCnt += couponSaleDAO.insertDetail(rowData);
				
				//쿠폰 번호 마스터에 업데이트 처리 한다.
				rowData.put("advanceNum", maxAdvanceNum);
				updRowCnt += couponSaleDAO.updateNumMst(rowData);
			}	
		}else{
			//쿠폰 판매(이동) 마스터 처리
			
			Map<String, Object> rowAddData = inData.get(0);

			addRowCnt = couponSaleDAO.updateMst(rowAddData);
			couponSaleDAO.updateReceiveWay(rowAddData);
			
			rowAddData.put("couponStatus", "2");
			couponSaleDAO.updateNumCancleMst(rowAddData);
			couponSaleDAO.delete(rowAddData);
			
			rowAddData.put("occurDate", rowAddData.get("procDate"));  //발생일자
			rowAddData.put("occurAmt", rowAddData.get("couponAmt"));  //발생금액
			rowAddData.put("occurSupplyAmt", rowAddData.get("supplyAmt"));          //발생공급가액
			rowAddData.put("occurVatAmt", rowAddData.get("vatAmt"));                //발생부가세
			
			//지불유형에 따른 처리 1:현금 2:카드 7:후불 P2:선수금
			if ("1".equals(rowAddData.get("payType"))){
				//영업현금발생
				insRowCnt += saleCashAlterDAO.updateSaleCashCoupon(rowAddData);
				
				//선수금마스터 발생
				//insRowCnt += advanceCommonDAO.updateAdvanceMasterCoupon(rowAddData);
			} else if ("2".equals(rowAddData.get("payType"))){
				//채권발생
				rowAddData.put("arAmt", rowAddData.get("couponAmt"));   //채권금액
				insRowCnt += arMstProcessDAO.update(rowAddData);
				
				//선수금마스터 발생
				//insRowCnt += advanceCommonDAO.updateAdvanceMasterCoupon(rowAddData);
			} else if ("7".equals(rowAddData.get("payType"))){
				//채권발생
				rowAddData.put("arAmt", rowAddData.get("couponAmt"));   //채권금액
				insRowCnt += arMstProcessDAO.update(rowAddData);
				
				//선수금마스터 발생
				//insRowCnt += advanceCommonDAO.updateAdvanceMasterCoupon(rowAddData);
			} else if ("P2".equals(rowAddData.get("payType"))){
				//선수금 대체처리
				int altMstInsertCnt = 0;	//선수금대체마스터 등록 건수
				int altMstUpdateCnt = 0;	//선수금대체마스터 수정 건수
				int altDtlInsertCnt = 0;	//선수금대체디테일 등록 건수
				int altDtlUpdateCnt = 0;	//선수금대체디테일 수정 건수
				int advMstUpdateCnt = 0;	//선수금마스터 수정 건수
				
				int iApplyAmt		= 0;	//적용금액
				int advTransCnt		= 0;	//거래처/업장이관 건수(선수금마스터 등록건수)

				String sRowStatusMst	= "";	//마스터 상태
				String sRowStatusDtl	= "";	//디테일 상태
				String sAtlNum			= "";	//선수금 대체번호
				String sTransYn			= "";	//이관여부
				Map<String, Object> rowDataMst = advanceData.get(0);
				
				if(rowDataMst.get("rowStatus") == null) sRowStatusMst = "";
				else sRowStatusMst = rowDataMst.get("rowStatus").toString();

				/************************************************************************************************
				 * 선수금 대체 마스터정보 등록/수정
				************************************************************************************************/
				//선수금 대체 마스터 등록
				if("UPDATE".equals(sRowStatusMst)){
					altMstUpdateCnt = advanceCommonDAO.updateAdvanceAltMst(rowDataMst);
				}
				
				/************************************************************************************************
				 * 선수금 대체 디테일 등록/수정/삭제, 선수금 마스터정보 변경
				************************************************************************************************/
				for (int i = 0 ; i < listAdvance.size() ; i++) {
					Map<String, Object> rowDataDtl = listAdvance.get(i);
					
					//상태
					if(rowDataDtl.get("rowStatus") == null) sRowStatusDtl = "";
					else sRowStatusDtl = rowDataDtl.get("rowStatus").toString();
					
					//적용금액
					if(rowDataDtl.get("applyAmt") == null) iApplyAmt = 0;
					else iApplyAmt = Integer.parseInt(rowDataDtl.get("applyAmt").toString());

					//선수금대체번호
					if(rowDataDtl.get("altNum") == null) sAtlNum = "";
					else sAtlNum = rowDataDtl.get("altNum").toString();			
					
					//선수금대체 디테일정보 변경
					if("UPDATE".equals(sRowStatusDtl)){
						altDtlUpdateCnt += advanceCommonDAO.updateAdvanceAltDtl(rowDataDtl);
					}
					
					//선수금 마스터정보 변경
					advMstUpdateCnt += advanceCommonDAO.updateAdvanceApplyAmtProc(rowDataDtl);
										
				}
			}
			
			//선수금마스터 발생
			insRowCnt += advanceCommonDAO.updateAdvanceMasterCoupon(rowAddData);
			
			for (int i = 0 ; i < list.size() ; i++) {
				Map<String, Object> rowData = list.get(i);
				int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
				
				rowData.put("maxCouponProcNum", inData.get(0).get("couponProcNum"));
				rowData.put("quantity", "1");
				
				rowData.put("couponStatus", "3");
				rowData.put("procDate", inData.getMapValue(0, "procDate"));
				rowData.put("recdStatus", "L");

				insRowCnt += couponSaleDAO.insertDetail(rowData);
				
				//쿠폰 번호 마스터에 업데이트 처리 한다.
				updRowCnt += couponSaleDAO.updateNumMst(rowData);
			}	
		}
			
		return insRowCnt + updRowCnt;
	}
	
	/**
	 * 쿠폰판매관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int cancleList(DataSetMap list, DataSetMap inData, DataSetMap listAdvance, DataSetMap advanceData) throws Exception {
		int addRowCnt = 0;
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String maxCouponProcNum = "";
		

		//쿠폰 판매(이동) 마스터 처리
		
		Map<String, Object> rowAddData = inData.get(0);

		addRowCnt = couponSaleDAO.deleteMst(rowAddData);		
		
		rowAddData.put("couponStatus", "2");
		couponSaleDAO.updateNumCancleMst(rowAddData);
		couponSaleDAO.deleteDetail(rowAddData);
		
		rowAddData.put("recdStatus", "D");
		
		if ("1".equals(rowAddData.get("payType"))){
			//영업수입 현금 취소
			updRowCnt += saleCashAlterDAO.cancelSaleCashCoupon(rowAddData);
		} else if ("2".equals(rowAddData.get("payType"))){
			//채권발생 취소
			updRowCnt += arMstProcessDAO.update(rowAddData);
		} else if ("7".equals(rowAddData.get("payType"))){
			//채권발생 취소
			updRowCnt += arMstProcessDAO.update(rowAddData);
		} else if ("P2".equals(rowAddData.get("payType"))){
			//선수금 대체취소처리
			int rowCnt	= 0;
			int iApplyAmt = 0;
			
			/************************************************************************************************
			 * 선수금대체 마스터정보 삭제
			************************************************************************************************/	
			Map<String, Object> rowDataMst = advanceData.get(0);
			
			//선수금 대체 마스터 정보 삭제 (RECD_STATUS = 'D')
			rowCnt = advanceCommonDAO.cancelAdvanceAltMaster(rowDataMst);

			/************************************************************************************************
			 * 선수금 마스터, 선수금대체 디테일 정보 삭제
			************************************************************************************************/
			for (int i = 0 ; i < listAdvance.size() ; i++) {
				Map<String, Object> rowDataDtl = listAdvance.get(i);
				
				//적용금액
				if(rowDataDtl.get("applyAmt") == null) iApplyAmt = 0;
				else iApplyAmt = Integer.parseInt(rowDataDtl.get("applyAmt").toString());
				
					
				/************************************************************************************************
				 * 대체취소
				************************************************************************************************/		
					
				//선수금 대체 디테일 정보 삭제 (RECD_STATUS = 'D')
				if(iApplyAmt > 0) rowCnt += advanceCommonDAO.cancelAdvanceAltDetail(rowDataDtl);

				//선수금 마스터정보 변경
				rowCnt += advanceCommonDAO.updateAdvanceApplyAmtProc(rowDataDtl);
				
			}
		}
		//선수금발생 취소
		updRowCnt += advanceCommonDAO.mstAdvanceCancel(rowAddData);
		updRowCnt += advanceCommonDAO.advanceReceiveWayCancel(rowAddData);			

		/*		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			rowData.put("maxCouponProcNum", inData.get(0).get("couponProcNum"));
			rowData.put("quantity", "1");
			
			rowData.put("couponStatus", "3");
			rowData.put("procDate", inData.getMapValue(0, "procDate"));
			rowData.put("recdStatus", "L");

			insRowCnt += couponSaleDAO.insertDetail(rowData);
			
			//쿠폰 번호 마스터에 업데이트 처리 한다.
			updRowCnt += couponSaleDAO.updateNumMst(rowData);
		}	
*/
		return insRowCnt + updRowCnt;
	}	
}
