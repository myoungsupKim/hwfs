package com.hwfs.ls.ltm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 시험결과등록-시험항목별 Dao Class
 *
 * @ClassName TestResulTestArticleRegDAO.java
 * @Description TestResulTestArticleRegDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 04. 02.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 04. 02.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ls/ltm/testResulTestArticleRegDAO")
public class TestResulTestArticleRegDAO extends DefaultDAO {

    /**
     * 검체목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.ltm.testResulTestArticleRegDAO.selectList", parameter);
    }

    /**
     * 시험항목 목록을 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectDetailList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.ltm.testResulTestArticleRegDAO.selectDetailList", parameter);
    }

    /**
     * 시험항목 판정내역을 저장한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int updateTestArticleList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.ltm.testResulTestArticleRegDAO.updateTestArticleList", parameter);
    }

}
