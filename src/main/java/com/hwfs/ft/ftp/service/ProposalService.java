package com.hwfs.ft.ftp.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.List;
import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * Authority Service Interface
 *
 * @ClassName ProposalService.java
 * @Description ProposalService Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.02.24.   KJJ        최초생성
 * </pre>
 * @author FC종합전산구축 : KJJ
 * @since 2015. 02. 24.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface ProposalService {

    /**
     * 구매 품의 마스터 을 조회한다.
     * <pre>
     * 구매 품의 마스터을 조회한다.
     * </pre>
     *
     * @param inVar
     * @return PgmAuthDTO
     * @throws Exception
     */
    public RecordSet selectPoOrderList (Map <String, Object> inVar) throws Exception;

    /**
     * 품의 상신 한다.
     *
     * @param proposalInfo, itemList, payList, blckMarkList
     * @throws Exception
     */
    int proposalDraft(LoginDTO loginParameter,DataSetMap search, DataSetMap dsProposalList )  throws Exception;

    /**
     * 품의 삭제 한다.
     *
     * @param proposalInfo, itemList, payList, blckMarkList
     * @throws Exception
     */
    int deletePoProposalMst(LoginDTO loginParameter,DataSetMap search, DataSetMap dsProposalList );

    /**
     * 구매 품의 마스터 시퀀스을 조회한다.
     * <pre>
     * 구매 품의 마스터 시퀀스을 조회한다.
     * </pre>
     *
     * @param inVar
     * @return PgmAuthDTO
     * @throws Exception
     */
    public String getPoProposalMstS (Map <String, Object> inVar) throws Exception;

    /**
     * 구매 품의 마스터 을 조회한다.
     * <pre>
     * 구매 품의 마스터을 조회한다.
     * </pre>
     *
     * @param inVar
     * @return PgmAuthDTO
     * @throws Exception
     */
    public RecordSet selectProposalDtl (Map <String, Object> inVar) throws Exception;

    /**
     * 구매 품의 마스터 을 조회한다.
     * <pre>
     * 구매 품의 마스터을 조회한다.
     * </pre>
     *
     * @param inVar
     * @return PgmAuthDTO
     * @throws Exception
     */

    public RecordSet selectCallProposalDtl (Map <String, Object> inVar) throws Exception;

    /**
     * 구매 품의 품목 상세를 조회한다.
     *
     * @param inVar
     * @throws Exception
     */
    public RecordSet selectPoProposalItemDtlList (Map <String, Object> inVar) throws Exception;

    /**
     * 구매 품의 품목 sum 조회한다.
     *
     * @param inVar
     * @throws Exception
     */
    public RecordSet selectPoProposalItemDtlSum (Map <String, Object> inVar) throws Exception;

    /**
     * 구매 품의 지불 조건를 조회한다.
     *
     * @param inVar
     * @throws Exception
     */
    public RecordSet selectPoProposalPayCondList (Map <String, Object> inVar) throws Exception;

    /**
     * 구매 품의 벌점 조건를 조회한다.
     *
     * @param inVar
     * @throws Exception
     */
    public RecordSet selectPoProposalBlckMarkCondList (Map <String, Object> inVar) throws Exception;

    /**
     * 구매 품의를 저장 한다.
     *
     * @param proposalInfo, itemList, payList, blckMarkList
     * @throws Exception
     */
    List<Map<String, Object>> saveProposalDtl(LoginDTO loginParameter,DataSetMap search, DataSetMap proposalInfo, DataSetMap itemList, DataSetMap payList, DataSetMap blckMarkList, DataSetMap file, DataSetMap file2) throws Exception ;


    /**
     * 구매 품의 마스터 을 조회한다.
     * <pre>
     * 구매 품의 마스터을 조회한다.
     * </pre>
     *
     * @param inVar
     * @return PgmAuthDTO
     * @throws Exception
     */
    public RecordSet selectProposalSearchPop (Map <String, Object> inVar) throws Exception;

    /**
     * 환율을 조회한다.
     * <pre>
     * 구매 품의 마스터 시퀀스을 조회한다.
     * </pre>
     *
     * @param inVar
     * @return PgmAuthDTO
     * @throws Exception
     */
    public Record getExchangeRate (Map <String, Object> inVar) throws Exception;

    /**
     * 단위변경시 단위에 해당하는 실단위 가져오기
     * <pre>
     * 구매 품의 마스터 시퀀스을 조회한다.
     * </pre>
     *
     * @param inVar
     * @return PgmAuthDTO
     * @throws Exception
     */
    public Record chkDupBlnum (Map <String, Object> inVar) throws Exception;

    /**
     * 수수료구분 변경시 계정정보 가져오기
     * <pre>
     * 구매 품의 마스터 시퀀스을 조회한다.
     * </pre>
     *
     * @param inVar
     * @return PgmAuthDTO
     * @throws Exception
     */
    public Record getAccCdInfo (Map <String, Object> inVar) throws Exception;

    /**
     * BL번호 중복체크
     * <pre>
     * BL번호 중복체크
     * </pre>
     *
     * @param inVar
     * @return PgmAuthDTO
     * @throws Exception
     */
    public Record getUnitInfo (Map <String, Object> inVar) throws Exception;
}
