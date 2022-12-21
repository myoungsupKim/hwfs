package com.hwfs.sc.scz.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 고정자산 명세서를 조회하는 FixedAssetsList DAO
 * 
 * @ClassName FixedAssetsListDAO.java
 * @Description FixedAssetsListDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.11.11   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.11.11
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scz/fixedAssetsListDAO")
public class FixedAssetsListDAO extends DefaultDAO {
	
	/**
	 * 고정자산 명세서 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCostCenter(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.fixedAssetsListDAO.selectCostCenter", mapParam);
	}

	public RecordSet selectMapCostCenter(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.fixedAssetsListDAO.selectMapCostCenter", mapParam);
	}

	public RecordSet selectSingleCostCenter(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.fixedAssetsListDAO.selectSingleCostCenter", mapParam);
	}

	public RecordSet selectMapTmCostCenter(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.fixedAssetsListDAO.selectMapTmCostCenter", mapParam);
	}

	public RecordSet selectBonbuCostCenter(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.fixedAssetsListDAO.selectBonbuCostCenter", mapParam);
	}

	public RecordSet selectBonbuTmCostCenter(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scz.fixedAssetsListDAO.selectBonbuTmCostCenter", mapParam);
	}
}
