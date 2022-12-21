package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fms.dao.SalePriceSimuDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 판매가를 시뮬레이션하는 SalePriceSimu Service Implementation
 * 
 * @ClassName SalePriceSimuServiceImpl.java
 * @Description SalePriceSimuServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.29    최성연        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.05.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fms/salePriceSimuService")
public class SalePriceSimuServiceImpl extends DefaultServiceImpl implements SalePriceSimuService {
	
	/** SalePriceSimuDAO Bean 생성 */
	@Resource(name = "/fm/fms/salePriceSimuDAO")
	private SalePriceSimuDAO salePriceSimuDAO;

	/**
	 * 판매가 시뮬레이션 ID 리스트를 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectSimu(Map<String, Object> mapParam) throws Exception {
		return salePriceSimuDAO.selectSimu(mapParam);
	}
	

	/**
	 * 판매가 시뮬레이션 KEY 값을 구한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectID(Map<String, Object> mapParam) throws Exception {
		return salePriceSimuDAO.selectID(mapParam);
	}
	

	/**
	 * 판매가 시뮬레이션 목록을 조회한다.
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
		if(("NEW").equals(mapParam.get("schSimuId")))
			return salePriceSimuDAO.selectList(mapParam);
		else
			return salePriceSimuDAO.selectList2(mapParam);
	}

	
	/**
	 * 판매가 시뮬레이션 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap list, String strId) throws Exception {
		int insRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			//int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			// 일괄 삭제 후에 INSERT 하는 방식으로 처리해야 한다.(한번만 실행) : 신규는 제외
			if ((i==0) && (!"NEW".equals(rowData.get("simuId")))) {
				delRowCnt = salePriceSimuDAO.deleteAll(rowData);
			}
			
			// 신규일경우 KEY SET
			if ("NEW".equals(rowData.get("simuId"))) {
				rowData.put("simuId", strId);
			} 
			
			// 건별저장 실행
			insRowCnt += salePriceSimuDAO.insert(rowData);
		}
				
		return insRowCnt;
	}


	/**
	 * 선택한 판매가 시뮬레이션을 Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int deleteSimu(DataSetMap list) throws Exception {
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			//int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			// 판매가 시뮬레이션 삭제
			delRowCnt = salePriceSimuDAO.deleteAll(rowData);
			
		}
				
		return delRowCnt;
	}

	
	/**
	 * 시뮬레이션을 확인 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveConfirm(DataSetMap list) throws Exception {
		int updRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			//int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			updRowCnt += salePriceSimuDAO.confirm(rowData);
			
		}
		return updRowCnt;
	}
	


}
