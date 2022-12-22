package com.hwfs.ms.mpi.dao;

import hone.core.jdbc.search.SearchParameters;
import hone.core.util.record.RecordSet;
import hone.core.util.record.RecordUtils;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.SqlInOutParameter;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;
import com.hwfs.guide.sample.dto.SampleSearchDTO;

/**
 * ProductInformation Dao Implementation
 * @ClassName ProductInformationDaoImpl.java
 * @Description ProductInformationDaoImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 02. 23.   DSKANG        최초생성
 * </pre>
 * @author FC종합전산구축 : DSKANG
 * @since 2015. 02. 23.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ms/mpi/productInformationDAO")
public class ProductInformationDAO extends DefaultDAO {

    
	/**
	 * 상품정보(모바일) 조회.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 글 목록 RecordSet
	 * @exception Exception
	 */
	public RecordSet selectProductInformationList(Map<String, Object> searchMap) throws Exception {
		return queryForRecordSet ("ms.mpi.productInformationDAO.selectProductInformationList", searchMap);
	}
	
	/**
	 * 상품정보(모바일) 조회.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 글 목록 RecordSet
	 * @exception Exception
	 */
	public RecordSet selectCustProductInformationList(Map<String, Object> mapParam) throws Exception {
		return queryForRecordSet("ms.mpi.productInformationDAO.selectCustProductInformationList", mapParam);
	}
}
