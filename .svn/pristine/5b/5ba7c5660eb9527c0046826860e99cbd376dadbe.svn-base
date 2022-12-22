package com.hwfs.rc.rrm.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.sql.ResultSet;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rrm.dao.RecipeBatchChangeDAO;

 /**
 * 업장 레시피 품목을 일괄 변경하는 RecipeBatchChange Service Implementation
 * 
 * @ClassName RecipeBatchChangeServiceImpl.java
 * @Description RecipeBatchChangeServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.21    Yu        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 Yu
 * @since 2015.04.21
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rrm/recipeBatchChangeService")
public class RecipeBatchChangeServiceImpl extends DefaultServiceImpl implements RecipeBatchChangeService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** RecipeBatchChangeDAO Bean 생성 */
	@Resource(name = "/rc/rrm/recipeBatchChangeDAO")
	private RecipeBatchChangeDAO recipeBatchChangeDAO;
	

	/**
	 * 업장 레시피 품목 일괄 변경 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return recipeBatchChangeDAO.selectList(mapParam);
	}

	/**
	 * 업장 레시피 품목 일괄 변경 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap list, Map<String, Object> mapParam) throws Exception
	{
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;

		if( mapParam.get("roleType").equals("A") )
		{
			for( int i = 0; i < list.size(); i++ )
			{
				Map<String, Object> rowData = list.get(i);
				
				if(rowData.get("chk").equals("1") && rowData.get("upjangModifyAllowYn").equals("Y"))
				{
					// 변경 자재 등록
					//insRowCnt += recipeBatchChangeDAO.saveNewItem(rowData);
					
					//변경 후 자재가 레시피에 있으면 우선 삭제(업장) 2017.02.17(김호석)
					delRowCnt = recipeBatchChangeDAO.deleteUpjang(rowData);				
					
					// 기투입자재 종료일자 변경
					updRowCnt += recipeBatchChangeDAO.updateOldItem(rowData);

					// 관리테이블 이력 등록
					insRowCnt += recipeBatchChangeDAO.saveLog(rowData);
				}
			}
		}
		else
		{
			for( int i = 0; i < list.size(); i++ )
			{
				Map<String, Object> rowData = list.get(i);
				
				if(rowData.get("chk").equals("1") && rowData.get("upjangModifyAllowYn").equals("Y"))
				{
					// 변경 요청 등록
					insRowCnt += recipeBatchChangeDAO.insert(rowData);
				}
			}
		}
			
		return insRowCnt + updRowCnt;
	}
}
