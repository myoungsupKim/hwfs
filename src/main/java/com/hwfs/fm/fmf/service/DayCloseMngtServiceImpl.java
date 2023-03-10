package com.hwfs.fm.fmf.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import oracle.net.aso.e;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.fm.fmf.dao.DayCloseMngtDAO;
import com.hwfs.sc.cmn.util.StringUtil;
import com.hwfs.sm.cmn.dao.CloseCommonDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 일마감관리하는 DayCloseMngt Service Implementation
 * 
 * @ClassName DayCloseMngtServiceImpl.java
 * @Description DayCloseMngtServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.08    손형민        최초생성
 *  2017.03.29	  kihoon		[CH201703_00751] 미마감내역 조회 팝업 프로그램 개발
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.06.08
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fmf/dayCloseMngtService")
public class DayCloseMngtServiceImpl extends DefaultServiceImpl implements DayCloseMngtService {
	
	/** DayCloseMngtDAO Bean 생성 */
	@Resource(name = "/fm/fmf/dayCloseMngtDAO")
	private DayCloseMngtDAO dayCloseMngtDAO;
	
	/** CloseCommonDAO Bean 생성 */
	@Resource(name = "/sm/cmn/closeCommonDAO")
	private CloseCommonDAO closeCommonDAO;
	

	/**
	 * 일마감관리 목록을 조회한다.
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
		return dayCloseMngtDAO.selectList(mapParam);
	}
	
	/**
	 * 일마감관리 목록을 조회한다.
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
	public RecordSet selectSubList(Map<String, Object> mapParam) throws Exception {
		return dayCloseMngtDAO.selectSubList(mapParam);
	}
	public RecordSet selectSubList2(Map<String, Object> mapParam) throws Exception {
		return dayCloseMngtDAO.selectSubList2(mapParam);
	}

	/**
	 * 매출마감 일괄처리
	 *
	 * @param param
	 * @return 에러메세지
	 * @throws Exception
	*/
	public Map<String, Object> closingAll(DataSetMap list, Map<String, Object> param) throws Exception {
		Map<String, Object> retProcItemVal = new HashMap<String, Object>();
		Map<String, Object> pMap = new HashMap<String, Object>();
		
		pMap.put("p_sale_date", param.get("schSaleDate")); //매출일자
		pMap.put("p_upjang", param.get("schUpjang")); //사업장
		pMap.put("p_subinv_code", ""); //공장
		pMap.put("p_user", param.get("loginSabun")); //처리자
		
		//SP_FM_SALE_MAGAM_PROC [정상분]
        retProcItemVal  = dayCloseMngtDAO.closing(pMap);
        if("FALSE".equals(nvls(retProcItemVal.get("O_RTN")))){
        	throw new BizException(retProcItemVal.get("O_RTNMSG").toString());
        }

        //SP_FM_SALE_MOD_MAGAM_PROC [조정분]
        retProcItemVal  = dayCloseMngtDAO.sp_Fm_Sale_Mod_Magam_Proc(pMap);
        if("FALSE".equals(nvls(retProcItemVal.get("O_RTN")))){
        	throw new BizException(retProcItemVal.get("O_RTNMSG").toString());
        }
 
        //PG_FM_SALE_MAGAM [정상분]
        retProcItemVal  = dayCloseMngtDAO.pg_fm_sale_magam(pMap);
        if("FALSE".equals(retProcItemVal.get("O_RTN").toString())){
        	throw new BizException(retProcItemVal.get("O_RTNMSG").toString());
        }

        //SP_FM_SALE_MOD_CRD_SAL_IF_PROC [조정분]
        pMap = new HashMap<String, Object>();
		pMap.put("p_sale_date", param.get("schSaleDate")); //매출일자
		pMap.put("p_upjang", param.get("schUpjang")); //사업장
		pMap.put("p_receipt_num", ""); //영수증 번호
		pMap.put("p_subinv_code", ""); //공장
		pMap.put("p_user", param.get("loginSabun")); //처리자
		
        retProcItemVal  = dayCloseMngtDAO.Sp_Fm_Sale_Mod_Crd_Sla_If_Proc(pMap);
        if("FALSE".equals(retProcItemVal.get("O_RTN").toString())){
        	throw new BizException(retProcItemVal.get("O_RTNMSG").toString());
        }
		
		return retProcItemVal;
	}

