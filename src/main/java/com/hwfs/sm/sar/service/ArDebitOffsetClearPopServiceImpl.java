package com.hwfs.sm.sar.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.cmn.dao.AdvanceCommonDAO;
import com.hwfs.sm.cmn.dao.CommonDAO;
import com.hwfs.sm.cmn.service.AdvanceCommonService;
import com.hwfs.sm.sar.dao.ArDebitOffsetClearPopDAO;
import com.hwfs.sm.sar.dao.ArMstProcessDAO;
import com.hwfs.sm.sar.dao.ReceiveMgntPopDAO;

 /**
 * 채권채무 상계처리하는 ArDebitOffsetClearPop Service Implementation
 * 
 * @ClassName ArDebitOffsetClearPopServiceImpl.java
 * @Description ArDebitOffsetClearPopServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.27    김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.04.27
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/sar/arDebitOffsetClearPopService")
public class ArDebitOffsetClearPopServiceImpl extends DefaultServiceImpl implements ArDebitOffsetClearPopService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** ArDebitOffsetClearPopDAO Bean 생성 */
	@Resource(name = "/sm/sar/arDebitOffsetClearPopDAO")
	private ArDebitOffsetClearPopDAO arDebitOffsetClearPopDAO;
	
	/** ReceiveMgntPopDAO Bean 생성 */
	@Resource(name = "/sm/sar/receiveMgntPopDAO")
	private ReceiveMgntPopDAO receiveMgntPopDAO;
	
	/** ArMstProcessDAO Bean 생성 */
	@Resource(name = "/sm/sar/arMstProcessDAO")
	private ArMstProcessDAO arMstProcessDAO;

	/** AdvanceCommonDAO Bean 생성 */
	@Resource(name = "/sm/cmn/advanceCommonDAO")
	private AdvanceCommonDAO advanceCommonDAO;


	/**
	 * 채권채무 상계처리 목록을 조회한다.
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
		return arDebitOffsetClearPopDAO.selectList(mapParam);
	}

	/**
	 * 채권채무 상계처리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param listAr
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap listAr, DataSetMap receiveData, DataSetMap listAdvance, DataSetMap advanceData) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		/************************************************************************************************
		 * 입금 마스터 정보 등록/수정
		************************************************************************************************/
		//입금 마스터 번호 생성
		String maxReceiveNum="";
		//입금 처리 등록
		Map<String, Object> rowReceiveData = receiveData.get(0);
		
		//생성인지 수정인지 조건 체크	
		if(rowReceiveData.get("receiveNum").toString().isEmpty()){
			//입금처리 번호 생성(max값)
			maxReceiveNum =  receiveMgntPopDAO.selectMaxReceiveNum(rowReceiveData);
			rowReceiveData.put("receiveNum", maxReceiveNum);
			//수정 처리
			insRowCnt += receiveMgntPopDAO.insertMst(rowReceiveData);
			//입금 수단
			insRowCnt += receiveMgntPopDAO.insertReceiveWay(rowReceiveData);
		}else{
			//수정 처리
			maxReceiveNum = rowReceiveData.get("receiveNum").toString();
			insRowCnt += receiveMgntPopDAO.updateMst(rowReceiveData);	
			//입금 수단
			updRowCnt += receiveMgntPopDAO.updateReceiveWay(rowReceiveData);
		}	
		
		/************************************************************************************************
		 * 선수금 대체 마스터정보 (ds_search) : 대체금액(altAmt) = Sum(applyAmt)
		************************************************************************************************/

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
//		System.out.println("################### listAdvance.size() :"+listAdvance.size());
		
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
			
			//System.out.println("################### listAdvance.size() :"+sMaxAtlNum);
			//선수금대체 디테일정보 등록(적용금액을 입력했을 경우)
			if("INSERT".equals(sRowStatusDtl) && iApplyAmt > 0){
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
		}
		

		/************************************************************************************************
		 * 입금 DETAIL 정보 등록/수정
		************************************************************************************************/
	
		
		for (int i = 0 ; i < listAr.size() ; i++) {
			Map<String, Object> rowData = listAr.get(i);

			if (rowData.get("arAltNum").toString().equals("0")){
				//입금 처리 상세 Insert 처리
				rowData.put("receiveNum", maxReceiveNum);
				rowData.put("receiveDate", rowReceiveData.get("receiveDate"));
				rowData.put("remarks", rowReceiveData.get("remark"));
				rowData.put("batchId", rowReceiveData.get("batchId"));
				rowData.put("recdStatus", "L");
				
				insRowCnt += receiveMgntPopDAO.insertDetail(rowData);
				
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
			}
			
			
			//채권마스터 입금 처리 업데이트
			updRowCnt += arMstProcessDAO.updateReceive(rowData);
			
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}


	/**
	 * 채권채무 상계 취소 처리한다.
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
	public int cancleList(DataSetMap listAr, DataSetMap receiveData, DataSetMap listAdvance, DataSetMap advanceData) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;

		//입금 처리 등록
		Map<String, Object> rowReceiveData = receiveData.get(0);
		

		//취소 처리
		delRowCnt += receiveMgntPopDAO.cancleMst(rowReceiveData);			
		delRowCnt += receiveMgntPopDAO.cancleReceiveWay(rowReceiveData);			
		
		
		for (int i = 0 ; i < listAr.size() ; i++) {
			Map<String, Object> rowData = listAr.get(i);
			if (!rowData.get("arAltNum").toString().equals("0")){
				//취소 처리
				delRowCnt += receiveMgntPopDAO.cancleDetail(rowData);
					
	
				//채권마스터 입금 처리 업데이트
				updRowCnt += arMstProcessDAO.updateReceive(rowData);
			}
			
		}
		
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
//		System.out.println("################### listDtl.size() :"+listDtl.size());
		
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
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
