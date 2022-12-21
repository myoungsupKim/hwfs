package com.hwfs.rc.sle.service;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.sle.dao.EodMgmtDAO;

 /**
 * EodMgmtServiceImpl에 대한 설명 작성
 * @ClassName EodMgmtServiceImpl.java
 * @Description EodMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 6. 15.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 :외식영업(POS영업관리)
 * @since 2015. 6. 15.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/sle/eodMgmtService")
public class EodMgmtServiceImpl extends DefaultServiceImpl implements EodMgmtService {
	@Resource(name="/rc/sle/eodMgmtDAO")
	private EodMgmtDAO eodMgmt;
	
	
	@Override
	public RecordSet eodList(Map<String, Object> parameter) throws Exception {
		return eodMgmt.eodList(parameter);
	}
	
	@Override
	public RecordSet eodAllList(Map<String, Object> parameter) throws Exception {
		return eodMgmt.eodAllList(parameter);
	}

	@Override
	public RecordSet endOfDayList(Map<String, Object> parameter) throws Exception {
		return eodMgmt.endOfDayList(parameter);
	}
	
	//자재
	@Override
	public Map<String, Object> fopostrInfo(Map<String, Object> parameter) throws Exception {
		
		Map<String, Object> p   = new HashMap<String, Object>();
		Map<String, Object> eod = new HashMap<String, Object>();
		Map<String, Object> data = new HashMap<String, Object>();
		
		RecordSet chkRsSet = eodMgmt.ListOutlet(parameter);	//해당 업장을 읽어 온다.
		
		if(chkRsSet != null && chkRsSet.size() > 0) {
			for (int i = 0 ; i < chkRsSet.size() ; i++) {
				Map<String, Object> parameterOutlet = chkRsSet.get(i);
				
				data.put("muCd",     parameterOutlet.get("muCd").toString());
				data.put("tmCd",     parameterOutlet.get("tmCd").toString());
				data.put("outletCd", parameterOutlet.get("outletCd").toString());
				data.put("salesDt", parameter.get("salesDt").toString());
				data.put("empNo",    parameter.get("empNo").toString());
				
				
				p.put("V_DATE",        data.get("salesDt"));
				p.put("V_MUCD",        data.get("muCd"));
				p.put("V_TMCD",        data.get("tmCd"));
				p.put("V_OUTLET_CD",   data.get("outletCd")); 
			    p.put("V_LOGIN_SABUN", data.get("empNo"));
			     
			    
			    Map<String, Object> rtn  = eodMgmt.fopostrInfo(p);
			    
			    eod.put("outletCd", data.get("outletCd"));
			    eod.put("salesDt",  data.get("salesDt"));
			    eod.put("eodSeq",   "100");
			    eod.put("eodNm",    "자재 정보");
			    eod.put("oRtn",     rtn.get("O_RTN").toString());
			    eod.put("oRtnmsg",  rtn.get("O_RTNMSG").toString());
			    
			    eodMgmt.insertData(eod);	//내역을 저장 한다.
			      
			    
			}
			
		}
		p.put("O_RTN", "TRUE");
		p.put("O_RTNMSG", "매출 정보  마감처리 완료");
		return p;
	}
	
	//매출 정보 (영업회계)
	@Override
	public Map<String, Object> salesInfo(Map<String, Object> parameter) throws Exception {
		 
		Map<String, Object> p   = new HashMap<String, Object>();
		Map<String, Object> eod = new HashMap<String, Object>();
		Map<String, Object> data = new HashMap<String, Object>();
		
		RecordSet chkRsSet = eodMgmt.ListOutlet(parameter);	//해당 업장을 읽어 온다.
		
		if(chkRsSet != null && chkRsSet.size() > 0) {
			for (int i = 0 ; i < chkRsSet.size() ; i++) {
				Map<String, Object> parameterOutlet = chkRsSet.get(i);
				
				data.put("muCd",     parameterOutlet.get("muCd").toString());
				data.put("tmCd",     parameterOutlet.get("tmCd").toString());
				data.put("outletCd", parameterOutlet.get("outletCd").toString());
				data.put("salesDt", parameter.get("salesDt").toString());
				data.put("empNo",    parameter.get("empNo").toString());
				
				
				p.put("V_DATE",        data.get("salesDt"));
				p.put("V_MUCD",        data.get("muCd"));
				p.put("V_TMCD",        data.get("tmCd"));
				p.put("V_OUTLET_CD",   data.get("outletCd")); 
			    p.put("V_LOGIN_SABUN", data.get("empNo"));
			     
			    
			    Map<String, Object> rtn  = eodMgmt.salesInfo(p);
			    
			    eod.put("outletCd", data.get("outletCd"));
			    eod.put("salesDt",  data.get("salesDt"));
			    eod.put("eodSeq",   "200");
			    eod.put("eodNm",    "매출 정보 (영업회계)");
			    eod.put("oRtn",     rtn.get("O_RTN").toString());
			    eod.put("oRtnmsg",  rtn.get("O_RTNMSG").toString());
			    
			    eodMgmt.insertData(eod);	//내역을 저장 한다.
			      
			    
			}
			
		}
		p.put("O_RTN", "TRUE");
		p.put("O_RTNMSG", "매출 정보  마감처리 완료");
		return p;
	}
	
	//매출 상세 정보 (영업회계)
	@Override
	public Map<String, Object> salesDetailInfo(Map<String, Object> parameter) throws Exception {
		Map<String, Object> p   = new HashMap<String, Object>();
		Map<String, Object> eod = new HashMap<String, Object>();
		Map<String, Object> data = new HashMap<String, Object>();
		
		RecordSet chkRsSet = eodMgmt.ListOutlet(parameter);	//해당 업장을 읽어 온다.
		
		if(chkRsSet != null && chkRsSet.size() > 0) {
			for (int i = 0 ; i < chkRsSet.size() ; i++) {
				Map<String, Object> parameterOutlet = chkRsSet.get(i);
				
				data.put("muCd",     parameterOutlet.get("muCd").toString());
				data.put("tmCd",     parameterOutlet.get("tmCd").toString());
				data.put("outletCd", parameterOutlet.get("outletCd").toString());
				data.put("salesDt",  parameter.get("salesDt").toString());
				data.put("empNo",    parameter.get("empNo").toString());
				
				
				p.put("V_DATE",        data.get("salesDt"));
				p.put("V_MUCD",        data.get("muCd"));
				p.put("V_TMCD",        data.get("tmCd"));
				p.put("V_OUTLET_CD",   data.get("outletCd")); 
			    p.put("V_LOGIN_SABUN", data.get("empNo"));
			     
			    Map<String, Object> rtn  = eodMgmt.salesDetailInfo(p);
				
				eod.put("outletCd", data.get("outletCd"));
			    eod.put("salesDt",  data.get("salesDt"));
			    eod.put("eodSeq",   "300");
			    eod.put("eodNm",    "매출 상세 정보 (영업회계)");
			    eod.put("oRtn",     rtn.get("O_RTN").toString());
			    eod.put("oRtnmsg",  rtn.get("O_RTNMSG").toString());
			    
			    eodMgmt.insertData(eod);	//내역을 저장 한다.
			      
			    
			}
			
		}
		p.put("O_RTN", "TRUE");
		p.put("O_RTNMSG", "매출 상세 정보  마감처리 완료");
		return p;
	}
	//매출 지불 정보 (영업회계)
	@Override
	public Map<String, Object> salesPaymentInfo(Map<String, Object> parameter) throws Exception {

		Map<String, Object> p   = new HashMap<String, Object>();
		Map<String, Object> eod = new HashMap<String, Object>();
		Map<String, Object> data = new HashMap<String, Object>();
		
		RecordSet chkRsSet = eodMgmt.ListOutlet(parameter);	//해당 업장을 읽어 온다.
		
		if(chkRsSet != null && chkRsSet.size() > 0) {
			for (int i = 0 ; i < chkRsSet.size() ; i++) {
				Map<String, Object> parameterOutlet = chkRsSet.get(i);
				
				data.put("muCd",     parameterOutlet.get("muCd").toString());
				data.put("tmCd",     parameterOutlet.get("tmCd").toString());
				data.put("outletCd", parameterOutlet.get("outletCd").toString());
				data.put("salesDt",  parameter.get("salesDt").toString());
				data.put("empNo",    parameter.get("empNo").toString());
				
				
				p.put("V_DATE",        data.get("salesDt"));
				p.put("V_MUCD",        data.get("muCd"));
				p.put("V_TMCD",        data.get("tmCd"));
				p.put("V_OUTLET_CD",   data.get("outletCd")); 
			    p.put("V_LOGIN_SABUN", data.get("empNo"));
			     
			    
			    Map<String, Object> rtn  = eodMgmt.salesPaymentInfo(p);

				eod.put("outletCd", data.get("outletCd"));
			    eod.put("salesDt",  data.get("salesDt"));
			    eod.put("eodSeq",   "400");
			    eod.put("eodNm",    "매출 지불 정보 (영업회계)");
			    eod.put("oRtn",     rtn.get("O_RTN").toString());
			    eod.put("oRtnmsg",  rtn.get("O_RTNMSG").toString());
			    
			    eodMgmt.insertData(eod);	//내역을 저장 한다.
			      
			    
			}
			
		}
		p.put("O_RTN", "TRUE");
		p.put("O_RTNMSG", "매출 지불 정보  마감처리 완료");
		return p;
	}
	
	//카드 승인정보 
	@Override
	public Map<String, Object> cardApprovalInfo(Map<String, Object> parameter) throws Exception {
		Map<String, Object> p   = new HashMap<String, Object>();
		Map<String, Object> eod = new HashMap<String, Object>();
		Map<String, Object> data = new HashMap<String, Object>();
		
		RecordSet chkRsSet = eodMgmt.ListOutlet(parameter);	//해당 업장을 읽어 온다.
		
		if(chkRsSet != null && chkRsSet.size() > 0) {
			for (int i = 0 ; i < chkRsSet.size() ; i++) {
				Map<String, Object> parameterOutlet = chkRsSet.get(i);
				
				data.put("muCd",     parameterOutlet.get("muCd").toString());
				data.put("tmCd",     parameterOutlet.get("tmCd").toString());
				data.put("outletCd", parameterOutlet.get("outletCd").toString());
				data.put("salesDt",  parameter.get("salesDt").toString());
				data.put("empNo",    parameter.get("empNo").toString());
				
				
				p.put("V_DATE",        data.get("salesDt"));
				p.put("V_MUCD",        data.get("muCd"));
				p.put("V_TMCD",        data.get("tmCd"));
				p.put("V_OUTLET_CD",   data.get("outletCd")); 
			    p.put("V_LOGIN_SABUN", data.get("empNo"));
			     
			    
			    Map<String, Object> rtn  =  eodMgmt.cardApprovalInfo(p);

				eod.put("outletCd", data.get("outletCd"));
			    eod.put("salesDt",  data.get("salesDt"));
			    eod.put("eodSeq",   "500");
			    eod.put("eodNm",    "카드 승인 정보 (영업회계)");
			    eod.put("oRtn",     rtn.get("O_RTN").toString());
			    eod.put("oRtnmsg",  rtn.get("O_RTNMSG").toString());
			    
			    eodMgmt.insertData(eod);	//내역을 저장 한다.
			      
			    
			}
			
		}
		p.put("O_RTN", "TRUE");
		p.put("O_RTNMSG", "카드승인정보  마감처리 완료");
		return p;
	}
	
	
	
	/**
	 * salesSum 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.EodMgmtService#salesSum(hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	public Map<String, Object> salesSum(Map<String, Object> parameter) throws Exception {

		Map<String, Object> p = new HashMap<String, Object>();
		p.put("V_DATE", parameter.get("salesDt"));
		p.put("V_MUCD", parameter.get("muCd"));
		p.put("V_TMCD", parameter.get("tmCd"));
		p.put("V_OUTLET_CD", parameter.get("outletCd")); 
	    
		return eodMgmt.salesSum(p);
	}
	
	@Override
	public Map<String, Object> timeSum(Map<String, Object> parameter) throws Exception {

		Map<String, Object> p = new HashMap<String, Object>();
		p.put("V_DATE", parameter.get("salesDt"));
		p.put("V_MUCD", parameter.get("muCd"));
		p.put("V_TMCD", parameter.get("tmCd"));
		p.put("V_OUTLET_CD", parameter.get("outletCd")); 
	    
		return eodMgmt.timeSum(p);
	}
	
	@Override
	public Map<String, Object> menuSum(Map<String, Object> parameter) throws Exception {

		Map<String, Object> p = new HashMap<String, Object>();
		p.put("V_DATE", parameter.get("salesDt"));
		p.put("V_MUCD", parameter.get("muCd"));
		p.put("V_TMCD", parameter.get("tmCd"));
		p.put("V_OUTLET_CD", parameter.get("outletCd")); 
	    
		return eodMgmt.menuSum(p);
	}
	
	@Override
	public Map<String, Object> discnSum(Map<String, Object> parameter) throws Exception {

		Map<String, Object> p = new HashMap<String, Object>();
		p.put("V_DATE", parameter.get("salesDt"));
		p.put("V_MUCD", parameter.get("muCd"));
		p.put("V_TMCD", parameter.get("tmCd"));
		p.put("V_OUTLET_CD", parameter.get("outletCd")); 
	    
		return eodMgmt.discnSum(p);
	}

	
	/*
	 * 외부업장 인터페이스된 자료 정리 작업
	 * 
	 */
	
	@Override
	public Map<String, Object> salesInfoIf(Map<String, Object> parameter) throws Exception {
		
		Map<String, Object> p   = new HashMap<String, Object>();
		Map<String, Object> eod = new HashMap<String, Object>();
		Map<String, Object> data = new HashMap<String, Object>();
		
		RecordSet chkRsSet = eodMgmt.ListOutlet(parameter);	//해당 업장을 읽어 온다.
		if(chkRsSet != null && chkRsSet.size() > 0) {
			for (int i = 0 ; i < chkRsSet.size() ; i++) {
				Map<String, Object> parameterOutlet = chkRsSet.get(i);
				
				data.put("muCd",     parameterOutlet.get("muCd").toString());
				data.put("tmCd",     parameterOutlet.get("tmCd").toString());
				data.put("outletCd", parameterOutlet.get("outletCd").toString());
				data.put("salesDt",  parameter.get("salesDt").toString());
				data.put("empNo",    parameter.get("empNo").toString());
				
				
				p.put("V_DATE",        data.get("salesDt"));
				p.put("V_MUCD",        data.get("muCd"));
				p.put("V_TMCD",        data.get("tmCd"));
				p.put("V_OUTLET_CD",   data.get("outletCd")); 
			    p.put("V_LOGIN_SABUN", data.get("empNo"));
			    
			    Map<String, Object> rtn  = eodMgmt.salesInfoIf(p);
			    
			    eod.put("outletCd", data.get("outletCd"));
			    eod.put("salesDt",  data.get("salesDt"));
			    eod.put("eodSeq",   "210");
			    eod.put("eodNm",    "외부 업장 매출 정보 (영업회계)");
			    eod.put("oRtn",     rtn.get("O_RTN").toString());
			    eod.put("oRtnmsg",  rtn.get("O_RTNMSG").toString());
			    
			    eodMgmt.insertData(eod);	//내역을 저장 한다.
			    	
			}
			
		}
		p.put("O_RTN", "TRUE");
		p.put("O_RTNMSG", "매출 정보  마감처리 완료");
		return p;
		 
	}
	
	@Override
	public Map<String, Object> salesDetailInfoIf(Map<String, Object> parameter) throws Exception {

		Map<String, Object> p   = new HashMap<String, Object>();
		Map<String, Object> eod = new HashMap<String, Object>();
		Map<String, Object> data = new HashMap<String, Object>();
		
		RecordSet chkRsSet = eodMgmt.ListOutlet(parameter);	//해당 업장을 읽어 온다.
		if(chkRsSet != null && chkRsSet.size() > 0) {
			for (int i = 0 ; i < chkRsSet.size() ; i++) {
				Map<String, Object> parameterOutlet = chkRsSet.get(i);
				
				data.put("muCd",     parameterOutlet.get("muCd").toString());
				data.put("tmCd",     parameterOutlet.get("tmCd").toString());
				data.put("outletCd", parameterOutlet.get("outletCd").toString());
				data.put("salesDt",  parameter.get("salesDt").toString());
				data.put("empNo",    parameter.get("empNo").toString());
				
				
				p.put("V_DATE",        data.get("salesDt"));
				p.put("V_MUCD",        data.get("muCd"));
				p.put("V_TMCD",        data.get("tmCd"));
				p.put("V_OUTLET_CD",   data.get("outletCd")); 
			    p.put("V_LOGIN_SABUN", data.get("empNo"));
			   
			    
			    Map<String, Object> rtn = eodMgmt.salesDetailInfoIf(p);

			    eod.put("outletCd", data.get("outletCd"));
			    eod.put("salesDt",  data.get("salesDt"));
			    eod.put("eodSeq",   "310");
			    eod.put("eodNm",    "외부 업장 매출 상세 정보 (영업회계)");
			    eod.put("oRtn",     rtn.get("O_RTN").toString());
			    eod.put("oRtnmsg",  rtn.get("O_RTNMSG").toString());
			    
			    eodMgmt.insertData(eod);	//내역을 저장 한다.
			    	
			}
			
		}
		p.put("O_RTN", "TRUE");
		p.put("O_RTNMSG", "외부업장 매출 상세 정보  마감처리 완료");
		return p;
	}
	
	@Override
	public Map<String, Object> salesPaymentInfoIf(Map<String, Object> parameter) throws Exception {

		Map<String, Object> p   = new HashMap<String, Object>();
		Map<String, Object> eod = new HashMap<String, Object>();
		Map<String, Object> data = new HashMap<String, Object>();
		
		RecordSet chkRsSet = eodMgmt.ListOutlet(parameter);	//해당 업장을 읽어 온다.
		if(chkRsSet != null && chkRsSet.size() > 0) {
			for (int i = 0 ; i < chkRsSet.size() ; i++) {
				Map<String, Object> parameterOutlet = chkRsSet.get(i);
				
				data.put("muCd",     parameterOutlet.get("muCd").toString());
				data.put("tmCd",     parameterOutlet.get("tmCd").toString());
				data.put("outletCd", parameterOutlet.get("outletCd").toString());
				data.put("salesDt",  parameter.get("salesDt").toString());
				data.put("empNo",    parameter.get("empNo").toString());
				
				
				p.put("V_DATE",        data.get("salesDt"));
				p.put("V_MUCD",        data.get("muCd"));
				p.put("V_TMCD",        data.get("tmCd"));
				p.put("V_OUTLET_CD",   data.get("outletCd")); 
			    p.put("V_LOGIN_SABUN", data.get("empNo"));
			   
			    
			    Map<String, Object> rtn = eodMgmt.salesPaymentInfoIf(p);

			    eod.put("outletCd", data.get("outletCd"));
			    eod.put("salesDt",  data.get("salesDt"));
			    eod.put("eodSeq",   "410");
			    eod.put("eodNm",    "외부 업장 매출 지불 정보 (영업회계)");
			    eod.put("oRtn",     rtn.get("O_RTN").toString());
			    eod.put("oRtnmsg",  rtn.get("O_RTNMSG").toString());
			    
			    eodMgmt.insertData(eod);	//내역을 저장 한다.
			    	
			}
			
		}
		p.put("O_RTN", "TRUE");
		p.put("O_RTNMSG", "외부업장 매출 지불 정보  마감처리 완료");
		return p;
	}

	@Override
	public Map<String, Object> cardApprovalInfoIf(Map<String, Object> parameter) throws Exception {

		Map<String, Object> p   = new HashMap<String, Object>();
		Map<String, Object> eod = new HashMap<String, Object>();
		Map<String, Object> data = new HashMap<String, Object>();
		
		RecordSet chkRsSet = eodMgmt.ListOutlet(parameter);	//해당 업장을 읽어 온다.
		if(chkRsSet != null && chkRsSet.size() > 0) {
			for (int i = 0 ; i < chkRsSet.size() ; i++) {
				Map<String, Object> parameterOutlet = chkRsSet.get(i);
				
				data.put("muCd",     parameterOutlet.get("muCd").toString());
				data.put("tmCd",     parameterOutlet.get("tmCd").toString());
				data.put("outletCd", parameterOutlet.get("outletCd").toString());
				data.put("salesDt",  parameter.get("salesDt").toString());
				data.put("empNo",    parameter.get("empNo").toString());
				
				
				p.put("V_DATE",        data.get("salesDt"));
				p.put("V_MUCD",        data.get("muCd"));
				p.put("V_TMCD",        data.get("tmCd"));
				p.put("V_OUTLET_CD",   data.get("outletCd")); 
			    p.put("V_LOGIN_SABUN", data.get("empNo"));
			   
			    
			    Map<String, Object> rtn = eodMgmt.cardApprovalInfoIf(p);

			    eod.put("outletCd", data.get("outletCd"));
			    eod.put("salesDt",  data.get("salesDt"));
			    eod.put("eodSeq",   "510");
			    eod.put("eodNm",    "외부 카드 승인 정보 (영업회계)");
			    eod.put("oRtn",     rtn.get("O_RTN").toString());
			    eod.put("oRtnmsg",  rtn.get("O_RTNMSG").toString());
			    
			    eodMgmt.insertData(eod);	//내역을 저장 한다.
			    	
			}
			
		}
		p.put("O_RTN", "TRUE");
		p.put("O_RTNMSG", "외부업장 카드 승인 정보  마감처리 완료");
		return p;
	}
	

	@Override
	public Map<String, Object> salesSumIf(Map<String, Object> parameter) throws Exception {

		Map<String, Object> p = new HashMap<String, Object>();
		p.put("V_DATE", parameter.get("salesDt"));
		p.put("V_MUCD", parameter.get("muCd"));
		p.put("V_TMCD", parameter.get("tmCd"));
		p.put("V_OUTLET_CD", parameter.get("outletCd")); 
	    
		return eodMgmt.salesSumIf(p);
	}
	
	@Override
	public Map<String, Object> timeSumIf(Map<String, Object> parameter) throws Exception {

		Map<String, Object> p = new HashMap<String, Object>();
		p.put("V_DATE", parameter.get("salesDt"));
		p.put("V_MUCD", parameter.get("muCd"));
		p.put("V_TMCD", parameter.get("tmCd"));
		p.put("V_OUTLET_CD", parameter.get("outletCd")); 
	    
		return eodMgmt.timeSumIf(p);
	}
	
	@Override
	public Map<String, Object> menuSumIf(Map<String, Object> parameter) throws Exception {

		Map<String, Object> p = new HashMap<String, Object>();
		p.put("V_DATE", parameter.get("salesDt"));
		p.put("V_MUCD", parameter.get("muCd"));
		p.put("V_TMCD", parameter.get("tmCd"));
		p.put("V_OUTLET_CD", parameter.get("outletCd")); 
		
		return eodMgmt.menuSumIf(p);
	}
	
	@Override
	public Map<String, Object> boInterface(Map<String, Object> parameter) throws Exception {

		Map<String, Object> p = new HashMap<String, Object>();
		p.put("V_DATE", parameter.get("salesDt"));
		p.put("V_MUCD", parameter.get("muCd"));
		p.put("V_TMCD", parameter.get("tmCd"));
		p.put("V_OUTLET_CD", parameter.get("outletCd")); 
		p.put("V_LOGIN_SABUN", parameter.get("empNo"));
		return eodMgmt.boInterface(p);
	}	
	
}
