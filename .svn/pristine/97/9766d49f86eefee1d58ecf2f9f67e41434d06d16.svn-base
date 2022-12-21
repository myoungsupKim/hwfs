package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.List;
import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 허브메카 단가 디데이설정하는 HubInterfaceSalePrice Service Interface
 * 
 * @ClassName HubInterfaceSalePriceService.java
 * @Description HubInterfaceSalePriceService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.06.26   김혜진       
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.04.14
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface HubInterfaceSalePriceService {

	/**
	 * 허브메카 user id를 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectUser(Map<String, Object> mapParam) throws Exception;
	
	
	
	/**
	 * 허브메카 단가 목록을 조회한다.
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
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;
	

	/**
	 * 허브메카 단가 디데이 수정 내역을 merge 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveList(DataSetMap list) throws Exception;

	/**
	 * 식자재영업 선택한 자재를 Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int deleteHubPrice(DataSetMap list) throws Exception;

	/**
	 * 허브메카 엑셀 업로드 목록을 조회한다.
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
	Map<String, List> searchUpload(DataSetMap list) throws Exception;


	
}
