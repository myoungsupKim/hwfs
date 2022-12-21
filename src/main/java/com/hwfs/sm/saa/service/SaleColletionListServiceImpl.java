package com.hwfs.sm.saa.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.saa.dao.SaleColletionListDAO;

/**
 * 판매/수금 부동처 현황하는 SaleColletionList Service Implementation
 *
 * @ClassName SaleColletionListServiceImpl.java
 * @Description SaleColletionListServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.12    최종덕        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최종덕
 * @since 2015.05.12
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/saa/saleColletionListService")
public class SaleColletionListServiceImpl extends DefaultServiceImpl implements SaleColletionListService {

    /** SaleColletionListDAO Bean 생성 */
    @Resource(name = "/sm/saa/saleColletionListDAO")
    private SaleColletionListDAO saleColletionListDAO;

    /**
     * 판매부동처 및 수금부동처 현황을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return saleColletionListDAO.selectList(mapParam);
    }

    /**
     * 판매부동처 및 수금부동처 현황(식재)을 조회한다.
     *
     * @param mapParam
     *            조회조건 Map
     * @return RecordSet
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectListFms(Map<String, Object> mapParam) throws Exception {
    	return saleColletionListDAO.selectListFms(mapParam);
    }
}
