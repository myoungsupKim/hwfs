package com.hwfs.ls.lsm.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

import hone.core.util.record.RecordSet;

/**
 * 월간보고 관리 Dao Class
 *
 * @ClassName MonthlyRptMgmtDAO.java
 * @Description MonthlyRptMgmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 6. 01.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 6. 01.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ls/lsm/monthlyRptMgmtDAO")
public class MonthlyRptMgmtDAO extends DefaultDAO {

    /**
     * 월간보고 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lsm.monthlyRptMgmtDAO.selectList", parameter);
    }

    /**
     * 월간보고 합계 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectListSum(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lsm.monthlyRptMgmtDAO.selectListSum", parameter);
    }

    /**
     * 월간보고 검사내용 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectSpecmDescList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lsm.monthlyRptMgmtDAO.selectSpecmDescList", parameter);
    }

    /**
     * 월간보고 검사내용 생성한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertSpecmDescList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lsm.monthlyRptMgmtDAO.insertSpecmDescList", parameter);
    }

    /**
     * 월간보고 검사내용 삭제한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteSpecmDescList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lsm.monthlyRptMgmtDAO.deleteSpecmDescList", parameter);
    }

    /**
     * 월간보고 검사내용 복사한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int copySpecmDescList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lsm.monthlyRptMgmtDAO.copySpecmDescList", parameter);
    }

}
