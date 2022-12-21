package com.hwfs.fs.fsa.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 채용관리사이트팝업하는 AdoptionSitePop Service Interface
 * 
 * @ClassName AdoptionSitePopService.java
 * @Description AdoptionSitePopService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.26    yanghj        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 yanghj
 * @since 2015.03.26
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface AdoptionSitePopService {

	/**
	 * 채용관리사이트팝업 목록을 조회한다.
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
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;
	
}
