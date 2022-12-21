package com.hwfs.sm.cmn.service;

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
import com.hwfs.sc.cmn.dao.GwIfDAO;
import com.hwfs.sm.cmn.dao.AdvanceCommonDAO;
import com.hwfs.sm.sar.dao.ArMstProcessDAO;
import com.hwfs.sm.ssi.dao.SalesTypeMgntDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 선수금정보 공통 AdvanceCommon Service Implementation
 * 
 * @ClassName AdvanceCommonServiceImpl.java
 * @Description AdvanceCommonServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.29    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.04.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/cmn/advanceCommonService")
public class AdvanceCommonServiceImpl extends DefaultServiceImpl implements AdvanceCommonService {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	/** AdvanceCommonDAO Bean 생성 */
	@Resource(name = "/sm/cmn/advanceCommonDAO")
	private AdvanceCommonDAO advanceCommonDAO;
	
	/** ArMstProcessDAO Bean 생성 */
	@Resource(name = "/sm/sar/arMstProcessDAO")
	private ArMstProcessDAO arMstProcessDAO;	
	
	/** SalesTypeMgntDAO Bean 생성 */
	@Resource(name = "/sm/ssi/salesTypeMgntDAO")
	private SalesTypeMgntDAO salesTypeMgntDAO;	
	
	/** GwIfDAO Bean 생성 */
	@Resource(name = "/sc/cmn/gwIfDAO")
	private GwIfDAO gwIfDAO;
	
	/**
	 * 선수금정보 조회
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectAdvanceMst(Map<String, Object> mapParam) throws Exception {
		return advanceCommonDAO.selectAdvanceMst(mapParam);
	}
	
	/**
	 * 선수금환불 대상 정보 조회
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectAdvanceRefundMst(Map<String, Object> mapParam) throws Exception {
		return advanceCommonDAO.selectAdvanceRefundMst(mapParam);
	}


	/**
	 * 선수금 대체 정보 조회(조회조건)
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectAdvanceAltMst(Map<String, Object> mapParam) throws Exception {
		return advanceCommonDAO.selectAdvanceAltMst(mapParam);
	}
	
	/**
	 * 선수금 입금수단 조회
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectAdvanceReceiveWay(Map<String, Object> mapParam) throws Exception {
		return advanceCommonDAO.selectAdvanceReceiveWay(mapParam);
	}
	
	/**
	 * 선수금대체처리(이관 포함)
	 * @param list - DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int setAdvanceAltProc(DataSetMap listMst, DataSetMap listDtl) throws Exception {
		
		int altMstInsertCnt = 0;	//선수금대체마스터 등록 건수
		int altMstUpdateCnt = 0;	//선수금대체마스터 수정 건수
		int altDtlInsertCnt = 0;	//선수금대체디테일 등록 건수
		int altDtlUpdateCnt = 0;	//선수금대체디테일 수정 건수
		int altDtlDeleteCnt = 0;	//선수금대체디테일 삭제 건수
		int advMstUpdateCnt = 0;	//선수금마스터 수정 건수
		int acctCdCnt		= 0;	//계정코드 등록 건수
		
		int iApplyAmt		= 0;	//적용금액
		int advTransCnt		= 0;	//거래처/업장이관 건수(선수금마스터 등록건수)

		String sRowStatusMst	= "";	//마스터 상태
		String sRowStatusDtl	= "";	//디테일 상태
		String sAtlNum			= "";	//선수금 대체번호
		String sMaxAtlNum		= "";	//신규 선수금 대체번호
		String sMaxAdvanceNum	= "";	//신규 선수금번호
		String sTransYn			= "";	//이관여부
		String sTypeGrpCd		= "";	//선수금대체구분
		String sAltTypeCd		= "";	//선수금대체유형
		String sAdvanceAtlNum	= "";	//선수금대체번호
		
//		System.out.println("############### setAdvanceAltProc Strat ####################");
		/************************************************************************************************
		 * 선수금 대체 마스터정보 (ds_search) : 대체금액(altAmt) = Sum(applyAmt)
		************************************************************************************************/
		Map<String, Object> rowDataMst = listMst.get(0);
		
		if(rowDataMst.get("rowStatus") != null) sRowStatusMst = rowDataMst.get("rowStatus").toString();	//마스터 상태
		if(rowDataMst.get("typeGrpCd") != null) sTypeGrpCd = rowDataMst.get("typeGrpCd").toString();	//선수금대체구분
		if(rowDataMst.get("altTypeCd") != null) sAltTypeCd = rowDataMst.get("altTypeCd").toString();	//선수금대체유형

		/************************************************************************************************
		 * 선수금 대체 마스터정보 등록/수정
		************************************************************************************************/
		
		//카드 환불일경우 - 금액 채권 생성
		String maxArNum      = "";
		Map<String, Object> rowArData = rowDataMst;		//채권

		//System.out.println("altTypeCd1 :"+rowDataMst.get("altTypeCd"));
		//System.out.println("rowDataMst1 :"+rowDataMst.toString());		
		
		if(("H03").equals(rowDataMst.get("altTypeCd"))){
			
			rowArData.put("occurDate", rowArData.get("altDate"));                //발생일자
			
			maxArNum      = arMstProcessDAO.selectMaxArNum(rowArData);
			rowDataMst.put("custCd", rowArData.get("cardCustCd"));      //카드환불거래처
			rowDataMst.put("custNm", rowArData.get("cardCustNm"));      //카드환불거래처		
			rowDataMst.put("cardArNum", maxArNum);      //카드환불거래처		
		}
		
