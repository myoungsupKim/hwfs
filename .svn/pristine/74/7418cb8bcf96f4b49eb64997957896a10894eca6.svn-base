package com.hwfs.ft.fsi.service;

import java.util.List;
import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

/**
* 냉동창고수수료 내역을 Service Interface
*
* @ClassName FreezeWhCommMgmtService.java
* @Description FreezeWhCommMgmtService Class
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2015.08.26    jshoon        최초생성
*
* </pre>
* @author FC종합전산구축 : 식재도매 kjj
* @since 2015.08.26
* @version 1.0
* @see
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
public interface FreezeWhCommMgmtService {

    /**
     * 냉동창고수수료 내역을 조회한다.
     *
     * @param mapParam
     * @return
     * @throws Exception
     */
    RecordSet selectList(Map<String, Object> mapParam) throws Exception;

    /**
     * 팝업에서 사용하는 거래처 계좌번호 조회
     *
     * @param mapParam
     * @return
     * @throws Exception
     */
    RecordSet selectSuplierAcctNoList(Map<String, Object> mapParam) throws Exception;

    /**
     * 냉동창고수수료 내역 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
     *
     * @param parameter
     * @param list
     * @return
     * @throws Exception
     */
    int saveList(Map<String, Object> parameter, DataSetMap list) throws Exception;

    /**
     * 전자결재 결과를 등록한다.
     *
     * @param parameter
     * @param list
     * @return
     * @throws Exception
     */
    int saveDraft(Map<String, Object> parameter, DataSetMap list) throws Exception;

    /**
     * 냉동창고수수료 일괄 저장
     *
     * @param parameter
     * @param saveList
     * @return
     * @throws Exception
     */
    int saveListAll(Map<String, Object> parameter, DataSetMap saveList) throws Exception;

    /**
     * 전표 IF -> SAP
     *
     * @param loginParameter
     * @param search
     * @param dsOtherAmtList
     * @return
     * @throws Exception
     */
    public Map<String, Object> createFiscalSlip(LoginDTO loginParameter, DataSetMap search, DataSetMap dsOtherAmtList)
            throws Exception;

    /**
     * 전표 취소 IF -> SAP
     *
     * @param loginParameter
     * @param search
     * @param dsOtherAmtList
     * @return
     * @throws Exception
     */
    public int cancelFiscalSlip(LoginDTO loginParameter, DataSetMap search, DataSetMap dsOtherAmtList) throws Exception;

    /**
     * 매입 전자세금계산서 조회
     *
     * @param mapParam
     * @return
     * @throws Exception
     */
    List<Map<String, Object>> selectElctnTexShetList(Map<String, Object> mapParam) throws Exception;

}
