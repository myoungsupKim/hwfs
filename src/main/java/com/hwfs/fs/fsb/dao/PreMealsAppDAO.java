package com.hwfs.fs.fsb.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 업장이력조회하는 PreMealsApp DAO
 * 
 * @ClassName UpjangPackHistoryDAO.java
 * @Description UpjangPackHistoryDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.20   	최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.05.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsb/preMealsAppDAO")
public class PreMealsAppDAO extends DefaultDAO {
	
	/**
	 * 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	/*
	//업장
	public RecordSet selectUpjang(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.preMealsAppDAO.selectUpjang", mapParam);
	}
	//식당
	public RecordSet selectHall(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.preMealsAppDAO.selectHall", mapParam);
	}
	//끼니
	public RecordSet selectMeal(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.preMealsAppDAO.selectMeal", mapParam);
	}
	//코너
	public RecordSet selectCorner(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.preMealsAppDAO.selectCorner", mapParam);
	}	
	//식수
	public RecordSet selectMealQty(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.preMealsAppDAO.selectMealQty", mapParam);
	}
	*/
	//기준정보
	public RecordSet selectInfo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.preMealsAppDAO.selectInfo", mapParam);
	}
	//거래처
	public RecordSet selectCust(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.preMealsAppDAO.selectCust", mapParam);
	}
	//날씨
	public RecordSet selectWeather(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.preMealsAppDAO.selectWeather", mapParam);
	}
	//레시피
	public RecordSet selectRecipe(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.preMealsAppDAO.selectRecipe", mapParam);
	}
	//식단
	public RecordSet selectMenu(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.preMealsAppDAO.selectMenu", mapParam);
	}
    
	//미사용
	public RecordSet selectMenuHD(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.preMealsAppDAO.selectMenuHD", mapParam);
	}
	//미사용
	public RecordSet selectMenuDT(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsb.preMealsAppDAO.selectMenuDT", mapParam);
	}

	/**
	 * 2022.08.23 김명섭 한화솔루션 챗봇용 식단정보(한화빌딩-100751)
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet hanwhaGourmetIF(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("fs.fsb.preMealsAppDAO.hanwhaGourmetIF", parameter);
	}
	
}
