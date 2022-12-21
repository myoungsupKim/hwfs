package com.hwfs.fs.fso.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 신규운영품의 대비 실적관리하는 NewOpProposalActMngt DAO
 * 
 * @ClassName NewOpProposalActMngtDAO.java
 * @Description NewOpProposalActMngtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.15   	최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.07.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fso/newOpProposalActMngtDAO")
public class NewOpProposalActMngtDAO extends DefaultDAO {
	
	/**
	 * 신규운영품의 대비 실적관리 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectNewOpProposalActMngtList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.newOpProposalActMngtDAO.selectNewOpProposalActMngtList", mapParam);
	}
	
	/**
	 * 업장별 실적을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectAccOrderPlan(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.newOpProposalActMngtDAO.selectAccOrderPlan", mapParam);
	}
	
	/**
	 * 월별실적(실적) 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPlinvoiceList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.newOpProposalActMngtDAO.selectPlinvoiceList", mapParam);
	}
	
	/**
	 * 월별실적(품의) 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPlinvoiceList2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.newOpProposalActMngtDAO.selectPlinvoiceList2", mapParam);
	}

	/**
	 * 신규운영품의 대비 실적관리(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertUpjangAct(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fso.newOpProposalActMngtDAO.insertUpjangAct", mapParam);
	}
	
	/**
	 * 신규운영품의 대비 실적관리(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateUpjangAct(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fso.newOpProposalActMngtDAO.updateUpjangAct", mapParam);
	}
	
	/**
	 * 신규운영품의 대비 실적관리(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteUpjangAct(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fso.newOpProposalActMngtDAO.deleteUpjangAct", mapParam);
	}
	
}
