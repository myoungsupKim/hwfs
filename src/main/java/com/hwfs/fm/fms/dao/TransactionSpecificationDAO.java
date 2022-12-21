package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 거래명세서(브랜드) TransactionSpecificationDAO DAO
 * 
 * @ClassName TransactionSpecificationDAO.java
 * @Description TransactionSpecificationDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2021.08.25   	윤인묵        최초생성
 * </pre> 
 * @author 윤인묵
 * @since 2021.08.25
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fms/transactionSpecificationDAO")
public class TransactionSpecificationDAO extends DefaultDAO {

	/**
	 *거래명세서 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.transactionSpecificationDAO.selectList", mapParam);
	}
	
	/**
	 * 거래명세서 파라미터 DATA를 추가한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertParamList(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.transactionSpecificationDAO.insertParamList", mapParam);
	}
	
	/**
	 * 거래명세서 파라미터 DATA를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteParamList(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.transactionSpecificationDAO.deleteParamList", mapParam);
	}	
}