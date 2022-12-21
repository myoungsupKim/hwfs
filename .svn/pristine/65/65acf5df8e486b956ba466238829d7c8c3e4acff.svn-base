package com.hwfs.ls.lsm.service;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ls.lsm.dao.TestUserTakeTermDAO;

import hone.core.util.record.RecordSet;

/**
 * 검사자 검사준수 현황 ServiceImple Class
 *
 * @ClassName TestUserTakeTermServiceImple.java
 * @Description TestUserTakeTermServiceImple Class
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
@Service("/ls/lsm/testUserTakeTermService")
public class TestUserTakeTermServiceImpl extends DefaultServiceImpl implements TestUserTakeTermService {

    @Resource(name = "/ls/lsm/testUserTakeTermDAO")
    private TestUserTakeTermDAO testUserTakeTermDAO;

    /**
     * 검사자 검사준수 현황
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.TestUserTakeTermService#selectList(java.util.Map)
    */
    @Override
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return testUserTakeTermDAO.selectList(parameter);
    }

}
