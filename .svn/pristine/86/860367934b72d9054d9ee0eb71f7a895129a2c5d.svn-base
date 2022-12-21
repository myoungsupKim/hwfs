package com.hwfs.fs.fso.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 입찰을 관리하는 BidMgnt DAO
 * 
 * @ClassName BidMgntDAO.java
 * @Description BidMgntDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.29   	김예진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.04.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fso/bidMgntDAO")
public class BidMgntDAO extends DefaultDAO {
	
	/**
	 * 입찰관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMuNm(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.bidMgntDAO.selectMuNm", mapParam);
	}
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.bidMgntDAO.selectList", mapParam);
	}

	/**
	 * 입찰관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fso.bidMgntDAO.insertBid", mapParam);
	}
	
	/**
	 * 입찰관리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fso.bidMgntDAO.updateBid", mapParam);
	}
	
	/**
	 * 입찰관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fso.bidMgntDAO.deleteBid", mapParam);
	}
	
}
