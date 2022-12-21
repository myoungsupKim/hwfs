package com.hwfs.ls.lsm.service;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ls.lsm.dao.SpecmTypeItemInqueryDAO;

import hone.core.util.record.RecordSet;

/**
 * 유형별 ITEM별 검사현황 ServiceImple Class
 *
 * @ClassName SpecmTypeItemInqueryServiceImple.java
 * @Description SpecmTypeItemInqueryServiceImple Class
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
@Service("/ls/lsm/specmTypeItemInqueryService")
public class SpecmTypeItemInqueryServiceImpl extends DefaultServiceImpl implements SpecmTypeItemInqueryService {

    @Resource(name = "/ls/lsm/specmTypeItemInqueryDAO")
    private SpecmTypeItemInqueryDAO specmTypeItemInqueryDAO;

    /**
     * 유형별 ITEM별 검사현황
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.SpecmTypeItemInqueryService#selectList(java.util.Map)
    */
    @Override
    public RecordSet selectList(Map<String, Object> parameter) throws Exception {
        return specmTypeItemInqueryDAO.selectList(parameter);
    }

    /**
     * 유형별 ITEM별 검사 상세현황
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.SpecmTypeItemInqueryService#selectList1(java.util.Map)
    */
    @Override
    public RecordSet selectList1(Map<String, Object> parameter) throws Exception {
        return specmTypeItemInqueryDAO.selectList1(parameter);
    }

    /**
     * 유형별 ITEM별 검사 시험항목 상세 현황
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.lsm.service.SpecmTypeItemInqueryService#selectDetailViewList(java.util.Map)
    */
    @Override
    public RecordSet selectDetailViewList(Map<String, Object> parameter) throws Exception {
        return specmTypeItemInqueryDAO.selectDetailViewList(parameter);
    }

}
