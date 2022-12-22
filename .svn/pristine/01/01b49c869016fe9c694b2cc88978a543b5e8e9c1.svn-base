package com.hwfs.ms.mom.service;

import hone.core.jdbc.search.SearchParameters;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ms.mom.dao.ProductOrderReportDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.tobesoft.xplatform.data.DataSet;

/**
 * ProductOrderReportService Service Implementation
 * @ClassName ProductOrderReportServiceServiceImpl.java
 * @Description ProductOrderReportServiceServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 02. 06.   DSKANG        최초생성
 * </pre>
 * @author FC종합전산구축 : DSKANG
 * @since 2015. 02. 06.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ms/mom/productOrderReportService")
public class ProductOrderReportServiceImpl extends DefaultServiceImpl implements ProductOrderReportService {

	@Resource(name="/ms/mom/productOrderReportDAO")
	private ProductOrderReportDAO productOrderReportDAO;
	
	/**
	 * 상품발주내역(모바일) 조회
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 건수
	 * @exception Exception
	 */
	public List<Map> selectList(Map<String, Object> searchMap) throws Exception {
		return productOrderReportDAO.selectList(searchMap);
    } 
    
	
}
