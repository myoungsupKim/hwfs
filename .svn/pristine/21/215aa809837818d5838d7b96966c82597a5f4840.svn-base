package com.hwfs.sm.saa.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 매출미발생사유 및 계획을 관리하는 SalsNonOccurReasonRept Service Interface
 * 
 * @ClassName SalsNonOccurReasonReptService.java
 * @Description SalsNonOccurReasonReptService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.06    김예진        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.05.06
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface SalsNonOccurReasonReptService {

	/**
	 * 매출미발생사유 및 계획 목록을 조회한다.
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
	RecordSet selectCustList(Map<String, Object> mapParam) throws Exception;
	RecordSet selectDamboList(Map<String, Object> mapParam) throws Exception;
	RecordSet selectArNonoccurList(Map<String, Object> mapParam) throws Exception;
    RecordSet selectHdrDealDesc(Map<String, Object> parameter) throws Exception;
	RecordSet selectDealDescList(Map<String, Object> parameter) throws Exception;
	RecordSet selectHdrDealDescFs(Map<String, Object> parameter) throws Exception;
	RecordSet selectDealDescListFs(Map<String, Object> parameter) throws Exception;

	/**
	 * 매출미발생사유 및 계획 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveList(DataSetMap damboList, DataSetMap arNonoccurList, DataSetMap fileList) throws Exception;

	/**
	 * 매출미발생사유 및 계획 DataSetMap의 데이터를 Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	 */
	int deleteList(DataSetMap arNonoccurList, DataSetMap fileList) throws Exception;
	
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
}
