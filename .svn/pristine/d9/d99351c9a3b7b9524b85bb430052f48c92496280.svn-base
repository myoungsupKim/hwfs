package com.hwfs.ls.lsm.service;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ls.lsm.dao.UpjangTermAmtInqueryDAO;

import hone.core.util.record.RecordSet;

/**
 * 업장기간별금액조회 ServiceImple Class
 *
 * @ClassName UpjangTermAmtInqueryServiceImple.java
 * @Description UpjangTermAmtInqueryServiceImple Class
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
@Service("/ls/lsm/upjangTermAmtInqueryService")
public class UpjangTermAmtInqueryServiceImpl extends DefaultServiceImpl implements UpjangTermAmtInqueryService {

    @Resource(name = "/ls/lsm/upjangTermAmtInqueryDAO")
    private UpjangTermAmtInqueryDAO upjangTermAmtInqueryDAO;

    /**
     * 업장기간별금액조회
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.UpjangTermAmtInqueryService#selectList(java.util.Map)
    */
    @Override
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return upjangTermAmtInqueryDAO.selectList(parameter);
    }

    /**
     * 업장기간별금액 상세를 조회한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.UpjangTermAmtInqueryService#selectDetailList(java.util.Map)
    */
    @Override
    public RecordSet selectDetailList(Map<String, Object> parameter) throws Exception {
        return upjangTermAmtInqueryDAO.selectDetailList(parameter);
    }

    /**
     * 업장기간별금액 상세 목록을 조회한다
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.UpjangTermAmtInqueryService#selectDetailViewList(java.util.Map)
    */
    @Override
    public RecordSet selectDetailViewList(Map<String, Object> parameter) throws Exception {
        return upjangTermAmtInqueryDAO.selectDetailViewList(parameter);
    }

}
