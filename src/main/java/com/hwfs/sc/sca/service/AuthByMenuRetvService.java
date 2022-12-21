package com.hwfs.sc.sca.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

 /**
 * 메뉴별 권한정보를 조회하는 AuthByMenuRetv Service Interface
 *
 * @ClassName AuthByMenuRetvService.java
 * @Description AuthByMenuRetvService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.31    김재섭        최초생성
 *
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.03.31
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface AuthByMenuRetvService {

	/**
	 * 메뉴별 권한정보 메뉴목록을 조회한다.
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
	RecordSet selectMenuList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 메뉴별 권한정보 권한/사용자목록을 조회한다.
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
	Map<String, RecordSet> selectList(Map<String, Object> mapParam) throws Exception;

}
