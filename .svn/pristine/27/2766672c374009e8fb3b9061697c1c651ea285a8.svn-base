package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 견적서를 작성하는 EstPaperWrite DAO
 * 
 * @ClassName EstPaperWriteDAO.java
 * @Description EstPaperWriteDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.28   	최성연        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.04.28
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fms/estPaperWriteDAO")
public class EstPaperWriteDAO extends DefaultDAO {
	
	/**
	 * 식재영업 담당자를 검색한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSabun(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.estPaperWriteDAO.selectSabun", mapParam);
	}

	/**
	 * 자재분류 정보를 검색한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectClass(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.estPaperWriteDAO.selectClass", mapParam);
	}
	
	/**
	 * 견적번호 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectEsti(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.estPaperWriteDAO.selectEsti", mapParam);
	}
	
	/**
	 * 견적서 목록을 조회한다.(신규작성용)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.estPaperWriteDAO.selectList", mapParam);
	}

	/**
	 * 견적서 목록을 조회한다.(기존자료용)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.estPaperWriteDAO.selectList2", mapParam);
	}
	
	/**
	 * 견적서 KEY를 GET
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectID(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.estPaperWriteDAO.selectID", mapParam);
	}

	/**
	 * 유사시뮬레이션 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSimu(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.estPaperWriteDAO.selectSimu", mapParam);
	}

	/**
	 * 유사시뮬레이션 수량을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSimQty(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.estPaperWriteDAO.selectSimQty", mapParam);
	}

	/**
	 * 평균시뮬레이션 수량을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectAvgQty(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.estPaperWriteDAO.selectAvgQty", mapParam);
	}
	
	
	/**
	 * 견적서 작성(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.estPaperWriteDAO.insert", mapParam);
	}
	public int insert2(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.estPaperWriteDAO.insert2", mapParam);
	}
	
	/**
	 * 견적서 작성(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.estPaperWriteDAO.update", mapParam);
	}
	
	/**
	 * 견적서 작성(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.estPaperWriteDAO.delete", mapParam);
	}

	/**
	 * 견적서(을)를 일괄 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteAll(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.estPaperWriteDAO.deleteAll", mapParam);
	}

	/**
	 * 선택한 자재를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteItem(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.estPaperWriteDAO.deleteItem", mapParam);
	}
	
	/**
	 * 견적서 자재를 확인처리 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int confirm(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.estPaperWriteDAO.confirm", mapParam);
	}

	/**
	 * 견적서 정보를 일괄 UPDATE
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateAll(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.estPaperWriteDAO.updateAll", mapParam);
	}
	
	
}
