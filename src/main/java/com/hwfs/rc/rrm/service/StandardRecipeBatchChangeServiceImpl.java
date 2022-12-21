package com.hwfs.rc.rrm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rrm.dao.StandardRecipeBatchChangeDAO;

 /**
 * 표준 레시피 자재를 일괄 변경하는 StandardRecipeBatchChange Service Implementation
 * 
 * @ClassName StandardRecipeBatchChangeServiceImpl.java
 * @Description StandardRecipeBatchChangeServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.20    Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.04.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rrm/standardRecipeBatchChangeService")
public class StandardRecipeBatchChangeServiceImpl extends DefaultServiceImpl implements StandardRecipeBatchChangeService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** StandardRecipeBatchChangeDAO Bean 생성 */
	@Resource(name = "/rc/rrm/standardRecipeBatchChangeDAO")
	private StandardRecipeBatchChangeDAO standardRecipeBatchChangeDAO;
	

	/**
	 * 표준 레시피 자재 일괄 변경 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return standardRecipeBatchChangeDAO.selectList(mapParam);
	}

	/**
	 * 표준 레시피 자재 일괄 변경 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
		int oldCnt = 0;
		
		logger.debug("list.size() : " + list.size());
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			logger.debug("rowData : " + rowData );
			if(rowData.get("chk").equals("1")){
				
				//새로운 재료로 등록(표준)
				//insRowCnt += standardRecipeBatchChangeDAO.insert(rowData);
				
				//새로운 재료 등록(업장)
				//insRowCnt += standardRecipeBatchChangeDAO.insertUpjang(rowData);
				
				//oldCnt =  standardRecipeBatchChangeDAO.selectOldList(rowData);
				//logger.debug("oldCnt : " + oldCnt ); 
				
				//변경 후 자재가 레시피에 있으면 우선 삭제(표준) 2017.02.17(김호석)
				delRowCnt = standardRecipeBatchChangeDAO.deleteStd(rowData);
								
				//이전자재 종료일자 변경(새로운자재 시작일자-1)(표준)
				//이전자재 변경자재로 변경(표준)2017.02.17(김호석)
				updRowCnt += standardRecipeBatchChangeDAO.updateEdate(rowData);
				
				//변경 후 자재가 레시피에 있으면 우선 삭제(업장) 2017.02.17(김호석)
				delRowCnt = standardRecipeBatchChangeDAO.deleteUpjang(rowData);				
				
				//이전자재 종료일자 변경(새로운자재 시작일자-1)(업장)
				//이전자재 변경자재로 변경(표준)2017.02.17(김호석)
				updRowCnt += standardRecipeBatchChangeDAO.updateEdateUpjang(rowData);
				
				// 표준 레시피 자재 일괄 변경 후 이력을 등록한다.
				insRowCnt += standardRecipeBatchChangeDAO.insertStdLog(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
