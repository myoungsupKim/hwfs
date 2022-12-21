package com.hwfs.sm.saa.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 판매/수금 부동처 현황하는 SaleColletionList DAO
 *
 * @ClassName SaleColletionListDAO.java
 * @Description SaleColletionListDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.12      최종덕        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최종덕
 * @since 2015.05.12
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/saa/saleColletionListDAO")
public class SaleColletionListDAO extends DefaultDAO {

    /**
     * 판매부동처 및 수금부동처 현황을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
        return super.queryForRecordSet("sm.saa.saleColletionListDAO.selectList", mapParam);
    }

    /**
     * 판매부동처 및 수금부동처 현황(식재)을 조회한다.
     *
     * @param mapParam
     * @return
     */
    public RecordSet selectListFms(Map<String, Object> mapParam) throws Exception {
    	return super.queryForRecordSet("sm.saa.saleColletionListDAO.selectListFms", mapParam);
    }
    
}
