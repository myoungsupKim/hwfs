package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.fm.fms.dao.SalePriceStChgDAO;

 /**
 * 판매단가를 강제변경하는 SalePriceStChg Service Implementation
 * 
 * @ClassName SalePriceStChgServiceImpl.java
 * @Description SalePriceStChgServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.24    최성연        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.04.24
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fms/salePriceStChgService")
public class SalePriceStChgServiceImpl extends DefaultServiceImpl implements SalePriceStChgService {
	
	/** SalePriceStChgDAO Bean 생성 */
	@Resource(name = "/fm/fms/salePriceStChgDAO")
	private SalePriceStChgDAO salePriceStChgDAO;
	

	/**
	 * 판매단가 강제변경 목록을 조회한다.
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
		return salePriceStChgDAO.selectList(mapParam);
	}

	/**
	 * 판매단가 강제변경 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
		Map<String, Object> retProcItemVal = new HashMap<String, Object>();
		int updRowCnt = 0;
		int updRowCnt1 = 0;
		int updRowCnt2 = 0;
		int updRowCnt3 = 0;
		int delRowCnt = 0;
		int insRowCnt = 0;		
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			//int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			// 처리 순서
			delRowCnt += salePriceStChgDAO.delete(rowData);  //temp 테이블 삭제
			insRowCnt += salePriceStChgDAO.insert(rowData);  //temp 테이블에 인서트
			updRowCnt3 += salePriceStChgDAO.updateTemp(rowData);  //temp 테이블에 인서트
			
			// 1. SO_PR UPDATE
			updRowCnt += salePriceStChgDAO.update(rowData);
			// 2. PO_PO UPDATE
			updRowCnt1 += salePriceStChgDAO.update1(rowData);
			// 3. PO_TRANSACTION UPDATE : SALE_PRICE
			updRowCnt2 += salePriceStChgDAO.update2(rowData);
			// 4. PO_TRANSACTION UPDATE : SALE_AMOUNT 외
			//updRowCnt3 += salePriceStChgDAO.update3(rowData);
		}
		
		//service imple
		//여신집계
		RecordSet rs = salePriceStChgDAO.selectTemp(retProcItemVal);
        for(int i = 0 ; i < rs.size(); i ++){
        	
            
        	Map<String, Object> rowData = rs.get(i);
            Map<String, Object> ppMap = new HashMap<String, Object>();
            
            //001: 신청저장인 상태는 매입예정
            if ("001".equals(String.valueOf(rowData.get("lineStatus"))))  {
                ppMap.put("p_upjang_cd", String.valueOf(rowData.get("upjang"))); //업장코드
    			ppMap.put("p_apply_date", String.valueOf(rowData.get("saleDate"))); //적용일자
    			ppMap.put("p_occur_class", String.valueOf("01")); //발생구분			
    			ppMap.put("p_occur_amt", String.valueOf(rowData.get("chgAmt"))); //발생금액	
    			ppMap.put("p_occur_amt_before", String.valueOf(rowData.get("oriAmt"))); //발생전금액		
    			ppMap.put("p_class_cd", String.valueOf("03")); //구분코드
    			ppMap.put("p_occur_table", String.valueOf("SO_PR")); //발생테이블
    			ppMap.put("p_key_nm", String.valueOf("PR_NUM")); //키명
    			ppMap.put("p_key_value01", String.valueOf(rowData.get("prNum"))); //키값1
    			ppMap.put("p_key_value02", String.valueOf("")); //키값2		
    			ppMap.put("p_key_value03", String.valueOf("")); //키값3
    			ppMap.put("p_key_value04", String.valueOf("")); //키값4
    			ppMap.put("p_key_value05", String.valueOf("")); //키값5
    			ppMap.put("p_occur_prg_id", String.valueOf("salePriceStChg")); //프로그램ID
    			ppMap.put("p_occur_prg_nm", String.valueOf("판매단가강제변경")); //프로그램명
    			ppMap.put("p_cuser", String.valueOf(rowData.get("sabun"))); //처리자	
    			retProcItemVal  = salePriceStChgDAO.sp_Fms_Credit_Sum_Proc(ppMap);
            } 
            else 
            {
            	  //003:신청취소,005:결의반려, PD: 발주취소, 999: 엑셀 임시저장 인 건은 제외
            	  if  ("003".equals(String.valueOf(rowData.get("lineStatus"))) || "005".equals(String.valueOf(rowData.get("lineStatus")))
            			  || "PD".equals(String.valueOf(rowData.get("lineStatus"))) || "999".equals(String.valueOf(rowData.get("lineStatus")))
            			  || "PD".equals(String.valueOf(rowData.get("poLineStatus"))) || "PR".equals(String.valueOf(rowData.get("poLineStatus")))
            			  || "RD".equals(String.valueOf(rowData.get("poLineStatus")))){
            		    ppMap.put("p_upjang_cd", String.valueOf(rowData.get("upjang"))); //업장코드
		    			ppMap.put("p_apply_date", String.valueOf(rowData.get("saleDate"))); //적용일자
		    			ppMap.put("p_occur_class", String.valueOf("02")); //발생구분			
		    			ppMap.put("p_occur_amt", String.valueOf("0")); //발생금액	
		    			ppMap.put("p_occur_amt_before", String.valueOf("0")); //발생전금액		
		    			ppMap.put("p_class_cd", String.valueOf("03")); //구분코드
		    			ppMap.put("p_occur_table", String.valueOf("SO_PR")); //발생테이블
		    			ppMap.put("p_key_nm", String.valueOf("PR_NUM")); //키명
		    			ppMap.put("p_key_value01", String.valueOf(rowData.get("prNum"))); //키값1
		    			ppMap.put("p_key_value02", String.valueOf("")); //키값2		
		    			ppMap.put("p_key_value03", String.valueOf("")); //키값3
		    			ppMap.put("p_key_value04", String.valueOf("")); //키값4
		    			ppMap.put("p_key_value05", String.valueOf("")); //키값5
		    			ppMap.put("p_occur_prg_id", String.valueOf("salePriceStChg")); //프로그램ID
		    			ppMap.put("p_occur_prg_nm", String.valueOf("판매단가강제변경")); //프로그램명
		    			ppMap.put("p_cuser", String.valueOf(rowData.get("sabun"))); //처리자	
		    			retProcItemVal  = salePriceStChgDAO.sp_Fms_Credit_Sum_Proc(ppMap);   
            	  } 
            	  else 
            	  {
            		//입고완료인 상태는 매입확정 나머지는 매입예정  
            		if ("GC".equals(String.valueOf(rowData.get("poLineStatus")))) {  
		                ppMap.put("p_upjang_cd", String.valueOf(rowData.get("upjang"))); //업장코드
		    			ppMap.put("p_apply_date", String.valueOf(rowData.get("saleDate"))); //적용일자
		    			ppMap.put("p_occur_class", String.valueOf("02")); //발생구분			
		    			ppMap.put("p_occur_amt", String.valueOf(rowData.get("chgAmt"))); //발생금액	
		    			ppMap.put("p_occur_amt_before", String.valueOf(rowData.get("oriAmt"))); //발생전금액		
		    			ppMap.put("p_class_cd", String.valueOf("03")); //구분코드
		    			ppMap.put("p_occur_table", String.valueOf("SO_PR")); //발생테이블
		    			ppMap.put("p_key_nm", String.valueOf("PR_NUM")); //키명
		    			ppMap.put("p_key_value01", String.valueOf(rowData.get("prNum"))); //키값1
		    			ppMap.put("p_key_value02", String.valueOf("")); //키값2		
		    			ppMap.put("p_key_value03", String.valueOf("")); //키값3
		    			ppMap.put("p_key_value04", String.valueOf("")); //키값4
		    			ppMap.put("p_key_value05", String.valueOf("")); //키값5
		    			ppMap.put("p_occur_prg_id", String.valueOf("salePriceStChg")); //프로그램ID
		    			ppMap.put("p_occur_prg_nm", String.valueOf("판매단가강제변경")); //프로그램명
		    			ppMap.put("p_cuser", String.valueOf(rowData.get("sabun"))); //처리자	
		    			retProcItemVal  = salePriceStChgDAO.sp_Fms_Credit_Sum_Proc(ppMap);   
            		} else {
            			ppMap.put("p_upjang_cd", String.valueOf(rowData.get("upjang"))); //업장코드
            			ppMap.put("p_apply_date", String.valueOf(rowData.get("saleDate"))); //적용일자
            			ppMap.put("p_occur_class", String.valueOf("01")); //발생구분			
            			ppMap.put("p_occur_amt", String.valueOf(rowData.get("chgAmt"))); //발생금액	
            			ppMap.put("p_occur_amt_before", String.valueOf(rowData.get("oriAmt"))); //발생전금액		
            			ppMap.put("p_class_cd", String.valueOf("03")); //구분코드
            			ppMap.put("p_occur_table", String.valueOf("SO_PR")); //발생테이블
            			ppMap.put("p_key_nm", String.valueOf("PR_NUM")); //키명
            			ppMap.put("p_key_value01", String.valueOf(rowData.get("prNum"))); //키값1
            			ppMap.put("p_key_value02", String.valueOf("")); //키값2		
            			ppMap.put("p_key_value03", String.valueOf("")); //키값3
            			ppMap.put("p_key_value04", String.valueOf("")); //키값4
            			ppMap.put("p_key_value05", String.valueOf("")); //키값5
            			ppMap.put("p_occur_prg_id", String.valueOf("salePriceStChg")); //프로그램ID
            			ppMap.put("p_occur_prg_nm", String.valueOf("판매단가강제변경")); //프로그램명
            			ppMap.put("p_cuser", String.valueOf(rowData.get("sabun"))); //처리자	
            			retProcItemVal  = salePriceStChgDAO.sp_Fms_Credit_Sum_Proc(ppMap);
            	    
            		}
            	  }
            }
			
			
            if("FALSE".equals(retProcItemVal.get("O_RTN").toString())){
            	throw new BizException(retProcItemVal.get("O_RTNMSG").toString());
            }			
			

    		//if(!"TRUE".equals(strRtn1)){
    		//	throw new BizException(strRtnMsg1);
            //}				
		
        }	
		
      //여신집계
			
		
		
		
		
		
		
				
		// Update 처리건수 Return
		return updRowCnt + updRowCnt1 + updRowCnt2;
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
		return salePriceStChgDAO.selectTemp(mapParam);
	}	
	
	
	
	/**
	 * 판매단가 강제변경 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList2(DataSetMap list) throws Exception {
		int updRowCnt = 0;
		int updRowCnt1 = 0;
		int updRowCnt2 = 0;
		int updRowCnt3 = 0;	
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			//int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			// 1. SO_PR UPDATE
			updRowCnt += salePriceStChgDAO.update_old2(rowData);
			// 2. PO_PO UPDATE
			updRowCnt1 += salePriceStChgDAO.update1_old2(rowData);
			// 3. PO_TRANSACTION UPDATE : SALE_PRICE
			updRowCnt2 += salePriceStChgDAO.update2_old2(rowData);
			// 4. PO_TRANSACTION UPDATE : SALE_AMOUNT 외
			//updRowCnt3 += salePriceStChgDAO.update3(rowData);
		}
				
		// Update 처리건수 Return
		return updRowCnt + updRowCnt1 + updRowCnt2;
	}

}
