package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fms.dao.ThemeItemProfitDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 전략이익율 등록하는 ThemeItemProfit Service Implementation
 * 
 * @ClassName ThemeItemProfitServiceImpl.java
 * @Description ThemeItemProfitServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2019.08.13   	JHKim        최초생성
 *  
 * </pre>
 * @author FC운영 JHKim
 * @since 2019.08.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fms/ThemeItemProfitService")
public class ThemeItemProfitServiceImpl extends DefaultServiceImpl implements ThemeItemProfitService {
	
	/** ThemeItemProfitDAO Bean 생성 */
	@Resource(name = "/fm/fms/ThemeItemProfitDAO")
	private ThemeItemProfitDAO ThemeItemProfitDAO;
	

	/**
	 * 전략이익율 CC별 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectStd(Map<String, Object> mapParam) throws Exception {
		return ThemeItemProfitDAO.selectStd(mapParam);
	}
	
	/**
	 * 분류별 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectClass(Map<String, Object> mapParam) throws Exception {
		return ThemeItemProfitDAO.selectClass(mapParam);
	}
	public RecordSet selectClassType(Map<String, Object> mapParam) throws Exception {
		return ThemeItemProfitDAO.selectClassType(mapParam);
	}

	/**
	 * 자재별 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectItem(Map<String, Object> mapParam) throws Exception {
		return ThemeItemProfitDAO.selectItem(mapParam);
	}
	
	
	/**
	 * 전략이익율 등록 목록을 조회한다.
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
		return ThemeItemProfitDAO.selectList(mapParam);
	}

	/**
	 * 전략이익율 등록 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
				insRowCnt += ThemeItemProfitDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += ThemeItemProfitDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += ThemeItemProfitDAO.delete(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	
	/**
	 * 분류별 전략율 정보를 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	@Override
	public int saveClass(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			//int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			// 일괄 삭제 후에 INSERT 하는 방식으로 처리해야 한다.(한번만 실행)
			if (i==0) {
				delRowCnt = ThemeItemProfitDAO.deleteClass(rowData);
			}

			// DataSet RowType과는 상관없이 INSERT 한다
			insRowCnt += ThemeItemProfitDAO.insertClass(rowData);
		}
				
		return insRowCnt;
	}	
	
	
	/**
	 * 분류별 전략율 정보를 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * 일괄 삭제
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	@Override
	public int deleteClass(DataSetMap list) throws Exception {
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			//int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			// SET
			rowData.put("centerCode", rowData.get("selCenter").toString());
			rowData.put("ccCd", rowData.get("selCcCd").toString());
			rowData.put("profitDate", rowData.get("selDate").toString());
			
			// 일괄 삭제 후에 INSERT 하는 방식으로 처리해야 한다.(한번만 실행)
			delRowCnt = ThemeItemProfitDAO.deleteClass(rowData);

		}
				
		return delRowCnt;
	}	
		
	
	
	/**
	 * 전략이익률 자재  DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * N Transaction
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveItem(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			// 기존자료 삭제 후에 INSERT 하는 방식으로 처리해야 한다.
			//delRowCnt = ThemeItemProfitDAO.delete(rowData);

			// DataSet RowType과는 상관없이 INSERT 한다, 자재코드가 있는건만 처리
			if (!"".equals(rowData.get("itemCode").toString())) {
				insRowCnt += ThemeItemProfitDAO.insert(rowData);	
			}	
		}
				
		return insRowCnt + delRowCnt;
	}
	
	/**
	 * 자재별 전략율 정보를 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	@Override
	public int saveItem2(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			// 기존자료 삭제 후에 INSERT 하는 방식으로 처리해야 한다.
			delRowCnt = ThemeItemProfitDAO.delete(rowData);

			// DataSet RowType과는 상관없이 INSERT 한다, 자재코드가 있는건만 처리
			if (!"".equals(rowData.get("itemCode").toString())) {
				//insRowCnt += ThemeItemProfitDAO.insert(rowData);	
				insRowCnt += ThemeItemProfitDAO.insert2(rowData);	
			}	

		}
				
		return insRowCnt + delRowCnt;
	}	
	
	
	
	/**
	 * 전략이익률 자재  DataSetMap의 데이터를 일괄 Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int deleteAll(DataSetMap list) throws Exception {
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			// 일괄 삭제
			delRowCnt = ThemeItemProfitDAO.deleteAll(rowData);
		}
				
		return delRowCnt;
	}	
	
	
	/**
	 * 전략이익률 자재  DataSetMap의 데이터를 Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int deleteItem(DataSetMap list) throws Exception {
		int delRowCnt = 0;
		int delRow = 0;
		int delRowTheme = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			//int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			delRow = ThemeItemProfitDAO.delete(rowData);
			delRowTheme = ThemeItemProfitDAO.deleteTheme(rowData);

			if (delRow>0) {
				delRowCnt += 1;
			}

			
		}
		return delRowCnt;
	}	
	
	
}
