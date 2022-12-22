package com.hwfs.fm.fmc.service;

import java.util.Map;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;


 /**
 * 물류요청서처리하는 DistributionRequestRptProc Service Interface
 * 
 * @ClassName DistributionRequestRptProcService.java
 * @Description DistributionRequestRptProcService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.11    최영준        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015.03.11
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface DistributionRequestRptProcService {

	/**
	 * 물류요청서 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param parameter
	 *            조회조건 MAP
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectList(Map<String, Object> parameter) throws Exception;
	RecordSet selectMast(Map<String, Object> parameter) throws Exception;
	
	/**
	 * 물류요청서 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	int saveListMast(DataSetMap list) throws Exception;
	
	
    /**
     * File 데이터를 받아 첨부참조일련번호를 가져온다.
     * <pre>
     * - 데이터와 첨부파일을 함께 처리한다.
     * </pre>
     * 
     * @parma listFile 첨부파일 정보
     * @return 첨부참조일련번호
     * @throws Exception
     */
	public String saveAttachFile(DataSetMap listFile, Map <String, Object> inVar) throws Exception;
}
