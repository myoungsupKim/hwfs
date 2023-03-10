package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fms.dao.FoodMaterialsSupplyPriceIndexDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * 식자재 단가표하는 FoodMaterialsSupplyPriceIndex Service Implementation
 * 
 * @ClassName FoodMaterialsSupplyPriceIndexServiceImpl.java
 * @Description FoodMaterialsSupplyPriceIndexServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.17    최영준        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015.04.17
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fms/foodMaterialsSupplyPriceIndexService")
public class FoodMaterialsSupplyPriceIndexServiceImpl extends DefaultServiceImpl implements FoodMaterialsSupplyPriceIndexService {
	
	/** FoodMaterialsSupplyPriceIndexDAO Bean 생성 */
	@Resource(name = "/fm/fms/foodMaterialsSupplyPriceIndexDAO")
	private FoodMaterialsSupplyPriceIndexDAO foodMaterialsSupplyPriceIndexDAO;
	

	/**
	 * 공급 단가정보 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectListA(Map<String, Object> mapParam) throws Exception {
		return foodMaterialsSupplyPriceIndexDAO.selectListA(mapParam);
	}
	public RecordSet selectListB(Map<String, Object> mapParam) throws Exception {
		return foodMaterialsSupplyPriceIndexDAO.selectListB(mapParam);
	}
	public RecordSet selectListC(Map<String, Object> mapParam) throws Exception {
		return foodMaterialsSupplyPriceIndexDAO.selectListC(mapParam);
	}
	public RecordSet selectListD(Map<String, Object> mapParam) throws Exception {
		return foodMaterialsSupplyPriceIndexDAO.selectListD(mapParam);
	}
	public RecordSet selectListF(Map<String, Object> mapParam) throws Exception {
		return foodMaterialsSupplyPriceIndexDAO.selectListF(mapParam);
	}
	public RecordSet selectListG(Map<String, Object> mapParam) throws Exception {
		return foodMaterialsSupplyPriceIndexDAO.selectListG(mapParam);
	}
	
	/**
	 * 공급 단가정보 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectContractId(Map<String, Object> mapParam) throws Exception {
		return foodMaterialsSupplyPriceIndexDAO.selectContractId(mapParam);
	}

}
