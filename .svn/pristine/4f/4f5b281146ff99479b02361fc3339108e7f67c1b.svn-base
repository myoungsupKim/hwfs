package com.hwfs.ls.lsm.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

import hone.core.util.record.RecordSet;

/**
 * 월계획 조정 관리 Dao Class
 *
 * @ClassName MonthlyPlanMgmtDAO.java
 * @Description MonthlyPlanMgmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 9. 22.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 9. 22.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ls/lsm/monthlyPlanMgmtDAO")
public class MonthlyPlanMgmtDAO extends DefaultDAO {

    /**
     * 월계획 조정 수립 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lsm.monthlyPlanMgmtDAO.selectList", parameter);
    }

    /**
     * 공전유형 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectClassList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lsm.monthlyPlanMgmtDAO.selectClassList", parameter);
    }

    /**
     * 월계획 조정 조회 - 년간시료수
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectTestCnt(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lsm.monthlyPlanMgmtDAO.selectTestCnt", parameter);
    }

    /**
     * 월계획 조정 조회 - 화학 검사 수
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectMicbioCnt(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lsm.monthlyPlanMgmtDAO.selectMicbioCnt", parameter);
    }

    /**
     * 월계획 조정 조회 - 생물 검사 수
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectPhyChemCnt(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lsm.monthlyPlanMgmtDAO.selectPhyChemCnt", parameter);
    }

    /**
     * 자재 목록 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectItemList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lsm.monthlyPlanMgmtDAO.selectItemList", parameter);
    }

    /**
     * 자재 목록 조회 (위생_기타)
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectEtcItemList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lsm.monthlyPlanMgmtDAO.selectEtcItemList", parameter);
    }

    /**
     * 월계획 조정 master를 생성한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertMstList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lsm.monthlyPlanMgmtDAO.insertMstList", parameter);
    }

    /**
     * 월계획 조정 master를 삭제한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteMstList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lsm.monthlyPlanMgmtDAO.deleteMstList", parameter);
    }

    /**
     * 월계획 조정 detail을 수정한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int updateDtlList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lsm.monthlyPlanMgmtDAO.updateDtlList", parameter);
    }

    /**
     * 월계획 조정 detail을 삭제한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteDtlList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lsm.monthlyPlanMgmtDAO.deleteDtlList", parameter);
    }

    /**
     * 월계획 조정 세부 내역 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectItemDtlList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lsm.monthlyPlanMgmtDAO.selectItemDtlList", parameter);
    }

    /**
     * 년간계획 월계획 Master를 복사한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int saveYearPlanMstMigration(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lsm.monthlyPlanMgmtDAO.saveYearPlanMstMigration", parameter);
    }

    /**
     * 년간계획 월계획 Detail을 복사한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int saveYearPlanDtlMigration(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lsm.monthlyPlanMgmtDAO.saveYearPlanDtlMigration", parameter);
    }

    /**
     * 년간계획 대비 삭제 데이터 월계획 조정 Master 삭제
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteYearPlanMstMigration(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lsm.monthlyPlanMgmtDAO.deleteYearPlanMstMigration", parameter);
    }

    /**
     * 년간계획 대비 삭제 데이터 월계획 조정 Detail 삭제
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteYearPlanDtlMigration(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lsm.monthlyPlanMgmtDAO.deleteYearPlanDtlMigration", parameter);
    }

    /**
     * 시험결과 부적합 이력조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectDetailList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lsm.monthlyPlanMgmtDAO.selectDetailList", parameter);
    }

}
