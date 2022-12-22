package com.hwfs.fs.fso.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 수주 및 운영품의하는 AccOrderPropRept DAO
 * 
 * @ClassName AccOrderPropReptDAO.java
 * @Description AccOrderPropReptDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.01   	최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.06.01
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fso/accOrderPropReptDAO")
public class AccOrderPropReptDAO extends DefaultDAO {
	
	/**
	 * 물건목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectObjectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.accOrderPropReptDAO.selectObjectList", mapParam);
	}
	
	/**
	 * 수주 및 운영품의 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectAccOrderOpProposal(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.accOrderPropReptDAO.selectAccOrderOpProposal", mapParam);
	}
	
	/**
	 * 수주(운영) 손익추정보고서 등록여부를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectOpProposalChk(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.accOrderPropReptDAO.selectOpProposalChk", mapParam);
	}

	/**
	 * 수주 및 운영품의(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertAccOrderOpProposal(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fso.accOrderPropReptDAO.insertAccOrderOpProposal", mapParam);
	}
	
	/**
	 * 수주 및 운영품의(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateAccOrderOpProposal(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fso.accOrderPropReptDAO.updateAccOrderOpProposal", mapParam);
	}
	
	/**
	 * 수주 및 운영품의(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteAccOrderOpProposal(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fso.accOrderPropReptDAO.deleteAccOrderOpProposal", mapParam);
	}
	
	/**
	 * 전자결재정보를 Update한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateSign(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fso.accOrderPropReptDAO.updateSign", mapParam);
	}
	
}
