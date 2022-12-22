package com.hwfs.ls.lcm.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 시험항목 관리 Dao Class
 *
 * @ClassName TestArticleMgmtDAO.java
 * @Description TestArticleMgmtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 2. 9.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 2. 9.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ls/lcm/testArticleMgmtDAO")
public class TestArticleMgmtDAO extends DefaultDAO {

    /**
     * 시험항목에 대하여 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public RecordSet selectTestArticleList(Map<String, Object> parameter) throws Exception {
        return super.queryForRecordSet("ls.lcm.testArticleMgmtDAO.selectTestArticleList", parameter);
    }

    /**
     * 시험항목번호를 채번 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public String selectTestArticleCd(Map<String, Object> parameter) throws Exception {
        return (String) super.queryForObject("ls.lcm.testArticleMgmtDAO.selectTestArticleCd", parameter, null);
    }

    /**
     * 시험항목을 생성한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertTestArticleList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.testArticleMgmtDAO.insertTestArticleList", parameter);
    }

    /**
     * 시험항목을 수정한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int updateTestArticleList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.testArticleMgmtDAO.updateTestArticleList", parameter);
    }

    /**
     * 시험항목을 삭제한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteTestArticleList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.testArticleMgmtDAO.deleteTestArticleList", parameter);
    }

    /**
     * 전체 생성
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int insertTestArticleAllList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.testArticleMgmtDAO.insertTestArticleAllList", parameter);
    }

    /**
     * 전체를 삭제
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public int deleteAllList(Map<String, Object> parameter) throws Exception {
        return super.update("ls.lcm.testArticleMgmtDAO.deleteAllList", parameter);
    }

}
