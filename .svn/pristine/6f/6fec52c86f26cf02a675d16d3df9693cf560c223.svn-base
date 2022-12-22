package com.hwfs.fm.fmp.service;

import java.util.Map;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

/**
 * 매출창고 강제변경 Serive Class
 *
 * @ClassName SalsWhStModifyService.java
 * @Description SpecmTYpeTestArticleMgmtService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 8. 21.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 8. 21.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface SalsWhStModifyService {

    /**
     * 매출창고 강제변경 목록을 조회한다
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    RecordSet selectList(Map<String, Object> parameter) throws Exception;

    /**
     * 일자를 조회한다
     *
     * @param searchList
     * @param saveList
     * @return
     * @throws Exception
     */
    RecordSet selectUpjangWh(Map<String, Object> parameter) throws Exception;

    /**
     * 변경후 창고 정보 조회
     *
     * @param searchList
     * @param saveList
     * @return
     * @throws Exception
     */
    RecordSet selectUpjangWhChg(Map<String, Object> parameter) throws Exception;

    /**
     * 창고별 일괄 저장한다.
     *
     * @param search
     * @param saveList
     * @return
     * @throws Exception
     */
    Map<String, Object> modifyAllList(Map<String, Object> parameter, DataSetMap saveList) throws Exception;

	/**
	 * selectSubinvCredit 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param searchMap
	 * @return
	 */
	RecordSet selectSubinvCredit(Map<String, Object> parameter)throws Exception;

}
