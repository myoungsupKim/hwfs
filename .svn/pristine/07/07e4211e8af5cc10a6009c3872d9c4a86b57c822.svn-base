package com.hwfs.rc.sle.dao;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;
import com.hwfs.sc.cmn.defaults.DefaultResortfoDAO;

 /**
 * B&B 매출조회하는 BnbSale DAO
 * 
 * @ClassName BnbSaleDAO.java
 * @Description BnbSaleDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.09.15   	ydpark        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 ydpark
 * @since 2015.09.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/sle/bnbSaleDAO")
public class BnbSaleDAO extends DefaultResortfoDAO {
	
	/**
	 * 조회 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("rc.sle.bnbSaleDAO.selectList", mapParam);
	}

	/**
	 * 조회(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.sle.bnbSaleDAO.insert", mapParam);
	}
	
	/**
	 * 조회(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.sle.bnbSaleDAO.update", mapParam);
	}
	
	/**
	 * 조회(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("rc.sle.bnbSaleDAO.delete", mapParam);
	}
	
}