		//선수금 대체 마스터 등록
		if("INSERT".equals(sRowStatusMst)){

			//선수금 대체번호 채번(신규일 경우 채번)
			sMaxAtlNum = advanceCommonDAO.getMaxAtlNum(listMst.get(0));
			
			rowDataMst.put("altNum", sMaxAtlNum);	//신규 선수금대체번호
			altMstInsertCnt = advanceCommonDAO.insertAdvanceAltMst(rowDataMst);
			
		//선수금대체 마스터정보 변경	
		}else if("UPDATE".equals(sRowStatusMst)){
			altMstUpdateCnt = advanceCommonDAO.updateAdvanceAltMst(rowDataMst);
		}
//		System.out.println("################### listDtl.size() :"+listDtl.size());
		
		/************************************************************************************************
		 * 선수금 대체 디테일 등록/수정/삭제, 선수금 마스터정보 변경
		************************************************************************************************/
		for (int i = 0 ; i < listDtl.size() ; i++) {
			Map<String, Object> rowDataDtl = listDtl.get(i);
			
			if(rowDataDtl.get("rowStatus") != null) sRowStatusDtl = rowDataDtl.get("rowStatus").toString();	//상태
			if(rowDataDtl.get("applyAmt") != null) iApplyAmt = Integer.parseInt(rowDataDtl.get("applyAmt").toString());	//적용금액
			if(rowDataDtl.get("altNum") != null) sAtlNum = rowDataDtl.get("altNum").toString();	//선수금대체번호
			if(rowDataDtl.get("transYn") != null) sTransYn = rowDataDtl.get("transYn").toString();	//이관여부
			if(rowDataDtl.get("advanceAltNum") != null) sAdvanceAtlNum = rowDataDtl.get("advanceAltNum").toString();	//이관여부
			
//			System.out.println("######## ["+i+"] sRowStatusDtl :"+sRowStatusDtl);
//			System.out.println("######## ["+i+"] iApplyAmt :"+iApplyAmt);
//			System.out.println("######## ["+i+"] altNum :"+sAtlNum);
//			System.out.println("######## ["+i+"] transYn :"+sTransYn);
//			System.out.println("######## ["+i+"] sAdvanceAtlNum :"+sAdvanceAtlNum);
			
			/************************************************************************************************
			 * 이관 : 신규 선수금번호를 채번한 후 선수금마스터에 저장한다.(거래처/업장 이관시 사용)
			************************************************************************************************/				
			if("Y".equals(sTransYn)){

				if("INSERT".equals(sRowStatusMst)){

					//신규 선수금번호 채번
					sMaxAdvanceNum = advanceCommonDAO.getMaxAdvanceNum(listDtl.get(i));
					
//					System.out.println("## ["+i+"] sMaxAdvanceNum :"+sMaxAdvanceNum);
					rowDataDtl.put("transAdvanceNum", sMaxAdvanceNum);	//신규 선수금번호
					rowDataDtl.put("refNum", sMaxAtlNum);	//신규 선수금번호

					//거래처/업장 이관(신규 선수금번호 저장)
					advTransCnt += advanceCommonDAO.insertAdvanceMasterTrans(rowDataDtl);
				}else{
					advTransCnt += advanceCommonDAO.updateAdvanceMasterTrans(rowDataDtl);
				}

			}
			
			//계정코드 등록
//			System.out.println("######## ["+i+"] typeGrpCd :"+sTypeGrpCd);
//			System.out.println("######## ["+i+"] altTypeCd :"+sAltTypeCd);
			rowDataDtl.put("typeGrpCd", sTypeGrpCd);
			rowDataDtl.put("altTypeCd", sAltTypeCd);
			
			if(!"".equals(sTypeGrpCd) && !"".equals(sAltTypeCd)){
				rowDataDtl.put("acctCd", null);
			}
			
//			System.out.println("######## ["+i+"] d typeGrpCd :"+rowDataDtl.get("typeGrpCd"));
//			System.out.println("######## ["+i+"] d altTypeCd :"+rowDataDtl.get("altTypeCd"));
//			System.out.println("######## ["+i+"] d acctCd :"+rowDataDtl.get("acctCd"));
			
			//선수금대체 디테일정보 등록(적용금액을 입력했을 경우)
			if("INSERT".equals(sRowStatusDtl) && iApplyAmt > 0){
				if("".equals(sAtlNum)) rowDataDtl.put("altNum", sMaxAtlNum);	//신규 선수금대체번호
				altDtlInsertCnt += advanceCommonDAO.insertAdvanceAltDtl(rowDataDtl);
				//acctCdCnt += advanceCommonDAO.setAcctCd(rowDataDtl);
				//선수금 마스터정보 변경
				advMstUpdateCnt += advanceCommonDAO.updateAdvanceApplyAmtProc(rowDataDtl);
			}
			
			//선수금대체 디테일정보 변경
			if("UPDATE".equals(sRowStatusDtl) && !"".equals(sAdvanceAtlNum)){
//				if(!"".equals(sAdvanceAtlNum)){
					altDtlUpdateCnt += advanceCommonDAO.updateAdvanceAltDtl(rowDataDtl);
//				}
					//선수금 마스터정보 변경
					advMstUpdateCnt += advanceCommonDAO.updateAdvanceApplyAmtProc(rowDataDtl);
					
			}
			
			//선수금 대체디테일정보 삭제(단건 대체취소 (ApplyAmt = 0))
			if("DELETE".equals(sRowStatusDtl) && iApplyAmt == 0){
				altDtlDeleteCnt += advanceCommonDAO.deleteAdvanceAltDtl(rowDataDtl);
			}
			
			//초기화
			sRowStatusDtl 	= "";
			sAtlNum 		= "";
			sTransYn 		= "";
			sAdvanceAtlNum 	= "";
			iApplyAmt 		= 0;			
		}
		
