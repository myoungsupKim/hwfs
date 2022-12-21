package com.hwfs.sm.ssi.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 영업 지불유형을 관리하는 SalePaymentTypeMgnt Service Interface
 * 
 * @ClassName SalePaymentTypeMgntService.java
 * @Description SalePaymentTypeMgntService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.17    유인찬        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 유인찬
 * @since 2015.03.17
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface SalePaymentTypeMgntService {

	/**
	 * 영업 지불유형 목록을 조회한다.
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
	 * 영업 지불유형 중복체크를 한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	int selectExists(Map<String, Object> mapParam) throws Exception;

	/**
	 * 영업 지불유형 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
