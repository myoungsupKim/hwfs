package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 테마자재율 등록하는 ThemeItemProfit DAO
 * 
 * @ClassName ThemeItemProfitDAO.java
 * @Description ThemeItemProfitDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2019.08.27    JHKIM        최초생성
 * </pre>
 * @author 식재영업운ㅇㅇ :  통합영업 JHKIM
 * @since 2019.08.27
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fms/ThemeItemProfitDAO")
public class ThemeItemProfitDAO extends DefaultDAO {
	

	/**
	 *테마자재율 CC목록을 조회한다.
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectStd(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.ThemeItemProfitDAO.selectStd", mapParam);
	}

	/**
	 *분류별 목록을 조회한다.
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectClass(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.ThemeItemProfitDAO.selectClass", mapParam);
	}
	public RecordSet selectClassType(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.ThemeItemProfitDAO.selectClassType", mapParam);
	}

	/**
	 *자재별 목록을 조회한다.
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectItem(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.ThemeItemProfitDAO.selectItem", mapParam);
	}
	
	/**
	 * 테마자재율 등록 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.ThemeItemProfitDAO.selectList", mapParam);
	}

	/**
	 * 테마자재율 등록(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.ThemeItemProfitDAO.insert", mapParam);
	}
	public int insert2(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.ThemeItemProfitDAO.insert2", mapParam);
	}
	public int insertClass(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.ThemeItemProfitDAO.insertClass", mapParam);
	}
	
	/**
	 * 테마자재율 등록(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.ThemeItemProfitDAO.update", mapParam);
	}
	
	/**
	 * 테마자재율 등록(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.ThemeItemProfitDAO.delete", mapParam);
	}
	public int deleteClass(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.ThemeItemProfitDAO.deleteClass", mapParam);
	}
	public int deleteItem(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.ThemeItemProfitDAO.deleteItem", mapParam);
	}
	public int deleteTheme(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.ThemeItemProfitDAO.deleteTheme", mapParam);
	}

	/**
	 * 테마자재률 자재 (을)를 일괄 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteAll(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.ThemeItemProfitDAO.deleteAll", mapParam);
	}

	
}