		//카드 환불일경우 - 금액 채권 생성
		if(("H03").equals(rowDataMst.get("altTypeCd"))){
//			Map<String, Object> rowArData = rowDataMst;		//채권
			
//			rowArData.put("occurDate", rowArData.get("altDate"));                //발생일자
			
//			maxArNum      = arMstProcessDAO.selectMaxArNum(rowArData);
			
			rowArData.put("seq", "1");			                                    //지불테이블에 순번
			//rowAddData.put("sysClass", "13");                                       //시스템구분 (식자재)
			rowArData.put("fiscalDate", rowArData.get("altDate"));               //회계일자
			rowArData.put("journalzYn", "N");                                      //분개여부
			
			rowArData.put("arNum", maxArNum);
			rowArData.put("arOccurClass", "AO08");   //채권발생구분  : 신용카드청구
			rowArData.put("arTypeCd", "A03");        //미수금신용카드
			
			//영업유형 을(를) 조회한다.(계정코드 가져오자)
			Map<String,Object> mapData = new HashMap<String,Object>();
			
			mapData.put("typeGrpCdDtl", "001");
			mapData.put("typeCd", rowArData.get("arTypeCd"));
			RecordSet rs = salesTypeMgntDAO.selectDtlList(mapData);
			
			for (int i = 0; i < rs.size(); i++){
				mapData.put("acctCd", rs.get(i).get("acctCd"));
			}
			rowArData.put("acctCd", mapData.get("acctCd"));           //계정코드 셋팅  미수금_신용카드_청구(-)
			rowArData.put("arAmt", Integer.parseInt(rowArData.get("altAmt").toString()) * -1);      //채권금액
			
			rowArData.put("custCd", rowArData.get("cardCustCd"));      //카드환불거래처
			rowArData.put("custNm", rowArData.get("cardCustNm"));      //카드환불거래처				

			rowArData.put("taxShetPublishYn", "N");                   //세금계산서 발행 여부
			rowArData.put("payClassCd", "2");                         //지불 구분 코드
			rowArData.put("billingPublishYn", "N");                   //청구 발행 여부
			
			//채권발생
			altDtlInsertCnt += arMstProcessDAO.insert(rowArData);			
			
		}
		
		
//		System.out.println("############### setAdvanceAltProc End ####################");
		return altMstInsertCnt + altMstUpdateCnt + altDtlInsertCnt + altDtlUpdateCnt + altDtlDeleteCnt + advMstUpdateCnt + advTransCnt + acctCdCnt;
	} 
	

	/**
	 * 선수금대체처리(이관전 등록)
	 * @param list - DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int setAdvanceAltProcReq(DataSetMap listMst, DataSetMap listDtl) throws Exception {
		
		int altMstInsertCnt = 0;	//선수금대체마스터 등록 건수
		int altMstUpdateCnt = 0;	//선수금대체마스터 수정 건수
		int altDtlInsertCnt = 0;	//선수금대체디테일 등록 건수
		int altDtlUpdateCnt = 0;	//선수금대체디테일 수정 건수
		int altDtlDeleteCnt = 0;	//선수금대체디테일 삭제 건수
		int advMstUpdateCnt = 0;	//선수금마스터 수정 건수
		int acctCdCnt		= 0;	//계정코드 등록 건수
		
		int iApplyAmt		= 0;	//적용금액
		int advTransCnt		= 0;	//거래처/업장이관 건수(선수금마스터 등록건수)

		String sRowStatusMst	= "";	//마스터 상태
		String sRowStatusDtl	= "";	//디테일 상태
		String sAtlNum			= "";	//선수금 대체번호
		String sMaxAtlNum		= "";	//신규 선수금 대체번호
		String sMaxAdvanceNum	= "";	//신규 선수금번호
		String sTransYn			= "";	//이관여부
		String sTypeGrpCd		= "";	//선수금대체구분
		String sAltTypeCd		= "";	//선수금대체유형
		String sAdvanceAtlNum	= "";	//선수금대체번호
		
//		System.out.println("############### setAdvanceAltProc Strat ####################");
		/************************************************************************************************
		 * 선수금 대체 마스터정보 (ds_search) : 대체금액(altAmt) = Sum(applyAmt)
		************************************************************************************************/
		Map<String, Object> rowDataMst = listMst.get(0);
		
		if(rowDataMst.get("rowStatus") != null) sRowStatusMst = rowDataMst.get("rowStatus").toString();	//마스터 상태
		if(rowDataMst.get("typeGrpCd") != null) sTypeGrpCd = rowDataMst.get("typeGrpCd").toString();	//선수금대체구분
		if(rowDataMst.get("altTypeCd") != null) sAltTypeCd = rowDataMst.get("altTypeCd").toString();	//선수금대체유형

		/************************************************************************************************
		 * 선수금 대체 마스터정보 등록/수정
		************************************************************************************************/
		
		//카드 환불일경우 - 금액 채권 생성
		String maxArNum      = "";
		Map<String, Object> rowArData = rowDataMst;		//채권

		//System.out.println("altTypeCd1 :"+rowDataMst.get("altTypeCd"));
		//System.out.println("rowDataMst1 :"+rowDataMst.toString());		
		
		if(("H03").equals(rowDataMst.get("altTypeCd"))){
			
			rowArData.put("occurDate", rowArData.get("altDate"));                //발생일자
			
			maxArNum      = arMstProcessDAO.selectMaxArNum(rowArData);
			rowDataMst.put("custCd", rowArData.get("cardCustCd"));      //카드환불거래처
			rowDataMst.put("custNm", rowArData.get("cardCustNm"));      //카드환불거래처		
			rowDataMst.put("cardArNum", maxArNum);      //카드환불거래처		
		}
		
		//선수금 대체 마스터 등록
		if("INSERT".equals(sRowStatusMst)){

			//선수금 대체번호 채번(신규일 경우 채번)
			sMaxAtlNum = advanceCommonDAO.getMaxAtlNum(listMst.get(0));
			
			rowDataMst.put("altNum", sMaxAtlNum);	//신규 선수금대체번호
			altMstInsertCnt = advanceCommonDAO.insertAdvanceAltMst2(rowDataMst);
			
		//선수금대체 마스터정보 변경	
		}else if("UPDATE".equals(sRowStatusMst)){
			altMstUpdateCnt = advanceCommonDAO.updateAdvanceAltMst(rowDataMst);
		}
