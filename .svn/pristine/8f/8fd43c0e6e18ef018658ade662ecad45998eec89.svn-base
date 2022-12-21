package com.hwfs.fs.fso.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 마케터별 실적관리하는 MarketerActMngt DAO
 * 
 * @ClassName MarketerActMngtDAO.java
 * @Description MarketerActMngtDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.14   	최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.07.14
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fs/fso/marketerActMngtDAO")
public class MarketerActMngtDAO extends DefaultDAO {
	
	/**
	 * 담당 마케터(급식,식재, 외식)를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPrcgEmpCd(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.marketerActMngtDAO.selectPrcgEmpCd", mapParam);
	}
	
	/**
	 * 신규수주계획 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectProposalPlanList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.marketerActMngtDAO.selectProposalPlanList", mapParam);
	}
	
	/**
	 * 마케터별 실적관리 목록(기본운영계획, 수정운영계획)을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMarketerActMngtList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.marketerActMngtDAO.selectMarketerActMngtList", mapParam);
	}
	
	/**
	 * 계획 리스트를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPlanList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.marketerActMngtDAO.selectPlanList", mapParam);
	}
	
	/**
	 * 실적 리스트를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectActList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fs.fso.marketerActMngtDAO.selectActList", mapParam);
	}
}
