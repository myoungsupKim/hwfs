package com.hwfs.rc.roa.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.roa.dao.PartTimeDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 용역 발생을 등록하는 PartTime Service Implementation
 * 
 * @ClassName PartTimeServiceImpl.java
 * @Description PartTimeServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.23    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.03.23
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/roa/partTimeService")
public class PartTimeServiceImpl extends DefaultServiceImpl implements PartTimeService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** PartTimeDAO Bean 생성 */
	@Resource(name = "/rc/roa/partTimeDAO")
	private PartTimeDAO partTimeDAO;
	

	/**
	 * 용역 발생 등록 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return partTimeDAO.selectList(mapParam);
	}

	/**
	 * 용역 발생 차수를 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet getOccurNumOfTimes(Map<String, Object> mapParam) throws Exception {
		return partTimeDAO.getOccurNumOfTimes(mapParam);
	}

	/**
	 * 공제시간을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet getDeducTime(Map<String, Object> mapParam) throws Exception {
		return partTimeDAO.getDeducTime(mapParam);
	}

	/**
	 * 신규 용역 사번을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectPartTimeEmpSabun(Map<String, Object> mapParam) throws Exception {
		return partTimeDAO.selectPartTimeEmpSabun(mapParam);
	}
	
	/**
	 * 용역 발생 등록 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
				insRowCnt += partTimeDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += partTimeDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += partTimeDAO.delete(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}

	/**
	 * 용역 대상자 등록 및  용역 발생 등록을 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveMgnt(DataSetMap list1, DataSetMap list2) throws Exception {
		int insRowCnt = 0;
		
		Map<String, Object> rowData1 = list1.get(0);
		Map<String, Object> rowData2 = list2.get(0);
		
		insRowCnt = partTimeDAO.insert1(rowData1);	//용역 대상자 등록
		if(insRowCnt > 0) insRowCnt = partTimeDAO.insert(rowData2);	//용역 발생 등록
				
		return insRowCnt;
	}
	
}
