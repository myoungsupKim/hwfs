package com.hwfs.rc.rcg.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 쿠폰종류 등록 관리팝업하는 couponSpeciesPop DAO
 * 
 * @ClassName couponSpeciesPopDAO.java
 * @Description couponSpeciesPopDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.19   	김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.03.19
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/rcg/couponSpeciesPopDAO")
public class CouponSpeciesPopDAO extends DefaultDAO {
	
	/**
	 * 쿠폰종류 등록 관리팝업 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rcg.couponSpeciesPopDAO.selectList", mapParam);
	}

	/**
	 * 쿠폰종류 등록 관리팝업 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectKindCount(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rcg.couponSpeciesPopDAO.selectKindCount", mapParam);
	}

	/**
	 * 쿠폰종류 등록 관리팝업(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponSpeciesPopDAO.insert", mapParam);
	}
	
	/**
	 * 쿠폰종류 등록 관리팝업(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponSpeciesPopDAO.update", mapParam);
	}
	
	/**
	 * 쿠폰종류 등록 관리팝업(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponSpeciesPopDAO.delete", mapParam);
	}
	
	/**
	 * 쿠폰종류 등록 관리팝업 업장 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUpjang(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.rcg.couponSpeciesPopDAO.selectUpjang", mapParam);
	}

	/**
	 * 쿠폰종류 등록 관리팝업(을)를 업장 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertUpjang(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponSpeciesPopDAO.insertUpjang", mapParam);
	}
	
	/**
	 * 쿠폰종류 등록 관리팝업(을)를 업장목록을 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteUpjang(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.rcg.couponSpeciesPopDAO.deleteUpjang", mapParam);
	}

}
