package com.hwfs.batch.sc.sap.service;

import hone.core.util.record.RecordSet;

import org.springframework.stereotype.Repository;

import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

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
@Repository("/batch/sc/sap/sapSlipAutoSendDAO")
public interface SapSlipAutoSendService {

	/**
	 * FC 영업회계 전표 자동 전송
	 *
	 * @param mapParam
	 * @return
	 */
	public int[] sapSlipAutoSend() throws Exception;
	
	public int[] sapSlipAutoSend6B() throws Exception;
	
	public RecordSet selectBatchList() throws Exception;
	
	public RecordSet selectBatchList6B() throws Exception;
	
}
