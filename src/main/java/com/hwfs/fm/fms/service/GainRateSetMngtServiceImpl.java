package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fms.dao.GainRateSetMngtDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 이익율을 설정하는 GainRateSetMngt Service Implementation
 * 
 * @ClassName GainRateSetMngtServiceImpl.java
 * @Description GainRateSetMngtServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.10    최성연        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.03.10
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fms/gainRateSetMngtService")
public class GainRateSetMngtServiceImpl extends DefaultServiceImpl implements GainRateSetMngtService {
	
	/** GainRateSetMngtDAO Bean 생성 */
	@Resource(name = "/fm/fms/gainRateSetMngtDAO")
	private GainRateSetMngtDAO gainRateSetMngtDAO;
	

	/**
	 * 팀 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectTm(Map<String, Object> mapParam) throws Exception {
		return gainRateSetMngtDAO.selectTm(mapParam);
	}
	
	/**
	 *단가계약업장 DATA를 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectStd(Map<String, Object> mapParam) throws Exception {
		return gainRateSetMngtDAO.selectStd(mapParam);
	}
	
	
	
	/**
	 * 판매그룹 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	@Override
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return gainRateSetMngtDAO.selectList(mapParam);
	}
	

	/**
	 * 판매그룹 정보를 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList(LoginDTO loginParameter,DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		int delCnt = 0;		// 하위정보 삭제여부를 위한 Flag
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += gainRateSetMngtDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += gainRateSetMngtDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delCnt = gainRateSetMngtDAO.delete(rowData);
				delRowCnt += delCnt;
				
				// 하위의 이익율 관리 정보도 모두 삭제함(분류, 자재)
				if (delCnt>0) {
					// 분류별 이익율 정보 삭제
					gainRateSetMngtDAO.deleteClass(rowData);
					// 자재별 이익율 정보 삭제
					gainRateSetMngtDAO.deleteItemAll(rowData);
				}
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 자재 대분류별 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	@Override
	public RecordSet selectClassCode(Map<String, Object> mapParam) throws Exception {
		return gainRateSetMngtDAO.selectClassCode(mapParam);
	}
		
	
	
	/**
	 * 분류별 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	@Override
	public RecordSet selectClass(Map<String, Object> mapParam) throws Exception {
		return gainRateSetMngtDAO.selectClass(mapParam);
	}
	

	/**
	 * 업장 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	@Override
	public RecordSet selectUpjang(Map<String, Object> mapParam) throws Exception {
		return gainRateSetMngtDAO.selectUpjang(mapParam);
	}
	
	
	/**
	 * 자재별 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	@Override
	public RecordSet selectItem(Map<String, Object> mapParam) throws Exception {
		return gainRateSetMngtDAO.selectItem(mapParam);
	}
	
	
	/**
	 * 자재별 목록을 조회한다.테마자재
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	@Override
	public RecordSet selectTheme(Map<String, Object> mapParam) throws Exception {
		return gainRateSetMngtDAO.selectTheme(mapParam);
	}

	/**
	 * 자재별 이익율 현황을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	@Override
	public RecordSet selectGainList(Map<String, Object> mapParam) throws Exception {
		return gainRateSetMngtDAO.selectGainList(mapParam);
	}
	public RecordSet selectGainList2(Map<String, Object> mapParam) throws Exception {
		return gainRateSetMngtDAO.selectGainList2(mapParam);
	}
	
	/**
	 * 추가할 자재를 검색한다.
	 * <pre>
	 * 팝업화면(GainRateItemSearchPop)
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	@Override
	public RecordSet selectItemPop(Map<String, Object> mapParam) throws Exception {
		return gainRateSetMngtDAO.selectItemPop(mapParam);
	}
	
	
	/**
	 * 분류별 이익율 정보를 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	@Override
	public int saveClass(LoginDTO loginParameter,DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			//int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			// 일괄 삭제 후에 INSERT 하는 방식으로 처리해야 한다.(한번만 실행)
			if (i==0) {
				delRowCnt = gainRateSetMngtDAO.deleteClass(rowData);
			}

			// DataSet RowType과는 상관없이 INSERT 한다
			insRowCnt += gainRateSetMngtDAO.insertClass(rowData);
		}
				
		return insRowCnt;
	}
	

	
	/**
	 * 자재별 이익율 정보를 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * 삭제 후 일괄저장 방식
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	@Override
	public int saveItem(LoginDTO loginParameter,DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String bChk = "";
		String saleRate = "";
		String fixedPrice = "";
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			if (rowData.get("saleRate")== null) saleRate = "0"; 
			else saleRate = rowData.get("saleRate").toString();
			if (rowData.get("fixedPrice")== null) fixedPrice = "0";
			else fixedPrice = rowData.get("fixedPrice").toString();
			
			
			
			if (("0".equals(saleRate)) && ("0".equals(fixedPrice))) bChk = "1";
			else bChk = "";
			
			
			// 일괄삭제 후 INSERT 처리
			if (i==0) {
				delRowCnt = gainRateSetMngtDAO.deleteItemAll(rowData);
			}

			// 판매율, 고정단가가 모두 0인 자료는 PASS
			if ("".equals(bChk)) {
				 //System.out.println("insert ROW : " + (i+1) + " ITEM_CODE : " + rowData.get("itemCode").toString());
				
				// DataSet RowType과는 상관없이 INSERT 한다
				insRowCnt += gainRateSetMngtDAO.insertItem(rowData);
			}	
			
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	

	/**
	 * 자재별 이익율 정보를 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * 변경된 내역만 저장
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	@Override
	public int saveItem2(LoginDTO loginParameter,DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int delRowCnt = 0;
		String bChk = "";
		String saleRate = "";
		String fixedPrice = "";
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			if (rowData.get("saleRate")== null) saleRate = "0"; 
			else saleRate = rowData.get("saleRate").toString();
			if (rowData.get("fixedPrice")== null) fixedPrice = "0";
			else fixedPrice = rowData.get("fixedPrice").toString();
			
			if (("0".equals(saleRate)) && ("0".equals(fixedPrice))) bChk = "1";
			else bChk = "";
			
			// 판매율, 고정단가가 모두 0인 자료는 PASS
			if ("".equals(bChk)) {
				// 삭제
				delRowCnt = gainRateSetMngtDAO.deleteItem(rowData);
				// 저장
				insRowCnt += gainRateSetMngtDAO.insertItem(rowData);
			}	
			
		}
				
		return insRowCnt;
	}
	

	/**
	 * 테마자재별 이익율 정보를 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * 변경된 내역만 저장
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	@Override
	public int saveTheme(LoginDTO loginParameter,DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int delRowCnt = 0;
		String bChk = "";
		String saleRate = "";
		String fixedPrice = "";
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			if (rowData.get("saleRate")== null) saleRate = "0"; 
			else saleRate = rowData.get("saleRate").toString();
			if (rowData.get("fixedPrice")== null) fixedPrice = "0";
			else fixedPrice = rowData.get("fixedPrice").toString();
			
			if (("0".equals(saleRate)) && ("0".equals(fixedPrice))) bChk = "1";
			else bChk = "";
			
			// 판매율, 고정단가가 모두 0인 자료는 PASS
			if ("".equals(bChk)) {
				// 삭제
				delRowCnt = gainRateSetMngtDAO.deleteTheme(rowData);
				// 저장
				insRowCnt += gainRateSetMngtDAO.insertTheme(rowData);
			}	
			
		}
				
		return insRowCnt;
	}

	
	/**
	 * 자재별 이익율 정보를 Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	@Override
	public int deleteItem(LoginDTO loginParameter,DataSetMap list) throws Exception {
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			//Delete 처리.
			if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += gainRateSetMngtDAO.deleteItem(rowData);
			}
			
		}
				
		return delRowCnt;
	}

	
	/**
	 * 테마자재별 이익율 정보를 Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	@Override
	public int deleteTheme(LoginDTO loginParameter,DataSetMap list) throws Exception {
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			//Delete 처리.
			if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += gainRateSetMngtDAO.deleteTheme(rowData);
			}
			
		}
				
		return delRowCnt;
	}
	
	
	/**
	 * 자재별 이익율 정보를 Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int rateCopy(DataSetMap upjangList,Map<String, Object> mapParam) throws Exception {
		int udpRowCnt = 0;
		
		for (int u = 0 ; u < upjangList.size() ; u++) {
			Map<String, Object> rowData = upjangList.get(u);
			rowData.put("upjang",mapParam.get("upjang"));
			//선택한 업장.
			if("1".equals(rowData.get("stdChk").toString())){
				//해당업장에 이익율 정보 삭제.
				gainRateSetMngtDAO.deleteAll(rowData);
				
				gainRateSetMngtDAO.classCopy(rowData);
			}
			udpRowCnt++;
		}
				
		return udpRowCnt;
	}
}
