package com.hwfs.rc.bms.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.bms.dao.FncDiaryListTimeDAO;

 /**
 * FncDiaryListTimeServiceImpl에 대한 설명 작성
 * @ClassName FncDiaryListTimeServiceImpl.java
 * @Description FncDiaryListTimeServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 7. 28.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 연회웨딩
 * @since 2015. 7. 28.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/bms/fncDiaryListTimeService")
public class FncDiaryListTimeServiceImpl extends DefaultServiceImpl implements FncDiaryListTimeService {
	@Resource(name="/rc/bms/fncDiaryListTimeDAO")
	private FncDiaryListTimeDAO fncDiaryListTime;
	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.bms.service.FncDiaryListTimeService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return fncDiaryListTime.selectList(parameter);
	}

	/**
	 * selectDtList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.bms.service.FncDiaryListTimeService#selectDtList(java.util.Map)
	 */
	@Override
	public RecordSet selectDtList(Map<String, Object> parameter) throws Exception {
		return fncDiaryListTime.selectDtList(parameter);
	}

}
