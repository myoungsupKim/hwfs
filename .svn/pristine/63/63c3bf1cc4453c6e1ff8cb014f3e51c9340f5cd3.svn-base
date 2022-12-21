package com.hwfs.rc.roa.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.roa.dao.OverTimeClosingDAO;

 /**
 * 특근 마감 작업하는 OverTimeClosing Service Implementation
 * 
 * @ClassName OverTimeClosingServiceImpl.java
 * @Description OverTimeClosingServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.01    손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.07.01
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/roa/overTimeClosingService")
public class OverTimeClosingServiceImpl extends DefaultServiceImpl implements OverTimeClosingService {
	
	/** OverTimeClosingDAO Bean 생성 */
	@Resource(name = "/rc/roa/overTimeClosingDAO")
	private OverTimeClosingDAO overTimeClosingDAO;
	

	/**
	 * 특근 마감 작업 목록을 조회한다.
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
		return overTimeClosingDAO.selectList(mapParam);
	}

	/**
	 * 특근 마감 작업 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	public int saveList(Map<String, Object> mapParam) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		//마감처리
		if("I".equals(mapParam.get("gubun").toString())){
			insRowCnt += overTimeClosingDAO.insert(mapParam);
			
			if(insRowCnt > 0){
				overTimeClosingDAO.insertOverTimeInfoSum(mapParam);	//RSS_OVER_TIME_INFO
				overTimeClosingDAO.logInfo(mapParam);
			}

		//마감취소
		}else{
			updRowCnt += overTimeClosingDAO.delete(mapParam);
			
			if(updRowCnt > 0){
				overTimeClosingDAO.cancelOverTimeInfoSum(mapParam);	//RSS_OVER_TIME_INFO
				overTimeClosingDAO.cancelLogInfo(mapParam);
			}
		}
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
