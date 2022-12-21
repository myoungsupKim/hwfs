package com.hwfs.batch.sc.sap.service;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.sap.EAIResponse;
import com.hwfs.sc.cmn.sap.list.SlipDtlList;
import com.hwfs.sc.cmn.sap.list.SlipMstList;
import com.hwfs.sc.cmn.sap.service.EAIService;
import com.hwfs.sm.srm.dao.SapSlipSendReptDAO;

 /**
 * SapSlipAutoSendService에 대한 설명 작성
 * @ClassName SapSlipAutoSendService.java
 * @Description SapSlipAutoSendService Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016. 02. 12.   김동표        최초생성
 * </pre>
 * @author FC종합전산구축 : 김동표
 * @since 2016. 02. 12.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/batch/sc/sap/sapSlipAutoSendService")
public class SapSlipAutoSendServiceImpl extends DefaultServiceImpl implements SapSlipAutoSendService {

	/** SapSlipSendReptDAO Bean 생성 */
	@Resource(name = "/sm/srm/sapSlipSendReptDAO")
	private SapSlipSendReptDAO sapSlipSendReptDAO;
	
	@Resource(name="EAIService")
	EAIService eaiService;
	
	/**
	 * EMAIL 전송 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectBatchList() throws Exception {
		
		Map<String, Object> mapParam = new HashMap<String, Object>();
		
		return sapSlipSendReptDAO.selectBatchList(mapParam);
	}
	
	/**
	 * EMAIL 전송 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectBatchList6B() throws Exception {
		
		Map<String, Object> mapParam = new HashMap<String, Object>();
		
		return sapSlipSendReptDAO.selectBatchList6B(mapParam);
	}	
	
	/**
     * FC 영업전표 자동 전송(SAP)
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int[] sapSlipAutoSend() throws Exception {
		int insRowCnt1 = 0;
		int insRowCnt2 = 0;
		int insRowCnt  = 0;
		String strChk = "";
		
		System.out.println("※※※※※※※※※※ SAP I/F 연동 Strat ※※※※※※※※※※");
		
		Map<String, Object> mapParam = new HashMap<String, Object>();		
		mapParam.put("loginSabun", "SYSTEM");
		mapParam.put("loginUserid", "SYSTEM");
		mapParam.put("loginPersMask", "YYYYNNYYYYYNNNN");
		
		
		RecordSet list = sapSlipSendReptDAO.selectAutoList(mapParam);
		
		insRowCnt = list.size();
		
		System.out.println("※※※※※※※※※※ list.size():"+list.size());
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			if(rowData.get("chk") != null)	strChk	= rowData.get("chk").toString();
			
			System.out.println("["+i+"] ※※※※※※※※※※ slipNum:"+rowData.get("slipNum").toString());
			
			if("1".equals(strChk)){
				SlipMstList slipMstList = new SlipMstList();
				SlipDtlList slipDtlList = new SlipDtlList();
				
				RecordSet rsMst = sapSlipSendReptDAO.sapIfcSlipMst(rowData);
				RecordSet rsDtl = sapSlipSendReptDAO.sapIfcSlipDtl(rowData);
				
				slipMstList.setDataList(rsMst);
				slipDtlList.setDataList(rsDtl);
				
				EAIResponse res1 = eaiService.call(slipMstList);
				EAIResponse res2 = eaiService.call(slipDtlList);

				if (res1.isSuccess()){
					
					//SAP 전표전송 상태값을 저장한다.
					insRowCnt1 += sapSlipSendReptDAO.updateSlipStatusOfSlipMst(rowData);
				}
				if (res2.isSuccess()) insRowCnt2++;
				
			}
		}
		
		//return insRowCnt1 + insRowCnt2;
		return new int[]{insRowCnt, insRowCnt1, insRowCnt2};
    }
	
	/**
     * FC 영업전표 자동 전송(SAP)
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int[] sapSlipAutoSend6B() throws Exception {
		int insRowCnt1 = 0;
		int insRowCnt2 = 0;
		int insRowCnt  = 0;
		String strChk = "";
		
		System.out.println("※※※※※※※※※※ SAP I/F 연동 Strat ※※※※※※※※※※");
		
		Map<String, Object> mapParam = new HashMap<String, Object>();		
		mapParam.put("loginSabun", "SYSTEM");
		mapParam.put("loginUserid", "SYSTEM");
		mapParam.put("loginPersMask", "YYYYNNYYYYYNNNN");
		
		
		RecordSet list = sapSlipSendReptDAO.selectAutoList6B(mapParam);
		
		insRowCnt = list.size();
		
		System.out.println("※※※※※※※※※※ list.size():"+list.size());
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			if(rowData.get("chk") != null)	strChk	= rowData.get("chk").toString();
			
			System.out.println("["+i+"] ※※※※※※※※※※ slipNum:"+rowData.get("slipNum").toString());
			
			if("1".equals(strChk)){
				SlipMstList slipMstList = new SlipMstList();
				SlipDtlList slipDtlList = new SlipDtlList();
				
				RecordSet rsMst = sapSlipSendReptDAO.sapIfcSlipMst(rowData);
				RecordSet rsDtl = sapSlipSendReptDAO.sapIfcSlipDtl(rowData);
				
				slipMstList.setDataList(rsMst);
				slipDtlList.setDataList(rsDtl);
				
				EAIResponse res1 = eaiService.call(slipMstList);
				EAIResponse res2 = eaiService.call(slipDtlList);

				if (res1.isSuccess()){
					
					//SAP 전표전송 상태값을 저장한다.
					insRowCnt1 += sapSlipSendReptDAO.updateSlipStatusOfSlipMst(rowData);
				}
				if (res2.isSuccess()) insRowCnt2++;
				
			}
		}
		
		//return insRowCnt1 + insRowCnt2;
		return new int[]{insRowCnt, insRowCnt1, insRowCnt2};
    }    
}
