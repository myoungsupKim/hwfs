package com.hwfs.fs.fse.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * 사업부 기기/기물 조회 팝업하는 EventUtensilPop Service Interface
 * 
 * @ClassName EventUtensilPopService.java
 * @Description EventUtensilPopService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.04    김미경        최초생성
 *  
 * </pre>
 * @author FC종합전산구축 : 통합영업 김미경
 * @since 2015.06.04
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface EventUtensilPopService {

	/**
	 * 사업부 기기/기물 조회 팝업 목록을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	RecordSet selectList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 콤보용 코드 목록을 조회한다. (대분류, 중분류)
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	Map<String, RecordSet> selectCodeList(Map<String, Object> mapParam) throws Exception;

}
