package com.hwfs.ma.mag.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 사업장 일마감 하는하는 UpjangDayClose DAO
 * 
 * @ClassName UpjangDayCloseDAO.java
 * @Description UpjangDayCloseDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.10.12   	박준석        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 박준석
 * @since 2015.10.12
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ma/mag/upjangDayCloseDAO")
public class UpjangDayCloseDAO extends DefaultDAO {
	
	/**
	 * 사업장 일마감 하는 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectBeforeMagam(Map<String, Object> mapParam) throws Exception {
		if(mapParam.get("closeGubun").equals("007")){
			return super.queryForRecordSet("ma.mag.upjangDayCloseDAO.selectBeforeMagamAll", mapParam);
		}else{
			return super.queryForRecordSet("ma.mag.upjangDayCloseDAO.selectBeforeMagam", mapParam);
		}
	}
	
	/**
	 * 일마감 입금, 지불 차이 조회.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCloseInfo(Map<String, Object> mapParam) throws Exception {
			return super.queryForRecordSet("ma.mag.upjangDayCloseDAO.selectCloseInfo", mapParam);
	}
	
	/**
	 * 일마감 입금, 지불 차이 조회.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCloseInfoOut(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ma.mag.upjangDayCloseDAO.selectCloseInfoOut", mapParam);
	}

	/**
	 * 사업장 일마감 하는(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("ma.mag.upjangDayCloseDAO.insert", mapParam);
	}
	
	/**
	 * 사업장 일마감 하는(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("ma.mag.upjangDayCloseDAO.update", mapParam);
	}
	
	/**
	 * 사업장 일마감 하는(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("ma.mag.upjangDayCloseDAO.delete", mapParam);
	}
	
}
