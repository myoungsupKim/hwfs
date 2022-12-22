package com.hwfs.rc.rrm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.util.StringUtil;
import com.hwfs.rc.rrm.dao.RecipeDetailedMgntDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 업장 레시피 상세를 관리하는 RecipeDetailedMgnt Service Implementation
 * 
 * @ClassName RecipeDetailedMgntServiceImpl.java
 * @Description RecipeDetailedMgntServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.10    Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.04.10
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rrm/recipeDetailedMgntService")
public class RecipeDetailedMgntServiceImpl extends DefaultServiceImpl implements RecipeDetailedMgntService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** RecipeDetailedMgntDAO Bean 생성 */
	@Resource(name = "/rc/rrm/recipeDetailedMgntDAO")
	private RecipeDetailedMgntDAO recipeDetailedMgntDAO;
	

	/**
	 * 업장 레시피 목록을 조회한다.
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
		return recipeDetailedMgntDAO.selectList(mapParam);
	}

	/**
	 * 업장 레시피 상세 목록을 조회한다.
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
	public RecordSet selectListDtl(Map<String, Object> mapParam) throws Exception {
		return recipeDetailedMgntDAO.selectListDtl(mapParam);
	}

	/**
	 * 업장 레시피 상세 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap list,DataSetMap dtllist) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			if (rowType == DataSet.ROW_TYPE_UPDATED) {
				logger.debug("rowData " + rowData.toString());
				logger.debug("rowData.get('setRecipeCd') " + rowData.get("setRecipeCd"));
				logger.debug("rowData.get('oldSetRecipeCd') " + rowData.get("oldSetRecipeCd"));
				updRowCnt += recipeDetailedMgntDAO.updateMst(rowData);
				if((rowData.get("oldSetRecipeCd") != null || rowData.get("setRecipeCd") == null) && !rowData.get("setRecipeCd").toString().equals(rowData.get("oldSetRecipeCd").toString())){
					recipeDetailedMgntDAO.setRecipeDelMst(rowData);
				}
				//반찬세트 저장	-- 변경된 경웅만 저장
				if(rowData.get("setRecipeCd") != null && !"".equals(rowData.get("setRecipeCd").toString()) && !rowData.get("setRecipeCd").toString().equals(rowData.get("oldSetRecipeCd").toString())){
					recipeDetailedMgntDAO.setRecipeUpdateMst(rowData);
				}
			}
		}
		for (int i = 0 ; i < dtllist.size() ; i++) {
			Map<String, Object> rowData = dtllist.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += recipeDetailedMgntDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				
				//시작일자 변경(O) 식자재 변경(X)
				if(!StringUtil.isEmpty(rowData.get("orgSdate")) && StringUtil.isEmpty(rowData.get("orgMaterialCd"))){
					
					//시작일자 수정
					updRowCnt += recipeDetailedMgntDAO.updateSdate(rowData);
					
					//종료일자 수정
					//rowData.put("gubun", "2");
					updRowCnt += recipeDetailedMgntDAO.updateEdatePrvsMaterial(rowData);
					
				//시작일자 변경(O) 식자재 변경(O)
				}else if(!StringUtil.isEmpty(rowData.get("orgSdate")) && !StringUtil.isEmpty(rowData.get("orgMaterialCd"))){
					
					//새로등록
					rowData.put("edate", "29991231");
					rowData.put("prvsMaterialCd", rowData.get("orgMaterialCd"));
					insRowCnt += recipeDetailedMgntDAO.insert(rowData);
					
					//종료일 수정(품목이 새로 등록되는 시작일자 -1)
					rowData.put("materialCd", rowData.get("orgMaterialCd"));
					//rowData.put("gubun", "1");
					updRowCnt += recipeDetailedMgntDAO.updateEdate(rowData);
					
				//시작일자 변경(X) 식자재 변경(O)
				}else if(StringUtil.isEmpty(rowData.get("orgSdate")) && !StringUtil.isEmpty(rowData.get("orgMaterialCd"))){
					
					//식자재 변경
					updRowCnt += recipeDetailedMgntDAO.updateMaterialCd(rowData);
					
				//시작일자 변경(X) 식자재 변경(X)
				}else{
					updRowCnt += recipeDetailedMgntDAO.update(rowData);
				}
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += recipeDetailedMgntDAO.delete(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 업장 레시피 상세 목록을 조회한다.
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
	public RecordSet selectRsr(Map<String, Object> mapParam) throws Exception {
		return recipeDetailedMgntDAO.selectRsr(mapParam);
	}
	
}
