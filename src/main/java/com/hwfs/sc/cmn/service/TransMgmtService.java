package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import java.util.List;
import java.util.Map;

import com.hwfs.sc.cmn.dto.LmsMmsDTO;
import com.hwfs.sc.cmn.dto.LoginDTO;

/**
 * 배송처검색하는 TransMgmt Service Interface
 *
 * @ClassName TransMgmtService.java
 * @Description TransMgmtService Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2017.11.16    kihoon        최초생성
 *
 * </pre>
 * @author FC종합전산구축 : COM kihoon
 * @since 2017.11.16
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface TransMgmtService {

	/**
	 * 배송처검색 목록을 조회한다.
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
	
	RecordSet selectCheck(Map<String, Object> mapParam, LoginDTO loginDTO)
			throws Exception;
	
	int saveList(Map<String, Object> mapParam, LoginDTO loginDTO) throws Exception;
	
}
