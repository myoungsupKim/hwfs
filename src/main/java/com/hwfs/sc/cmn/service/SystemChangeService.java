package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

 /**
 * 권한에 따른 시스템을 표시하는 SystemChange Service Interface
 *
 * @ClassName SystemChangeService.java
 * @Description SystemChangeService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.15    김재섭        최초생성
 *
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.05.15
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface SystemChangeService {

	/**
	 * 권한에 따른 시스템 목록을 조회한다.
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
	RecordSet selectList() throws Exception;
}
