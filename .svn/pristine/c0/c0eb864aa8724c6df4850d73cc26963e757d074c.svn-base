package com.hwfs.rc.roa.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.roa.dao.OverTimeUpjangDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * 특근 발생 현황하는 OverTimeUpjang Service Implementation
 * 
 * @ClassName OverTimeUpjangServiceImpl.java
 * @Description OverTimeUpjangServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.11.26    손형민        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 손형민
 * @since 2015.11.26
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/roa/overTimeUpjangService")
public class OverTimeUpjangServiceImpl extends DefaultServiceImpl implements OverTimeUpjangService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** OverTimeUpjangDAO Bean 생성 */
	@Resource(name = "/rc/roa/overTimeUpjangDAO")
	private OverTimeUpjangDAO overTimeUpjangDAO;
	

	/**
	 * 특근 발생 현황 목록을 조회한다.
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
		return overTimeUpjangDAO.selectList(mapParam);
	}

	/**
	 * 특근 발생 현황 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += overTimeUpjangDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += overTimeUpjangDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += overTimeUpjangDAO.delete(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
