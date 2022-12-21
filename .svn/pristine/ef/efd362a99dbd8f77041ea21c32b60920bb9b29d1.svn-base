package com.hwfs.sm.saa.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.saa.dao.RiskArListDAO;

/**
 * 부실채권 발생처 조회하는 RiskArList Service Implementation
 *
 * @ClassName RiskArListServiceImpl.java
 * @Description RiskArListServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.28    남기빈        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 남기빈
 * @since 2015.04.28
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/saa/riskArListService")
public class RiskArListServiceImpl extends DefaultServiceImpl implements RiskArListService {

    /** RiskArListDAO Bean 생성 */
    @Resource(name = "/sm/saa/riskArListDAO")
    private RiskArListDAO riskArListDAO;

    /**
     * 부실채권 발생처 조회 목록을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return riskArListDAO.selectList(mapParam);
    }

    /**
     * 부실채권 발생처 조회 목록(식재)을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectListFms(Map<String, Object> mapParam) throws Exception {
    	return riskArListDAO.selectListFms(mapParam);
    }
}
