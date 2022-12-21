package com.hwfs.ls.lum.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 시약수불 관리 Dao Class
 *
 * @ClassName ReagentTransMgmtDAO.java
 * @Description ReagentTransMgmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 22.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 4. 22.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ls/lum/reagentTransMgmtDAO")
public class ReagentTransMgmtDAO extends DefaultDAO {

    /**
     * 시약수불에 대하여 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lum.reagentTransMgmtDAO.selectList", parameter);
    }

    /**
     * 시약수불 내역에 대하여 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectSummaryList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lum.reagentTransMgmtDAO.selectSummaryList", parameter);
    }

    /**
     * 시약수불을 생성한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertReagentTransList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lum.reagentTransMgmtDAO.insertReagentTransList", parameter);
    }

    /**
     * 시약수불을 삭제한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteReagentTransList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lum.reagentTransMgmtDAO.deleteReagentTransList", parameter);
    }

}
