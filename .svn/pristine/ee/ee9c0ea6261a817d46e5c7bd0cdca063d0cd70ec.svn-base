package com.hwfs.ls.lrm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 접수정보 조회 Dao Class
 *
 * @ClassName TestAcceptApprvDAO.java
 * @Description TestAcceptApprvDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 19.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 3. 19.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ls/lrm/testAcceptApprvDAO")
public class TestAcceptApprvDAO extends DefaultDAO {

    /**
     * 시험접수목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lrm.testAcceptApprvDAO.selectList", parameter);
    }

    /**
     * 접수내역을 상태를 저장 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int saveTestReqStatus(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lrm.testAcceptApprvDAO.saveTestReqStatus", parameter);
    }

}
