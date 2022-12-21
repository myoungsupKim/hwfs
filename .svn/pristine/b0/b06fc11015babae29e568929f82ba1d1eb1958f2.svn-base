package com.hwfs.sm.srm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * SAP 전표 전송하는 SapSlipSendRept Service Interface
 * 
 * @ClassName SapSlipSendReptService.java
 * @Description SapSlipSendReptService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.19    JUN        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.06.19
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface SapSlipSendReptService {

	/**
	 * SAP 전표 전송 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 그룹웨어 상신을 위한 본문을 생성하여 연동한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectSilpList(Map<String, Object> mapParam) throws Exception;	


	/**
	 * 그룹웨어 상신을 위한 본문을 생성하여 연동한다.(계약관리)
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectContractList(Map<String, Object> mapParam) throws Exception;	

	
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
	 */
	int saveSignInfo(DataSetMap list) throws Exception;
	
	/**
	 * 전자결재정보를 Update 처리한다.(계약관리)
	 * <pre>
	 * - 업무 테이블에 Instance ID Update
	 * - 결재정보 공통 테이블에 결재정보 Insert or Update
	 * </pre>
	 *
	 * @param list
	 * @return
	 * @throws Exception
	 */
	int saveSignInfo2(DataSetMap list) throws Exception;
	
	/**
	 * 전표 SAP I/F 연동
	 * 
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveSapIfcSlip(DataSetMap list) throws Exception;
	
	/**
	 * 전표취소 SAP I/F 연동
	 * 
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveSapIfcCancelSlip(DataSetMap datas) throws Exception;
	
	/**
	 * 전표생성취소
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 코드/코드명
	 * @throws Exception
	*/
	String cancelSlipList(DataSetMap list) throws Exception;
			
}
