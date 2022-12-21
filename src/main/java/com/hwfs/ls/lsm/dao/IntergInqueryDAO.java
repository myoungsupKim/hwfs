package com.hwfs.ls.lsm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 통합목록 조회 Dao Class
 *
 * @ClassName IntergInqueryDAO.java
 * @Description IntergInqueryDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 13.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 4. 13.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ls/lsm/intergInqueryDAO")
public class IntergInqueryDAO extends DefaultDAO {

    /**
     * 통합목록 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lsm.intergInqueryDAO.selectList", parameter);
    }

    /**
     * 검체유형항목 대분류를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectMgrpList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lsm.intergInqueryDAO.selectMgrpList", parameter);
    }

    /**
     * 검체유형항목 중분류를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectMcalssList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lsm.intergInqueryDAO.selectMcalssList", parameter);
    }

    /**
     * 검체유형항목 소분류를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectSclassList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lsm.intergInqueryDAO.selectSclassList", parameter);
    }

}
