package com.hwfs.sc.scu.service;

import java.util.Map;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

/**
* 사용자의 권한을 변경하는 UserRoleChng Service Interface
*
* @ClassName UserRoleChngService.java
* @Description UserRoleChngService Class
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2015.05.18    김재섭        최초생성
*
* </pre>
* @author FC종합전산구축 : COM 김재섭
* @since 2015.05.18
* @version 1.0
* @see
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
public interface UserRoleChngService {

    /**
     * 사용자 권한 목록을 조회한다.
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
     * 사용자 권한 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    Long saveList(DataSetMap list) throws Exception;

    /**
     * 시스템 권한변경 요청 그룹웨어 상신 Master를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    Record selectGwDraftMst(Map<String, Object> parameter) throws Exception;

    /**
     * 상신 후 instanceId를 저장 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    int saveGwInstanceId(Map<String, Object> parameter) throws Exception;
}
