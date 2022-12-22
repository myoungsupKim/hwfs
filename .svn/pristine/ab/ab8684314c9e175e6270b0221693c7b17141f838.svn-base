package com.hwfs.rc.roa.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.roa.dao.OverTimeCalendarDAO;

 /**
 * 특근 캘린더 관리하는 OverTimeCalendar Service Implementation
 * 
 * @ClassName OverTimeCalendarServiceImpl.java
 * @Description OverTimeCalendarServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.29    손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 홍길동
 * @since 2015.06.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/roa/overTimeCalendarService")
public class OverTimeCalendarServiceImpl extends DefaultServiceImpl implements OverTimeCalendarService {
	
	/** OverTimeCalendarDAO Bean 생성 */
	@Resource(name = "/rc/roa/overTimeCalendarDAO")
	private OverTimeCalendarDAO overTimeCalendarDAO;
	

	/**
	 * 특근 캘린더 관리 목록을 조회한다.
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
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return overTimeCalendarDAO.selectList(mapParam);
	}

	/**
	 * 특근 캘린더 관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			insRowCnt += overTimeCalendarDAO.insert(rowData);
			
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
