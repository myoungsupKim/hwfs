package com.hwfs.rc.rcg.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 할인권 생성 관리하는 CouponCreate DAO
 * 
 * @ClassName DiscPromotionDAO.java
 * @Description DiscPromotionDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018.08.03    김명섭        최초생성
 * </pre>
 * @author FC정보기획팀 :  통합영업
 * @since 2018.08.03
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/rcg/discPromotionDAO")
public class DiscPromotionDAO extends DefaultDAO {
	
	/**
	 * 할인 생성 관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rcg.discPromotionDAO.selectList", mapParam);
	}

	/**
	 * 할인 생성 관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.discPromotionDAO.insert", mapParam);
	}

	/**
	 * 할인 생성 관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertRow(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.discPromotionDAO.insertRow", mapParam);
	}
	
	/**
	 * 할인 생성 관리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.discPromotionDAO.update", mapParam);
	}
	
	/**
	 * 할인 생성 관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.discPromotionDAO.delete", mapParam);
	}
	
    /**
     * 할인권코드를 생성 한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     */
    public String selectDiscNo(Map<String, Object> parameter) throws Exception {
        return (String) super.queryForObject("rc.rcg.discPromotionDAO.selectDiscNo", parameter, null);
    }

	/**
	 * 할인코드 공통코드 생성한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int CreateDiscNo(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.discPromotionDAO.createDiscNo", mapParam);
	}
    
}
