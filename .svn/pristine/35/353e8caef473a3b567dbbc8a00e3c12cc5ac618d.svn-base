package com.hwfs.ft.fgp.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.List;
import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 물품대금 마스터하는 GdspaymMst Service Interface
 *
 * @ClassName GdspaymMstService.java
 * @Description GdspaymMstService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.06    kjj        최초생성
 *
 * </pre>
 * @author FC종합전산구축 : 물품대금 마스터 kjj
 * @since 2015.04.06
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface GdspaymMstService {

    /**
     * 물품대금 마스터 관리 목록을 조회한다.
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
     * 회계전표 IF 버튼 클릭시 SAP
     *
     * @param ds_search, ds_gdspaymList
     * @throws Exception
     */
    public List<Map<String, Object>>  createFiscalSlip( LoginDTO loginParameter, DataSetMap search, DataSetMap dsOtherAmtList ) throws Exception ;

    /**
     * 회계전표 IF 취소 버튼 클릭시 SAP
     *
     * @param ds_search, ds_gdspaymList
     * @throws Exception
     */
    public int cancelFiscalSlip( LoginDTO loginParameter, DataSetMap search, DataSetMap dsOtherAmtList ) throws Exception ;

    /**
     * 회계전표 IF 버튼 클릭시 SAP
     *
     * @param ds_search, ds_gdspaymList
     * @throws Exception
     */
    public List<Map<String, Object>>  createDmtFiscalSlip( LoginDTO loginParameter, DataSetMap search, DataSetMap dsOtherAmtList ) throws Exception ;

    /**
     * 회계전표 IF -취소 버튼 클릭시 SAP
     *
     * @param ds_search, ds_gdspaymList
     * @throws Exception
     */
    public int cancelMinusDmtFiscalSlipIf( LoginDTO loginParameter, DataSetMap search, DataSetMap dsOtherAmtList ) throws Exception ;


    /**
     * 회계전표 IF- 버튼 클릭시 SAP
     *
     * @param ds_search, ds_gdspaymList
     * @throws Exception
     */
    public int createMinusDmtFiscalSlipIf( LoginDTO loginParameter, DataSetMap search, DataSetMap dsOtherAmtList ) throws Exception ;

    /**
     * 회계전표 IF 취소 버튼 클릭시 SAP
     *
     * @param ds_search, ds_gdspaymList
     * @throws Exception
     */
    public int cancelDmtFiscalSlip( LoginDTO loginParameter, DataSetMap search, DataSetMap dsOtherAmtList ) throws Exception ;


    /**
     * 물품대금 마스터 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
     * 물품대금 삭제 한다.
     *
     * @param dsPoOrderList
     * @throws Exception
     */
    int deleteGdspaymList(LoginDTO loginParameter,DataSetMap search, DataSetMap dsGdspaymList ) throws Exception;

    /**
     * 물품대금 마스터(내수) 관리 목록을 조회한다.
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
    RecordSet selectList2(Map<String, Object> mapParam) throws Exception;

    /**
     * 물품대금 마스터(내수) 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
     * <pre>
     * - 메소드 상세설명 작성(생략 가능) --> 생략 시 삭제할 것
     * </pre>
     *
     * @param list
     *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
     * @return 처리건수
     * @throws Exception
    */
    int saveList2(DataSetMap list) throws Exception;

    /**
     * 과세유형 가져오기
     * <pre>
     * 구매 품의 마스터 시퀀스을 조회한다.
     * </pre>
     *
     * @param inVar
     * @return PgmAuthDTO
     * @throws Exception
     */
    public Record getVatClassCd (Map <String, Object> inVar) throws Exception;


    /**
     * 수수료 정보를 등록한다.
     *
     * @param proposalInfo, itemList, payList, blckMarkList
     * @throws Exception
     */
    List<Map<String, Object>> saveIncomDraft(
            LoginDTO loginParameter
          , DataSetMap search
          , DataSetMap dsGdspaymList
          ) throws Exception ;

}
