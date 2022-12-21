package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

/**
 * 거래명세서(브랜드) TransactionSpecificationService Interface
 * 
 * @ClassName TransactionSpecificationService.java
 * @Description TransactionSpecificationService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2021.08.25   	윤인묵        최초생성
 * </pre> 
 * @author 윤인묵
 * @since 2021.08.25
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface TransactionSpecificationService {
	/**
	 * 거래명세서 목록을 조회한다.
	 * <pre>
	 * - DTO 
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
	 * 거래명세서 파라미터 저장
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	int saveParamList(DataSetMap list, LoginDTO loginDTO) throws Exception;
}
