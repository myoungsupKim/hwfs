package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 이익율을 설정하는 GainRateSetMngt DAO
 * 
 * @ClassName GainRateSetMngtDAO.java
 * @Description GainRateSetMngtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.10   	최성연        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.03.10
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fms/gainRateSetMngtDAO")
public class GainRateSetMngtDAO extends DefaultDAO {

	/**
	 * 팀 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectTm(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.gainRateSetMngtDAO.selectTm", mapParam);
	}
	
	/**
	 *단가계약업장 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectStd(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.gainRateSetMngtDAO.selectStd", mapParam);
	
	}
	
	/**
	 * 판매그룹 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.gainRateSetMngtDAO.selectList", mapParam);
	}
	
	
	/**
	 * 분류별 이익율관리 건수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 건수
	 * @exception Exception
	 */
	public int selectClassCnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("fm.fms.gainRateSetMngtDAO.selectClassCnt", mapParam);
	}
	
	
	
	/**
	 * 판매그룹(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.gainRateSetMngtDAO.insert", mapParam);
	}
	
	/**
	 * 판매그룹(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.gainRateSetMngtDAO.update", mapParam);
	}
	
	/**
	 * 판매그룹을(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.gainRateSetMngtDAO.delete", mapParam);
	}
	

	/**
	 * 자재 대분류별 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectClassCode(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.gainRateSetMngtDAO.selectClassCode", mapParam);
	}
	
	
	/**
	 * 분류별 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectClass(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.gainRateSetMngtDAO.selectClass", mapParam);
	}
	

	/**
	 * 업장 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUpjang(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.gainRateSetMngtDAO.selectUpjang", mapParam);
	}
	
	
	/**
	 * 자재별 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectItem(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.gainRateSetMngtDAO.selectItem", mapParam);
	}
	
	
	/**
	 * 자재별 목록을 조회한다.테마자재
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectTheme(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.gainRateSetMngtDAO.selectTheme", mapParam);
	}

	/**
	 * 자재별 이익율 현황을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectGainList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.gainRateSetMngtDAO.selectGainList", mapParam);
	}
	public RecordSet selectGainList2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.gainRateSetMngtDAO.selectGainList2", mapParam);
	}
	
	
	/**
	 * 추가할 자재를 검색한다.
	 * <pre>
	 * 팝업화면(GainRateItemSearchPop)
	 * </pre>
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectItemPop(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.gainRateSetMngtDAO.selectItemPop", mapParam);
	}

	
	
	/**
	 * 분류목록을 삭제한다.(소분류코드 기준)
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteClass(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.gainRateSetMngtDAO.deleteClass", mapParam);
	}

	/**
	 * 분류목록(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertClass(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.gainRateSetMngtDAO.insertClass", mapParam);
	}

	
	/**
	 * 자재별 이익율관리 건수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 건수
	 * @exception Exception
	 */
	public int selectItemCnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("fm.fms.gainRateSetMngtDAO.selectItemCnt", mapParam);
	}
	
	
	/**
	 * 이익율 목록 전체 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteAll(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.gainRateSetMngtDAO.deleteAll", mapParam);
	}

	
	
	/**
	 * 자재목록을 일괄 삭제한다.
	 * (분류정보 삭제 시 일괄로 삭제하기 위한 용도)
	 * @param mapParam
	 * @return
	 */
	public int deleteItemAll(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.gainRateSetMngtDAO.deleteItemAll", mapParam);
	}
	

	/**
	 * 자재별목록을 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteItem(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.gainRateSetMngtDAO.deleteItem", mapParam);
	}

	
	/**
	 * 자재별목록(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertItem(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.gainRateSetMngtDAO.insertItem", mapParam);
	}
	


	/**
	 * 자재별목록(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateItem(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.gainRateSetMngtDAO.updateItem", mapParam);
	}
	
	/**
	 * 자재별목록(을)를 [복사]한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int classCopy(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.gainRateSetMngtDAO.classCopy", mapParam);
	}

	
	
	/**
	 * 테마자재목록을 일괄 삭제한다.
	 * (분류정보 삭제 시 일괄로 삭제하기 위한 용도)
	 * @param mapParam
	 * @return
	 */
	public int deleteThemeAll(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.gainRateSetMngtDAO.deleteThemeAll", mapParam);
	}
	

	/**
	 * 자재별목록을 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteTheme(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.gainRateSetMngtDAO.deleteTheme", mapParam);
	}

	
	/**
	 * 자재별목록(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertTheme(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.gainRateSetMngtDAO.insertTheme", mapParam);
	}
	


	/**
	 * 자재별목록(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateTheme(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.gainRateSetMngtDAO.updateTheme", mapParam);
	}
	
}
