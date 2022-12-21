package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fms.dao.EstPaperWriteDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 견적서를 작성하는 EstPaperWrite Service Implementation
 * 
 * @ClassName EstPaperWriteServiceImpl.java
 * @Description EstPaperWriteServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.28    최성연        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.04.28
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fms/estPaperWriteService")
public class EstPaperWriteServiceImpl extends DefaultServiceImpl implements EstPaperWriteService {
	

	/** EstPaperWriteDAO Bean 생성 */
	@Resource(name = "/fm/fms/estPaperWriteDAO")
	private EstPaperWriteDAO estPaperWriteDAO;

	/**
	 * 식재영업 담당자를 검색한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectSabun(Map<String, Object> mapParam) throws Exception {
		return estPaperWriteDAO.selectSabun(mapParam);
	}
	
	/**
	 * 자재분류 정보를 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectClass(Map<String, Object> mapParam) throws Exception {
		return estPaperWriteDAO.selectClass(mapParam);
	}

	/**
	 * 견적번호 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectEsti(Map<String, Object> mapParam) throws Exception {
		return estPaperWriteDAO.selectEsti(mapParam);
	}
	
	/**
	 * 견적서 목록을 조회한다.
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

		if(("NEW").equals(mapParam.get("schEstiId")))
			return estPaperWriteDAO.selectList(mapParam);
		else
			return estPaperWriteDAO.selectList2(mapParam);
	}

	/**
	 * 견적번호를 구한다(신규)
	 * 
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리결과
	 * @throws Exception
	 */
	public RecordSet selectID(Map<String, Object> mapParam) throws Exception {
		return estPaperWriteDAO.selectID(mapParam);
	}

	
	/**
	 * 유사시뮬레이션 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectSimu(Map<String, Object> mapParam) throws Exception {
		return estPaperWriteDAO.selectSimu(mapParam);
	}
	
	/**
	 * 유사시뮬레이션 수량을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectSimQty(Map<String, Object> mapParam) throws Exception {
		return estPaperWriteDAO.selectSimQty(mapParam);
	}

	/**
	 * 평균시뮬레이션 수량을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectAvgQty(Map<String, Object> mapParam) throws Exception {
		return estPaperWriteDAO.selectAvgQty(mapParam);
	}
	
	/**
	 * 견적서 작성 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 1 Transaction 처리
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
		int updRowCnt = 0;
		int updCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			// 일괄 삭제 후에 INSERT 하는 방식으로 처리해야 한다.(한번만 실행) : 신규는 제외
			//if ((i==0) && (!"NEW".equals(rowData.get("estiId")))) {
			//	delRowCnt = estPaperWriteDAO.deleteAll(rowData);
			//}
			// 신규일경우 KEY SET
			if ("NEW".equals(rowData.get("estiId"))) {
				rowData.put("estiId", strId);
			}  
			
			//Insert 처리
//			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				// 건별저장 실행 : INSERT
//				insRowCnt += estPaperWriteDAO.insert(rowData);
//			}
			//Update 처리.
//			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				// 건별저장 실행 : UPDATE
//				updRowCnt += estPaperWriteDAO.update(rowData);
//			}
			
			// MERGE 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED ||  rowType == DataSet.ROW_TYPE_UPDATED) {
				// 건별저장 실행 : INSERT
				insRowCnt += estPaperWriteDAO.insert2(rowData);
			}
			
			
		}
		
		// 최종일괄 UPDATE : 제출처, 비고, 견적기간(TO) 저장
		if (insRowCnt + updRowCnt > 0) {
			Map<String, Object> rowData = list.get(0);
		
			// 제출처, 비고, 견적기간(TO) 일괄 저장 : 변동사항이 발생할 수 있으므로
			updCnt = estPaperWriteDAO.updateAll(rowData);		
		}
				
		return insRowCnt + updRowCnt;
	}
	
	
	/**
	 * 견적서 작성 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * 1 ROW씩 처리 : N Transaction
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList2(DataSetMap list, String strId) throws Exception {
		int insRowCnt = 0;
		int updRow = 0;
		int delRowCnt = 0;
		String msg = "";			// 처리결과 문구
		String isLast = "";
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			// 신규일경우 KEY SET
			if ("I".equals(rowData.get("saveFlag"))) {
				rowData.put("estiId", strId);
			}  
			
			// 기존자료 삭제 후에 INSERT 하는 방식으로 처리해야 한다.(한번만 실행)
			delRowCnt = estPaperWriteDAO.deleteItem(rowData);

			// 최종자료여부 SET
			isLast = rowData.get("isLast").toString();
			
			// 견적서정보 개별 생성
			insRowCnt = estPaperWriteDAO.insert(rowData);
				
		} // end for
		
		// 최종마지막 자료인 경우에 실행 : 최종 1회 실행
		if (insRowCnt>0 && "Y".equals(isLast)) {
			Map<String, Object> rowData = list.get(0);
			
			// 제출처, 비고, 견적기간(TO) 일괄 저장 : 변동사항이 발생할 수 있으므로
			updRow = estPaperWriteDAO.updateAll(rowData);		
		}
		
		return insRowCnt;
	}
	
	
	/**
	 * 견적서를 Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int deleteEst(DataSetMap list, String strId) throws Exception {
		int delRowCnt = 0;
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			// 신규일경우 KEY SET
			if ("I".equals(rowData.get("saveFlag"))) {
				rowData.put("estiId", strId);
			}  

			delRowCnt += estPaperWriteDAO.deleteAll(rowData);
			
		}
		return delRowCnt;
	}
	
	
	/**
	 * 견적서의 선택한 자재를 Delete 처리한다.
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
		String contractStart = "";
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			//int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			delRowCnt += estPaperWriteDAO.deleteItem(rowData);
			
		}
		return delRowCnt;
	}
	

	
	/**
	 * 견적서의 자재를 확인 처리한다.
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
			
			updRowCnt += estPaperWriteDAO.confirm(rowData);
			
		}
		return updRowCnt;
	}
	
	
}
