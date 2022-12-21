package com.hwfs.sm.saa.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

/**
 * 사고업장관리하는 AccdUpjangMngt Service Interface
 *
 * @ClassName AccdUpjangMngtService.java
 * @Description AccdUpjangMngtService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.22    최종덕        최초생성
 *
 * </pre>
 * @author FC종합전산구축 : 통합영업 최종덕
 * @since 2015.04.22
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface AccdUpjangMngtService {

    /**
     * 사고업장관리 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
    */
    RecordSet selectList(Map<String, Object> parameter) throws Exception;
    
    
    /**
     * 사고채권발생보고, 매출 미발생 사유보고에 데이터가 있는지 확인한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
    */
    RecordSet selectAccdList(Map<String, Object> parameter) throws Exception;

    /**
     * 사고업장관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int saveList(DataSetMap list, LoginDTO loginDTO) throws Exception;
}