	/**
	 * SP_SLA_SALS_POS_MAGAM_PROC 수행
	 *
	 * @param search
	 * @return 에러메세지
	 * @throws Exception
	*/
	public Map<String, Object> callSpSlaSalsPosMagamProc(Map<String, Object> param) throws Exception {
		Map<String, Object> retProcItemVal = new HashMap<String, Object>();
        Map<String, Object> inParam = new HashMap<String, Object>();
        
        inParam.put("P_OCCUR_DATE",	String.valueOf(param.get("schSaleDate")));
		inParam.put("P_SYS_CLASS",	String.valueOf("13"));
		inParam.put("P_UPJANG_CD",	String.valueOf(param.get("upjang")));
		
		Map<String, Object> retVal = closeCommonDAO.callCloseProcedure(inParam, "SP_SLA_SALS_POS_MAGAM_PROC");
		
		String strRtn		= String.valueOf(retVal.get("O_RTN"));
		String strRtnMsg	= String.valueOf(retVal.get("O_RTNMSG"));
		
		if(!"TRUE".equals(strRtn)){
			throw new BizException(strRtnMsg);
		}
		
		return retProcItemVal;
	}
	
	/**
	 * FMS_SLA_SALS_POS_MAGAM_BAT 수행
	 *
	 * @param search
	 * @return 에러메세지
	 * @throws Exception
	*/
	public Map<String, Object> callFmsSlaSalsPosMagamBat(Map<String, Object> param) throws Exception {
		Map<String, Object> retProcItemVal = new HashMap<String, Object>();
        Map<String, Object> inParam = new HashMap<String, Object>();
        
        inParam.put("P_OCCUR_DATE",	String.valueOf(param.get("schSaleDate")));
        inParam.put("O_RTN",	"");
        inParam.put("O_RTNMSG",	"");
		
		Map<String, Object> retVal = closeCommonDAO.callCloseProcedure(inParam, "FMS_SLA_SALS_POS_MAGAM_BAT");
		
		String strRtn		= String.valueOf(retVal.get("O_RTN"));
		String strRtnMsg	= String.valueOf(retVal.get("O_RTNMSG"));
		
		if(!"TRUE".equals(strRtn)){
			throw new BizException(strRtnMsg);
		}
		
		return retProcItemVal;
	}
	
	/**
	 * 일마감 관리에 마감처리를 한다.
	 *
	 * @param list , search
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 에러메세지
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public Map<String, Object> closing(DataSetMap list,Map<String, Object> search) throws Exception {
		Map<String, Object> retProcItemVal = new HashMap<String, Object>();
		
		/**
		 * 리스트가 없는 경우. SP_FM_SALE_MAGAM_PROC,PG_FM_SALE_MAGAM 프로시저 실행.
		 */
		
		String isAllMagamYN = "N"; // 전체마감취소 여부 
		
