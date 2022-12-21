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
import com.hwfs.rc.rrm.dao.ExpectPoQtyEstDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 식재 예상 구매량 추정을 관리하는 ExpectPoQtyEst Implementation
 * 
 * @ClassName ExpectPoQtyEstServiceImpl.java
 * @Description ExpectPoQtyEstServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016.07.11    백승현        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 백승현
 * @since 2016.07.27
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */

@Service("/rc/rrm/expectPoQtyEstService")
public class ExpectPoQtyEstServiceImpl extends DefaultServiceImpl implements ExpectPoQtyEstService
{
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** RecipeListDAO Bean 생성 */
	@Resource(name = "/rc/rrm/expectPoQtyEstDAO")
	private ExpectPoQtyEstDAO expectPoQtyEstDAO;
	
	/**
	 * 레시피 목록을 조회한다.
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
			return expectPoQtyEstDAO.selectList(mapParam);
	}

	/**
	 * 식재 목록을 조회한다.
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
			return expectPoQtyEstDAO.selectDetailList(mapParam);
	}

	/**
	 * 예상판매량을 저장한다.
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

		for( int i = 0; i < list.size(); i++ )
		{
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			if( rowType == DataSet.ROW_TYPE_UPDATED )
			{
				insRowCnt += expectPoQtyEstDAO.saveList(rowData);
			}
		}

		return insRowCnt;
	}

	/**
	 * 예상판매량을 삭제한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	public int deleteList(Map<String, Object> mapParam) throws Exception
	{
		int insRowCnt = 0;

		insRowCnt += expectPoQtyEstDAO.deleteList(mapParam);

		return insRowCnt;
	}
}