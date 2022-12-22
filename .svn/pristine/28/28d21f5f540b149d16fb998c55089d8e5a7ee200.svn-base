package com.hwfs.fs.fsf.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 장례식 상세 판매 및 구매내역 조회하는 FuneralDetailPoSaleList DAO
 * 
 * @ClassName FuneralDetailPoSaleListDAO.java
 * @Description FuneralDetailPoSaleListDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.10.01   	박준석        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 박준석
 * @since 2015.10.01
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsf/funeralDetailPoSaleListDAO")
public class FuneralDetailPoSaleListDAO extends DefaultDAO {
	
	/**
	 * 장례식 상세 판매 및 구매내역 조회 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsf.funeralDetailPoSaleListDAO.selectList", mapParam);
	}

	/**
	 * 장례식 상세 판매 및 구매내역 조회(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralDetailPoSaleListDAO.insert", mapParam);
	}
	
	/**
	 * 장례식 상세 판매 및 구매내역 조회(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralDetailPoSaleListDAO.update", mapParam);
	}
	
	/**
	 * 장례식 상세 판매 및 구매내역 조회(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsf.funeralDetailPoSaleListDAO.delete", mapParam);
	}
	
}