		if(list.size() == 0){
			String strDate = (String) search.get("dateList");
			
			search.put("schMainUpjang", search.get("schUpjang")); 

			for(String date : strDate.split(",")){
				search.put("schSaleDate", date);

				//업장을 선택한 경우
				if(!"".equals(nvls(search.get("schUpjang")))){
					//하위업장일괄마감 체크 여부에 따라 처리할 업장목록 조회
					RecordSet rsUpjangList = dayCloseMngtDAO.selectUpjangList(search);
					
					// 하위업장 포함 기부업장여부 조회 
					if(rsUpjangList.getRowCount() == 0) {
						throw new BizException("기부업장입니다.");
					}

					for(int i = 0; i < rsUpjangList.getRowCount(); i++){
			        	Map<String, Object> rowUpjang = rsUpjangList.get(i);
			        	
			        	search.put("schUpjang", rowUpjang.get("upjang"));
			        	search.put("upjang", rowUpjang.get("upjang2"));
						
						//int fmsCnt = dayCloseMngtDAO.fmsCnt(search);
						
						//if(fmsCnt > 0){
						//	String errorDate = date.substring(0, 4) + "-" + date.substring(4, 6) + "-" + date.substring(6);
						//	throw new BizException(errorDate + " 일자에 마감데이터가 존재합니다. \n\n[재집계] 해주세요.");
						//}
						
						// 전일자 수불자료 여부 확인
						//int fmsDayTrCnt = dayCloseMngtDAO.fmsDayTrCnt(search);
						
						// 전일자 수불자료 존재 시 전일자 마감여부 CHECK
						//if(fmsDayTrCnt > 0){
						//	int fmsDayCnt = dayCloseMngtDAO.fmsDayCnt(search);
						//	if(fmsDayCnt == 0){
						//		String errorDate = date.substring(0, 4) + "-" + date.substring(4, 6) + "-" + date.substring(6);
						//		throw new BizException(errorDate + " 일자의 전일자 마감데이터가 존재하지 않습니다.\n\n전일자 [마감처리] 해주세요.");
						//	}
						//}

						closingAll(list, search);

			        	//SP_SLA_SALS_POS_MAGAM_PROC 수행
			        	callSpSlaSalsPosMagamProc(search);
					}
					
				//업장을 선택하지 않은 경우(전체 사업장 마감)
				}else{
					closingAll(list, search);
					//System.out.println("callFmsSlaSalsPosMagamBat Start!");
					//프로시저 한번 호출로 변경 2017.11.28 김호석
	                callFmsSlaSalsPosMagamBat(search);
	                //System.out.println("callFmsSlaSalsPosMagamBat End!");
					
			        //RecordSet rs = dayCloseMngtDAO.selectUpjangList(search);
					/*
					RecordSet rs = dayCloseMngtDAO.upjangList(search);
			        
			        for(int i = 0 ; i < rs.size(); i++){
		            	Map<String, Object> rowData = rs.get(i);
		            	
			        	//search.put("upjang", rowData.get("upjang2"));
		            	search.put("upjang", rowData.get("upjang"));
			        	//SP_SLA_SALS_POS_MAGAM_PROC 수행
			        	callSpSlaSalsPosMagamProc(search);
					}
					*/
	                
					// 기부업장 마감 취소 로직 
	                isAllMagamYN = "Y";
//					RecordSet rsDonaUpjangList = dayCloseMngtDAO.selectDonaUpjangList(search); //기부업장 매출목록 select
//					
//					for(int z=0; z<rsDonaUpjangList.size(); z++){
//						Map<String, Object> param = new HashMap<String, Object>(); // 마감취소용 param
//						Map<String, Object> param2 = new HashMap<String, Object>(); // 업장 매출데이터 삭제용 param
//						
//						param.put("p_occur_date"	, rsDonaUpjangList.get(z).get("saleDate")); 	//회계일자
//						param.put("p_sub_upjang_cd"	, rsDonaUpjangList.get(z).get("upjang")); 		//매출_업장
//						param.put("p_upjang_cd"		, rsDonaUpjangList.get(z).get("upjang2")); 		//채권_업장
//						param.put("p_receipt_num"	, rsDonaUpjangList.get(z).get("receiptNum")); 	//매출일자
//						param.put("p_sys_class"		, "13"); 						//시스템구분(13)
//						
//						// 기부업장 마감취소 
//				        retProcItemVal = dayCloseMngtDAO.sp_Sla_Sals_Pos_Upjang_Cancel_Proc(param);
//				        if("FALSE".equals(retProcItemVal.get("O_RTN").toString())){
//				        	throw new BizException(retProcItemVal.get("O_RTNMSG").toString());
//				        }
//				        
//			            retProcItemVal  = dayCloseMngtDAO.sp_Fm_Sale_Cncl_Sla_If_Proc(param);
//			            if("FALSE".equals(retProcItemVal.get("O_RTN").toString())){
//			            	throw new BizException(retProcItemVal.get("O_RTNMSG").toString());
//			            }
//			            
//			            
//			            // 기부업장 FMS_SALES 데이터 삭제
//			            param2.put("saleDate", rsDonaUpjangList.get(z).get("saleDate"));
//			            param2.put("upjang", rsDonaUpjangList.get(z).get("upjang"));
//			            
//			            dayCloseMngtDAO.fmssalesDelete(param2);
//					} 
					
					
					
					
				}
			}
		}else{
			/**
			  * 리스트가 있는 경우. PG_FM_SALE_MAGAM프로시저 실행
			  */
			for (int i = 0 ; i < list.size() ; i++) {
				Map<String, Object> rowData = list.get(i);
				if("1".equals(rowData.get("chk1").toString())){
					
					// 기부업장 체크 
					RecordSet rsDonationUpjang = dayCloseMngtDAO.selectCheckDonaUpjang(rowData);
					if(rsDonationUpjang.size() != 0) {
						throw new BizException("기부업장입니다.");
					}
					
					
					if("Y".equals(nvls(rowData.get("modifySalsYn")))){//조정분
						Map<String, Object> param = new HashMap<String, Object>();
						param.put("p_sale_date", rowData.get("saleDate")); //매출일자
						param.put("p_upjang", rowData.get("upjang")); //사업장
						param.put("p_subinv_code", rowData.get("subinvCode")); //공장
						param.put("p_receipt_num", rowData.get("receiptNum")); //영수증 번호
						param.put("p_user", search.get("loginSabun")); //처리자

		                retProcItemVal  = dayCloseMngtDAO.Sp_Fm_Sale_Mod_Crd_Sla_If_Proc(param);
					}else{
						//PG_FM_SALE_MAGAM -- 정상분.
						Map<String, Object> param = new HashMap<String, Object>();
						param.put("p_sale_date", rowData.get("saleDate")); //매출일자
						param.put("p_upjang", rowData.get("upjang")); //사업장
						param.put("p_subinv_code", rowData.get("subinvCode")); //공장
						param.put("p_user", search.get("loginSabun")); //처리자
						
		                retProcItemVal  = dayCloseMngtDAO.pg_fm_sale_magam(param);
					}
					
	                if("FALSE".equals(retProcItemVal.get("O_RTN").toString())){
	                	throw new BizException(retProcItemVal.get("O_RTNMSG").toString());
	                }
	                
	                Map<String, Object> inParam = new HashMap<String, Object>();
	                inParam.put("P_OCCUR_DATE",	String.valueOf(rowData.get("saleDate")));
	        		inParam.put("P_SYS_CLASS",	String.valueOf("13"));
	        		inParam.put("P_UPJANG_CD",	String.valueOf(rowData.get("upjang2")));
	        		Map<String, Object> retVal = closeCommonDAO.callCloseProcedure(inParam, "SP_SLA_SALS_POS_MAGAM_PROC");
	        		String strRtn		= String.valueOf(retVal.get("O_RTN"));
	        		String strRtnMsg	= String.valueOf(retVal.get("O_RTNMSG"));
	        		if(!"TRUE".equals(strRtn)){
	        			throw new BizException(strRtnMsg);
	        		}
				}
			}
		}

