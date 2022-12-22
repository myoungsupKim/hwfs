package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fms.dao.SpContFactDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 특약율을 설정하는 SpContFact Service Implementation
 * 
 * @ClassName SpContFactServiceImpl.java
 * @Description SpContFactServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.16    최성연        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.03.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fms/spContFactService")
public class SpContFactServiceImpl extends DefaultServiceImpl implements SpContFactService {

	/** SpContFactDAO Bean 생성 */
	@Resource(name = "/fm/fms/spContFactDAO")
	private SpContFactDAO spContFactDAO;
	

	/**
	 * 업장별 창고리스트 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectSubinv(Map<String, Object> mapParam) throws Exception {
		return spContFactDAO.selectSubinv(mapParam);
	}
	
	
	/**
	 * 품목별 특약율을 설정 목록을 조회한다.
	 * <pre>
	 * - 중분류, 소분류, 품목별 LIST
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectGroup(Map<String, Object> mapParam) throws Exception {
		mapParam.put("schClassType", "S");
		return spContFactDAO.selectClass(mapParam);
	}
	public RecordSet selectClass(Map<String, Object> mapParam) throws Exception {
		mapParam.put("schClassType", "D");
		return spContFactDAO.selectClass(mapParam);
	}
	public RecordSet selectItem(Map<String, Object> mapParam) throws Exception {
		return spContFactDAO.selectItem(mapParam);
	}
	public RecordSet selectItem2(Map<String, Object> mapParam) throws Exception {
		return spContFactDAO.selectItem2(mapParam);
	}

	/**
	 * 품목별 특약율 관련 기준일자 목록을 조회한다.
	 * <pre>
	 * - 기준일자 LIST
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectDateList(Map<String, Object> mapParam) throws Exception {
		return spContFactDAO.selectDateList(mapParam);
	}
	
	
	/**
	 * 선택한 본사에 대한 창고리스트 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectSub(Map<String, Object> mapParam) throws Exception {
		return spContFactDAO.selectSub(mapParam);
	}	
	
	/**
	 * 특약율 일괄복사를 위한 자료여부 COUNT 
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public int selectSubCnt(Map<String, Object> mapParam) throws Exception {
		return spContFactDAO.selectSubCnt(mapParam);
	}	
	
	
	/**
	 * 품목별 특약율을 설정 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 중분류/소분류에 대한 특약율 저장
	 * </pre>
	 *
	 * @param loginParameter
	 *            Login 세션
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveGroup(LoginDTO loginParameter,DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			// 일괄 삭제 후에 INSERT 하는 방식으로 처리해야 한다.(한번만 실행)
			if (i==0) {
				//System.out.println("clsLvl : " + rowData.get("clsLvl"));
				delRowCnt = spContFactDAO.deleteGroup(rowData);
			}

			// DataSet RowType과는 상관없이 INSERT 한다
			insRowCnt += spContFactDAO.insertGroup(rowData);

		}
		
		if (insRowCnt > 0) {
			Map<String, Object> rowData = list.get(0);
			// 종료일자는 중분류, 소분류기준으로 한번씩 UDPATE한다 : 2016-02-03
			rowData.put("clsLvl", "S");
			spContFactDAO.updateGroup(rowData);
			rowData.put("clsLvl", "D");
			spContFactDAO.updateGroup(rowData);
		}

		return insRowCnt;
	}

	
	/**
	 * 품목별 특약율을 설정 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 자재별에 대한 특약율 저장
	 * </pre>
	 *
	 * @param loginParameter
	 *            Login 세션
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveItem(LoginDTO loginParameter,DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int delRowCnt = 0;
		String bChk = "";
		String itemCode = "";			// 자재코드
		String fmSaleRate = "";
		String fmNosaleRate = "";
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			//System.out.println("insert ROW : " + (i+1) + " ITEM_CODE : " + rowData.get("itemCode").toString());
			
			itemCode = rowData.get("itemCode").toString();
			
			if (rowData.get("fmSaleRate")== null) fmSaleRate = "0"; 
			else fmSaleRate = rowData.get("fmSaleRate").toString();
			if (rowData.get("fmNosaleRate")== null) fmNosaleRate = "0";
			else fmNosaleRate = rowData.get("fmNosaleRate").toString();

			if (("0".equals(fmSaleRate)) && ("0".equals(fmNosaleRate))) bChk = "1";
			else bChk = "";
			
			// 일괄 삭제 후에 INSERT 하는 방식으로 처리해야 한다.(한번만 실행)
			if (i==0) {
				delRowCnt = spContFactDAO.deleteItem(rowData);
			}

			// 엑셀업로드 시 혹시 자재코드가 없는 경우는 그냥 Pass 한다	
			if (!"".equals(itemCode) && ("".equals(bChk))) {
				 //System.out.println("insert ROW : " + (i+1) + " ITEM_CODE : " + rowData.get("itemCode").toString());
				
				// DataSet RowType과는 상관없이 INSERT 한다
				insRowCnt += spContFactDAO.insertItem(rowData);
			}	
		}
				
		if (insRowCnt > 0) {
			Map<String, Object> rowData = list.get(0);
			// 종료일자를 UPDATE
			spContFactDAO.updateItem(rowData);
		}
		
		
		return insRowCnt;
	}
	

	/**
	 * 품목별 특약율을 설정 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 자재별에 대한 특약율 삭제
	 * </pre>
	 *
	 * @param loginParameter
	 *            Login 세션
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int deleteItem2(LoginDTO loginParameter,DataSetMap list) throws Exception {
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			delRowCnt = spContFactDAO.deleteItem2(rowData);

			if (delRowCnt > 0) {
				// 종료일자를 UPDATE
				spContFactDAO.updateItem2(rowData);
			}
		}
		return delRowCnt;
	}
	
	
	

	/**
	 * 품목별 특약율을 선택한 창고로 일괄복사한다.
	 *
	 * @param loginParameter
	 *            Login 세션
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveSub(DataSetMap list, DataSetMap list1) throws Exception {
		int insRowCnt1 = 0;
		int insRowCnt2 = 0;
		int delRowCnt1 = 0;
		int delRowCnt2 = 0;
		int updRowCnt1 = 0;
		int updRowCnt2 = 0;
		String schUpjang = "";			// 조건_업장코드
		String schSubinvCode = "";		// 조건_창고코드
		String schSdate = "";			// 조건_기준일자
		String schCashCode = "";		// 조건_현금성분류
		String schStdDate = "";			// 적용일자
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			schUpjang = rowData.get("schUpjang").toString();
			schSubinvCode = rowData.get("schSubinvCode").toString();
			schCashCode = rowData.get("schCashCode").toString();
			schSdate = rowData.get("schSdate").toString();
			schStdDate = rowData.get("schStdDate").toString();
		}	
		
		for (int i = 0 ; i < list1.size() ; i++) {
			Map<String, Object> rowData = list1.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			// 일괄복사를 위한 조건을 설정한다
			rowData.put("schUpjang", schUpjang);
			rowData.put("schSubinvCode", schSubinvCode);
			rowData.put("schCashCode", schCashCode);
			rowData.put("schSdate", schSdate);
			rowData.put("schStdDate", schStdDate);
			
			//System.out.println("schUpjang : " + schUpjang);
			//System.out.println("schSubinvCode : " + schSubinvCode);
			//System.out.println("schSdate : " + schStdDate);
			//System.out.println("schCashCode : " + schCashCode);
			
			// 자료여부와 상관없이 일괄 삭제 : 분류별
			delRowCnt1 += spContFactDAO.deleteSub(rowData);
			// 자료여부와 상관없이 일괄 삭제 : 자재별
			delRowCnt2 += spContFactDAO.deleteSubItem(rowData);
			
			// DataSet RowType과는 상관없이 INSERT 한다 : 분류별 복사
			insRowCnt1 += spContFactDAO.insertSub(rowData);
			// DataSet RowType과는 상관없이 INSERT 한다 : 자재별 복사
			insRowCnt2 += spContFactDAO.insertSubItem(rowData);
			
			
			if (insRowCnt1 > 0) {
				// 분류별 종료일자를 UPDATE
				updRowCnt1 += spContFactDAO.updateSub(rowData);
			}

			if (insRowCnt2 > 0) {
				// 자재별 종료일자를 UPDATE
				updRowCnt2 += spContFactDAO.updateSubItem(rowData);
			}
			
			
		}
		return insRowCnt1 + insRowCnt2;
	}
	
	
}
