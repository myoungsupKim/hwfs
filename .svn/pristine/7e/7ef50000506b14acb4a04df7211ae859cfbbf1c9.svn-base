package com.hwfs.fs.fse.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fse.dao.EventMasterListDAO;

 /**
 * 이벤트관리 현황조회하는 EventMasterList Service Implementation
 * 
 * @ClassName EventMasterListServiceImpl.java
 * @Description EventMasterListServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2020.20.22    JHKIM        최초생성
 * </pre>
 * @author  
 * @since 2020.20.22
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fse/eventMasterListService")
public class EventMasterListServiceImpl extends DefaultServiceImpl implements EventMasterListService {

	/** EventMasterListDAO Bean 생성 */
	@Resource(name = "/fs/fse/eventMasterListDAO")
	private EventMasterListDAO eventMasterListDAO;
	

	/**
	 * 이벤트관리 현황조회 목록을 조회한다.
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
	public RecordSet selectList01(Map<String, Object> mapParam) throws Exception {
		return eventMasterListDAO.selectList01(mapParam);
	}
	
	/**
	 * 이벤트관리 현황조회  목록을 조회한다.
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
	public RecordSet selectList02(Map<String, Object> mapParam) throws Exception {
		return eventMasterListDAO.selectList02(mapParam);
	}
	
	/**
	 * 이벤트관리 현황조회  목록을 조회한다.
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
	public RecordSet selectList03(Map<String, Object> mapParam) throws Exception {
		return eventMasterListDAO.selectList03(mapParam);
	}


}
