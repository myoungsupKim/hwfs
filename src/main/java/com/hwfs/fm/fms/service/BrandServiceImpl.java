package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fms.dao.BrandDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 브랜드 업장/아이템 BrandService Implementation
 * 
 * @ClassName BrandServiceImpl.java
 * @Description BrandServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2021.07.21    Jaey        최초생성
 *  
 * </pre>
 * @author Jaey
 * @since 2021.07.21
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fms/brandService")
public class BrandServiceImpl extends DefaultServiceImpl implements BrandService {
	
	/** BrandDAO Bean 생성 */
	@Resource(name = "/fm/fms/brandDAO")
	private BrandDAO brandDAO;
	

	/**
	 * 브랜드 업장 조회
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectBrandUpjangList(Map<String, Object> mapParam) throws Exception {
		return brandDAO.selectBrandUpjangList(mapParam);
	}
	
	/**
	 * 브랜드 상품 조회
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectBrandItemList(Map<String, Object> mapParam) throws Exception {
		return brandDAO.selectBrandItemList(mapParam);
	}

	/**
	 * 브랜드 발주제한상품 조회
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectBrandExceptionItemList(Map<String, Object> mapParam) throws Exception {
		return brandDAO.selectBrandExceptionItemList(mapParam);
	}
	
	
}