//		System.out.println("################### listDtl.size() :"+listDtl.size());
		
		/************************************************************************************************
		 * 선수금 대체 디테일 등록/수정/삭제, 선수금 마스터정보 변경
		************************************************************************************************/
		for (int i = 0 ; i < listDtl.size() ; i++) {
			Map<String, Object> rowDataDtl = listDtl.get(i);
			
			if(rowDataDtl.get("rowStatus") != null) sRowStatusDtl = rowDataDtl.get("rowStatus").toString();	//상태
			if(rowDataDtl.get("applyAmt") != null) iApplyAmt = Integer.parseInt(rowDataDtl.get("applyAmt").toString());	//적용금액
			if(rowDataDtl.get("altNum") != null) sAtlNum = rowDataDtl.get("altNum").toString();	//선수금대체번호
			if(rowDataDtl.get("transYn") != null) sTransYn = rowDataDtl.get("transYn").toString();	//이관여부
			if(rowDataDtl.get("advanceAltNum") != null) sAdvanceAtlNum = rowDataDtl.get("advanceAltNum").toString();	//이관여부
			
//			System.out.println("######## ["+i+"] sRowStatusDtl :"+sRowStatusDtl);
//			System.out.println("######## ["+i+"] iApplyAmt :"+iApplyAmt);
//			System.out.println("######## ["+i+"] altNum :"+sAtlNum);
//			System.out.println("######## ["+i+"] transYn :"+sTransYn);
//			System.out.println("######## ["+i+"] sAdvanceAtlNum :"+sAdvanceAtlNum);
			
			/************************************************************************************************
			 * 이관 : 신규 선수금번호를 채번한 후 선수금마스터에 저장한다.(거래처/업장 이관시 사용)
			************************************************************************************************/				
			if("Y".equals(sTransYn)){

				if("INSERT".equals(sRowStatusMst)){

					//신규 선수금번호 채번
					sMaxAdvanceNum = advanceCommonDAO.getMaxAdvanceNum(listDtl.get(i));
					
//					System.out.println("## ["+i+"] sMaxAdvanceNum :"+sMaxAdvanceNum);
					rowDataDtl.put("transAdvanceNum", sMaxAdvanceNum);	//신규 선수금번호
					rowDataDtl.put("refNum", sMaxAtlNum);	//신규 선수금번호
					rowDataDtl.put("signInstanceId", rowDataMst.get("signInstanceId"));	//전자결재ID 20190213 김호석 추가					

					//거래처/업장 이관(신규 선수금번호 저장)
					advTransCnt += advanceCommonDAO.insertAdvanceMasterTrans2(rowDataDtl);
				}else{
					advTransCnt += advanceCommonDAO.updateAdvanceMasterTrans(rowDataDtl);
				}

			}
			
			//계정코드 등록
//			System.out.println("######## ["+i+"] typeGrpCd :"+sTypeGrpCd);
//			System.out.println("######## ["+i+"] altTypeCd :"+sAltTypeCd);
			rowDataDtl.put("typeGrpCd", sTypeGrpCd);
			rowDataDtl.put("altTypeCd", sAltTypeCd);
			
			if(!"".equals(sTypeGrpCd) && !"".equals(sAltTypeCd)){
				rowDataDtl.put("acctCd", null);
			}
			
//			System.out.println("######## ["+i+"] d typeGrpCd :"+rowDataDtl.get("typeGrpCd"));
//			System.out.println("######## ["+i+"] d altTypeCd :"+rowDataDtl.get("altTypeCd"));
//			System.out.println("######## ["+i+"] d acctCd :"+rowDataDtl.get("acctCd"));
			
			//선수금대체 디테일정보 등록(적용금액을 입력했을 경우)
			if("INSERT".equals(sRowStatusDtl) && iApplyAmt > 0){
				if("".equals(sAtlNum)) rowDataDtl.put("altNum", sMaxAtlNum);	//신규 선수금대체번호
				altDtlInsertCnt += advanceCommonDAO.insertAdvanceAltDtl2(rowDataDtl);
				//acctCdCnt += advanceCommonDAO.setAcctCd(rowDataDtl);
				//선수금 마스터정보 변경
				advMstUpdateCnt += advanceCommonDAO.updateAdvanceApplyAmtProc(rowDataDtl);
			}
			
			//선수금대체 디테일정보 변경
			if("UPDATE".equals(sRowStatusDtl) && !"".equals(sAdvanceAtlNum)){
//				if(!"".equals(sAdvanceAtlNum)){
					altDtlUpdateCnt += advanceCommonDAO.updateAdvanceAltDtl(rowDataDtl);
//				}
					//선수금 마스터정보 변경
					advMstUpdateCnt += advanceCommonDAO.updateAdvanceApplyAmtProc(rowDataDtl);
					
			}
			
			//선수금 대체디테일정보 삭제(단건 대체취소 (ApplyAmt = 0))
			if("DELETE".equals(sRowStatusDtl) && iApplyAmt == 0){
				altDtlDeleteCnt += advanceCommonDAO.deleteAdvanceAltDtl(rowDataDtl);
			}
			
			//초기화
			sRowStatusDtl 	= "";
			sAtlNum 		= "";
			sTransYn 		= "";
			sAdvanceAtlNum 	= "";
			iApplyAmt 		= 0;			
		}
		
		//카드 환불일경우 - 금액 채권 생성
		if(("H03").equals(rowDataMst.get("altTypeCd"))){
//			Map<String, Object> rowArData = rowDataMst;		//채권
			
//			rowArData.put("occurDate", rowArData.get("altDate"));                //발생일자
			
//			maxArNum      = arMstProcessDAO.selectMaxArNum(rowArData);
			
			rowArData.put("seq", "1");			                                    //지불테이블에 순번
			//rowAddData.put("sysClass", "13");                                       //시스템구분 (식자재)
			rowArData.put("fiscalDate", rowArData.get("altDate"));               //회계일자
			rowArData.put("journalzYn", "N");                                      //분개여부
			
			rowArData.put("arNum", maxArNum);
			rowArData.put("arOccurClass", "AO08");   //채권발생구분  : 신용카드청구
			rowArData.put("arTypeCd", "A03");        //미수금신용카드
			
			//영업유형 을(를) 조회한다.(계정코드 가져오자)
			Map<String,Object> mapData = new HashMap<String,Object>();
			
			mapData.put("typeGrpCdDtl", "001");
			mapData.put("typeCd", rowArData.get("arTypeCd"));
			RecordSet rs = salesTypeMgntDAO.selectDtlList(mapData);
			
			for (int i = 0; i < rs.size(); i++){
				mapData.put("acctCd", rs.get(i).get("acctCd"));
			}
			rowArData.put("acctCd", mapData.get("acctCd"));           //계정코드 셋팅  미수금_신용카드_청구(-)
			rowArData.put("arAmt", Integer.parseInt(rowArData.get("altAmt").toString()) * -1);      //채권금액
			
			rowArData.put("custCd", rowArData.get("cardCustCd"));      //카드환불거래처
			rowArData.put("custNm", rowArData.get("cardCustNm"));      //카드환불거래처				

			rowArData.put("taxShetPublishYn", "N");                   //세금계산서 발행 여부
			rowArData.put("payClassCd", "2");                         //지불 구분 코드
			rowArData.put("billingPublishYn", "N");                   //청구 발행 여부
			
			//채권발생
			altDtlInsertCnt += arMstProcessDAO.insert(rowArData);			
			
		}
		
		
