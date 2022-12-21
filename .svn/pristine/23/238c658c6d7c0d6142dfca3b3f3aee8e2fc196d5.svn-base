package com.hwfs.sc.scp.dao;

import hone.core.util.record.RecordSet;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 개인정보 접근로그를 조회하는 PersAccessLog DAO
 * 
 * @ClassName PersAccessLogDAO.java
 * @Description PersAccessLogDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.15   	kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.05.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/scp/persAccessLogDAO")
public class PersAccessLogDAO extends DefaultDAO {
	
	/**
	 * 개인정보 접근로그 목록을 페이지 단위로 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectListPerPage(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.scp.persAccessLogDAO.selectListPerPage", mapParam);
	}

	/**
	 * 개인정보 접근로그 목록 대상 전체 건수를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int selectTotalCnt(Map<String, Object> mapParam) throws Exception {
		return queryForInt("sc.scp.persAccessLogDAO.selectTotalCnt", mapParam);
	}

	/**
	 * 개인정보 열람승인을 처리한다.
	 *
	 * @param list
	 * @return
	 */
	public int updateApproveList(List<Map> list) throws Exception {
		return batchUpdate2("sc.scp.persAccessLogDAO.updateApprove", list);
	}

	/**
	 * 개인정보 열람승인취소를 처리한다.
	 *
	 * @param list
	 * @return
	 */
	public int updateApproveCancelList(List<Map> list) throws Exception {
		return batchUpdate2("sc.scp.persAccessLogDAO.updateApproveCancel", list);
	}

}
