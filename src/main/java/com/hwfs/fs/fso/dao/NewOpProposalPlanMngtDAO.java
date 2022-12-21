package com.hwfs.fs.fso.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 신규수주계획하는 NewOpProposalPlanMngt DAO
 * 
 * @ClassName NewOpProposalPlanMngtDAO.java
 * @Description NewOpProposalPlanMngtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.03   	최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.07.03
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fso/newOpProposalPlanMngtDAO")
public class NewOpProposalPlanMngtDAO extends DefaultDAO {
	
	/**
	 * 담당 마케터(급식,식재, 외식) 코드를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMarketer(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.newOpProposalPlanMngtDAO.selectMarketer", mapParam);
	}
	
	/**
	 * 신규수주계획 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectProposalPlanList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.newOpProposalPlanMngtDAO.selectProposalPlanList", mapParam);
	}
	
	/**
	 * 수주계획 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectOrderPlanList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.newOpProposalPlanMngtDAO.selectOrderPlanList", mapParam);
	}
	
	/**
	 * 배부반영 계획을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectAccOrderDivplanList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.newOpProposalPlanMngtDAO.selectAccOrderDivplanList", mapParam);
	}
	
	/**
	 * 물건카드 팝업을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectObjectCardPopup(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.newOpProposalPlanMngtDAO.selectObjectCardPopup", mapParam);
	}

	/**
	 * 수주계획(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertAccOrderPlanList(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fso.newOpProposalPlanMngtDAO.insertAccOrderPlanList", mapParam);
	}
	
	/**
	 * 수주계획(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateAccOrderPlanList(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fso.newOpProposalPlanMngtDAO.updateAccOrderPlanList", mapParam);
	}
	
	/**
	 * 수주계획(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteAccOrderPlanList(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fso.newOpProposalPlanMngtDAO.deleteAccOrderPlanList", mapParam);
	}
	
	/**
	 * 배부반영 계획(을)를 등록한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertAccOrderDivplanList(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fso.newOpProposalPlanMngtDAO.insertAccOrderDivplanList", mapParam);
	}
	
	/**
	 * 배부반영 계획(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateAccOrderDivplanList(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fso.newOpProposalPlanMngtDAO.updateAccOrderDivplanList", mapParam);
	}
	
	/**
	 * 배부반영 계획(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteAccOrderDivplanList(Map<String, Object> mapParam) throws Exception {
		return super.update("fs.fso.newOpProposalPlanMngtDAO.deleteAccOrderDivplanList", mapParam);
	}
}
