package com.hwfs.sc.scz.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 주소정제 결과를 보정하는 AddressRevision Service Interface
 * 
 * @ClassName AddressRevisionService.java
 * @Description AddressRevisionService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.09.26    김재섭        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.09.26
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface AddressRevisionService {

	/**
	 * 주소 보정 목록을 조회한다.
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
	RecordSet selectStUpjang(Map<String, Object> mapParam) throws Exception;

	RecordSet selectFmsUpjang1(Map<String, Object> mapParam) throws Exception;
	
	RecordSet selectFmsUpjang2(Map<String, Object> mapParam) throws Exception;
	
	RecordSet selectStCust(Map<String, Object> mapParam) throws Exception;
	
	RecordSet selectFmsSecureLand(Map<String, Object> mapParam) throws Exception;

	RecordSet selectFmsSecurePerson(Map<String, Object> mapParam) throws Exception;
	
	RecordSet selectScoUpjangMst(Map<String, Object> mapParam) throws Exception;
	
	RecordSet selectScoUpjangCustHis(Map<String, Object> mapParam) throws Exception;
	
	RecordSet selectScoUpjangCust(Map<String, Object> mapParam) throws Exception;
	
	RecordSet selectMakCustMstA(Map<String, Object> mapParam) throws Exception;
	
	RecordSet selectMakCustMstB(Map<String, Object> mapParam) throws Exception;
	
	
	/**
	 * 주소 보정 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveList(DataSetMap list) throws Exception;
}
