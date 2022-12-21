package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fms.dao.SalePriceIndexPackModifyDAO;

 /**
 * 판매단가를 일괄수정하는 SalePriceIndexPackModify Service Implementation
 * 
 * @ClassName SalePriceIndexPackModifyServiceImpl.java
 * @Description SalePriceIndexPackModifyServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.21    최성연        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.04.21
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fms/salePriceIndexPackModifyService")
public class SalePriceIndexPackModifyServiceImpl extends DefaultServiceImpl implements SalePriceIndexPackModifyService {
	
	/** SalePriceIndexPackModifyDAO Bean 생성 */
	@Resource(name = "/fm/fms/salePriceIndexPackModifyDAO")
	private SalePriceIndexPackModifyDAO salePriceIndexPackModifyDAO;
	
	/**
	 * 구매자재 목록을 조회한다.
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectItem(Map<String, Object> mapParam) throws Exception {
		return salePriceIndexPackModifyDAO.selectItem(mapParam);
	}

	
	/**
	 * 판매단가 일괄수정 목록을 조회한다.
	 * <pre>
	 * - 1번째 탭 리스트 조회
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return salePriceIndexPackModifyDAO.selectList(mapParam);
	}

	/**
	 * 판매단가 일괄수정 업장 목록을 조회한다.
	 * <pre>
	 * - 2번째 탭 리스트 조회
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectUpjang(Map<String, Object> mapParam) throws Exception {
		return salePriceIndexPackModifyDAO.selectUpjang(mapParam);
	}

	/**
	 * 판매단가 일괄수정 추가 자재 정보를 조회한다.
	 * <pre>
	 * - 2/3번째 탭 리스트 조회(자재목록 추가)
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectItemCode(Map<String, Object> mapParam) throws Exception {
		return salePriceIndexPackModifyDAO.selectItemCode(mapParam);
	}
	public RecordSet selectItemCode2(Map<String, Object> mapParam) throws Exception {
		return salePriceIndexPackModifyDAO.selectItemCode2(mapParam);
	}
	
	/**
	 * 판매단가 일괄수정 추가 자재 정보 이력사항을 조회한다.
	 * <pre>
	 * - 2번째 탭
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectHist(Map<String, Object> mapParam) throws Exception {
		return salePriceIndexPackModifyDAO.selectHist(mapParam);
	}
	
	
	/**
	 * 판매단가를 일괄수정 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 1번째 탭의 고객사별 단가를 일괄 변경
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap list) throws Exception {
		int updRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			//int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			// rowType과 상관없이 UPDATE 문 처리
			updRowCnt += salePriceIndexPackModifyDAO.update(rowData);
		}
				
		return updRowCnt;
	}


	/**
	 * 자재 일괄추가/변경 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 2번째 탭의 고객사별 단가를 일괄 변경
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
		int insRow = 0;
		int hisRow = 0;
		int selRowCnt = 0;
		String procType = "";
		String remark = "";
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			//int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			// 구매 매입단가 자료 COUNT GET
			selRowCnt = salePriceIndexPackModifyDAO.selectPoCnt(rowData);
			
			// 자재일괄추가 관련 History를 생성한다
			if (selRowCnt==0) {
				procType = "E";
				remark = "구매 매입단가 정보가 존재하지 않습니다.";
			} else {
				procType = "S";
				remark = "";
			}
			// 변수대입
			rowData.put("procType", procType);
			rowData.put("remark", remark);
			// 이력정보 생성
			hisRow = salePriceIndexPackModifyDAO.insertHist(rowData);

			// 매입단가 정보가 존재하면 판매단가 생성
			if (selRowCnt > 0) {

				// 기존자료가 있으면 삭제
				salePriceIndexPackModifyDAO.delete2(rowData);
			
				// 단가정보를 생성
				insRow = salePriceIndexPackModifyDAO.insert2(rowData);

				if (insRow>0) {
					insRowCnt += 1;
					// 계약종료일자 SET : 원 차수에 대한 단가정보는 무조건 종료시킨다(09-11)
					//salePriceIndexPackModifyDAO.update2(rowData);	// 단일 자재코드에 대한 종료일자 SET 
					//salePriceIndexPackModifyDAO.updateDate3(rowData); // 이전회차에 대한 종료일자 강제 SET : (2015-10-08) 사용 X
				}
			}	
			
		}
				
		return insRowCnt;
	}


	/**
	 * 자재 일괄추가/변경 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 3번째 탭의 고객사별 단가를 일괄 삭제
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList3(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int insRow = 0;
		int hisRow = 0;
		int selRowCnt = 0;
		String procType = "";
		String remark = "";
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			//int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			// 구매 매입단가 자료 COUNT GET
			selRowCnt = salePriceIndexPackModifyDAO.selectSaleCnt(rowData);
			
			// 자재일괄추가 관련 History를 생성한다
			if (selRowCnt==0) {
				procType = "E";
				remark = "판매단가 정보가 존재하지 않습니다.";
			} else {
				procType = "S";
				remark = "";
			}
			// 변수대입
			rowData.put("procType", procType);
			rowData.put("remark", remark);
			rowData.put("gubun", "2");	// 삭제구분
			// 이력정보 생성
			hisRow = salePriceIndexPackModifyDAO.insertHist(rowData);

			// 판매단가 정보가 존재하면 판매단가 삭제
			if (selRowCnt > 0) {
				
				// 단가정보를 삭제
				insRow = salePriceIndexPackModifyDAO.deleteItem(rowData);

				if (insRow>0) {
					insRowCnt += 1;
				}
			}	
			
		}
				
		return insRowCnt;
	}
	
	
	

}
