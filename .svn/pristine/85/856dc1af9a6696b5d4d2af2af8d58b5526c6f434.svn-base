package com.hwfs.fm.fmp.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fmp.dao.VdScheduleMgntDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 수발주 스케쥴관리하는 VdScheduleMgnt Service Implementation
 * 
 * @ClassName VdScheduleMgntServiceImpl.java
 * @Description VdScheduleMgntServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.11.25    강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재영업 강대성
 * @since 2015.11.25
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fmp/vdScheduleMgntService")
public class VdScheduleMgntServiceImpl extends DefaultServiceImpl implements VdScheduleMgntService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** VdScheduleMgntDAO Bean 생성 */
	@Resource(name = "/fm/fmp/vdScheduleMgntDAO")
	private VdScheduleMgntDAO vdScheduleMgntDAO;
	

	/**
	 * 수발주 스케쥴관리 목록을 조회한다.
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
		return vdScheduleMgntDAO.selectList(mapParam);
	}
	
	/**
	 * 단가업장 목록을 조회한다.
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
	@Override
	public RecordSet selectPopList(Map<String, Object> parameter) throws Exception {
		return vdScheduleMgntDAO.selectPopList(parameter);
	}

	/**
	 * 수발주 스케쥴관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap searchList, DataSetMap list) throws Exception {
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			Map<String, Object> rowData2 = searchList.get(0);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Update 처리
			if (rowType == DataSet.ROW_TYPE_UPDATED) {
				rowData.putAll(rowData2);
				updRowCnt += vdScheduleMgntDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += vdScheduleMgntDAO.delete(rowData);
			}
		}
				
		return updRowCnt + delRowCnt;
	}
	
	/**
	 * 수발주 스케쥴관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int deleteList(DataSetMap searchList, DataSetMap list) throws Exception {
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			Map<String, Object> rowData2 = searchList.get(0);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//DELETE 처리
			if (rowType == DataSet.ROW_TYPE_UPDATED) {
				rowData.putAll(rowData2);
				delRowCnt += vdScheduleMgntDAO.delete(rowData);
			}
		}
				
		return updRowCnt + delRowCnt;
	}
}
