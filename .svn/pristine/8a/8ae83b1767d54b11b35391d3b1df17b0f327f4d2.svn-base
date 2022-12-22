package com.hwfs.fs.fsf.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 고인등록하는 FuneralPatronMstReg DAO
 * 
 * @ClassName FuneralPatronMstRegDAO.java
 * @Description FuneralPatronMstRegDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.02   	백정훈        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 백정훈
 * @since 2015.04.02
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsf/funeralPatronMstRegDAO")
public class FuneralPatronMstRegDAO extends DefaultDAO {
	
	/**
	 * 고인Master 등록관리 화면 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralPatronMstRegDAO.selectList", mapParam);
	}
	
	/**
	 * 동일일자, 동일빈소 여부를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectIsDuplicate(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralPatronMstRegDAO.selectIsDuplicate", mapParam);
	}

	/**
	 * 고인Master 등록관리 화면(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralPatronMstRegDAO.insert", mapParam);
	}
	
	/**
	 * 고인Master 등록관리 화면(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralPatronMstRegDAO.update", mapParam);
	}
	
	/**
	 * 고인Master 등록관리 화면(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralPatronMstRegDAO.delete", mapParam);
	}
	
	/**
	 * 고인 가족관리 화면 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDtlList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralPatronMstRegDAO.selectDtlList", mapParam);
	}

	/**
	 * 고인 가족관리 화면(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertDtl(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralPatronMstRegDAO.insertDtl", mapParam);
	}
	
	/**
	 * 고인 가족관리 화면(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateDtl(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralPatronMstRegDAO.updateDtl", mapParam);
	}
	
	/**
	 * 고인 가족관리 화면(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteDtl(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralPatronMstRegDAO.deleteDtl", mapParam);
	}
	
	/**
	 * 고인Master 고객번호 Max순번+1.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMaxNum(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralPatronMstRegDAO.selectMaxNum", mapParam);
	}
	
	/**
	 * 고인 가족관리 장례식장,고객번호 Max순번+1
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMaxDtlNum(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralPatronMstRegDAO.selectMaxDtlNum", mapParam);
	}
	
	/**
	 * 고인및 상주상세정보 화면 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectGuestDtlList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralPatronMstRegDAO.selectGuestDtlList", mapParam);
	}
}
