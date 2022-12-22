package com.hwfs.ft.fsi.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

 /**
 * SAP 인터페이스하는 FtSapInterface Service Interface
 *
 * @ClassName FtSapInterfaceService.java
 * @Description FtSapInterfaceService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.25    kjj        최초생성
 *
 * </pre>
 * @author FC종합전산구축 : 식재도매 kjj
 * @since 2015.06.25
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface FtSapInterfaceService {

    /**
     * SAP 인터페이스 목록을 조회한다.
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

    /**
     * SAP 인터페이스 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int saveList(DataSetMap list) throws Exception;


    /**
     * SAP 인터페이스 목록을 조회한다.
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
    RecordSet selectSlipMst(Map<String, Object> mapParam) throws Exception;

    /**
     * SAP 인터페이스 목록을 조회한다.
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
    RecordSet selectSlipList(Map<String, Object> mapParam) throws Exception;
    
	/**
	 * 그룹웨어 상신을 위한 본문을 생성하여 연동한다.
	 *
	 * @param mapParam
	 * @return
	 */
	RecordSet selectGwSlipList(Map<String, Object> mapParam) throws Exception;
}
