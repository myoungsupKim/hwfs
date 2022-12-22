package com.hwfs.sm.sar.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.math.BigDecimal;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Map;
import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.sap.EAIResponse;
import com.hwfs.sc.cmn.sap.request.SuspenseReceiveRequest;
import com.hwfs.sc.cmn.sap.service.EAIService;
import com.hwfs.sm.cmn.dao.AdvanceCommonDAO;
import com.hwfs.sm.cmn.dao.SuspenseCommonDAO;
import com.hwfs.sm.cmn.service.SuspenseCommonService;
import com.hwfs.sm.sar.dao.ArMstProcessDAO;
import com.hwfs.sm.sar.dao.ReceiveMgntPopDAO;
import com.hwfs.sm.sar.dao.SaleCashAlterDAO;
import com.hwfs.sm.ssi.dao.SalesTypeMgntDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 입금처리하는 ReceiveMgntPop Service Implementation
 * 
 * @ClassName ReceiveMgntPopServiceImpl.java
 * @Description ReceiveMgntPopServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.16    김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.04.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/sar/receiveMgntPopService")
public class ReceiveMgntPopServiceImpl extends DefaultServiceImpl implements ReceiveMgntPopService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** ReceiveMgntPopDAO Bean 생성 */
	@Resource(name = "/sm/sar/receiveMgntPopDAO")
	private ReceiveMgntPopDAO receiveMgntPopDAO;
	
	/** ArMstProcessDAO Bean 생성 */
	@Resource(name = "/sm/sar/arMstProcessDAO")
	private ArMstProcessDAO arMstProcessDAO;
	
	/** SuspenseCommonDAO Bean 생성 */
	@Resource(name = "/sm/cmn/suspenseCommonDAO")
	private SuspenseCommonDAO suspenseCommonDAO;
	
	/** SuspenseCommonService Bean 생성 */
	@Resource(name = "/sm/cmn/suspenseCommonService")
	private SuspenseCommonService suspenseCommonService;
	
	/** AdvanceCommonDAO Bean 생성 */
	@Resource(name = "/sm/cmn/advanceCommonDAO")
	private AdvanceCommonDAO advanceCommonDAO;
	
	/** SaleCashAlterDAO Bean 생성 */
	@Resource(name = "/sm/sar/saleCashAlterDAO")
	private SaleCashAlterDAO saleCashAlterDAO;
	
	/** SalesTypeMgntDAO Bean 생성 */
	@Resource(name = "/sm/ssi/salesTypeMgntDAO")
	private SalesTypeMgntDAO salesTypeMgntDAO;

	@Resource(name = "EAIService")
	EAIService eaiService;
	
	/**
	 * 입금처리 목록을 조회한다.
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
		return receiveMgntPopDAO.selectList(mapParam);
	}

	/**
	 * 입금처리 상세 목록을 조회한다.
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
	public RecordSet selectDetail(Map<String, Object> mapParam) throws Exception {
		return receiveMgntPopDAO.selectDetail(mapParam);
	}
	
	/**
	 * 입금수단을 조회한다.
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
	public RecordSet selectReceiveWayList(Map<String, Object> mapParam) throws Exception {
		return receiveMgntPopDAO.selectReceiveWayList(mapParam);
	}

	/**
	 * 공제사항 목록을 조회한다.
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
	public RecordSet selectDeduc(Map<String, Object> mapParam) throws Exception {
		return receiveMgntPopDAO.selectDeduc(mapParam);
	}


	/**
	 * 입금처리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap listAr, DataSetMap receiveData, DataSetMap listDeduc, DataSetMap listSuspense, DataSetMap listAdvance, DataSetMap advanceData, DataSetMap cardData) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String maxReceiveNum="";
		String maxArNum="";
		String maxSalesCashNum = "";   //현금의 경우 영업현금발생
		
		//입금 처리 등록
		Map<String, Object> rowReceiveData = receiveData.get(0);
		
		/*
		 * 입금 수단은 Dataset을 하나 더 만들어서 처리할것...가수 계좌 다건 존재.(입금처리화면에서는 가수금계좌 다건 선택으로 계좌번호는 못보여줌)
		 * 
		*/
		
		//생성인지 수정인지 조건 체크
		if(rowReceiveData.get("receiveNum").toString().isEmpty()){
			//입금처리 번호 생성(max값)
			maxReceiveNum =  receiveMgntPopDAO.selectMaxReceiveNum(rowReceiveData);
			rowReceiveData.put("receiveNum", maxReceiveNum);
			//수정 처리
			insRowCnt += receiveMgntPopDAO.insertMst(rowReceiveData);
			//입금유형이 가수금(B02),어음입금(B13),선수금(B10),카드결제(B15),선수금(사업장)(B19)가 아니면 입금 수단 등록하자
			if (!"B02".equals(rowReceiveData.get("receiveTypeCd")) && !"B10".equals(rowReceiveData.get("receiveTypeCd")) && !"B15".equals(rowReceiveData.get("receiveTypeCd")) 
				&& !"B13".equals(rowReceiveData.get("receiveTypeCd")) && !"B11".equals(rowReceiveData.get("receiveTypeCd")) && !"B19".equals(rowReceiveData.get("receiveTypeCd"))){
				insRowCnt += receiveMgntPopDAO.insertReceiveWay(rowReceiveData);
			}
			
			//현금인 경우는 영업현금 발생
			if ("B18".equals(rowReceiveData.get("receiveTypeCd"))){
				rowReceiveData.put("occurDate", rowReceiveData.get("receiveDate"));         //발생일자
                maxSalesCashNum = saleCashAlterDAO.selectMaxSalesCashNum(rowReceiveData);
				
                rowReceiveData.put("maxSalesCashNum", maxSalesCashNum);
                rowReceiveData.put("acctCd", listAr.getMapValue(0, "acctCd"));
                rowReceiveData.put("occurAmt", rowReceiveData.get("receiveAmt"));
                rowReceiveData.put("modifySalsYn", "N");               //데이타구분 "N" :정상분  "Y":조정분
                rowReceiveData.put("dealType"    , "3");               //거래유형 "1":정상매출분 "2":선수금입금 "3":후불입금 "4":쿠폰판매분 "5":MEMBER가입 "6":식권판매
                rowReceiveData.put("dataClass"   , "C");               //자동수기구분  "C":자동  "A":수기발생
                rowReceiveData.put("cashOccurClass"   , "CH05");               //자동수기구분  "C":자동  "A":수기발생
				insRowCnt += saleCashAlterDAO.insertSaleCash(rowReceiveData);
			}
		}else{
			//수정 처리
			maxReceiveNum = rowReceiveData.get("receiveNum").toString();
			insRowCnt += receiveMgntPopDAO.updateMst(rowReceiveData);
			
			//입금유형이 가수금(B02),선수금(B10),카드결제(B15)가 아니면 입금 수단 수정하자
			if (!"B02".equals(rowReceiveData.get("receiveTypeCd")) && !"B10".equals(rowReceiveData.get("receiveTypeCd")) && !"B15".equals(rowReceiveData.get("receiveTypeCd")) 
				&& !"B13".equals(rowReceiveData.get("receiveTypeCd")) && !"B11".equals(rowReceiveData.get("receiveTypeCd"))){
				updRowCnt += receiveMgntPopDAO.updateReceiveWay(rowReceiveData);
			}
			
			//입금유형이 현금인경우 영업현금발생 업데이트 처리한다
			if ("B18".equals(rowReceiveData.get("receiveTypeCd"))){
				rowReceiveData.put("occurAmt", rowReceiveData.get("receiveAmt"));
				updRowCnt += saleCashAlterDAO.updateSaleCashReceive(rowReceiveData);
			}
		}
		
		//입금유형에 따른 입금수단 저장
		if ("B02".equals(rowReceiveData.get("receiveTypeCd")) || "B13".equals(rowReceiveData.get("receiveTypeCd"))){
			if (!rowReceiveData.get("receiveNum").toString().isEmpty()){
				delRowCnt += receiveMgntPopDAO.deleteReceiveWay(rowReceiveData);
			}
			
			//입금수단 저장 및 업데이트
			for (int i = 0 ; i < listSuspense.size() ; i++){
				Map<String, Object> rowDataSuspense = listSuspense.get(i);
				rowDataSuspense.put("receiveTypeCd",rowReceiveData.get("receiveTypeCd"));
				rowDataSuspense.put("imnoCrgleftNum",rowDataSuspense.get("bankAcctNo"));
				rowDataSuspense.put("suspenseDate",rowDataSuspense.get("receiveDate"));
				rowDataSuspense.put("imnoReceiveSeq",rowDataSuspense.get("altSeq"));
				rowDataSuspense.put("imnoAltNum",rowDataSuspense.get("altNum"));
				rowDataSuspense.put("receiveAmt",rowDataSuspense.get("applyAmt"));
				
				if (rowReceiveData.get("receiveNum").toString().isEmpty()){
					//Mst 정보에서 생성한 입금처리번호 가져옴
					rowDataSuspense.put("receiveNum", maxReceiveNum);
					insRowCnt += receiveMgntPopDAO.insertReceiveWay(rowDataSuspense);
				} else {
					maxReceiveNum = rowReceiveData.get("receiveNum").toString();
					rowDataSuspense.put("receiveNum", maxReceiveNum);
					
					//입금 수단
					insRowCnt += receiveMgntPopDAO.insertReceiveWay(rowDataSuspense);
				}
			}
			//가수금 대체처리
			//int processCnt = suspenseCommonService.setSuspenseAltProc(listSuspense);
			Map<String,Object> mapData = new HashMap<String,Object>();
			mapData = this.setSuspenseAltProc(listSuspense);
			
			//입금번호 셋팅
			mapData.put("receiveNum", maxReceiveNum);
			
			//가수금 대체번호 업데이트
			insRowCnt += receiveMgntPopDAO.updateMstAtlNum(mapData);
			
			//입금수단 가수금대체번호 업데이트
			insRowCnt += receiveMgntPopDAO.updateReceiveWayAtlNum(mapData);
		//선수금 처리 선수금(선매출)B10 , 계약이행예치금(B11) , 선수금(사업장) B19
		} else if ("B10".equals(rowReceiveData.get("receiveTypeCd")) || "B11".equals(rowReceiveData.get("receiveTypeCd")) || "B19".equals(rowReceiveData.get("receiveTypeCd"))){
			if(rowReceiveData.get("receiveNum").toString().isEmpty()){
				insRowCnt += receiveMgntPopDAO.insertReceiveWay(rowReceiveData);
			}else{
				updRowCnt += receiveMgntPopDAO.updateReceiveWay(rowReceiveData);
			}
			
			//선수금 대체처리
			int altMstInsertCnt = 0;	//선수금대체마스터 등록 건수
			int altMstUpdateCnt = 0;	//선수금대체마스터 수정 건수
			int altDtlInsertCnt = 0;	//선수금대체디테일 등록 건수
			int altDtlUpdateCnt = 0;	//선수금대체디테일 수정 건수
			int altDtlDeleteCnt = 0;	//선수금대체디테일 삭제 건수
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
				
			//선수금대체 마스터정보 변경	
			}else if("UPDATE".equals(sRowStatusMst)){
				sMaxAtlNum = rowDataMst.get("altNum").toString();
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
				

				rowDataDtl.put("receiveNum", maxReceiveNum);	//신규 입금번호
				
				//선수금대체 디테일정보 등록(적용금액을 입력했을 경우)
				//if("INSERT".equals(sRowStatusDtl) && iApplyAmt > 0){
				//선수금대체 디테일정보 등록(적용금액을 마이너스로 입력했을 경우) 2018.02.14 김호석 추가(김현녕 대리 요청)
				if("INSERT".equals(sRowStatusDtl)){
					rowDataDtl.put("altNum", sMaxAtlNum);	//신규 선수금대체번호
					
					altDtlInsertCnt += advanceCommonDAO.insertAdvanceAltDtl(rowDataDtl);
				}
				
				//선수금대체 디테일정보 변경
				if("UPDATE".equals(sRowStatusDtl)){
					altDtlUpdateCnt += advanceCommonDAO.updateAdvanceAltDtl(rowDataDtl);
				}
				
				//선수금 대체디테일정보 삭제(단건 대체취소 (ApplyAmt = 0))
				if("DELETE".equals(sRowStatusDtl) && iApplyAmt == 0){
					altDtlDeleteCnt += advanceCommonDAO.deleteAdvanceAltDtl(rowDataDtl);
				}
				
				//선수금 마스터정보 변경
				advMstUpdateCnt += advanceCommonDAO.updateAdvanceApplyAmtProc(rowDataDtl);
				
				
				Map<String,Object> mapDataAdvance = new HashMap<String,Object>();
				//입금번호 셋팅
				mapDataAdvance.put("atlNum", sMaxAtlNum);
				mapDataAdvance.put("receiveNum", maxReceiveNum);
				
				//선수금 대체번호 업데이트
				altDtlUpdateCnt += receiveMgntPopDAO.updateMstAtlNum(mapDataAdvance);
			}
		//신용카드결제 처리
		} else if ("B15".equals(rowReceiveData.get("receiveTypeCd"))){
			Map<String, Object> rowDataCard = cardData.get(0);
			String receiveCustCd = "";         //입금데이타의 거래처코드
			String cardCustCd    = "";         //매입사의 거래처코드
			
			receiveCustCd = (String)rowReceiveData.get("custCd");
			cardCustCd    = (String)rowDataCard.get("custCd");
			
			if("INSERT".equals(rowDataCard.get("rowStatus"))){
				//채권발생
				rowReceiveData.put("occurDate", rowReceiveData.get("receiveDate"));   //발생일자
				maxArNum  = arMstProcessDAO.selectMaxArNum(rowReceiveData);
				
				rowReceiveData.put("arNum", maxArNum);     //채권번호
				rowReceiveData.put("fiscalDate", rowReceiveData.get("receiveDate"));   //회계일자
				rowReceiveData.put("arOccurClass", "AO07");   //채권발생구분
				rowReceiveData.put("arTypeCd", "A03");     //채권유형코드
				//rowReceiveData.put("acctCd", "11204011");  //계정코드
				
				//영업유형 을(를) 조회한다.(계정코드 가져오자)
				Map<String,Object> mapData = new HashMap<String,Object>();
				
				mapData.put("typeGrpCdDtl", "001");
				mapData.put("typeCd", rowReceiveData.get("arTypeCd"));
				RecordSet rs = salesTypeMgntDAO.selectDtlList(mapData);
				
				for (int i = 0; i < rs.size(); i++){
					mapData.put("acctCd", rs.get(i).get("acctCd"));
				}
				rowReceiveData.put("acctCd", mapData.get("acctCd"));    //계정코드 셋팅
				
				rowReceiveData.put("arAmt", rowReceiveData.get("arWithdrawAmt"));  //채권금액
				rowReceiveData.put("custCd", cardCustCd);           //신용카드결제인경우 매입사의
				rowReceiveData.put("recdStatus", "L");     //레코드상태
				insRowCnt += arMstProcessDAO.insert(rowReceiveData);
				
				//입금수단 발생
				rowDataCard.put("receiveNum", maxReceiveNum);
				rowDataCard.put("arNum", maxArNum);
				rowDataCard.put("custCd", receiveCustCd);
				
				insRowCnt += receiveMgntPopDAO.insertReceiveWay(rowDataCard);
			}else{
				//채권 수정
				rowReceiveData.put("arNum", rowDataCard.get("arNum"));
				rowReceiveData.put("arAmt", rowReceiveData.get("arWithdrawAmt"));
				
				updRowCnt += arMstProcessDAO.update(rowReceiveData);
				//입금수단 수정
				maxReceiveNum = rowReceiveData.get("receiveNum").toString();
				rowDataCard.put("receiveNum", maxReceiveNum);
				
				updRowCnt += receiveMgntPopDAO.updateReceiveWay(rowDataCard);
			}
		} 
		//else {
			/*if(rowReceiveData.get("receiveNum").toString().isEmpty()){
				insRowCnt += receiveMgntPopDAO.insertReceiveWay(rowReceiveData);
			}else{
				updRowCnt += receiveMgntPopDAO.updateReceiveWay(rowReceiveData);
			}
		}*/
		
		//입금 채권 상세 목록
		for (int i = 0 ; i < listAr.size() ; i++) {
			Map<String, Object> rowData = listAr.get(i);
			

			if (rowData.get("arAltNum").toString().equals("0")){
				//입금액이 값이 있는 것들만 insert
				if (!rowData.get("receiveAmt").toString().equals("0")){
					//입금 처리 상세 Insert 처리
					rowData.put("receiveNum", maxReceiveNum);
					rowData.put("receiveDate", rowReceiveData.get("receiveDate"));
					rowData.put("remarks", rowReceiveData.get("remark"));
					rowData.put("batchId", rowReceiveData.get("batchId"));
					rowData.put("receiveTypeCd", rowReceiveData.get("receiveTypeCd"));		//유형에 CC가 물려 있으면 그 CC로 업데이트한다 : 김명호(2015-09-25)
					rowData.put("recdStatus", "L");
					
					insRowCnt += receiveMgntPopDAO.insertDetail(rowData);
					
					//채권마스터 입금 처리 업데이트
					updRowCnt += arMstProcessDAO.updateReceive(rowData);
				}
			}else{
				//입금 처리 상세 UPDATE 처리
				if(rowData.get("receiveAmt").toString().equals("0")) {	//입금처리액을 0으로 만들었을 경우 삭제처리한다
					rowData.put("recdStatus", "D");			
					rowData.put("batchId", "");
					updRowCnt += receiveMgntPopDAO.deleteDetail(rowData);
				}else{
					rowData.put("recdStatus", "L");					
					rowData.put("remarks", rowReceiveData.get("remark"));
					rowData.put("batchId", rowReceiveData.get("batchId"));
					updRowCnt += receiveMgntPopDAO.updateDetail(rowData);
				}
				
				//채권마스터 입금 처리 업데이트
				updRowCnt += arMstProcessDAO.updateReceive(rowData);
			}				
			
			//채권마스터 입금 처리 업데이트
			//updRowCnt += arMstProcessDAO.updateReceive(rowData);
			
		}
		
		//공제 항목
		for (int i = 0 ; i < listDeduc.size() ; i++) {
			Map<String, Object> rowDataDeduc = listDeduc.get(i);
			

			if (rowDataDeduc.get("receiveNum").toString().equals("0")){
				//입금 처리 상세 Insert 처리
				rowDataDeduc.put("receiveNum", maxReceiveNum);
				rowDataDeduc.put("recdStatus", "L");
				
				insRowCnt += receiveMgntPopDAO.insertDeduc(rowDataDeduc);
				
			}else{
				//공제사항 UPDATE 처리
				int rowType = ((Integer)rowDataDeduc.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
				if (rowType == DataSet.ROW_TYPE_DELETED) {
					delRowCnt += receiveMgntPopDAO.deleteDeduc(rowDataDeduc);
				}else{
					updRowCnt += receiveMgntPopDAO.updateDeduc(rowDataDeduc);
				}
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 입금처리 DataSetMap의 데이터를 rowType에 따라 취소 처리한다.
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
	public int cancleList(DataSetMap list, DataSetMap receiveData, DataSetMap listDeduc, DataSetMap listSuspense, DataSetMap listAdvance, DataSetMap advanceData, DataSetMap cardData) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		int rowCnt	= 0;
		int iApplyAmt = 0;
		
		//입금 처리 등록
		Map<String, Object> rowReceiveData = receiveData.get(0);

		//취소 처리
		delRowCnt += receiveMgntPopDAO.cancleMst(rowReceiveData);
		delRowCnt += receiveMgntPopDAO.cancleReceiveWay(rowReceiveData);
		delRowCnt += receiveMgntPopDAO.cancleDeduc(rowReceiveData);			
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			if (!rowData.get("arAltNum").toString().equals("0")){
				//취소 처리
				delRowCnt += receiveMgntPopDAO.cancleDetail(rowData);
					
	
				//채권마스터 입금 처리 업데이트
				updRowCnt += arMstProcessDAO.updateReceive(rowData);
			}
		}
		
		if ("B02".equals(rowReceiveData.get("receiveTypeCd")) || "B13".equals(rowReceiveData.get("receiveTypeCd"))){
			//가수금 대체취소처리
			updRowCnt += suspenseCommonService.setSuspenseAltCancel(listSuspense);
		} else if ("B10".equals(rowReceiveData.get("receiveTypeCd")) || "B11".equals(rowReceiveData.get("receiveTypeCd")) || "B19".equals(rowReceiveData.get("receiveTypeCd"))){
			//선수금 대체취소처리

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
				//if(iApplyAmt > 0) rowCnt += advanceCommonDAO.cancelAdvanceAltDetail(rowDataDtl);
				//마이너스 입금처리 시 처리 필요 20180406 추가 김호석
				rowCnt += advanceCommonDAO.cancelAdvanceAltDetail(rowDataDtl);

				//선수금 마스터정보 변경
				rowCnt += advanceCommonDAO.updateAdvanceApplyAmtProc(rowDataDtl);
				
			}
		} else if ("B15".equals(rowReceiveData.get("receiveTypeCd"))){
			Map<String, Object> rowCardData = cardData.get(0);
			delRowCnt += arMstProcessDAO.cancelArMst(rowCardData);
		} else if ("B18".equals(rowReceiveData.get("receiveTypeCd"))){
			//현금인 경우 영업현금발생 취소 처리한다
			delRowCnt += saleCashAlterDAO.cancelSaleCashReceive(rowReceiveData);
		}
		return insRowCnt + updRowCnt + delRowCnt + rowCnt;
	}
	
	/**
	 * 입금처리 DataSetMap의 데이터를 rowType에 따라 처리한다.
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
	public Map<String,Object> setSuspenseAltProc(DataSetMap list) throws Exception {
		Map<String,Object> reMapData = new HashMap<String,Object>();
		int rowCnt 			= 0;	//건수
		int iApplyAmt		= 0;	//적용금액
//		int eaiCnt			= 0;
		String newCc 	    = "";
		
		String sRowStatus	= "";	//디테일 상태
		String sAtlNum		= "";	//가수금 대체번호
		String sMaxAtlNum	= "";	//신규 가수금 대체번호
		int sFirstSnum		= 0;	//신규 가수금이 없을경우 처리
		
		long time = System.currentTimeMillis();
		
		SimpleDateFormat sDay = new SimpleDateFormat("yyyymmdd", java.util.Locale.getDefault());
		SimpleDateFormat sTime = new SimpleDateFormat("HHmmss", java.util.Locale.getDefault());
		
		String strDay = com.hwfs.sc.cmn.util.DateUtil.getYyyymmdd();//sDay.format(new Date(time));
		String strTime = sTime.format(new Date(time));
		
		
		/************************************************************************************************
		 * 가수금 대체 디테일 등록/수정/삭제, 가수금 마스터정보 변경
		************************************************************************************************/
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			//상태
			if(rowData.get("rowStatus") == null) sRowStatus = "";
			else sRowStatus = rowData.get("rowStatus").toString();
			
			//적용금액
			if(rowData.get("applyAmt") == null) iApplyAmt = 0;
			else iApplyAmt = Integer.parseInt(rowData.get("applyAmt").toString());

			//가수금대체번호
			if(rowData.get("altNum") == null) sAtlNum = "";
			else sAtlNum = rowData.get("altNum").toString();
							
			//가수금대체 디테일정보 등록(적용금액을 입력했을 경우)
			String sabun = suspenseCommonDAO.selectSabun(rowData);
			
			if("INSERT".equals(sRowStatus) && iApplyAmt > 0){

				//가수금 대체번호 채번(신규일 경우 채번)
				if(sMaxAtlNum.isEmpty()){
					sMaxAtlNum = suspenseCommonDAO.getMaxAtlNum(list.get(i));
					sFirstSnum = i;
				}
				
				if("".equals(sAtlNum)) rowData.put("altNum", sMaxAtlNum);	//신규 가수금대체번호
				
				//순번 체크
				int altSeq = suspenseCommonDAO.selectAltSeq(rowData);
				
				rowData.put("altSeq", altSeq);	
				
				rowCnt += suspenseCommonDAO.insertSuspenseAltDtl(rowData);
				
				/************************************************************************************************
				 * SAP IFC 가수금 입금 반제 Start
				************************************************************************************************/
				
				SuspenseReceiveRequest dto = new SuspenseReceiveRequest();
				
				if (rowData.containsKey("buCd")) {
					//외식사업부 BU,MU,CC 맵핑 변경 20200131 김호석
					if (rowData.get("muCd").equals("2003")) {
						dto.setBuCd("1000");						
					} else {
						dto.setBuCd(rowData.get("buCd").toString().trim());
					}
				}
				
				if (rowData.containsKey("sapSuspenseNum"))
					dto.setSapSuspenseNum(rowData.get("sapSuspenseNum").toString().trim());
				
				//if (rowData.containsKey("seq"))
				dto.setSeq(Integer.parseInt(rowData.get("altSeq").toString()));
				
				//if (rowData.containsKey("sabun"))
				dto.setAltProcUser(sabun.toString().trim());
				
				if (rowData.containsKey("applyAmt"))
					dto.setAmt((BigDecimal) rowData.get("applyAmt"));

				if (rowData.containsKey("ccCd")) {
					//외식사업부 BU,MU,CC 맵핑 변경 20200131 김호석
					if (rowData.get("muCd").equals("2003")) {
						//구 cc 검색해서 가져오기 
						newCc = suspenseCommonDAO.selectCc(rowData);
						dto.setCcCd(newCc);
					} else {
						dto.setCcCd(rowData.get("ccCd").toString().trim());
					}					
				}
				
				if (rowData.containsKey("altDate"))
					dto.setAltDate(rowData.get("altDate").toString().trim());
				
				if (rowData.containsKey("sapCustCd"))
					dto.setSapCustCd(rowData.get("sapCustCd").toString().trim());
				
				dto.setAltProcDate(strDay);
				dto.setAltProcTime(strTime);
				dto.setCurrency("KRW");
				dto.setAltSlipNum(" ");
				dto.setReqType("1");
				eaiService.call(dto);
//				EAIResponse res = eaiService.call(dto);
//				
//				if (res.isSuccess()) {
//					eaiCnt++;
//				}
				/************************************************************************************************
				 * SAP IFC 가수금 입금 반제 End
				************************************************************************************************/
			}
			
			//가수금대체 디테일정보 변경
			if("UPDATE".equals(sRowStatus)){
				rowCnt += suspenseCommonDAO.updateSuspenseAltDtl(rowData);
				
				/************************************************************************************************
				 * SAP IFC 가수금 입금 반제/취소 Strat
				************************************************************************************************/
				SuspenseReceiveRequest dto1 = new SuspenseReceiveRequest();	//반제
				SuspenseReceiveRequest dto2 = new SuspenseReceiveRequest();	//반제취소
				
				if (rowData.containsKey("buCd")) {
					//외식사업부 BU,MU,CC 맵핑 변경 20200131 김호석
					if (rowData.get("muCd").equals("2003")) {
						dto2.setBuCd("1000");						
					} else {
						dto2.setBuCd(rowData.get("buCd").toString().trim());
					}
				}
				
				if (rowData.containsKey("sapSuspenseNum"))
					dto2.setSapSuspenseNum(rowData.get("sapSuspenseNum").toString().trim());
				
				//if (rowData.containsKey("seq"))
				dto2.setSeq(Integer.parseInt(rowData.get("altSeq").toString()));
				
				//if (rowData.containsKey("sabun"))
				dto2.setAltProcUser(sabun.toString().trim());
				
				if (rowData.containsKey("applyAmtOrg"))
					dto2.setAmt((BigDecimal) rowData.get("applyAmtOrg"));
				
				if (rowData.containsKey("ccCd")) {
					//외식사업부 BU,MU,CC 맵핑 변경 20200131 김호석
					if (rowData.get("muCd").equals("2003")) {
						//구 cc 검색해서 가져오기 
						newCc = suspenseCommonDAO.selectCc(rowData);
						dto2.setCcCd(newCc);
					} else {
						dto2.setCcCd(rowData.get("ccCd").toString().trim());
					}					
				}
				
				if (rowData.containsKey("altDate"))
					dto2.setAltDate(rowData.get("altDate").toString().trim());
				
				if (rowData.containsKey("sapCustCd"))
					dto2.setSapCustCd(rowData.get("sapCustCd").toString().trim());

				dto2.setAltProcDate(strDay);
				dto2.setAltProcTime(strTime);
				dto2.setCurrency("KRW");
				dto2.setAltSlipNum(" ");
				dto2.setReqType("2");
				eaiService.call(dto2);
//				EAIResponse res2 = eaiService.call(dto2);
//
//				if (res2.isSuccess()) {
//					eaiCnt++;
//				}
				
				if (rowData.containsKey("buCd")) {
					//외식사업부 BU,MU,CC 맵핑 변경 20200131 김호석
					if (rowData.get("muCd").equals("2003")) {
						dto1.setBuCd("1000");						
					} else {
						dto1.setBuCd(rowData.get("buCd").toString().trim());
					}
				}
				
				if (rowData.containsKey("sapSuspenseNum"))
					dto1.setSapSuspenseNum(rowData.get("sapSuspenseNum").toString().trim());
				
				//if (rowData.containsKey("seq"))
				dto1.setSeq(Integer.parseInt(rowData.get("altSeq").toString()));
				
				//if (rowData.containsKey("sabun"))
				dto1.setAltProcUser(sabun.toString().trim());
				
				if (rowData.containsKey("applyAmt"))
					dto1.setAmt((BigDecimal) rowData.get("applyAmt"));

				if (rowData.containsKey("ccCd")) {
					//외식사업부 BU,MU,CC 맵핑 변경 20200131 김호석
					if (rowData.get("muCd").equals("2003")) {
						//구 cc 검색해서 가져오기 
						newCc = suspenseCommonDAO.selectCc(rowData);
						dto1.setCcCd(newCc);
					} else {
						dto1.setCcCd(rowData.get("ccCd").toString().trim());
					}					
				}

				if (rowData.containsKey("altDate"))
					dto1.setAltDate(rowData.get("altDate").toString().trim());
				
				if (rowData.containsKey("sapCustCd"))
					dto1.setSapCustCd(rowData.get("sapCustCd").toString().trim());

				dto1.setAltProcDate(strDay);
				dto1.setAltProcTime(strTime);
				dto1.setCurrency("KRW");
				dto1.setAltSlipNum(" ");
				dto1.setReqType("1");
				eaiService.call(dto1);
//				EAIResponse res1 = eaiService.call(dto1);
//				
//				if (res1.isSuccess()) {
//					eaiCnt++;
//				}
				
				/************************************************************************************************
				 * SAP IFC 가수금 입금 반제/취소 End
				************************************************************************************************/
			}
			
			//가수금 대체디테일정보 삭제(단건 대체취소 (ApplyAmt = 0))
			if("DELETE".equals(sRowStatus) && iApplyAmt == 0){
				rowCnt += suspenseCommonDAO.deleteSuspenseAltDtl(rowData);
				
				/************************************************************************************************
				 * SAP IFC 가수금 입금 반제취소 Strat
				************************************************************************************************/
				SuspenseReceiveRequest dto = new SuspenseReceiveRequest();	//반제취소

				if (rowData.containsKey("buCd")) {
					//외식사업부 BU,MU,CC 맵핑 변경 20200131 김호석
					if (rowData.get("muCd").equals("2003")) {
						dto.setBuCd("1000");						
					} else {
						dto.setBuCd(rowData.get("buCd").toString().trim());
					}
				}
				
				if (rowData.containsKey("sapSuspenseNum"))
					dto.setSapSuspenseNum(rowData.get("sapSuspenseNum").toString().trim());
				
				//if (rowData.containsKey("seq"))
				dto.setSeq(Integer.parseInt(rowData.get("altSeq").toString()));
				
				//if (rowData.containsKey("sabun"))
				dto.setAltProcUser(sabun.toString().trim());
				
				if (rowData.containsKey("applyAmtOrg"))
					dto.setAmt((BigDecimal) rowData.get("applyAmtOrg"));
				
				if (rowData.containsKey("ccCd")) {
					//외식사업부 BU,MU,CC 맵핑 변경 20200131 김호석
					if (rowData.get("muCd").equals("2003")) {
						//구 cc 검색해서 가져오기 
						newCc = suspenseCommonDAO.selectCc(rowData);
						dto.setCcCd(newCc);
					} else {
						dto.setCcCd(rowData.get("ccCd").toString().trim());
					}					
				}

				if (rowData.containsKey("altDate"))
					dto.setAltDate(rowData.get("altDate").toString().trim());
				
				if (rowData.containsKey("sapCustCd"))
					dto.setSapCustCd(rowData.get("sapCustCd").toString().trim());

				dto.setAltProcDate(strDay);
				dto.setAltProcTime(strTime);
				dto.setCurrency("KRW");
				dto.setAltSlipNum(" ");
				dto.setReqType("2");
				eaiService.call(dto);
//				EAIResponse res2 = eaiService.call(dto);
//
//				if (res2.isSuccess()) {
//					eaiCnt++;
//				}
				/************************************************************************************************
				 * SAP IFC 가수금 입금 반제취소 End
				************************************************************************************************/				
			}
			
			//가수금 마스터정보 변경
			//rowCnt += suspenseCommonDAO.updateSuspenseApplyAmtProc(rowData);
		}

		/************************************************************************************************
		 * 상태 - 가수금 대체 마스터 정보 상태값
		************************************************************************************************/
		Map<String, Object> rowDataMst = list.get(0);
		
		if(rowDataMst.get("rowStatus") == null) sRowStatus = "";
		else sRowStatus = rowDataMst.get("rowStatus").toString();

		/************************************************************************************************
		 * 가수금 대체 마스터정보 등록/수정
		************************************************************************************************/
		//가수금 대체 마스터 등록
		if("INSERT".equals(sRowStatus)){

			rowDataMst.put("altNum", sMaxAtlNum);	//신규 가수금대체번호
			rowCnt = suspenseCommonDAO.insertSuspenseAltMst(rowDataMst);
			
			reMapData.put("atlNum", sMaxAtlNum);
			
		//가수금대체 마스터정보 변경	
		}else if("UPDATE".equals(sRowStatus)){
			rowCnt = suspenseCommonDAO.updateSuspenseAltMst(rowDataMst);
			
			reMapData.put("atlNum", sAtlNum);
		}
		
		reMapData.put("rowCnt", rowCnt);
		//reMapData.put("atlNum", sMaxAtlNum);
		
		return reMapData;
	}
	
	/**
	 * 수수료금액을 들고온다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectCharge(DataSetMap data) throws Exception {
		Map<String, Object> mapParam = data.get(0);
		return receiveMgntPopDAO.selectCharge(mapParam);
	}
	
}
