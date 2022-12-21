package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fms.dao.StrategyGainRateItemRegDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * 전략이익률 자재를 등록 하는 StrategyGainRateItemReg Service Implementation
 * 
 * @ClassName StrategyGainRateItemRegServiceImpl.java
 * @Description StrategyGainRateItemRegServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.15    최성연        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.05.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fms/strategyGainRateItemRegService")
public class StrategyGainRateItemRegServiceImpl extends DefaultServiceImpl implements StrategyGainRateItemRegService {
	
	/** StrategyGainRateItemRegDAO Bean 생성 */
	@Resource(name = "/fm/fms/strategyGainRateItemRegDAO")
	private StrategyGainRateItemRegDAO strategyGainRateItemRegDAO;
	

	/**
	 * 전략이익률 자재  목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return strategyGainRateItemRegDAO.selectList(mapParam);
	}
	public RecordSet selectDate(Map<String, Object> mapParam) throws Exception {
		return strategyGainRateItemRegDAO.selectDate(mapParam);
	}
	public RecordSet upjangList(Map<String, Object> mapParam) throws Exception {
		return strategyGainRateItemRegDAO.upjangList(mapParam);
	}

	/**
	 * 전략이익률 자재  DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * 1 Transaction
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
		int selRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			// 일괄 삭제 후에 INSERT 하는 방식으로 처리해야 한다.(한번만 실행)
			if (i==0) {
				delRowCnt = strategyGainRateItemRegDAO.deleteAll(rowData);
			}

			// DataSet RowType과는 상관없이 INSERT 한다, 자재코드가 있는건만 처리
			if (!"".equals(rowData.get("itemCode").toString())) {
				
//				// INSERT, UPDATE 처리를 위한 COUNT GET, 중복 CHECK는 하지 X
//				selRowCnt = strategyGainRateItemRegDAO.selectItemCnt(rowData);
//				
//				if (selRowCnt==0) {
//					insRowCnt += strategyGainRateItemRegDAO.insert(rowData);
//				} else {
//					updRowCnt += strategyGainRateItemRegDAO.update(rowData);
//				}
				insRowCnt += strategyGainRateItemRegDAO.insert2(rowData);	
			}	
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
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
	public int saveList2(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			// 기존자료 삭제 후에 INSERT 하는 방식으로 처리해야 한다.
			delRowCnt = strategyGainRateItemRegDAO.delete(rowData);

			// DataSet RowType과는 상관없이 INSERT 한다, 자재코드가 있는건만 처리
			if (!"".equals(rowData.get("itemCode").toString())) {
				insRowCnt += strategyGainRateItemRegDAO.insert2(rowData);	
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
	public int deleteList(DataSetMap list) throws Exception {
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			// 일괄 삭제
			delRowCnt = strategyGainRateItemRegDAO.deleteAll(rowData);
		}
				
		return delRowCnt;
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
			delRowCnt = strategyGainRateItemRegDAO.deleteAll(rowData);
		}
				
		return delRowCnt;
	}
	
	

	/**
	 * 매출처 업장  DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * 1 Transaction
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int upjangMig(DataSetMap list) throws Exception {
		int updRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			// DataSet RowType과는 상관없이 INSERT 한다, 자재코드가 있는건만 처리
			if (!"".equals(rowData.get("upjang").toString())) {
				updRowCnt += strategyGainRateItemRegDAO.updateMig(rowData);	
			}	
		}
				
		return updRowCnt;
	}

}
