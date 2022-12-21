package com.hwfs.ls.lsm.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

import hone.core.util.record.RecordSet;

/**
 * 업장기간별금액조회 Dao Class
 *
 * @ClassName UpjangTermAmtInqueryDAO.java
 * @Description UpjangTermAmtInqueryDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 7. 16.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 7. 16.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ls/lsm/upjangTermAmtInqueryDAO")
public class UpjangTermAmtInqueryDAO extends DefaultDAO {

    /**
     * 업장기간별금액조회
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lsm.upjangTermAmtInqueryDAO.selectList", parameter);
    }

    /**
     * 업장기간별금액 상세를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectDetailList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lsm.upjangTermAmtInqueryDAO.selectDetailList", parameter);
    }

    /**
     * 업장기간별금액 상세 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectDetailViewList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lsm.upjangTermAmtInqueryDAO.selectDetailViewList", parameter);
    }

}
