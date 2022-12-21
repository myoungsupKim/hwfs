package com.hwfs.fs.fsa.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 채용인력요청 관리하는 AdoptionReqList DAO
 * 
 * @ClassName AdoptionReqListDAO.java
 * @Description AdoptionReqListDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.02   	김예진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.04.02
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fsa/adoptionReqListDAO")
public class AdoptionReqListDAO extends DefaultDAO {
	
	/**
	 * 채용인력요청 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet searchUpjangAddr(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsa.adoptionReqListDAO.searchUpjangAddr", mapParam);
	}
	public RecordSet selectReqList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsa.adoptionReqListDAO.selectReqList", mapParam);
	}
	public RecordSet selectUpjangPoolList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fsa.adoptionReqListDAO.selectUpjangPoolList", mapParam);
	}

	/**
	 * 채용인력요청(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertReq(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsa.adoptionReqListDAO.insertReq", mapParam);
	}
	
	/**
	 * 채용인력요청(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateReq(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsa.adoptionReqListDAO.updateReq", mapParam);
	}
	public int updateAssign(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsa.adoptionReqListDAO.updateAssign", mapParam);
	}

	/**
	 * 자체마감 처리한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateEnd(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsa.adoptionReqListDAO.updateEnd", mapParam);
	}
	
	
	/**
	 * 채용인력요청(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteReq(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fsa.adoptionReqListDAO.deleteReq", mapParam);
	}
	
}