//		System.out.println("############### setAdvanceAltProc End ####################");
		return altMstInsertCnt + altMstUpdateCnt + altDtlInsertCnt + altDtlUpdateCnt + altDtlDeleteCnt + advMstUpdateCnt + advTransCnt + acctCdCnt;
	}
	
	/**
	 * 전자결재정보를 Update 처리한다.
	 * <pre>
	 * - 업무 테이블에 Instance ID Update
	 * - 결재정보 공통 테이블에 결재정보 Insert or Update
	 * </pre>
	 *
	 * @param list
	 * @return
	 * @throws Exception
	 * @see com.hwfs.guide.sample.service.GuideSampleService#saveSign(hone.online.xplatform.map.DataSetMap)
	*/
	@SuppressWarnings("unchecked")
	public int saveSignInfo(DataSetMap list) throws Exception {
		int updateRowCnt = 0;

		Map<String, Object> rowData = list.get(0);
		//SCC_SIGN_INFO 테이블에 결재정보저장 (Insert or Update)
		updateRowCnt = gwIfDAO.saveSignInfo(rowData);

		return updateRowCnt;
	}
	
	/**
	 * 선수금대체 취소처리(이관 포함)
	 * @param list - DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int setAdvanceAltCancel(DataSetMap listMst, DataSetMap listDtl) throws Exception {
		int rowCnt	= 0;
		int iApplyAmt = 0;
		String sTransYn = "";	//이관여부
		
//		System.out.println("############### setAdvanceAltCancel Strat ####################");
		/************************************************************************************************
		 * 선수금대체 마스터정보 삭제
		************************************************************************************************/	
		Map<String, Object> rowDataMst = listMst.get(0);
		
		//선수금 대체 마스터 정보 삭제 (RECD_STATUS = 'D')
		rowCnt = advanceCommonDAO.cancelAdvanceAltMaster(rowDataMst);

		/************************************************************************************************
		 * 선수금 마스터, 선수금대체 디테일 정보 삭제
		************************************************************************************************/
