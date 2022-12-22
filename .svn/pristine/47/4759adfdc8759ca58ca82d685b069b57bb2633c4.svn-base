package com.hwfs.fm.fmo.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 식재영업 출력설정하는 FoodMaterialsSalePrintSet DAO
 * 
 * @ClassName FoodMaterialsSalePrintSetDAO.java
 * @Description FoodMaterialsSalePrintSetDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.20   	최영준        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015.04.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmo/foodMaterialsSalePrintSetDAO")
public class FoodMaterialsSalePrintSetDAO extends DefaultDAO {

	/**
	 * 식재영업 출력설정 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.foodMaterialsSalePrintSetDAO.selectList", mapParam);
	}

	/**
	 * (공통)거래명세서 일괄출력 목록을 조회한다.
	 *
	 * @return
	 */
	public RecordSet selectSCC() throws Exception {
		return super.queryForRecordSet("fm.fmo.foodMaterialsSalePrintSetDAO.selectSCC","");
	}

	/**
	 * 식재영업 출력설정(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.foodMaterialsSalePrintSetDAO.insert", mapParam);
	}
	
	/**
	 * 식재영업 출력설정(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.foodMaterialsSalePrintSetDAO.update", mapParam);
	}
	
	/**
	 * 식재영업 출력설정(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.foodMaterialsSalePrintSetDAO.delete", mapParam);
	}
	
}
