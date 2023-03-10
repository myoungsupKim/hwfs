package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 브랜드 업장/아이템 BrandDAO
 * 
 * @ClassName BrandDAO.java
 * @Description BrandDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2021.07.21    Jaey        최초생성
 * </pre>
 * @author Jaey
 * @since 2021.07.21
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fms/brandDAO")
public class BrandDAO extends DefaultDAO {
	

	/**
	 * 브랜드 업장 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectBrandUpjangList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.brandDAO.selectBrandUpjangList", mapParam);
	}
	
	/**
	 * 브랜드 상품 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectBrandItemList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.brandDAO.selectBrandItemList", mapParam);
	}

	/**
	 * 브랜드 발주제한상품 조회
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectBrandExceptionItemList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.brandDAO.selectBrandExceptionItemList", mapParam);
	}

	
}
