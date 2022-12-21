package com.hwfs.rc.rcm.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rcm.dao.NonCloseMgntDAO;

 /**
 * NonCloseMgntServiceImpl에 대한 설명 작성
 * @ClassName NonCloseMgntServiceImpl.java
 * @Description NonCloseMgntServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016. 4. 01.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2016. 4. 01.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rcm/nonCloseMgntService")
public class NonCloseMgntServiceImpl extends DefaultServiceImpl implements NonCloseMgntService
{
	/** CloseStatusDAO Bean 생성 */
	@Resource(name = "/rc/rcm/nonCloseMgntDAO")
	private NonCloseMgntDAO nonCloseMgntDAO;

	/**
	 * 미마감현황 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return nonCloseMgntDAO.selectList(mapParam);
	}
}