		//여신집계 프로시저 한번 호출로 변경 2017.11.28 김호석
        Map<String, Object> ppMap = new HashMap<String, Object>();
		dayCloseMngtDAO.sp_Fms_Credit_Sum_Proc(ppMap);
		
      
        
		
		
		
		/*
		RecordSet rs2 = dayCloseMngtDAO.selectTemp(retProcItemVal);
        for(int j = 0 ; j < rs2.size();j ++){
        	Map<String, Object> rowData2 = rs2.get(j);
            Map<String, Object> ppMap = new HashMap<String, Object>();
        
            ppMap.put("p_upjang_cd", String.valueOf(rowData2.get("upjangCd"))); //업장코드
			ppMap.put("p_apply_date", String.valueOf(rowData2.get("yymm"))); //적용일자
			ppMap.put("p_occur_class", String.valueOf("03")); //발생구분			
			ppMap.put("p_occur_amt", String.valueOf(rowData2.get("buyConfirmAmt"))); //발생금액	
			ppMap.put("p_occur_amt_before", String.valueOf("0")); //발생전금액		
			ppMap.put("p_class_cd", String.valueOf("06")); //구분코드
			ppMap.put("p_occur_table", String.valueOf("FMS_SALES")); //발생테이블
			ppMap.put("p_key_nm", String.valueOf("RECEIPT_NUM")); //키명
			ppMap.put("p_key_value01", String.valueOf(rowData2.get("keyValue01"))); //키값1
			ppMap.put("p_key_value02", String.valueOf("")); //키값2		
			ppMap.put("p_key_value03", String.valueOf("")); //키값3
			ppMap.put("p_key_value04", String.valueOf("")); //키값4
			ppMap.put("p_key_value05", String.valueOf("")); //키값5
			ppMap.put("p_occur_prg_id", String.valueOf("dayCloseMngt")); //프로그램ID
			ppMap.put("p_occur_prg_nm", String.valueOf("식재일마감관리")); //프로그램명
			ppMap.put("p_cuser", String.valueOf(rowData2.get("cuser"))); //처리자
			
			dayCloseMngtDAO.sp_Fms_Credit_Sum_Proc(ppMap);
        }
        
        */
        
        
        
