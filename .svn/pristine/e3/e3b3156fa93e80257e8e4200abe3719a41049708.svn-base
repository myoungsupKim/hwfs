package com.hwfs.fs.fso.service;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fso.dao.MarketerActMngtDAO;

 /**
 * 마케터별 실적관리하는 MarketerActMngt Service Implementation
 * 
 * @ClassName MarketerActMngtServiceImpl.java
 * @Description MarketerActMngtServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.14    최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.07.14
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fso/marketerActMngtService")
public class MarketerActMngtServiceImpl extends DefaultServiceImpl implements MarketerActMngtService {
	
	/** MarketerActMngtDAO Bean 생성 */
	@Resource(name = "/fs/fso/marketerActMngtDAO")
	private MarketerActMngtDAO marketerActMngtDAO;
	
	/**
	 * 담당 마케터(급식,식재, 외식)를 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectPrcgEmpCd(Map<String, Object> mapParam) throws Exception {
		return marketerActMngtDAO.selectPrcgEmpCd(mapParam);
	}
	
	/**
	 * 신규수주계획 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectProposalPlanList(Map<String, Object> mapParam) throws Exception {
		return marketerActMngtDAO.selectProposalPlanList(mapParam);
	}

	/**
	 * 마케터별 실적관리 목록(기본운영계획, 수정운영계획)을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public Map<String, RecordSet> selectMarketerActMngtList(Map<String, Object> mapParam) throws Exception {
		
		Map<String, RecordSet> rsMap = new HashMap<String, RecordSet>();
		
		RecordSet rs1 = marketerActMngtDAO.selectProposalPlanList(mapParam);	// 실적목록 조회
		RecordSet rs2 = marketerActMngtDAO.selectMarketerActMngtList(mapParam);	// 실적목록 조회
		RecordSet rs3 = marketerActMngtDAO.selectPlanList(mapParam);			// 계획 리스트 조회
		RecordSet rs4 = marketerActMngtDAO.selectActList(mapParam);	// 실적 리스트 조회
				
		rsMap.put("default", rs1);
		rsMap.put("marketerAct", rs2);
		rsMap.put("plan", rs3);
		rsMap.put("act", rs4);
		
		return rsMap;
	}	
}
