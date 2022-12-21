package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

/**
 * 팀정보를 조회한다.
 *
 * @ClassName TmSearchService.java
 * @Description TmSearchService Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 10.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 3. 10.
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface TmSearchService {
	RecordSet selectTeamControl() throws Exception;
	
	RecordSet selectList(Map<String, Object> parameter) throws Exception;

	RecordSet selectListAll(Map<String, Object> parameter) throws Exception;
	
	RecordSet selectListBonbu(Map<String, Object> parameter) throws Exception;

	RecordSet selectAccobjList(Map<String, Object> parameter) throws Exception;
}
