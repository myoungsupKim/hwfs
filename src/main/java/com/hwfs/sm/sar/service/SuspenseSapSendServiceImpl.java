package com.hwfs.sm.sar.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.math.BigDecimal;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.sap.request.SuspenseReceiveRequest;
import com.hwfs.sc.cmn.sap.service.EAIService;
import com.hwfs.sm.cmn.dao.SuspenseCommonDAO;
import com.hwfs.sm.sar.dao.SuspenseSapSendDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 가수금 대체 건 재 전송하는 SuspenseSapSend Service Implementation
 * 
 * @ClassName SuspenseSapSendServiceImpl.java
 * @Description SuspenseSapSendServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.12.09    김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.12.09
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/sar/suspenseSapSendService")
public class SuspenseSapSendServiceImpl extends DefaultServiceImpl implements SuspenseSapSendService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SuspenseSapSendDAO Bean 생성 */
	@Resource(name = "/sm/sar/suspenseSapSendDAO")
	private SuspenseSapSendDAO suspenseSapSendDAO;
	
	/** SuspenseCommonDAO Bean 생성 */
	@Resource(name = "/sm/cmn/suspenseCommonDAO")
	private SuspenseCommonDAO suspenseCommonDAO;	
	
	@Resource(name = "EAIService")
	EAIService eaiService;	

	/**
	 * 가수금 대체 건 재 전송 목록을 조회한다.
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
		return suspenseSapSendDAO.selectList(mapParam);
	}

	/**
	 * 가수금 대체 건 재 전송 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		long time = System.currentTimeMillis();
		
		SimpleDateFormat sDay = new SimpleDateFormat("yyyymmdd", java.util.Locale.getDefault());
		SimpleDateFormat sTime = new SimpleDateFormat("HHmmss", java.util.Locale.getDefault());
		
		String strDay = com.hwfs.sc.cmn.util.DateUtil.getYyyymmdd();//sDay.format(new Date(time));
		String strTime = sTime.format(new Date(time));
				
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			//가수금대체 디테일정보 등록(적용금액을 입력했을 경우)
			String sabun = suspenseCommonDAO.selectSabun(rowData);
			
			/************************************************************************************************
			 * SAP IFC 가수금 입금 반제 Start
			************************************************************************************************/
			
			SuspenseReceiveRequest dto = new SuspenseReceiveRequest();
			
			if (rowData.containsKey("buCd"))
				dto.setBuCd(rowData.get("buCd").toString().trim());
			
			if (rowData.containsKey("sapSuspenseNum"))
				dto.setSapSuspenseNum(rowData.get("sapSuspenseNum").toString().trim());
			
			//if (rowData.containsKey("seq"))
			dto.setSeq(Integer.parseInt(rowData.get("altSeq").toString()));
			
			//if (rowData.containsKey("sabun"))
			dto.setAltProcUser(rowData.get("cuser").toString().trim());
			
			if (rowData.containsKey("altAmt"))
				dto.setAmt((BigDecimal) rowData.get("altAmt"));

			if (rowData.containsKey("ccCd"))
				dto.setCcCd(rowData.get("ccCd").toString().trim());
			
			if (rowData.containsKey("altDate"))
				dto.setAltDate(rowData.get("altDate").toString().trim());
			
			if (rowData.containsKey("sapCustCd"))
				dto.setSapCustCd(rowData.get("sapCustCd").toString().trim());
			
			dto.setAltProcDate(rowData.get("altDate").toString().trim());
			dto.setAltProcTime(strTime);
			dto.setCurrency("KRW");
			dto.setAltSlipNum(" ");
			if("L".equals(rowData.get("recdStatus"))){
				dto.setReqType("1");				
			}else{
				dto.setReqType("2");				
			}
			eaiService.call(dto);
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
