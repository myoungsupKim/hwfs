package com.hwfs.rc.rrm.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rrm.dao.RecipeCopyDAO;

 /**
 * 표준 레시피를 복사하는 RecipeCopy Service Implementation
 * 
 * @ClassName RecipeCopyServiceImpl.java
 * @Description RecipeCopyServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.08    유인찬        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유인찬
 * @since 2015.04.08
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rrm/recipeCopyService")
public class RecipeCopyServiceImpl extends DefaultServiceImpl implements RecipeCopyService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** RecipeCopyDAO Bean 생성 */
	@Resource(name = "/rc/rrm/recipeCopyDAO")
	private RecipeCopyDAO recipeCopyDAO;
	

	/**
	 * 표준 레시피 복사 목록을 조회한다.
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
		return recipeCopyDAO.selectList(mapParam);
	}

	/**
	 * 표준 레시피 복사 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap list) throws Exception
	{
		int insRowCnt = 0;

		RecordSet rs = null;
		Record record = null;

		for( int i = 0; i < list.size(); i++ )
		{
			Map<String, Object> rowData = list.get(i);

			if( "1".equals(rowData.get("chk").toString()) )
			{
				rs = recipeCopyDAO.selectUpjangRecipe(rowData);
				record = rs.get(0);

				recipeCopyDAO.deleteUpjangRecipeMst(rowData);		// 업장레시피 마스터 삭제
				recipeCopyDAO.deleteUpjangRecipeDtl(rowData);		// 업장레시피 상세 삭제
				recipeCopyDAO.deleteUpjangRecipeCuisine(rowData);	// 업장레시피 조리법 삭제

				insRowCnt += recipeCopyDAO.saveUpjangRecipeMst(rowData);		// 업장레시피 마스터 저장
				insRowCnt += recipeCopyDAO.saveUpjangRecipeDtl(rowData);		// 업장레시피 상세 저장
				insRowCnt += recipeCopyDAO.saveUpjangRecipeCuisine(rowData);	// 업장레시피 조리법 저장
			}
		}

		return insRowCnt;
	}
}