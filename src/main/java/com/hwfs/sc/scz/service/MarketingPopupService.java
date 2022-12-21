package com.hwfs.sc.scz.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 마케팅용 팝업을 호출하는 MarketingPopup Service Interface
 * 
 * @ClassName MarketingPopupService.java
 * @Description MarketingPopupService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.10.01    김재섭        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.10.01
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface MarketingPopupService {

	/**
	 * 마케팅용 팝업 목록을 조회한다.
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
