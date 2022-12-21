package com.hwfs.rc.rrm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rrm.dao.SmlRecipeMgntDAO;

/**
 * 가상레시피 등록 현황을 관리하는 SmlRecipeMgnt Service Implementation
 *
 * @ClassName SmlRecipeMgntServiceImpl.java
 * @Description SmlRecipeMgntServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016.08.26    백승현        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 백승현
 * @since 2016.08.26
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */

@Service("/rc/rrm/smlRecipeMgntService")
public class SmlRecipeMgntServiceImpl extends DefaultServiceImpl implements SmlRecipeMgntService
{
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SmlRecipeMgntDAO Bean 생성 */
	@Resource(name = "/rc/rrm/smlRecipeMgntDAO")
	private SmlRecipeMgntDAO smlRecipeMgntDAO;

	/**
	 * 가상레시피 등록 현황을 조회한다.
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
		return smlRecipeMgntDAO.selectList(mapParam);
	}

	/**
	 * 가상레시피를 표준레시피로 등록 요청한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public int requestList(DataSetMap list) throws Exception
	{
		int updRowCnt = 0;

		for( int i = 0; i < list.size(); i++ )
		{
			Map<String, Object> rowData = list.get(i);

			if( rowData.get("chk").equals("1") )
			{
				rowData.put("status", "01");
				updRowCnt += smlRecipeMgntDAO.updateRequest(rowData);
				
			}
		}

		return updRowCnt;
	}

	/**
	 * 표준레시피 등록 요청을 승인처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap list) throws Exception
	{
		int updRowCnt = 0;

		for( int i = 0; i < list.size(); i++ )
		{
			Map<String, Object> rowData = list.get(i);

			if( rowData.get("chk").equals("1") )
			{
				rowData.put("status", "02");
				updRowCnt += smlRecipeMgntDAO.updateStatus(rowData);
				updRowCnt += smlRecipeMgntDAO.updateStdRecipe(rowData);
			}
		}

		return updRowCnt;
	}

	/**
	 * 표준레시피 등록 요청을 요청취소 처리한다.
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

			if( rowData.get("chk").equals("1") )
			{
				rowData.put("status", "99");
				updRowCnt += smlRecipeMgntDAO.updateStatus(rowData);
			}
		}

		return updRowCnt;
	}
}