package com.hwfs.rc.rrm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rrm.dao.RecipeBatchChangeMgntDAO;

 /**
 * 업장 레시피 자재 일괄 변경 이력을 관리하는 RecipeBatchChangeMgnt Service Implementation
 * 
 * @ClassName RecipeBatchChangeMgntServiceImpl.java
 * @Description RecipeBatchChangeMgntServiceImpl Class
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

@Service("/rc/rrm/recipeBatchChangeMgntService")
public class RecipeBatchChangeMgntServiceImpl extends DefaultServiceImpl implements RecipeBatchChangeMgntService
{
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** RecipeListDAO Bean 생성 */
	@Resource(name = "/rc/rrm/recipeBatchChangeMgntDAO")
	private RecipeBatchChangeMgntDAO recipeBatchChangeMgntDAO;
	
	/**
	 * 업장 레시피 자재 일괄 변경 이력을 조회한다.
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
			return recipeBatchChangeMgntDAO.selectList(mapParam);
	}

	/**
	 * 업장 레시피 자재 일괄 변경 상세이력을 조회한다.
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
	public RecordSet selectDetailList(Map<String, Object> mapParam) throws Exception
	{
			return recipeBatchChangeMgntDAO.selectDetailList(mapParam);
	}

	/**
	 * 업장 레시피 품목 일괄 변경 요청을 승인처리한다.
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
		int updRowCnt = 0;
		int delRowCnt = 0;

		for( int i = 0; i < list.size(); i++ )
		{
			Map<String, Object> rowData = list.get(i);
			
			if( rowData.get("chk").equals("1") )
			{
				// 새로운 재료 등록
				//insRowCnt += recipeBatchChangeMgntDAO.insert(rowData);
				
				//변경 후 자재가 레시피에 있으면 우선 삭제(업장) 2017.02.17(김호석)
				delRowCnt = recipeBatchChangeMgntDAO.deleteUpjang(rowData);		
				
				// 이전자재 종료일자 변경(새로운자재 시작일자-1)(업장)
				updRowCnt += recipeBatchChangeMgntDAO.updateEdate(rowData);

				// 체크된 레시피는 진행상태를 변경하고 체크안된 레시피는 처리일자를 넣어서 구분한다.
				// 진행상황 변경(신규요청 -> 처리완료)
				rowData.put("status", "02");
			}
			
			// 진행상황 수정
			updRowCnt += recipeBatchChangeMgntDAO.updateStatus(rowData);
		}
				
		return insRowCnt + updRowCnt;
	}

	/**
	 * 업장 레시피 품목 일괄 변경 요청을 요청취소 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public int cancelList(DataSetMap list) throws Exception
	{
		int updRowCnt = 0;

		for( int i = 0; i < list.size(); i++ )
		{
			Map<String, Object> rowData = list.get(i);

			// 체크된 레시피는 진행상태를 변경하고 체크안된 레시피는 처리일자를 넣어서 구분한다.
			if( rowData.get("chk").equals("1") )
			{
				// 진행상황 변경(신규요청 -> 미적용)
				rowData.put("status", "99");
			}

			// 진행상황 수정
			updRowCnt += recipeBatchChangeMgntDAO.updateStatus(rowData);
		}
		
		return updRowCnt;
	}
}