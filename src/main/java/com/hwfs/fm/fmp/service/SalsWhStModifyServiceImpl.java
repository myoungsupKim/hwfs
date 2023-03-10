package com.hwfs.fm.fmp.service;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.fm.fmp.dao.SalsWhStModifyDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.tobesoft.xplatform.data.DataSet;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

/**
 * 매출창고 강제변경 ServiceImple Class
 *
 * @ClassName SalsWhStModifyServiceImple.java
 * @Description SalsWhStModifyServiceImple Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 8. 21.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 8. 21.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fmp/salsWhStModifyService")
public class SalsWhStModifyServiceImpl extends DefaultServiceImpl implements SalsWhStModifyService {

    @Resource(name = "/fm/fmp/salsWhStModifyDAO")
    private SalsWhStModifyDAO salsWhStModifyDAO;

    /**
     * 매출창고 강제변경 목록을 조회한다
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.fm.fmp.service.SalsWhStModifyService#selectList(java.util.Map)
    */
    @Override
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return salsWhStModifyDAO.selectList(parameter);
    }

    /**
     * 사업장 창고 정보 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.fm.fmp.service.SalsWhStModifyService#selectDdayList(java.util.Map)
    */
    @Override
    public RecordSet selectUpjangWh(Map<String, Object> parameter) throws Exception {
        return salsWhStModifyDAO.selectUpjangWh(parameter);
    }

    /**
     * 변경후 창고 정보 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.fm.fmp.service.SalsWhStModifyService#selectUpjangWhChg(java.util.Map)
    */
    @Override
    public RecordSet selectUpjangWhChg(Map<String, Object> parameter) throws Exception {
        return salsWhStModifyDAO.selectUpjangWhChg(parameter);
    }

    /**
     * 창고별 일괄 저장한다.
     *
     * @param param
     * @param saveList
     * @return
     * @throws Exception
     * @see com.hwfs.fm.fmp.service.SalsWhStModifyService#modifyAllList(java.util.Map, hone.online.xplatform.map.DataSetMap)
    */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> modifyAllList(Map<String, Object> param, DataSetMap saveList) throws Exception {
    	Map<String, Object> retProcItemVal = new HashMap<String, Object>();
        int procCnt = 0;
        Map<String, Object> parameter = null;
        int rowType = 0;
        String strChk = "0";
		double saleAmt  = 0; //발생금액

		if ( !chkCanChangWh(param) ) {
			throw new BizException("변경 후 창고(업장)의 가용 여신 금액이 부족합니다.");
		}
		
        for (int i = 0; i < saveList.size(); i++) {
            parameter = saveList.get(i);
            rowType = ((Integer) parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
            if (rowType == DataSet.ROW_TYPE_UPDATED) {
                strChk = LimsUtil.checkNull(parameter.get("chk"));
                if ("1".equals(strChk)) {
                    parameter.put("subinv", LimsUtil.checkNull(param.get("subinv")));
                    parameter.put("upjang", LimsUtil.checkNull(param.get("upjang")));
                    parameter.put("subinvCodeChg", LimsUtil.checkNull(param.get("subinvCodeChg")));
                    parameter.put("upjangChg", LimsUtil.checkNull(param.get("upjangChg")));
             
                    
                    procCnt += salsWhStModifyDAO.modifyList(parameter);
                    procCnt += salsWhStModifyDAO.modifyList2(parameter);
                    procCnt += salsWhStModifyDAO.modifyList3(parameter);
                    
                    //이력테이블 저장 추가 2021.09.09
                    procCnt += salsWhStModifyDAO.insertHistory(parameter);
             
            		//여신집계
					saleAmt  = 0;
            		//여신집계
					if (String.valueOf(parameter.get("taxCode")).equals("100")) {
						saleAmt = Math.round(Double.parseDouble(String.valueOf(parameter.get("saleAmount")))*1.1);
					} else {
						saleAmt = Double.parseDouble(String.valueOf(parameter.get("saleAmount")));
					}

                    parameter.put("p_upjang_cd", String.valueOf(parameter.get("upjangChg"))); //변경되는 업장
                    parameter.put("p_apply_date", String.valueOf(parameter.get("transDate"))); //적용일자
                    parameter.put("p_occur_class", String.valueOf("12")); //발생구분			
                    //parameter.put("p_occur_amt", String.valueOf(parameter.get("saleAmount"))); //발생금액	
                    parameter.put("p_occur_amt", saleAmt); //발생금액
                    parameter.put("p_occur_amt_before", String.valueOf("")); //발생전금액		
                    parameter.put("p_class_cd", String.valueOf("04")); //구분코드
                    parameter.put("p_occur_table", String.valueOf("HLDC_PO_TRANSACTION_SALE")); //발생테이블
                    parameter.put("p_key_nm", String.valueOf("TRANS_ID")); //키명
                    parameter.put("p_key_value01", String.valueOf(parameter.get("transId"))); //키값1
                    parameter.put("p_key_value02", String.valueOf(parameter.get(""))); //변경 전 업장		
                    parameter.put("p_key_value03", String.valueOf("")); //키값3
                    parameter.put("p_key_value04", String.valueOf("")); //키값4
                    parameter.put("p_key_value05", String.valueOf("")); //키값5
                    parameter.put("p_occur_prg_id", String.valueOf("salsWhStModify")); //프로그램ID
                    parameter.put("p_occur_prg_nm", String.valueOf("매출창고강제변경")); //프로그램명
                    parameter.put("p_cuser", String.valueOf(parameter.get("loginSabun"))); //처리자	
            			retProcItemVal  = salsWhStModifyDAO.sp_Fms_Credit_Sum_Proc(parameter);
            			//String strRtn1		= String.valueOf(retProcItemVal.get("O_RTN"));
                		//String strRtnMsg1	= String.valueOf(retProcItemVal.get("O_RTNMSG"));
                        if("FALSE".equals(retProcItemVal.get("O_RTN").toString())){
                        	throw new BizException(retProcItemVal.get("O_RTNMSG").toString());
                        }			
            			

                        parameter.put("p_upjang_cd", String.valueOf(parameter.get("upjang"))); //변경되는 업장
                        parameter.put("p_apply_date", String.valueOf(parameter.get("transDate"))); //적용일자
                        parameter.put("p_occur_class", String.valueOf("12")); //발생구분			
                        parameter.put("p_occur_amt", String.valueOf("")); //발생금액	
                        //parameter.put("p_occur_amt_before", String.valueOf(parameter.get("saleAmount"))); //발생전금액	
                        parameter.put("p_occur_amt_before", saleAmt); //발생전금액		
                        parameter.put("p_class_cd", String.valueOf("04")); //구분코드
                        parameter.put("p_occur_table", String.valueOf("HLDC_PO_TRANSACTION_SALE")); //발생테이블
                        parameter.put("p_key_nm", String.valueOf("TRANS_ID")); //키명
                        parameter.put("p_key_value01", String.valueOf(parameter.get("transId"))); //키값1
                        parameter.put("p_key_value02", String.valueOf(parameter.get(""))); //변경 전 업장		
                        parameter.put("p_key_value03", String.valueOf("")); //키값3
                        parameter.put("p_key_value04", String.valueOf("")); //키값4
                        parameter.put("p_key_value05", String.valueOf("")); //키값5
                        parameter.put("p_occur_prg_id", String.valueOf("salsWhStModify")); //프로그램ID
                        parameter.put("p_occur_prg_nm", String.valueOf("매출창고강제변경")); //프로그램명
                        parameter.put("p_cuser", String.valueOf(parameter.get("loginSabun"))); //처리자	
                			retProcItemVal  = salsWhStModifyDAO.sp_Fms_Credit_Sum_Proc(parameter);
                			//String strRtn1		= String.valueOf(retProcItemVal.get("O_RTN"));
                    		//String strRtnMsg1	= String.valueOf(retProcItemVal.get("O_RTNMSG"));
                            if("FALSE".equals(retProcItemVal.get("O_RTN").toString())){
                            	throw new BizException(retProcItemVal.get("O_RTNMSG").toString());
                            }	
            		
                  //여신집계
                }
            }
        }

        Map<String, Object> retVal = new HashMap<String, Object>();
        retVal.put("procCnt", procCnt);

        return retVal;
    }
    
    
    /*
     * 가용 여신 금액 내 매출창고 변경여부 확인
     * 
     */
    public boolean chkCanChangWh(Map<String, Object> param) throws Exception {
    	//double saleAmt = Double.parseDouble(String.valueOf(param.get("saleAmt")));
    	RecordSet rs = salsWhStModifyDAO.selectUpjangCredit(param);
    	
    	return ( "1".equals(rs.get(0).getString("chkAble")) );
    }
    
    /*
     * 가용 여신 금액 내 매출창고 변경여부 확인
     * 
     */
    public RecordSet selectSubinvCredit(Map<String, Object> param) throws Exception {
    	return salsWhStModifyDAO.selectUpjangCredit(param);
    	
    }
}
