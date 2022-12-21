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
import com.hwfs.fm.fms.dao.FoodMaterialsSalePriceDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 식자재영업 판매단가 생성하는 FoodMaterialsSalePrice Service Implementation
 * 
 * @ClassName FoodMaterialsSalePriceServiceImpl.java
 * @Description FoodMaterialsSalePriceServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.14    최성연        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.04.14
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fms/foodMaterialsSalePriceService")
public class FoodMaterialsSalePriceServiceImpl extends DefaultServiceImpl implements FoodMaterialsSalePriceService {
	
	/** FoodMaterialsSalePriceDAO Bean 생성 */
	@Resource(name = "/fm/fms/foodMaterialsSalePriceDAO")
	private FoodMaterialsSalePriceDAO foodMaterialsSalePriceDAO;
	

	/**
	 * 식자재영업 센터별 고객사 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectUpjang(Map<String, Object> mapParam) throws Exception {
		if ( ("DistributionRequestRptReg").equals(mapParam.get("attr01"))) {	// 물류요청서 등록
			return foodMaterialsSalePriceDAO.selectUpjang2(mapParam);
		} else {
			return foodMaterialsSalePriceDAO.selectUpjang(mapParam);
		}
	}
	
	/**
	 * 식자재영업 고객사별 계약번호 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectContract(Map<String, Object> mapParam) throws Exception {
		return foodMaterialsSalePriceDAO.selectContract(mapParam);
	}

	/**
	 * 식자재영업 고객사별 구매자재를 조회한다.(팝업)
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectItem(Map<String, Object> mapParam) throws Exception {
		return foodMaterialsSalePriceDAO.selectItem(mapParam);
	}
	
	/**
	 * 식자재영업 추가된 자재에 대한 구매정보를 GET
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectItemPo(Map<String, Object> mapParam) throws Exception {
		return foodMaterialsSalePriceDAO.selectItemPo(mapParam);
	}

	
	/**
	 * 식자재영업 판매단가 생성 목록을 조회한다.
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
		
		if(("NEW").equals(mapParam.get("schContractId")))
			return foodMaterialsSalePriceDAO.selectList(mapParam);
		else
			return foodMaterialsSalePriceDAO.selectList2(mapParam);
	}

	/**
	 * 식자재영업 판매단가 생성 목록을 조회한다. (조회용)
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectListView(Map<String, Object> mapParam) throws Exception {
		if(("NEW").equals(mapParam.get("schContractId")))
			return foodMaterialsSalePriceDAO.selectListView(mapParam);
		else
			return foodMaterialsSalePriceDAO.selectListView2(mapParam);
	}
	
	
	
	/**
	 * 식자재영업 판매단가 생성 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * batch update  형식으로 처리 - 사용 X
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
		int[] insRowArr = new int[list.size()];
		String msg = "";			// 처리결과 문구
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			// 일괄 삭제 후에 INSERT 하는 방식으로 처리해야 한다.(한번만 실행)
			// 신규생성건은 삭제 제외
			if (i==0 && !"NEW".equals(rowData.get("contractId"))) {
				delRowCnt = foodMaterialsSalePriceDAO.deleteAll(rowData);
			}
		} // end for

		// 실행 : 삭제를 제외하고 처리
//		insRow = foodMaterialsSalePriceDAO.insert2 (list.getInsRowMaps());
//		updRow = foodMaterialsSalePriceDAO.insert2 (list.getUpdRowMaps());
		
		insRowCnt = foodMaterialsSalePriceDAO.insert2(list.getRowMaps());
		//insRowArr = foodMaterialsSalePriceDAO.insert3(list.getRowMaps());
		//for (int i=0; i<insRowArr.length; i++) {
		//	System.out.println("insRowArr : [" + i + "] : " +  insRowArr[i]);			
		//}

		// batchUpdate2 에서 리턴 행을 정확하게 반환하지 않슴 : 결과값이 "-2'를 리턴함, 각 row별로
		// 따라서 list 갯수를 처리행수로 치환 
		insRowCnt = list.size();
		
		if (insRowCnt>0) {
			Map<String, Object> rowData = list.get(0);
			
			// 생성된 자재이외에 자료들에 대해 종료일자 SET
			//foodMaterialsSalePriceDAO.updateDateNon(rowData);
			// 이전 계약번호에 대한 전제단가정보의 종료일자를 UPDATE한다(08-05)
			foodMaterialsSalePriceDAO.updateDate3(rowData);		
			
			// 생성결과를 반영한다
			msg = insRowCnt + "건 단가생성완료 ";
			msg = msg + "시작일자(";
			msg = msg + rowData.get("stdDate").toString().substring(0, 4);
			msg = msg + "-" + rowData.get("stdDate").toString().substring(4, 6);
			msg = msg + "-" + rowData.get("stdDate").toString().substring(6, 8);
			msg = msg + ")";
			
			// 처리결과 SET
			rowData.put("msg", msg);
			
			// UPDATE 처리 호출
			foodMaterialsSalePriceDAO.updateMsg(rowData);
		}
		
		return insRowCnt;
	}


	/**
	 * 식자재영업 판매단가 생성 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList1(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int insRow = 0;
		int delRowCnt = 0;
		String msg = "";			// 처리결과 문구
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			// 일괄 삭제 후에 INSERT 하는 방식으로 처리해야 한다.(한번만 실행)
			// 신규생성건은 삭제 제외
			if (i==0 && !"NEW".equals(rowData.get("contractId"))) {
				delRowCnt = foodMaterialsSalePriceDAO.deleteAll(rowData);
			}

			// 삭제를 제외하고 생성
			if (rowType != DataSet.ROW_TYPE_DELETED) {
				// 신규 OR 기 생성 부분을 일괄로 저장한다
				insRow = foodMaterialsSalePriceDAO.insert(rowData);
				
				if (insRow>0) {
					insRowCnt += 1;
					
					// UPDATE 수행 : 계약종료일자 SET
					//foodMaterialsSalePriceDAO.updateDate(rowData);
				}
			}	
		} // end for
		
		if (insRowCnt>0) {
			Map<String, Object> rowData = list.get(0);
			
			// 생성된 자재이외에 자료들에 대해 종료일자 SET
			//foodMaterialsSalePriceDAO.updateDateNon(rowData);
			// 이전 계약번호에 대한 전제단가정보의 종료일자를 UPDATE한다(08-05)
			foodMaterialsSalePriceDAO.updateDate3(rowData);		
			
			// 생성결과를 반영한다
			msg = insRowCnt + "건 단가생성완료 ";
			msg = msg + "시작일자(";
			msg = msg + rowData.get("stdDate").toString().substring(0, 4);
			msg = msg + "-" + rowData.get("stdDate").toString().substring(4, 6);
			msg = msg + "-" + rowData.get("stdDate").toString().substring(6, 8);
			msg = msg + ")";
			
			// 처리결과 SET
			rowData.put("msg", msg);
			
			// UPDATE 처리 호출
			foodMaterialsSalePriceDAO.updateMsg(rowData);
		}
		
		return insRowCnt;
	}
	

	/**
	 * 식자재영업 판매단가 생성 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * 1 ROW씩 처리
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
		int insRow = 0;
		int delRowCnt = 0;
		String msg = "";			// 처리결과 문구
		String isLast = "";
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			// 기존자료 삭제 후에 INSERT 하는 방식으로 처리해야 한다.(한번만 실행)
			delRowCnt = foodMaterialsSalePriceDAO.deleteItem(rowData);

			// 최종자료여부 SET
			isLast = rowData.get("isLast").toString();
			
			// 단가정보 개별 생성
			insRowCnt = foodMaterialsSalePriceDAO.insert(rowData);
				
		} // end for
		
		// 최종마지막 자료인 경우에 실행 : 최종 1회 실행
		if (insRowCnt>0 && "Y".equals(isLast)) {
			Map<String, Object> rowData = list.get(0);
			
			// 이전 계약번호에 대한 전제단가정보의 종료일자를 UPDATE한다(08-05)
			foodMaterialsSalePriceDAO.updateDate3(rowData);		
			
			// 최종건수를 구해서 메세지를 적용한다
			int cnt = foodMaterialsSalePriceDAO.selectCnt(rowData);
			
			// 생성결과를 반영한다
			msg = cnt + "건 단가생성완료 ";
			msg = msg + "시작일자(";
			msg = msg + rowData.get("stdDate").toString().substring(0, 4);
			msg = msg + "-" + rowData.get("stdDate").toString().substring(4, 6);
			msg = msg + "-" + rowData.get("stdDate").toString().substring(6, 8);
			msg = msg + ")";
			
			// 처리결과 SET
			rowData.put("msg", msg);
			
			// UPDATE 처리 호출
			foodMaterialsSalePriceDAO.updateMsg(rowData);
		}
		
		return insRowCnt;
	}
	
	

	/**
	 * 식자재영업 판매단가 생성 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * N ROW씩 처리 : 신규, 수정된 행만 처리
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
		int delRowCnt = 0;
		String msg = "";			// 처리결과 문구
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			// 삭제를 제외하고 생성
			if (rowType != DataSet.ROW_TYPE_DELETED) {
				// 기존자료 삭제 후에 INSERT 하는 방식으로 처리해야 한다.(한번만 실행)
				delRowCnt = foodMaterialsSalePriceDAO.deleteItem(rowData);

				// 단가정보 개별 생성
				insRow = foodMaterialsSalePriceDAO.insert(rowData);
				
				if (insRow>0) {
					insRowCnt += 1;
				}
			}	
		} // end for
		
		// 최종마지막 자료인 경우에 실행 : 최종 1회 실행
		if (insRowCnt>0) {
			Map<String, Object> rowData = list.get(0);
			
			// 이전 계약번호에 대한 전제단가정보의 종료일자를 UPDATE한다(08-05)
			foodMaterialsSalePriceDAO.updateDate3(rowData);		
			
			// 최종건수를 구해서 메세지를 적용한다
			int cnt = foodMaterialsSalePriceDAO.selectCnt(rowData);
			
			// 생성결과를 반영한다
			msg = cnt + "건 단가생성완료 ";
			msg = msg + "시작일자(";
			msg = msg + rowData.get("stdDate").toString().substring(0, 4);
			msg = msg + "-" + rowData.get("stdDate").toString().substring(4, 6);
			msg = msg + "-" + rowData.get("stdDate").toString().substring(6, 8);
			msg = msg + ")";
			
			// 처리결과 SET
			rowData.put("msg", msg);
			
			// UPDATE 처리 호출
			foodMaterialsSalePriceDAO.updateMsg(rowData);
		}
		
		return insRowCnt;
	}
		
	
	
	
	/**
	 * 식자재영업 선택한 자재를 Delete 처리한다.
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
		String contractStart = "";
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			//int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			delRow = foodMaterialsSalePriceDAO.deleteItem(rowData);

			if (delRow>0) {
				delRowCnt += 1;

				// 2015-08-06 : 이전 계약건에 대한 자재별 계약종료일자를 UPDATE 하지 않는다
				// WHY? 계약종료일자가 없는 자료가 더이상 존재하지 않음
//				contractStart = foodMaterialsSalePriceDAO.selectItemDate(rowData);
//				rowData.put("stdDate2", contractStart);
//				
//				// UPDATE 수행 : 계약종료일자 SET
//				foodMaterialsSalePriceDAO.updateDate2(rowData);
			}

			
		}
		return delRowCnt;
	}


	/**
	 * 단가계약번호를 Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int deleteFsale(DataSetMap list) throws Exception {
		int delRowCnt = 0;

		if (list.size() > 0) {
			Map<String, Object> rowData = list.get(0);
			
			delRowCnt = foodMaterialsSalePriceDAO.deleteFsale(rowData);
		}
		
		return delRowCnt;
	}
	
	
	


}