//		System.out.println("################### listDtl.size() :"+listDtl.size());
		//System.out.println("altTypeCd :"+rowDataMst.get("altTypeCd"));		
		//System.out.println("rowDataMst :"+rowDataMst.toString());
		
		//카드 환불일경우 - 금액 채권 생성
		if(("H03").equals(rowDataMst.get("altTypeCd"))){
			Map<String, Object> rowArData = listMst.get(0);;		//채권
			rowArData.put("arNum", rowDataMst.get("cardArNum"));
			rowCnt += arMstProcessDAO.cancelArMst(rowArData);
		}
		
		for (int i = 0 ; i < listDtl.size() ; i++) {
			Map<String, Object> rowDataDtl = listDtl.get(i);

			//이관여부
			if(rowDataDtl.get("transYn") == null) sTransYn = "";
			else sTransYn = rowDataDtl.get("transYn").toString();
			
			//적용금액
			if(rowDataDtl.get("applyAmt") == null) iApplyAmt = 0;
			else iApplyAmt = Integer.parseInt(rowDataDtl.get("applyAmt").toString());
			
//			System.out.println("###################["+i+"] sTransYn :"+sTransYn);
//			System.out.println("###################["+i+"] sGubun :"+sGubun);
//			System.out.println("###################["+i+"] iApplyAmt :"+iApplyAmt);
			
			/************************************************************************************************
			 * 이관취소(거래처/업장 이관취소시 사용)
			************************************************************************************************/
			if("Y".equals(sTransYn)){
						
				//선수금 마스터정보 삭제 (RECD_STATUS = 'D')
				rowCnt += advanceCommonDAO.cancelAdvanceMaster(rowDataDtl);
				
				//선수금 대체 디테일 정보 삭제 (RECD_STATUS = 'D')
				rowCnt += advanceCommonDAO.cancelAdvanceAltDetail(rowDataDtl);
				
			/************************************************************************************************
			 * 대체취소
			************************************************************************************************/			
			}else{
				
				//선수금 대체 디테일 정보 삭제 (RECD_STATUS = 'D')
				if(iApplyAmt > 0) rowCnt += advanceCommonDAO.cancelAdvanceAltDetail(rowDataDtl);
			}
			
			//선수금 마스터정보 변경
			rowCnt += advanceCommonDAO.updateAdvanceApplyAmtProc(rowDataDtl);
			
		}
		
