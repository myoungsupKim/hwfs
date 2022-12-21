package com.hwfs.fs.fso.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 손익추정보고서하는 OpProposal DAO
 * 
 * @ClassName OpProposalDAO.java
 * @Description OpProposalDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.24   	최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.07.24
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fso/opProposalDAO")
public class OpProposalDAO extends DefaultDAO {
	
	/**
	 * 손익추정보고서 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectObjectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.opProposalDAO.selectObjectList", mapParam);
	}
	
	/**
	 * 업장 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectAccObjectUpjang(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.opProposalDAO.selectAccObjectUpjang", mapParam);
	}
	
	/**
	 * 손익추정 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPlinvoiceList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.opProposalDAO.selectPlinvoiceList", mapParam);
	}
	
	/**
	 * 해당건 존재여부를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectExistData(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.opProposalDAO.selectExistData", mapParam);
	}
	
	/**
	 * 손익추정보고서(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertPlinvoice(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fso.opProposalDAO.insertPlinvoice", mapParam);
	}
	
	/**
	 * 손익추정보고서(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updatePlinvoice(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fso.opProposalDAO.updatePlinvoice", mapParam);
	}
	
	/**
	 * 손익추정보고서(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deletePlinvoice(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fso.opProposalDAO.deletePlinvoice", mapParam);
	}
	
}
