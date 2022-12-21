
package com.hwfs.ft.fdm.service;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.List;
import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 관세비용 및 입고예정정보를 등록 관리하는 EntryMst Service Interface
 *
 * @ClassName EntryMstService.java
 * @Description EntryMstService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.13    kjj        최초생성
 *
 * </pre>
 * @author FC종합전산구축 : 식재도매 kjj
 * @since 2015.04.13
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface EntryMstService {

    /**
     * 관세비용 및 입고예정정보를 등록 관리 목록을 조회한다.
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
     * 관세비용 및 입고예정정보를 등록 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
     * 수입면허 품목선정 POP-UP 목록을 조회한다.
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
    RecordSet selectItemInfoSaveSearchPop(Map<String, Object> mapParam) throws Exception;


    /**
     * 수입면허 품목선정 POP-UP item 목록을 조회한다.
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
    RecordSet selectItemInfoSaveSearchPop2(Map<String, Object> mapParam) throws Exception;



    /**
     * 수입면허 품목선정 POP-UP 가입고 목록을 조회한다.
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
    RecordSet selectItemInfoSaveReceiveSearchPop(Map<String, Object> mapParam) throws Exception;


    /**
     * 수입면허 품목선정 POP-UP item 가입고 목록을 조회한다.
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
    RecordSet selectItemInfoSaveReceiveSearchPop2(Map<String, Object> mapParam) throws Exception;

    /**
     * 통관 마스터을 조회한다.
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
    RecordSet searchSignExchangeRate(Map<String, Object> mapParam) throws Exception;

    /**
     * 통관 마스터을 조회한다.
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
    RecordSet selectEntryMst(Map<String, Object> mapParam) throws Exception;

    /**
     * 구매주문(수입)을 저장 한다.
     *
     * @param proposalInfo, itemList, payList, blckMarkList
     * @throws Exception
     */
    List<Map<String, Object>> saveEntryDtl(
              LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap dsEntryMst
            , DataSetMap dsEntryItemDetailList
            ) throws Exception ;

    /**
     * 구매주문(수입)을 전체삭제 한다.
     *
     * @param proposalInfo, itemList, payList, blckMarkList
     * @throws Exception
     */
    int deleteEntryList(
              LoginDTO loginParameter
            , DataSetMap search
            , DataSetMap dsList
            ) throws Exception ;


    /**
     * 가입고 품목선정 POP-UP 목록을 조회한다.
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
    RecordSet selectBlListPop(Map<String, Object> mapParam) throws Exception;


    /**
     * 가입고 품목선정 POP-UP item 목록을 조회한다.
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
    RecordSet selectBlListPop2(Map<String, Object> mapParam) throws Exception;

    /**
     * 면허번호 중복체크
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
    String dupIncomeLicNumYn(Map<String, Object> mapParam) throws Exception;
}