        // 여신집계 이 후 전체마감에 대한 기부업장 취소처리 필요 
        if(isAllMagamYN.equals("Y")) {
        	RecordSet rsDonaUpjangList = dayCloseMngtDAO.selectDonaUpjangList(search); //기부업장 매출목록 select
			
			for(int z=0; z<rsDonaUpjangList.size(); z++){
				Map<String, Object> param = new HashMap<String, Object>(); // 마감취소용 param
				Map<String, Object> param2 = new HashMap<String, Object>(); // 업장 매출데이터 삭제용 param
				
				param.put("p_occur_date"	, rsDonaUpjangList.get(z).get("saleDate")); 	//회계일자
				param.put("p_sub_upjang_cd"	, rsDonaUpjangList.get(z).get("upjang")); 		//매출_업장
				param.put("p_upjang_cd"		, rsDonaUpjangList.get(z).get("upjang2")); 		//채권_업장
				param.put("p_receipt_num"	, rsDonaUpjangList.get(z).get("receiptNum")); 	//매출일자
				param.put("p_sys_class"		, "13"); 						//시스템구분(13)
				
				// 기부업장 마감취소 
		        retProcItemVal = dayCloseMngtDAO.sp_Sla_Sals_Pos_Upjang_Cancel_Proc(param);
		        if("FALSE".equals(retProcItemVal.get("O_RTN").toString())){
		        	throw new BizException(retProcItemVal.get("O_RTNMSG").toString());
		        }
		        
	            retProcItemVal  = dayCloseMngtDAO.sp_Fm_Sale_Cncl_Sla_If_Proc(param);
	            if("FALSE".equals(retProcItemVal.get("O_RTN").toString())){
	            	throw new BizException(retProcItemVal.get("O_RTNMSG").toString());
	            }
	            
	            
	            // 기부업장 FMS_SALES 데이터 삭제
	            param2.put("saleDate", rsDonaUpjangList.get(z).get("saleDate"));
	            param2.put("upjang", rsDonaUpjangList.get(z).get("upjang"));
	            
	            dayCloseMngtDAO.fmssalesDelete(param2);
			} 
        	
        }
        

        //여신집계 
        retProcItemVal.put("O_RTN", "TRUE");
        retProcItemVal.put("O_RTNMSG", "");
        
