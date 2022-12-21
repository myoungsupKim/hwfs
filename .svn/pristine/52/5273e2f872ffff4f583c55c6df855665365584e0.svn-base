package com.hwfs.ft.ftp.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 프로그램 권한, 권한에 맞는 메뉴목록을 조회하는 DAO
 * @ClassName ProposalDAO.java
 * @Description ProposalDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 2.24.   KJJ        최초생성
 * </pre>
 * @author FC종합전산구축 : KJJ
 * @since 2015. 2.24.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ft/ftp/proposalDAO")
public class ProposalDAO extends DefaultDAO {

    /**
     *구매 품의을 조회한다.
     *
     * @param
     * @return
     * @throws Exception
     */
    public RecordSet selectPoOrderList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftp.proposalDAO.selectPoOrderList", parameter);
    }

    /**
     * 구매 품의 상태를 수정한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @return
     * @param parameter
     */
    public int updatePoProposalDraft(Map<String, Object> parameter) {
        //if (parameter.size() <= 0) return 0;
        return super.update("ft.ftp.proposalDAO.updatePoProposalDraft", parameter);
    }

    /**
     * 구매 품의 삭제한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @return
     * @param parameter
     */
    public int deletePoProposalMst(Map<String, Object> parameter) {
        //if (parameter.size() <= 0) return 0;
        return super.update("ft.ftp.proposalDAO.deletePoProposalMst", parameter);
    }

    /**
     *구매 품의 마스터 시퀀스을 조회한다.
     *
     * @param
     * @return
     * @throws Exception
     */
    public String getPoProposalMstS(Map<String, Object> parameter) {
        return (String) super.queryForObject("ft.ftp.proposalDAO.getPoProposalMstS", parameter, null);
    }

    /**
     *구매 품의 마스터을 조회한다.
     *
     * @param
     * @return
     * @throws Exception
     */
    public RecordSet selectProposalDtl(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftp.proposalDAO.selectProposalDtl", parameter);
    }

    /**
     *구매 품의 마스터을 조회한다.
     *
     * @param
     * @return
     * @throws Exception
     */
    public RecordSet selectCallProposalDtl(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftp.proposalDAO.selectCallProposalDtl", parameter);
    }

    /**
     *  구매 품의 품목 상세를 조회한다.
     *
     * @return
     * @throws Exception
     */
    public RecordSet selectPoProposalItemDtlList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftp.proposalDAO.selectPoProposalItemDtlList", parameter);
    }

    /**
     *  구매 품의 품목 상세를 조회한다.
     *
     * @return
     * @throws Exception
     */
    public RecordSet selectPoProposalItemDtlSum(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftp.proposalDAO.selectPoProposalItemDtlSum", parameter);
    }
    /**
     * 구매 품의 지불 조건를 조회한다.
     *
     * @return
     * @throws Exception
     */
    public RecordSet selectPoProposalPayCondList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftp.proposalDAO.selectPoProposalPayCondList", parameter);
    }

    /**
     * 구매 품의 벌점 조건를 조회한다.
     *
     * @return
     * @throws Exception
     */
    public RecordSet selectPoProposalBlckMarkCondList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftp.proposalDAO.selectPoProposalBlckMarkCondList", parameter);
    }

    /**
     * 구매 품의 마스터를 생성한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     */
    public int insertPoProposal(Map<String, Object> parameter) {
        //if (parameter.size() <= 0) return 0;
        return super.update("ft.ftp.proposalDAO.insertPoProposal", parameter);
    }

    /**
     * 구매 품의 마스터를 수정한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @return
     * @param parameter
     */
    public int updatePoProposal(Map<String, Object> parameter) {
        //if (parameter.size() <= 0) return 0;
        return super.update("ft.ftp.proposalDAO.updatePoProposal", parameter);
    }

    /**
     * 구매 품의 마스터를 수정한다.(PO_TYPE)
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @return
     * @param parameter
     */
    public int updatePoProposaleType(Map<String, Object> parameter) {
        //if (parameter.size() <= 0) return 0;
        return super.update("ft.ftp.proposalDAO.updatePoProposalPoType", parameter);
    }
    

    /**
     * 구매 품의 품목 상세를 생성한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     */
    public int insertProposalItemList(Map<String, Object> parameter) {
        //if (parameter.size() <= 0) return 0;
        return super.update("ft.ftp.proposalDAO.insertProposalItemList", parameter);
    }

    /**
     * 구매 품의 품목 상세를 수정한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @return
     * @param parameter
     */
    public int updateProposalItemList(Map<String, Object> parameter) {
        //if (parameter.size() <= 0) return 0;
        return super.update("ft.ftp.proposalDAO.updateProposalItemList", parameter);
    }

    /**
     * 구매 품의 품목 상세를 수정한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @return
     * @param parameter
     */
    public int deleteProposalItemList(Map<String, Object> parameter) {
        //if (parameter.size() <= 0) return 0;
        return super.update("ft.ftp.proposalDAO.deleteProposalItemList", parameter);
    }

    /**
     * 구매 품의 지불 조건를 생성한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     */
    public int insertProposalPayList(Map<String, Object> parameter) {
        //if (parameter.size() <= 0) return 0;
        return super.update("ft.ftp.proposalDAO.insertProposalPayList", parameter);
    }

    /**
     * 구매 품의 지불 조건를 삭제한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @return
     * @param parameter
     */
    public int deleteProposalPayList(Map<String, Object> parameter) {
        //if (parameter.size() <= 0) return 0;
        return super.update("ft.ftp.proposalDAO.deleteProposalPayList", parameter);
    }

    /**
     * 구매 품의 지불 조건를 수정한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @return
     * @param parameter
     */
    public int updateProposalPayList(Map<String, Object> parameter) {
        //if (parameter.size() <= 0) return 0;
        return super.update("ft.ftp.proposalDAO.updateProposalPayList", parameter);
    }

    /**
     * 구매 품의 벌점 조건를 생성한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     */
    public int insertProposalBlckMarkList(Map<String, Object> parameter) {
        //if (parameter.size() <= 0) return 0;
        return super.update("ft.ftp.proposalDAO.insertProposalBlckMarkList", parameter);
    }

    /**
     * 구매 품의 벌점 조건를 수정한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @return
     * @param parameter
     */
    public int updateProposalBlckMarkList(Map<String, Object> parameter) {
        //if (parameter.size() <= 0) return 0;
        return super.update("ft.ftp.proposalDAO.updateProposalBlckMarkList", parameter);
    }

    /**
     * 구매 품의 벌점 조건를 삭제한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @return
     * @param parameter
     */
    public int deleteProposalBlckMarkList(Map<String, Object> parameter) {
        //if (parameter.size() <= 0) return 0;
        return super.update("ft.ftp.proposalDAO.deleteProposalBlckMarkList", parameter);
    }

    /**
     *구매 품의을 조회한다.
     *
     * @param
     * @return
     * @throws Exception
     */
    public RecordSet selectProposalSearchPop(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ft.ftp.proposalDAO.selectProposalSearchPop", parameter);
    }


    /**
     *환율을 조회한다.
     *
     * @param
     * @return
     * @throws Exception
     */
    public Record getExchangeRate(Map<String, Object> parameter) {
        return super.queryForRecord("ft.ftp.proposalDAO.getExchangeRate", parameter);
    }

    /**
     *단위변경시 단위에 해당하는 실단위 가져오기
     *
     * @param
     * @return
     * @throws Exception
     */
    public Record getUnitInfo(Map<String, Object> parameter) {
        return super.queryForRecord("ft.ftp.proposalDAO.getUnitInfo", parameter);
    }

    /**
     *수수료구분 변경시 계정정보 가져오기
     *
     * @param
     * @return
     * @throws Exception
     */
    public Record getAccCdInfo(Map<String, Object> parameter) {
        return super.queryForRecord("ft.ftp.proposalDAO.getAccCdInfo", parameter);
    }

    /**
     *매출 이익율을 조회한다.
     *
     * @param
     * @return
     * @throws Exception
     */
    public Record getSalsGainRat(Map<String, Object> parameter) {
        return  super.queryForRecord("ft.ftp.proposalDAO.getSalsGainRat", parameter);
    }

    /**
     *매출 이익율을 조회한다.
     *
     * @param
     * @return
     * @throws Exception
     */
    public Record getRatio(Map<String, Object> parameter) {
//        return (String) super.queryForObject("ft.ftp.proposalDAO.getRatio", parameter, null);
        return super.queryForRecord("ft.ftp.proposalDAO.getRatio", parameter);
    }

    /**
     *BL번호 중복체크
     *
     * @param
     * @return
     * @throws Exception
     */
    public Record chkDupBlnum(Map<String, Object> parameter) {
        return super.queryForRecord("ft.ftp.proposalDAO.chkDupBlnum", parameter);
    }

}
