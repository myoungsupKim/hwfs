package com.hwfs.rc.roa.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.roa.dao.OverTimeInputDAO;

 /**
 * 특근 근태 발생 등록하는 OverTimeInput Service Implementation
 * 
 * @ClassName OverTimeInputServiceImpl.java
 * @Description OverTimeInputServiceImpl Class
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
@Service("/rc/roa/overTimeInputService")
public class OverTimeInputServiceImpl extends DefaultServiceImpl implements OverTimeInputService {
	
	/** OverTimeInputDAO Bean 생성 */
	@Resource(name = "/rc/roa/overTimeInputDAO")
	private OverTimeInputDAO overTimeInputDAO;
	

	/**
	 * 특근 근태 발생 등록 목록을 조회한다.
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
	public RecordSet selectWeekly(Map<String, Object> mapParam) throws Exception {
		return overTimeInputDAO.selectWeekly(mapParam);
	}
	
	/**
	 * 특근 근태 발생 등록 목록을 조회한다.
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
		return overTimeInputDAO.selectList(mapParam);
	}

	/**
	 * 특근 근태 발생 등록 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap list,DataSetMap info) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			
			Map<String, Object> rowData = list.get(i);
			String cnt1 = overTimeInputDAO.listCnt(rowData);
			
			if(Integer.parseInt(cnt1) == 0){
				insRowCnt += overTimeInputDAO.insert(rowData);	//신규
			}else{
				insRowCnt += overTimeInputDAO.update(rowData);	//변경
			}
		}
		
		for (int i = 0 ; i < info.size() ; i++) {
			Map<String, Object> rowData = info.get(i);
			
			updRowCnt += overTimeInputDAO.infoInser(rowData);
			
			if("I".equals(rowData.get("logYn").toString())){
				insRowCnt += overTimeInputDAO.logInser(rowData);	//신규
			}else if("U".equals(rowData.get("logYn").toString())){
				insRowCnt += overTimeInputDAO.logInfo(rowData);		//변경
			}
		}
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
