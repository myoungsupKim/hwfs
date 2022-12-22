package com.hwfs.ls.lsm.service;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ls.lsm.dao.TestUserSpecmArticleInqueryDAO;

import hone.core.util.record.RecordSet;

/**
 * 검사자 검사항목 현황 ServiceImple Class
 *
 * @ClassName TestUserSpecmArticleInqueryServiceImple.java
 * @Description TestUserSpecmArticleInqueryServiceImple Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 9. 23.   jshoon        최초생성
 * </pre>
 * @author FC종합전산구축 : LIMS jshoon
 * @since 2015. 9. 23.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ls/lsm/testUserSpecmArticleInqueryService")
public class TestUserSpecmArticleInqueryServiceImpl extends DefaultServiceImpl implements TestUserSpecmArticleInqueryService {

    @Resource(name = "/ls/lsm/testUserSpecmArticleInqueryDAO")
    private TestUserSpecmArticleInqueryDAO testUserSpecmArticleInqueryDAO;

    /**
     * 검사구분별 검사 건수
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.TestUserSpecmArticleInqueryService#selectList(java.util.Map)
    */
    @Override
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return testUserSpecmArticleInqueryDAO.selectList(parameter);
    }

    /**
     * 담당자별 검수 건수
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.TestUserSpecmArticleInqueryService#selectList1(java.util.Map)
    */
    @Override
    public RecordSet selectList1(Map<String, Object> parameter) throws Exception {
        return testUserSpecmArticleInqueryDAO.selectList1(parameter);
    }

    /**
     * 검사분야 현황 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.TestUserSpecmArticleInqueryService#selectDetailList(java.util.Map)
    */
    @Override
    public RecordSet selectDetailList(Map<String, Object> parameter) throws Exception {
        return testUserSpecmArticleInqueryDAO.selectDetailList(parameter);
    }

    /**
     * 검사분야 현황 상세 조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.TestUserSpecmArticleInqueryService#selectDetailViewList(java.util.Map)
    */
    @Override
    public RecordSet selectDetailViewList(Map<String, Object> parameter) throws Exception {
        return testUserSpecmArticleInqueryDAO.selectDetailViewList(parameter);
    }

}
