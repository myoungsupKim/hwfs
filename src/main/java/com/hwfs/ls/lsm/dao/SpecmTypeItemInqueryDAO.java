package com.hwfs.ls.lsm.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

import hone.core.util.record.RecordSet;

/**
 * 유형별 ITEM별 검사현황 Dao Class
 *
 * @ClassName SpecmTypeItemInqueryDAO.java
 * @Description SpecmTypeItemInqueryDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 9. 24.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 9. 24.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ls/lsm/specmTypeItemInqueryDAO")
public class SpecmTypeItemInqueryDAO extends DefaultDAO {

    /**
     * 유형별 ITEM별 검사현황
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lsm.specmTypeItemInqueryDAO.selectList", parameter);
    }

    /**
     * 유형별 ITEM별 검사 상세현황
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectList1(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lsm.specmTypeItemInqueryDAO.selectList1", parameter);
    }

    /**
     * 유형별 ITEM별 검사 시험항목 상세 현황
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectDetailViewList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lsm.specmTypeItemInqueryDAO.selectDetailViewList", parameter);
    }

}