//		System.out.println("############### setAdvanceAltCancel End ####################");
		return rowCnt;
	}
	
	/**
	 * 재이관 여부 체크
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet chkAdvanceTransInfo(Map<String, Object> mapParam) throws Exception {
		return advanceCommonDAO.chkAdvanceTransInfo(mapParam);
	}

	/**
	 * 이관취소 가능여부
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet chkAdvanceTransCancel(Map<String, Object> mapParam) throws Exception {
		return advanceCommonDAO.chkAdvanceTransCancel(mapParam);
	}
	
	/**
	 * 선수금잔액 조회
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public RecordSet selectTotalAdvanceAmt(Map<String, Object> mapParam) throws Exception {
		return advanceCommonDAO.selectTotalAdvanceAmt(mapParam);
	}

	/**
	 * 선수금대체처리(이관 포함)
	 * @param list - DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public String setAdvanceAltProc2(DataSetMap listMst, DataSetMap listDtl) throws Exception {
		int iApplyAmt = 0;	//적용금액
		int altDtlInsertCnt = 0;	//선수금대체디테일 등록 건수

		String sRowStatusDtl	= "";	//디테일 상태
		String sAtlNum			= "";	//선수금 대체번호
		String sMaxAtlNum		= "";	//신규 선수금 대체번호
		String sMaxAdvanceNum	= "";	//신규 선수금번호
		String sTransYn			= "";	//이관여부
		String sTypeGrpCd		= "";	//선수금대체구분
		String sAltTypeCd		= "";	//선수금대체유형
		
//		System.out.println("############### setAdvanceAltProc Strat ####################");
		/************************************************************************************************
		 * 선수금 대체 마스터정보 (ds_search) : 대체금액(altAmt) = Sum(applyAmt)
		************************************************************************************************/
		Map<String, Object> rowDataMst = listMst.get(0);
		
		if(rowDataMst.get("typeGrpCd") != null) sTypeGrpCd = rowDataMst.get("typeGrpCd").toString();	//선수금대체구분
		if(rowDataMst.get("altTypeCd") != null) sAltTypeCd = rowDataMst.get("altTypeCd").toString();	//선수금대체유형

		//System.out.println("#################################### advanceAltOccurClass:"+ rowDataMst.get("advanceAltOccurClass").toString());
		//선수금 대체번호 채번(신규일 경우 채번)
		sMaxAtlNum = advanceCommonDAO.getMaxAtlNum(listMst.get(0));
		rowDataMst.put("altNum", sMaxAtlNum);	//신규 선수금대체번호
		advanceCommonDAO.insertAdvanceAltMst(rowDataMst);
		
		//카드 환불일경우 - 금액 채권 생성
		String maxArNum      = "";
		Map<String, Object> rowArData = rowDataMst;		//채권

		//System.out.println("altTypeCd1 :"+rowDataMst.get("altTypeCd"));
		//System.out.println("rowDataMst1 :"+rowDataMst.toString());		
		
		if(("H03").equals(rowDataMst.get("altTypeCd"))){
			
			rowArData.put("occurDate", rowArData.get("altDate"));                //발생일자
			
			maxArNum      = arMstProcessDAO.selectMaxArNum(rowArData);
			rowDataMst.put("custCd", rowArData.get("cardCustCd"));      //카드환불거래처
			rowDataMst.put("custNm", rowArData.get("cardCustNm"));      //카드환불거래처		
			rowDataMst.put("cardArNum", maxArNum);      //카드환불거래처		
		}

		//System.out.println("altTypeCd2 :"+rowDataMst.get("altTypeCd"));
		//System.out.println("rowDataMst2 :"+rowDataMst.toString());	
		
		/************************************************************************************************
		 * 선수금 대체 디테일 등록, 선수금 마스터정보 변경
		************************************************************************************************/
		for (int i = 0 ; i < listDtl.size() ; i++) {
			Map<String, Object> rowDataDtl = listDtl.get(i);
			
			if(rowDataDtl.get("rowStatus") != null) sRowStatusDtl = rowDataDtl.get("rowStatus").toString();	//상태
			if(rowDataDtl.get("applyAmt") != null) iApplyAmt = Integer.parseInt(rowDataDtl.get("applyAmt").toString());	//적용금액
			if(rowDataDtl.get("altNum") != null) sAtlNum = rowDataDtl.get("altNum").toString();	//선수금대체번호
			if(rowDataDtl.get("transYn") != null) sTransYn = rowDataDtl.get("transYn").toString();	//이관여부
			
//			System.out.println("######## ["+i+"] sRowStatusDtl :"+sRowStatusDtl);
//			System.out.println("######## ["+i+"] iApplyAmt :"+iApplyAmt);
//			System.out.println("######## ["+i+"] altNum :"+sAtlNum);
//			System.out.println("######## ["+i+"] transYn :"+sTransYn);
//			System.out.println("######## ["+i+"] sAdvanceAtlNum :"+sAdvanceAtlNum);
			
			/************************************************************************************************
			 * 이관 : 신규 선수금번호를 채번한 후 선수금마스터에 저장한다.(거래처/업장 이관시 사용)
			************************************************************************************************/				
			if("Y".equals(sTransYn)){

				//신규 선수금번호 채번
				sMaxAdvanceNum = advanceCommonDAO.getMaxAdvanceNum(listDtl.get(i));
				
//				System.out.println("## ["+i+"] sMaxAdvanceNum :"+sMaxAdvanceNum);
				rowDataDtl.put("transAdvanceNum", sMaxAdvanceNum);	//신규 선수금번호
				rowDataDtl.put("refNum", sMaxAtlNum);	//신규 선수금번호

				//거래처/업장 이관(신규 선수금번호 저장)
				advanceCommonDAO.insertAdvanceMasterTrans(rowDataDtl);
			}
			
			//계정코드 등록
			rowDataDtl.put("typeGrpCd", sTypeGrpCd);
			rowDataDtl.put("altTypeCd", sAltTypeCd);
			
			if(!"".equals(sTypeGrpCd) && !"".equals(sAltTypeCd)){
				rowDataDtl.put("acctCd", null);
			}
			
			//선수금대체 디테일정보 등록(적용금액을 입력했을 경우)
			if("INSERT".equals(sRowStatusDtl) && iApplyAmt > 0){
				if("".equals(sAtlNum)) rowDataDtl.put("altNum", sMaxAtlNum);	//신규 선수금대체번호
				advanceCommonDAO.insertAdvanceAltDtl(rowDataDtl);
				
				//선수금 마스터정보 변경
				advanceCommonDAO.updateAdvanceApplyAmtProc(rowDataDtl);
			}
			
			
			//초기화
			sRowStatusDtl 	= "";
			sAtlNum 		= "";
			sTransYn 		= "";
			iApplyAmt 		= 0;			
		}
		
		//카드 환불일경우 - 금액 채권 생성
				if(("H03").equals(rowDataMst.get("altTypeCd"))){
//					Map<String, Object> rowArData = rowDataMst;		//채권
					
//					rowArData.put("occurDate", rowArData.get("altDate"));                //발생일자
					
//					maxArNum      = arMstProcessDAO.selectMaxArNum(rowArData);
					
					rowArData.put("seq", "1");			                                    //지불테이블에 순번
					//rowAddData.put("sysClass", "13");                                       //시스템구분 (식자재)
					rowArData.put("fiscalDate", rowArData.get("altDate"));               //회계일자
					rowArData.put("journalzYn", "N");                                      //분개여부
					
					rowArData.put("arNum", maxArNum);
					rowArData.put("arOccurClass", "AO08");   //채권발생구분  : 신용카드청구
					rowArData.put("arTypeCd", "A03");        //미수금신용카드
					
					//영업유형 을(를) 조회한다.(계정코드 가져오자)
					Map<String,Object> mapData = new HashMap<String,Object>();
					
					mapData.put("typeGrpCdDtl", "001");
					mapData.put("typeCd", rowArData.get("arTypeCd"));
					RecordSet rs = salesTypeMgntDAO.selectDtlList(mapData);
					
					for (int i = 0; i < rs.size(); i++){
						mapData.put("acctCd", rs.get(i).get("acctCd"));
					}
					rowArData.put("acctCd", mapData.get("acctCd"));           //계정코드 셋팅  미수금_신용카드_청구(-)
					rowArData.put("arAmt", Integer.parseInt(rowArData.get("altAmt").toString()) * -1);      //채권금액
					
					rowArData.put("custCd", rowArData.get("cardCustCd"));      //카드환불거래처
					rowArData.put("custNm", rowArData.get("cardCustNm"));      //카드환불거래처				

					rowArData.put("taxShetPublishYn", "N");                   //세금계산서 발행 여부
					rowArData.put("payClassCd", "2");                         //지불 구분 코드
					rowArData.put("billingPublishYn", "N");                   //청구 발행 여부
					
					//채권발생
					altDtlInsertCnt += arMstProcessDAO.insert(rowArData);			
					
				}
		
