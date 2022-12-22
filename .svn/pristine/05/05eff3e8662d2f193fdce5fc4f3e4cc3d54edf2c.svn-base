package com.hwfs.fs.fsm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 업장 배장관리하는 MachineRequestAllcRtn Service Interface
 * 
 * @ClassName MachineRequestAllcRtnService.java
 * @Description MachineRequestAllcRtnService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.17    김예진        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.03.17
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface MachineRequestAllcRtnService {

	/**
	 * 기기/기물 신청 목록 목록을 조회한다.
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
	RecordSet selectReqRtnList(Map<String, Object> mapParam) throws Exception;
	
	/**
	 * 기기/기물 신청 목록 목록을 조회한다.(이벤트 신청 포함)
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
	RecordSet selectReqRtnList2(Map<String, Object> mapParam) throws Exception;

	/**
	 * 기기/기물 신청 목록 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveList(DataSetMap parameter, LoginDTO loginDTO) throws Exception;
}
