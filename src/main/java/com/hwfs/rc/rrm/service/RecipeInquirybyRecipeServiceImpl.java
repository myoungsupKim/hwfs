package com.hwfs.rc.rrm.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rrm.dao.RecipeInquirybyRecipeDAO;

 /**
 * 업장 레시피를 조회(by Recipe)하는 RecipeInquirybyRecipe Service Implementation
 * 
 * @ClassName RecipeInquirybyRecipeServiceImpl.java
 * @Description RecipeInquirybyRecipeServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.17    Y        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Y
 * @since 2015.04.17
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rrm/recipeInquirybyRecipeService")
public class RecipeInquirybyRecipeServiceImpl extends DefaultServiceImpl implements RecipeInquirybyRecipeService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** RecipeInquirybyRecipeDAO Bean 생성 */
	@Resource(name = "/rc/rrm/recipeInquirybyRecipeDAO")
	private RecipeInquirybyRecipeDAO recipeInquirybyRecipeDAO;
	

	/**
	 * 업장 레시피 조회(by Recipe) 목록을 조회한다.
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

		//레시피 내역 가장 상단의 레시피 조회
		RecordSet rs = recipeInquirybyRecipeDAO.selectRecipe(mapParam);
		
		int level = Integer.parseInt(mapParam.get("treeLevel").toString());
		
		//레시피 level1 검색
		mapParam.put("treeLevel", "1");
		RecordSet rsDtl = recipeInquirybyRecipeDAO.selectList(mapParam);
		
		if(level > 1){
			selectRecipeDetail(rsDtl, rs, level, 2, mapParam);
		}else{
			addRecordSetToRecordSet(rs, rsDtl);	//RecordSet에 추가
		}
		
		return rs;
	}
	
	/**
	 * 
	 * 레시피 상세 조회 재귀함수
	 * 
	 * @param rs 검색된 RecordSet
	 * @param rsSave 저장할 RecordSet
	 * @param schLevel 검색할 단계
	 * @param currLevel  현재 단계
	 * @param mapParam   조회조건
	 * @throws Exception
	 */
	public void selectRecipeDetail(RecordSet rs, RecordSet rsSave, int schLevel, int currLevel, Map<String, Object> mapParam) throws Exception {
		RecordSet rsTemp;
		
		if(rs != null && rs.size() > 0){
				
			for(int i=0; i<rs.size(); i++){
				Record record = rs.get(i);
				rsSave.add(record);
				
				if(record.get("semiGoodsYn").equals("Y")){
					mapParam.put("stdRecipeCd", record.get("materialCd"));
					mapParam.put("treeLevel", currLevel);
					rsTemp = recipeInquirybyRecipeDAO.selectList(mapParam);
					
					if(currLevel <= schLevel){
						selectRecipeDetail(rsTemp, rsSave, schLevel, currLevel+1, mapParam);
					}
				}
			}
		}
	}
	
	/**
	 * 
	 * 검색된 RecordSet을 저장할 RecordSet에 저장
	 *  
	 * @param rs
	 * @param rsFrom
	 */
	public void addRecordSetToRecordSet(RecordSet rs, RecordSet rsFrom){
		if(rsFrom != null && rsFrom.size() > 0){
			for(int i=0; i<rsFrom.size(); i++){
				rs.add(rsFrom.get(i));
			}
		}
	}

}
