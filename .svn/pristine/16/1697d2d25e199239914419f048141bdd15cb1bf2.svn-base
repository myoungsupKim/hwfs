package com.hwfs.ls.lsm.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

import hone.core.util.record.RecordSet;

/**
 * 년간계획 관리 Dao Class
 *
 * @ClassName YealyPlanMgmtDAO.java
 * @Description YealyPlanMgmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 5. 15.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 5. 15.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ls/lsm/yealyPlanMgmtDAO")
public class YealyPlanMgmtDAO extends DefaultDAO {

    /**
     * 년간계획 수립 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lsm.yealyPlanMgmtDAO.selectList", parameter);
    }

    /**
     * 공전유형 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectClassList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lsm.yealyPlanMgmtDAO.selectClassList", parameter);
    }

    /**
     * 년간계획 조회 - 년간시료수
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectTestCnt(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lsm.yealyPlanMgmtDAO.selectTestCnt", parameter);
    }

    /**
     * 년간계획 조회 - 화학 검사 수
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectMicbioCnt(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lsm.yealyPlanMgmtDAO.selectMicbioCnt", parameter);
    }

    /**
     * 년간계획 조회 - 생물 검사 수
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectPhyChemCnt(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lsm.yealyPlanMgmtDAO.selectPhyChemCnt", parameter);
    }

    /**
     * 자재 목록 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectItemList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lsm.yealyPlanMgmtDAO.selectItemList", parameter);
    }

    /**
     * 자재 목록 조회 (위생_기타)
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectEtcItemList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lsm.yealyPlanMgmtDAO.selectEtcItemList", parameter);
    }

    /**
     * 년간계획 master를 생성한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertMstList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lsm.yealyPlanMgmtDAO.insertMstList", parameter);
    }

    /**
     * 년간계획 master를 삭제한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteMstList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lsm.yealyPlanMgmtDAO.deleteMstList", parameter);
    }

    /**
     * 년간계획 detail을 수정한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int updateDtlList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lsm.yealyPlanMgmtDAO.updateDtlList", parameter);
    }

    /**
     * 년간계획 detail을 삭제한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteDtlList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lsm.yealyPlanMgmtDAO.deleteDtlList", parameter);
    }

    /**
     * 년간계획 세부 내역 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectItemDtlList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lsm.yealyPlanMgmtDAO.selectItemDtlList", parameter);
    }

}
