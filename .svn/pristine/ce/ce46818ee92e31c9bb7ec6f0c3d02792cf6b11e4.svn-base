package com.hwfs.fm.fms.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 판매가를 시뮬레이션하는 SalePriceSimu DAO
 * 
 * @ClassName SalePriceSimuDAO.java
 * @Description SalePriceSimuDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.29   	최성연        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.05.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fms/salePriceSimuDAO")
public class SalePriceSimuDAO extends DefaultDAO {
	
	/**
	 * 판매가 시뮬레이션 ID 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSimu(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.salePriceSimuDAO.selectSimu", mapParam);
	}

	/**
	 * 판매가 시뮬레이션 목록을 조회한다.(신규작성용)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.salePriceSimuDAO.selectList", mapParam);
	}
	
	/**
	 * 판매가 시뮬레이션 목록을 조회한다.(기존자료 조회용)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.salePriceSimuDAO.selectList2", mapParam);
	}

	/**
	 * 판매가 시뮬레이션 KEY값을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectID(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fms.salePriceSimuDAO.selectID", mapParam);
	}

	/**
	 * 판매가 시뮬레이션(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceSimuDAO.insert", mapParam);
	}
	
	/**
	 * 판매가 시뮬레이션(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceSimuDAO.update", mapParam);
	}
	
	/**
	 * 판매가 시뮬레이션(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceSimuDAO.delete", mapParam);
	}

	/**
	 * 판매가 시뮬레이션(을)를 전체 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteAll(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceSimuDAO.deleteAll", mapParam);
	}
	
	/**
	 * 시뮬레이션을 확인처리 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int confirm(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fms.salePriceSimuDAO.confirm", mapParam);
	}
	
	
}
