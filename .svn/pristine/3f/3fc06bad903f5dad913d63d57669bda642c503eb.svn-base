package com.hwfs.rc.roa.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.roa.dao.OverTimeInputDAO;
import com.hwfs.rc.roa.dao.OverTimeMgntDAO;

 /**
 * 특근 사용 등록하는 OverTimeMgnt Service Implementation
 * 
 * @ClassName OverTimeMgntServiceImpl.java
 * @Description OverTimeMgntServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.30    손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.06.30
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/roa/overTimeMgntService")
public class OverTimeMgntServiceImpl extends DefaultServiceImpl implements OverTimeMgntService {
	
	/** OverTimeMgntDAO Bean 생성 */
	@Resource(name = "/rc/roa/overTimeMgntDAO")
	private OverTimeMgntDAO overTimeMgntDAO;
	
	/** OverTimeInputDAO Bean 생성 */
	@Resource(name = "/rc/roa/overTimeInputDAO")
	private OverTimeInputDAO overTimeInputDAO;
	
	/**
	 * 특근 사용 등록 목록을 조회한다.
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
		return overTimeMgntDAO.selectList(mapParam);
	}

	/**
	 * 특근 사용 등록 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
		int updRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			/** 데이터 저장 **/
			updRowCnt += overTimeMgntDAO.update(rowData);
			
			if ("Y".equals(rowData.get("logYn").toString())) {
				updRowCnt += overTimeInputDAO.logInfo(rowData);
			}
			
			/** 마지막 행 이월 데이터 생성**/
			//if( i == (list.size()-1)){
			//	updRowCnt += overTimeMgntDAO.lastUpdate(rowData);
			//}
		}
				
		return updRowCnt;
	}
}
