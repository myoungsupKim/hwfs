package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 식자재 단가표하는 FoodMaterialsSupplyPriceIndex DAO
 * 
 * @ClassName FoodMaterialsSupplyPriceIndexDAO.java
 * @Description FoodMaterialsSupplyPriceIndexDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.17   	최영준        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015.04.17
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fms/foodMaterialsSupplyPriceIndexDAO")
public class FoodMaterialsSupplyPriceIndexDAO extends DefaultDAO {
	
	/**
	 * 공급 단가정보 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectListA(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.foodMaterialsSupplyPriceIndexDAO.selectListA", mapParam);
	}
	public RecordSet selectListB(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.foodMaterialsSupplyPriceIndexDAO.selectListB", mapParam);
	}
	public RecordSet selectListC(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.foodMaterialsSupplyPriceIndexDAO.selectListC", mapParam);
	}
	public RecordSet selectListD(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.foodMaterialsSupplyPriceIndexDAO.selectListD", mapParam);
	}
	public RecordSet selectListF(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.foodMaterialsSupplyPriceIndexDAO.selectListF", mapParam);
	}
	public RecordSet selectListG(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.foodMaterialsSupplyPriceIndexDAO.selectListG", mapParam);
	}
	
	/**
	 * 공급 단가정보 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectContractId(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.foodMaterialsSupplyPriceIndexDAO.selectContractId", mapParam);
	}
	
}
