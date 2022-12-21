package com.hwfs.rc.rrm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rrm.dao.RecipeClassCodeMgntDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 레시피 분류 코드를 관리하는 RecipeClassCodeMgnt Service Implementation
 * 
 * @ClassName RecipeClassCodeMgntServiceImpl.java
 * @Description RecipeClassCodeMgntServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.24    유인찬        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유인찬
 * @since 2015.03.24
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rrm/recipeClassCodeMgntService")
public class RecipeClassCodeMgntServiceImpl extends DefaultServiceImpl implements RecipeClassCodeMgntService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** RecipeClassCodeMgntDAO Bean 생성 */
	@Resource(name = "/rc/rrm/recipeClassCodeMgntDAO")
	private RecipeClassCodeMgntDAO recipeClassCodeMgntDAO;
	

	/**
	 * 레시피 분류 코드 목록을 조회한다.
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
		if(mapParam.get("codeGb").equals("M")){
			return recipeClassCodeMgntDAO.selectListMcalss(mapParam);
		}else if(mapParam.get("codeGb").equals("S")){
			return recipeClassCodeMgntDAO.selectListSclass(mapParam);
		}
		return recipeClassCodeMgntDAO.selectListMgrp(mapParam);
	}
	
	/**
	 * 
	 * 레시피 분류코드 중복을 체크한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.rrm.service.RecipeClassCodeMgntService#selectRecipeCodeExists(java.util.Map)
	 */
	public int selectExists(Map<String, Object> mapParam) throws Exception{
		if(mapParam.get("codeGb").equals("M")){
			return recipeClassCodeMgntDAO.selectMcalssExists(mapParam);
		}else if(mapParam.get("codeGb").equals("S")){
			return recipeClassCodeMgntDAO.selectSclassExists(mapParam);
		}
		return recipeClassCodeMgntDAO.selectMgrpExists(mapParam);
	}

	/**
	 * 레시피 분류 코드 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
			String codeGb = (String)rowData.get("codeGb");
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				if(codeGb.equals("G")){
					insRowCnt += recipeClassCodeMgntDAO.insertMgrp(rowData);
				}else if(codeGb.equals("M")){
					insRowCnt += recipeClassCodeMgntDAO.insertMcalss(rowData);
				}else{
					insRowCnt += recipeClassCodeMgntDAO.insertSclass(rowData);
				}
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				if(codeGb.equals("G")){
					updRowCnt += recipeClassCodeMgntDAO.updateMgrp(rowData);
				}else if(codeGb.equals("M")){
					updRowCnt += recipeClassCodeMgntDAO.updateMcalss(rowData);
				}else{
					updRowCnt += recipeClassCodeMgntDAO.updateSclass(rowData);
				}
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				if(codeGb.equals("G")){
					delRowCnt += recipeClassCodeMgntDAO.deleteMgrp(rowData);
				}else if(codeGb.equals("M")){
					delRowCnt += recipeClassCodeMgntDAO.deleteMcalss(rowData);
				}else{
					delRowCnt += recipeClassCodeMgntDAO.deleteSclass(rowData);
				}
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 레시피 분류 코드 단계별 모든 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectListAll(Map<String, Object> mapParam) throws Exception{
		if(mapParam.get("codeGb").equals("M")){
			return recipeClassCodeMgntDAO.selectListMcalssAll(mapParam);
		}else if(mapParam.get("codeGb").equals("S")){
			return recipeClassCodeMgntDAO.selectListSclassAll(mapParam);
		}
		return recipeClassCodeMgntDAO.selectListMgrp(mapParam);
	}
}
