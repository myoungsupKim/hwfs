package com.hwfs.ms.mpi.service;

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
import com.hwfs.ms.mpi.dao.ProductInformationDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.tobesoft.xplatform.data.DataSet;

/**
 * ProductInformationService Service Implementation
 * @ClassName ProductInformationServiceServiceImpl.java
 * @Description ProductInformationServiceServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 02. 23.   DSKANG        최초생성
 * </pre>
 * @author FC종합전산구축 : DSKANG
 * @since 2015. 02. .
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ms/mpi/productInformationService")
public class ProductInformationServiceImpl extends DefaultServiceImpl implements ProductInformationService {

	@Resource(name="/ms/mpi/productInformationDAO")
	private ProductInformationDAO productInformationDAO;
	
	/**
	 * 상품발주내역(모바일) 조회
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 건수
	 * @exception Exception
	 */
	public RecordSet selectProductInformationList(Map<String, Object> searchMap) throws Exception {
		return productInformationDAO.selectProductInformationList(searchMap);
    } 
	
	/**
	 * 상품발주내역(모바일) 조회
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 건수
	 * @exception Exception
	 */
	public RecordSet selectCustProductInformationList(Map<String, Object> searchMap) throws Exception {
		return productInformationDAO.selectCustProductInformationList(searchMap);
    } 
    
	
	/**
	 * 상품발주내역(모바일) 조회
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 건수
	 * @exception Exception
	 */
	public RecordSet selectProductInformationList2(Map<String, Object> searchMap) throws Exception {
		if ( searchMap.get("gubun").equals("01") ) {
			return productInformationDAO.selectProductInformationList(searchMap);
		} else {
			return productInformationDAO.selectCustProductInformationList(searchMap);
		}
		
    }	
}