		return retProcItemVal;
	}
	
	
	/**
	 * 일마감 관리에 마감취소처리를 한다.
	 *
	 * @param list , search
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 에러메세지
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public Map<String, Object> cncl(DataSetMap list,Map<String, Object> search) throws Exception {
		 Map<String, Object> retProcItemVal = new HashMap<String, Object>();
		 
		/**
		  * 리스트가 있는 경우. PG_FM_SALE_MAGAM프로시저 실행
		**/
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			if("1".equals(rowData.get("chk2").toString())){
				Map<String, Object> param = new HashMap<String, Object>();
				param.put("p_receipt_num", rowData.get("receiptNum")); //매출일자
				param.put("p_sub_upjang_cd"	, rowData.get("upjang")); 		//매출_업장
				param.put("p_occur_date"	, rowData.get("saleDate")); 	//회계일자
				param.put("p_sys_class"		, "13"); 						//시스템구분(13)				
				//PG_FM_SALE_MAGAM
	            retProcItemVal  = dayCloseMngtDAO.sp_Fm_Sale_Cncl_Sla_If_Proc(param);
	            if("FALSE".equals(retProcItemVal.get("O_RTN").toString())){
	            	throw new BizException(retProcItemVal.get("O_RTNMSG").toString());
	            }
			}
		}
		return retProcItemVal;
	}
	
	/**
	 * 일마감관리(을)를 재집계 처리한다.
	 *
	 * @param list , search
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 에러메세지
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public Map<String, Object> remagam(DataSetMap list,Map<String, Object> search) throws Exception {
		Map<String, Object> retProcItemVal = new HashMap<String, Object>();
		 
		/**
		  * 일마감관리 재집계 처리.
		  * 1.FMS_SALES 데이터 삭제
		  * 2.fm_sale_magam 프로시저 호출
		**/
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> rowData = list.get(i);
			
			if("1".equals(rowData.get("chk1").toString())){
				RecordSet retVal = dayCloseMngtDAO.fmssalesDupCheck(rowData);
				Map<String,Object> rtnMap = retVal.get(0);
				if ( "FALSE".equals(rtnMap.get("chk").toString()) ) {
					String Msg = rowData.get("saleDate")+"일자 ["+rowData.get("upjangNm")+" - "+rowData.get("subinvName")+"] 내역이 마감처리되어 재집계가 불가합니다.";
						   Msg += "\r\n매출목록을 재조회 후 재집계 대상을 다시 선택하세요.";
					throw new BizException(Msg);
				}
				
		        int delCnt = dayCloseMngtDAO.fmssalesDelete(rowData);
		        
	            if(delCnt > 0){
					Map<String, Object> param = new HashMap<String, Object>();
					
					param.put("p_sale_date"		, rowData.get("saleDate")); 	//매출일자
					param.put("p_upjang"		, rowData.get("upjang")); 		//사업장
					param.put("p_subinv_code"	, ""); 							//공장
					param.put("p_user"			, search.get("loginSabun")); 	//처리자
					
					//정상분 : SP_FM_SALE_MAGAM_PROC
	                retProcItemVal  = dayCloseMngtDAO.closing(param);
		            if("FALSE".equals(retProcItemVal.get("O_RTN").toString())){
		            	throw new BizException(retProcItemVal.get("O_RTNMSG").toString());
		            }
		            //조정분 : SP_FM_SALE_MOD_MAGAM_PROC
		            retProcItemVal  = dayCloseMngtDAO.sp_Fm_Sale_Mod_Magam_Proc(param);
		            if("FALSE".equals(retProcItemVal.get("O_RTN").toString())){
		            	throw new BizException(retProcItemVal.get("O_RTNMSG").toString());
		            }
	            }
			}
		}
		retProcItemVal.put("O_RTN", "TRUE");
		return retProcItemVal;
	}
	
