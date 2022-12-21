package com.hwfs.fs.fsc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsc.dao.CateringSchlReptDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * 케터링 스케줄보고하는 CateringSchlRept Service Implementation
 * 
 * @ClassName CateringSchlReptServiceImpl.java
 * @Description CateringSchlReptServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.18    yanghj        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 yanghj
 * @since 2015.03.18
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsc/cateringSchlReptService")
public class CateringSchlReptServiceImpl extends DefaultServiceImpl implements CateringSchlReptService {

	/** CateringSchlReptDAO Bean 생성 */
	@Resource(name = "/fs/fsc/cateringSchlReptDAO")
	private CateringSchlReptDAO cateringSchlReptDAO;
	

	/**
	 * 케터링 스케줄보고(사업장 주요행사 계획<행사실적>) 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectCeleList(Map<String, Object> mapParam) throws Exception {
		return cateringSchlReptDAO.selectCeleList(mapParam);
	}
	
	/**
	 * 케터링 스케줄보고(사업장 인력지원 계획<조리인력>) 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectCookHumanList(Map<String, Object> mapParam) throws Exception {
		return cateringSchlReptDAO.selectCookHumanList(mapParam);
	}
	
	/**
	 * 케터링 스케줄보고(개인별근무 스케줄 리스트) 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectPlanList(Map<String, Object> mapParam) throws Exception {
		return cateringSchlReptDAO.selectPlanList(mapParam);
	}
	
	/**
	 * 케터링 스케줄보고(개인별근무 스케줄 달력) 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectCalendarList(Map<String, Object> mapParam) throws Exception {
		return cateringSchlReptDAO.selectCalendarList(mapParam);
	}

	/**
	 * 케터링 스케줄보고 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
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
				insRowCnt += cateringSchlReptDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += cateringSchlReptDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += cateringSchlReptDAO.delete(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
