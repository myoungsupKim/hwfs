package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 특약율을 설정하는 SpContFact DAO
 * 
 * @ClassName SpContFactDAO.java
 * @Description SpContFactDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.16   	최성연        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.03.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fms/spContFactDAO")
public class SpContFactDAO extends DefaultDAO {
	
	/**
	 * 업장별 창고리스트 목록을 조회한다.
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSubinv(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.spContFactDAO.selectSubinv", mapParam);
	}

	/**
	 * 품목별 특약율을 설정 목록을 조회한다.
	 * (중분류, 소분류, 품목별로 조회한다)
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectClass(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.spContFactDAO.selectClass", mapParam);
	}
	public RecordSet selectItem(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.spContFactDAO.selectItem", mapParam);
	}
	public RecordSet selectItem2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.spContFactDAO.selectItem2", mapParam);
	}

	/**
	 * 품목별 특약율 관련 기준일자 목록을 조회한다.
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDateList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.spContFactDAO.selectDateList", mapParam);
	}

	/**
	 * 선택한 본사에 대한 창고리스트 목록을 조회한다.
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSub(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.spContFactDAO.selectSub", mapParam);
	}

	
	/**
	 * 품목별 특약율을 설정(을)를 삭제한다. (중분류, 소분류)
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteGroup(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.spContFactDAO.deleteGroup", mapParam);
	}

	
	/**
	 * 품목별 특약율을 설정(을)를 등록한다. (중분류, 소분류)
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertGroup(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.spContFactDAO.insertGroup", mapParam);
	}

	/**
	 * 특약율의 종료일자를 UPDATE한다. (중분류, 소분류)
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateGroup(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.spContFactDAO.updateGroup", mapParam);
	}
	public int updateGroup2(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.spContFactDAO.updateGroup2", mapParam);
	}
	
	/**
	 * 품목별 특약율을 설정(을)를 삭제한다. (자재별)
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteItem(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.spContFactDAO.deleteItem", mapParam);
	}
	public int deleteItem2(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.spContFactDAO.deleteItem2", mapParam);
	}

	
	/**
	 * 품목별 특약율을 설정(을)를 등록한다. (자재별)
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertItem(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.spContFactDAO.insertItem", mapParam);
	}
	
	
	/**
	 * 특약율의 종료일자를 UPDATE한다. (자재별)
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateItem(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.spContFactDAO.updateItem", mapParam);
	}
	public int updateItem2(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.spContFactDAO.updateItem2", mapParam);
	}
	
	
	/**
	 * 품목별 특약율을 설정(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.spContFactDAO.update", mapParam);
	}

	
	/**
	 * 일괄복사를 위한 특약율정보 건수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 건수
	 * @exception Exception
	 */
	public int selectSubCnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("fm.fms.spContFactDAO.selectSubCnt", mapParam);
	}

	
	/**
	 * 일괄복사 시 이전자료를 먼저 삭제한다. 
	 * (특약사항 정보 - 분류별) 
	 * @param mapParam
	 * @return
	 */
	public int deleteSub(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.spContFactDAO.deleteSub", mapParam);
	}
	

	/**
	 * 일괄복사 시 특약율정보를 INSERT한다.
	 * (특약사항 정보 - 분류별) 
	 * @param mapParam
	 * @return
	 */
	public int insertSub(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.spContFactDAO.insertSub", mapParam);
	}
	

	/**
	 * 일괄복사 시 특약율정보에 대한 종료일자 SET
	 * (특약사항 정보 - 분류별) 
	 * @param mapParam
	 * @return
	 */
	public int updateSub(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.spContFactDAO.updateSub", mapParam);
	}

	
	
	
	/**
	 * 일괄복사 시 이전자료를 먼저 삭제한다. 
	 * (특약사항 정보 - 자재별) 
	 * @param mapParam
	 * @return
	 */
	public int deleteSubItem(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.spContFactDAO.deleteSubItem", mapParam);
	}
	

	/**
	 * 일괄복사 시 특약율정보를 INSERT한다.
	 * (특약사항 정보 - 자재별) 
	 * @param mapParam
	 * @return
	 */
	public int insertSubItem(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.spContFactDAO.insertSubItem", mapParam);
	}
	
	/**
	 * 일괄복사 시 특약율정보에 대한 종료일자 SET
	 * (특약사항 정보 - 자재별) 
	 * @param mapParam
	 * @return
	 */
	public int updateSubItem(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.spContFactDAO.updateSubItem", mapParam);
	}
	
}
