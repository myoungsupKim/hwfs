package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 판매단가를 일괄수정하는 SalePriceIndexPackModify DAO
 * 
 * @ClassName SalePriceIndexPackModifyDAO.java
 * @Description SalePriceIndexPackModifyDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.21   	최성연        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.04.21
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fms/salePriceIndexPackModifyDAO")
public class SalePriceIndexPackModifyDAO extends DefaultDAO {

	/**
	 * 구매자재 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectItem(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.salePriceIndexPackModifyDAO.selectItem", mapParam);
	}
	
	
	/**
	 * 판매단가 일괄수정 목록을 조회한다. (1번째 탭 리스트 조회)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.salePriceIndexPackModifyDAO.selectList", mapParam);
	}

	/**
	 * 판매단가 일괄수정 업장 목록을 조회한다. (2번째 탭 리스트 조회)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUpjang(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.salePriceIndexPackModifyDAO.selectUpjang", mapParam);
	}
	
	/**
	 * 판매단가 일괄수정 추가된 자재정보를 조회한다. (2/3번째 탭 자재 조회)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectItemCode(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.salePriceIndexPackModifyDAO.selectItemCode", mapParam);
	}
	public RecordSet selectItemCode2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.salePriceIndexPackModifyDAO.selectItemCode2", mapParam);
	}

	/**
	 * 판매단가 일괄수정 추가된 자재정보 이력사항을 조회한다. (2번째 탭)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectHist(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.salePriceIndexPackModifyDAO.selectHist", mapParam);
	}
	
	
	/**
	 * 매입단가 여부를 체크한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 건수
	 * @exception Exception
	 */
	public int selectPoCnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("fm.fms.salePriceIndexPackModifyDAO.selectPoCnt", mapParam);
	}

	
	/**
	 * 판매단가 여부를 체크한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 건수
	 * @exception Exception
	 */
	public int selectSaleCnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForInt("fm.fms.salePriceIndexPackModifyDAO.selectSaleCnt", mapParam);
	}
	
	
	/**
	 * 판매단가를 일괄수정(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceIndexPackModifyDAO.insert", mapParam);
	}

	/**
	 * 자재일괄추가/변경관련 단가정보를 생성한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert2(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceIndexPackModifyDAO.insert2", mapParam);
	}

	/**
	 * 자재일괄추가/변경관련 이력정보를 생성한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertHist(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceIndexPackModifyDAO.insertHist", mapParam);
	}
	
	/**
	 * 판매단가를 일괄수정(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceIndexPackModifyDAO.update", mapParam);
	}

	/**
	 * 자재일괄추가/변경관련 계약종료일을 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update2(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceIndexPackModifyDAO.update2", mapParam);
	}
	
	/**
	 * 자재일괄추가/변경관련 계약종료일을 수정한다. : 이전 계약번호에 대한 모든 자재에 대한 종료일자  SET
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateDate3(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceIndexPackModifyDAO.updateDate3", mapParam);
	}
	
	
	
	/**
	 * 판매단가를 일괄수정(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteItem(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceIndexPackModifyDAO.deleteItem", mapParam);
	}

	/**
	 * 자재일괄추가/변경관련 기존자료를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete2(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceIndexPackModifyDAO.delete2", mapParam);
	}
	
	
}
