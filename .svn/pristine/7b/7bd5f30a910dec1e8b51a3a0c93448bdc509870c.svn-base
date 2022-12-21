package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

/**
 * 업장검색하는 UpjangSearch Service Interface
 *
 * @ClassName UpjangSearchService.java
 * @Description UpjangSearchService Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.19    김재섭        최초생성
 *
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.03.19
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface UpjangSearchService {

	/**
	 * 업장검색 목록을 조회한다.
	 *
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	RecordSet selectList(Map<String, Object> mapParam, LoginDTO loginDTO)
			throws Exception;
	
	RecordSet selectPartList(Map<String, Object> mapParam) throws Exception;

	RecordSet selectAccobjList(Map<String, Object> mapParam, LoginDTO loginDTO)
			throws Exception;
	
}