//		System.out.println("############### setAdvanceAltProc End ####################");
		return sMaxAtlNum;
	}
	
	/**
	 * 선수금환불/이관처리(을)를 처리한다.(식권 포함)
	 * @param list - DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int setAdvanceRefundProc(DataSetMap listMst, DataSetMap listDtl, DataSetMap listTicket) throws Exception {
		int totCnt = 1;
		String sMaxAtlNum 		= "";	// 선수금 대체번호

		//System.out.println("############### setAdvanceRefundProc Start ####################");
		/************************************************************************************************
		 * 1.선수금대체처리
		************************************************************************************************/
		try {
			sMaxAtlNum = setAdvanceAltProc2(listMst, listDtl);
		} catch (Exception e) {
			// TODO: handle exception
			logger.error(e.getMessage());
		}
		
		/************************************************************************************************
		 * 2.MAS_TICKET_MST(식권환불) 등록
		************************************************************************************************/
		//System.out.println("############## 1 MAS_TICKET_MST size :"+listTicket.size());
		if(listTicket.size() > 0){
			for (int i = 0 ; i < listTicket.size() ; i++) {
				Map<String, Object> rowDataTicket = listTicket.get(i);
				rowDataTicket.put("advanceAltNum", sMaxAtlNum);
				totCnt = advanceCommonDAO.insertMasTicketMst(rowDataTicket);
			}
		}
		//System.out.println("############### setAdvanceRefundProc End ####################");
		return totCnt;
	}
		
	/**
	 * 선수금환불 취소처리한다.(식권 포함)
	 * @param list - DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int setAdvanceRefundCancel(DataSetMap listMst, DataSetMap listDtl) throws Exception {
		int totCnt = 0;
//		System.out.println("############### setAdvanceRefundCancel Start ####################");
		/************************************************************************************************
		 * 1.선수금 환불 취소처리
		************************************************************************************************/
		totCnt = setAdvanceAltCancel(listMst, listDtl);

		/************************************************************************************************
		 * 2.MAS_TICKET_MST(식권환불) 취소처리
		************************************************************************************************/
		for (int i = 0 ; i < listDtl.size() ; i++) {
			Map<String, Object> rowData = listDtl.get(i);
			//if(i == 0){
				rowData.put("transGubun", "XR");
				totCnt += advanceCommonDAO.deleteMasTicketMst(rowData);
			//}
		}
//		System.out.println("############### setAdvanceRefundCancel End ####################");
		return totCnt;
	}
	
	/**
	 * 선수금이관처리(을)를 처리한다.(식권 포함)
	 * @param list - DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int setAdvanceTransProc(DataSetMap listMst, DataSetMap listDtl, DataSetMap listTicket) throws Exception {
		int totCnt = 0;	// 건수
//		System.out.println("############### setAdvanceTransProc Start ####################");
		/************************************************************************************************
		 * 1.MAS_TICKET_MST(식권환불) 등록
		************************************************************************************************/
//		System.out.println("############## 1 MAS_TICKET_MST size :"+listTicket.size());
		for (int i = 0 ; i < listTicket.size() ; i++) {
			Map<String, Object> rowDataTicket = listTicket.get(i);
			totCnt += advanceCommonDAO.insertMasTicketMst(rowDataTicket);
		}
		
		/************************************************************************************************
		 * 2.선수금대체처리(이관 포함)
		************************************************************************************************/
		totCnt += setAdvanceAltProc(listMst, listDtl);
//		System.out.println("############### setAdvanceTransProc End ####################");
		return totCnt;
	}
		
	/**
	 * 선수금이관 취소처리한다.(식권 포함)
	 * @param list - DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int setAdvanceTransCancel(DataSetMap listMst, DataSetMap listDtl) throws Exception {
		int totCnt = 0;
//		System.out.println("############### setAdvanceTransCancel Start ####################");
		/************************************************************************************************
		 * 1.선수금 이관 취소처리
		************************************************************************************************/
		totCnt = setAdvanceAltCancel(listMst, listDtl);

		/************************************************************************************************
		 * 2.MAS_TICKET_MST(식권이관) 취소처리
		************************************************************************************************/
		for (int i = 0 ; i < listDtl.size() ; i++) {
			Map<String, Object> rowData = listDtl.get(i);
//			rowData.put("transGubun", "WR");
			totCnt += advanceCommonDAO.deleteMasTicketMst(rowData);
		}
//		System.out.println("############### setAdvanceTransCancel End ####################");
		return totCnt;
	}	
	
	/**
	 * 선수금잔액 체크
	 * @return String 조회결과
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String getAdvanceAltYn(DataSetMap list) throws Exception {
		String sAdvanceAltYn	= "Y";
		int applyAmt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			applyAmt = Integer.parseInt(rowData.get("applyAmt").toString());
			
			if("Y".equals(sAdvanceAltYn) && applyAmt > 0){
//				System.out.println("################################# applyAmt:"+applyAmt);
				sAdvanceAltYn = advanceCommonDAO.getAdvanceAltYn(rowData);
			}
		}
		return sAdvanceAltYn;
	}
}
