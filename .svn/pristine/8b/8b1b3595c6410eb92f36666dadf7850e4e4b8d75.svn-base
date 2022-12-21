package com.hwfs.fs.fse.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

/**
 * 이벤트 조회 팝업하는 EventPop Service Interface
 *
 * @ClassName EventPopService.java
 * @Description EventPopService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.11    남기빈        최초생성
 *
 * </pre>
 * @author FC종합전산구축 : 통합영업 남기빈
 * @since 2015.03.11
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface EventPopService {

    /**
     * 이벤트 Master 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
    */
    RecordSet selectEventPopList(Map<String, Object> mapParam) throws Exception;

    /**
     * 이벤트 Master 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    RecordSet selectEventProcessInfoList(Map<String, Object> mapParam) throws Exception;

	/**
	 * 콤보용 코드 목록을 조회한다. (분류, 테마)
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	Map<String, RecordSet> selectCodeList() throws Exception;
    
}
