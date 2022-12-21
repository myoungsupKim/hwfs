package com.hwfs.sc.scp.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.scp.dao.PersAccessLogDAO;

 /**
 * 개인정보 접근로그를 조회하는 PersAccessLog Service Implementation
 * 
 * @ClassName PersAccessLogServiceImpl.java
 * @Description PersAccessLogServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.15    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.05.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scp/persAccessLogService")
public class PersAccessLogServiceImpl extends DefaultServiceImpl implements PersAccessLogService {
	
	/** PersAccessLogDAO Bean 생성 */
	@Resource(name = "/sc/scp/persAccessLogDAO")
	private PersAccessLogDAO persAccessLogDAO;
	

	/**
	 * 개인정보 접근로그 목록을 페이지 단위로 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectListPerPage(Map<String, Object> mapParam) throws Exception {
		return persAccessLogDAO.selectListPerPage(mapParam);
	}

	/**
	 * 개인정보 접근로그 목록 대상 전체 건수를 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	public int selectTotalCnt(Map<String, Object> mapParam) throws Exception {
		return persAccessLogDAO.selectTotalCnt(mapParam);
	}

	/**
	 * 개인정보 열람승인을 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	public int saveApproveList(DataSetMap list) throws Exception {
		return persAccessLogDAO.updateApproveList (list.getRowMaps());
	}

	/**
	 * 개인정보 열람승인취소를 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	public int saveApproveCancelList(DataSetMap list) throws Exception {
		return persAccessLogDAO.updateApproveCancelList (list.getRowMaps());
	}

}
