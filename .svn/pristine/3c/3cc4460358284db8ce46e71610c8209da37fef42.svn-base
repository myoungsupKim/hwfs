package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import com.hwfs.sc.cmn.dto.AuthorityChangeLogDTO;

/**
 * 권한의 변경 이력을 생성하는 AuthorityChangeLog Service Interface
 *
 * @ClassName AuthorityChangeLogService.java
 * @Description AuthorityChangeLogService Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.18    김재섭        최초생성
 *
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.05.18
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface AuthorityChangeLogService {

	/**
	 * 권한 변경 이력 목록을 조회한다.
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
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 권한 변경 이력을 생성한다.
	 *
	 * @param changeLog
	 *            이력 데이터
	 * @return 처리건수
	 * @throws Exception
	 */
	Map<String, Object> createLog(int authoriyTable, AuthorityChangeLogDTO dto)
			throws Exception;

}
