package com.hwfs.rc.rrm.service;

import hone.core.util.record.RecordSet;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rrm.dao.RecipeListDAO;

 /**
 * 레시피를 관리하는 RecipeList Service Implementation
 * 
 * @ClassName RecipeListServiceImpl.java
 * @Description RecipeListServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016.07.11    백승현        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 백승현
 * @since 2016.07.11
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */

@Service("/rc/rrm/recipeListService")
public class RecipeListServiceImpl extends DefaultServiceImpl implements RecipeListService
{
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** RecipeListDAO Bean 생성 */
	@Resource(name = "/rc/rrm/recipeListDAO")
	private RecipeListDAO recipeListDAO;
	
	/**
	 * 레시피를 조회한다.
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
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception
	{
		String gubun = (String) mapParam.get("gubun");

		if( gubun.equals("2") )
		{
			return recipeListDAO.selectUpjangRecipeList(mapParam);
		}
		else if( gubun.equals("3") )
		{
			return recipeListDAO.selectSmlRecipeList(mapParam);
		}
		else
		{
			return recipeListDAO.selectStdRecipeList(mapParam);
		}
	}

	/**
	 * 레시피 상세를 조회한다.
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
	public RecordSet selectRecipeDetail(Map<String, Object> mapParam) throws Exception
	{
		String gubun = (String) mapParam.get("gubun");
		
		if( gubun.equals("2") )
		{
			return recipeListDAO.selectUpjangRecipeDetail(mapParam);
		}
		else if( gubun.equals("3") )
		{
			return recipeListDAO.selectSmlRecipeDetail(mapParam);
		}
		else
		{
			return recipeListDAO.selectStdRecipeDetail(mapParam);
		}
	}

	/**
	 * 표준 레시피 조리법을 저장한다.
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
	public int saveList(Map<String, Object> mapParam) throws Exception {
		int insRowCnt = 0;
		int delRowCnt = 0;

		delRowCnt += recipeListDAO.deleteList(mapParam);
		insRowCnt += recipeListDAO.saveList(mapParam);
				
		return insRowCnt + delRowCnt;
	}
}