//	public Map<String, Object> slaCncl(DataSetMap list,Map<String, Object> search) throws Exception {
//		Map<String, Object> retProcItemVal = new HashMap<String, Object>();
//		
//		Map<String, Object> rowData = list.get(0);
//		Map<String, Object> param = new HashMap<String, Object>();
//		
//		param.put("p_occur_date", rowData.get("saleDate")); //회계일자
//		param.put("p_sys_class", "13"); //시스템구분(13)
//		param.put("p_upjang_cd", rowData.get("upjang2")); 		//채권_업장
//		param.put("p_sub_upjang_cd", rowData.get("upjang")); 	//매출_업장
//		
//		//SP_SLA_SALS_POS_UPJANG_CANCEL
//        retProcItemVal  = dayCloseMngtDAO.sp_Sla_Sals_Pos_Upjang_Cancel_Proc(param);
//        
//        if("FALSE".equals(retProcItemVal.get("O_RTN").toString())){
//        	throw new BizException(retProcItemVal.get("O_RTNMSG").toString());
//        }
//        
//		return retProcItemVal;
//	}
	
	/**
	 * 영업회계 일마감 관리에 마감취소처리를 한다.
	 *
	 * @param search
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 에러메세지
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public Map<String, Object> slaCncl(DataSetMap list, Map<String, Object> search) throws Exception {
		Map<String, Object> retProcItemVal = new HashMap<String, Object>();
		//Map<String, Object> retProcItemVal2 = new HashMap<String, Object>();
		
		for(int i = 0; i < list.size(); i++){
			Map<String, Object> rowData = list.get(i);
			Map<String, Object> param = new HashMap<String, Object>();

			if("1".equals(rowData.get("chk2").toString())){
				param.put("p_occur_date"	, rowData.get("saleDate")); 	//회계일자
				param.put("p_sub_upjang_cd"	, rowData.get("upjang")); 		//매출_업장
				param.put("p_upjang_cd"		, rowData.get("upjang2")); 		//채권_업장
				param.put("p_receipt_num"	, rowData.get("receiptNum")); 	//매출일자
				param.put("p_sys_class"		, "13"); 						//시스템구분(13)
				
				//SP_SLA_SALS_POS_UPJANG_CANCEL
		        retProcItemVal = dayCloseMngtDAO.sp_Sla_Sals_Pos_Upjang_Cancel_Proc(param);
		        if("FALSE".equals(retProcItemVal.get("O_RTN").toString())){
		        	throw new BizException(retProcItemVal.get("O_RTNMSG").toString());
		        }
		        
		        //SP_FM_SALE_CNCL_SLA_IF_PROC
	            retProcItemVal  = dayCloseMngtDAO.sp_Fm_Sale_Cncl_Sla_If_Proc(param);
	            if("FALSE".equals(retProcItemVal.get("O_RTN").toString())){
	            	throw new BizException(retProcItemVal.get("O_RTNMSG").toString());
	            }
			}
		}
		
		return retProcItemVal; 
	}
	
	public String nvls(Object col) throws Exception{
		if(col == null)
			return "";
		else
			return StringUtil.null2string(col.toString(), "");
	}
	
	/**
	 * 전체 일마감 권한을 조회한다.
	 * 추가일자:20170323  처리자:맹수영  요청자:이혜은
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectAllClose(Map<String, Object> mapParam) throws Exception {
		return dayCloseMngtDAO.selectAllClose(mapParam);
	}
	
	/**
	 * 미일마감 목록을 조회한다.
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
	public RecordSet selectCheckClose(Map<String, Object> mapParam) throws Exception {
		
		RecordSet rs = dayCloseMngtDAO.selectCheckCloseDayInfo(mapParam);
		mapParam.put("pivotInfo", rs.get(0).get("dateInfo").toString());
		return dayCloseMngtDAO.selectCheckClose(mapParam);
	}

	/**
	 * selectCheckCloseDayInfo 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 * @see com.hwfs.fm.fmf.service.DayCloseMngtService#selectCheckCloseDayInfo(java.util.Map)
	*/
	@Override
	public RecordSet selectCheckCloseDayInfo(Map<String, Object> mapParam) throws Exception {
		return dayCloseMngtDAO.selectCheckCloseDayInfo(mapParam);
	}
	
		/**
	 * 여신 집계 프로시처 호출 용 temp 테이블 조회
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectTemp(Map<String, Object> mapParam) throws Exception {
		return dayCloseMngtDAO.selectTemp(mapParam);
	}	
	
	
}
