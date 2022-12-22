package com.hwfs.ma.map.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ma.map.dao.ImprovTaskMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 
 * @ClassName ImprovTaskMgmtServiceImpl.java
 * @Description ImprovTaskMgmtServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.01    안종남        최초생성
 * </pre>
 * @author 안종남
 * @since 2015.07.01
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ma/map/improvTaskMgmtService")
public class ImprovTaskMgmtServiceImpl extends DefaultServiceImpl implements ImprovTaskMgmtService {

 

    /**  Bean 생성 */
    @Resource(name = "/ma/map/improvTaskMgmtDAO")
    private ImprovTaskMgmtDAO improvTaskMgmtDAO;

   /**
     * controller에 정의
     * 
     * @param parameter
     *            조회조건 Map
     * @return RecordSet 
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectVerNm(Map<String, Object> parameter) throws Exception {
        return improvTaskMgmtDAO.selectVerNm(parameter);
    }
    
    /**
     * controller에 정의
     * 
     * @param parameter
     *            조회조건 Map
     * @return RecordSet 
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectMuInfo(Map<String, Object> parameter) throws Exception {
        return improvTaskMgmtDAO.selectMuInfo(parameter);
    }
    
    /**
     * controller에 정의
     * 
     * @param parameter
     *            조회조건 Map
     * @return RecordSet 
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectDeptInfo(Map<String, Object> parameter) throws Exception {
        return improvTaskMgmtDAO.selectDeptInfo(parameter);
    }
    
    
    /**
     * controller에 정의
     * 
     * @param parameter
     *            조회조건 Map
     * @return RecordSet 
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectMuCdForUpjang(Map<String, Object> parameter) throws Exception {
        return improvTaskMgmtDAO.selectMuCdForUpjang(parameter);
    }
    
    /**
     * controller에 정의
     * 
     * @param parameter
     *            조회조건 Map
     * @return RecordSet 
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectUpjangForSabun(Map<String, Object> parameter) throws Exception {
        return improvTaskMgmtDAO.selectUpjangForSabun(parameter);
    }
    
    
    /**
     * controller에 정의
     * 
     * @param parameter
     *            조회조건 Map
     * @return RecordSet 
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectMapImprovCodeMst(Map<String, Object> parameter) throws Exception {
        return improvTaskMgmtDAO.selectMapImprovCodeMst(parameter);
    }
    
    /**
     * controller에 정의
     * 
     * @param parameter
     *            조회조건 Map
     * @return RecordSet 
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectImprovCode(Map<String, Object> parameter) throws Exception {
        return improvTaskMgmtDAO.selectImprovCode(parameter);
    }
    
    /**
     * controller에 정의
     *
     * @param parameter
     *            저장조건 list
     * @return   
     *            저장결과   
     * @throws Exception
    */
    @SuppressWarnings("unchecked")
	@Override
	public int saveMapImprovCodeMst(DataSetMap list) throws Exception
    {
    	int insertRowCnt = 0;
		int updateRowCnt = 0;
		int deleteRowCnt = 0;
		
		
		for (int i = 0 ; i < list.size() ; i++) 
		{
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) 
			{
				insertRowCnt += improvTaskMgmtDAO.deleteMapImprovCodeMst(rowData);
			}
			
			else if (rowType == DataSet.ROW_TYPE_UPDATED) 
			{
				updateRowCnt += improvTaskMgmtDAO.deleteMapImprovCodeMst(rowData);
			}
			
			else if (rowType == DataSet.ROW_TYPE_DELETED) 
			{
				deleteRowCnt += improvTaskMgmtDAO.deleteMapImprovCodeMst(rowData);
			}
		}
		
		for (int i = 0 ; i < list.size() ; i++) 
		{
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			
			if (rowType == DataSet.ROW_TYPE_INSERTED || rowType == DataSet.ROW_TYPE_UPDATED ) 
			{
				insertRowCnt += improvTaskMgmtDAO.insertMapImprovCodeMst(rowData);
			}
		}
				
		return insertRowCnt + updateRowCnt + deleteRowCnt;
    	
    }
    
    /**
     * controller에 정의
     *
     * @param parameter
     *            저장조건 list
     * @return   
     *            저장결과   
     * @throws Exception
    */
    @SuppressWarnings("unchecked")
	@Override
	public int saveCopyMapImprovCodeMst(DataSetMap list) throws Exception
    {
    	int insertRowCnt = 0;
		int updateRowCnt = 0;
		int deleteRowCnt = 0;
		
		if( list.size() > 0 )
		{
			Map<String, Object> rowData = list.get(0);
			
			insertRowCnt += improvTaskMgmtDAO.deleteMapImprovCodeMstAll(rowData);
		}
		
		for (int i = 0 ; i < list.size() ; i++) 
		{
			Map<String, Object> rowData = list.get(i);
			
			//추가를 수행합니다.
			insertRowCnt += improvTaskMgmtDAO.insertMapImprovCodeMst(rowData);
		}
				
		return insertRowCnt + updateRowCnt + deleteRowCnt;
    	
    }
    
    /**
     * controller에 정의
     *
     * @param parameter
     *            삭제조건 list
     * @return   
     *            삭제결과   
     * @throws Exception
    */
    @SuppressWarnings("unchecked")
	@Override
	public int removeMapImprovCodeMst(DataSetMap list) throws Exception
    {
    	int deleteRowCnt = 0;
		
		Map<String, Object> rowData = list.get(0);
		deleteRowCnt = improvTaskMgmtDAO.deleteMapImprovCodeMst(rowData);
						
		return deleteRowCnt;	
    }
    

    /**
     * controller에 정의
     * 
     * @param parameter
     *            조회조건 Map
     * @return RecordSet 
     *            조회결과
     * @throws Exception
     */
    public RecordSet selectMapImprovMgtMst(Map<String, Object> parameter) throws Exception {
        return improvTaskMgmtDAO.selectMapImprovMgtMst(parameter);
    }
    
    
    /**
     * controller에 정의
     *
     * @param parameter
     *            저장조건 list
     * @return   
     *            저장결과   
     * @throws Exception
    */
    @SuppressWarnings("unchecked")
	@Override
	public int saveMapImprovMgtMst(DataSetMap list) throws Exception
    {
    	int insertRowCnt = 0;
		int updateRowCnt = 0;
		int deleteRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) 
		{
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//추가를 수행합니다.
			if (rowType == DataSet.ROW_TYPE_INSERTED) 
			{
				if( ((String)rowData.get("revYn")).equals("N") )
				{	
					insertRowCnt += improvTaskMgmtDAO.insertMapImprovMgtMst(rowData);
				}
				else if( ((String)rowData.get("revYn")).equals("Y") )
				{	
					insertRowCnt += improvTaskMgmtDAO.insertMapImprovMgtMstRev(rowData);
				}
			}
			//수정을 수행합니다.
			else if (rowType == DataSet.ROW_TYPE_UPDATED) 
			{
				updateRowCnt += improvTaskMgmtDAO.updateMapImprovMgtMst(rowData);
			}
			//삭제를 수행합니다.
			else if (rowType == DataSet.ROW_TYPE_DELETED) 
			{
				deleteRowCnt += improvTaskMgmtDAO.deleteAllMapImprovPlDtl(rowData);
				deleteRowCnt += improvTaskMgmtDAO.deleteMapImprovMgtMst(rowData);
			}
		}
				
		return insertRowCnt + updateRowCnt + deleteRowCnt;
    	
    }
    
    /**
     * controller에 정의
     *
     * @param parameter
     *            삭제조건 list
     * @return   
     *            삭제결과   
     * @throws Exception
    */
    @SuppressWarnings("unchecked")
	@Override
	public int removeMapImprovMgtMst(DataSetMap list) throws Exception
    {
    	int deleteRowCnt = 0;
		
		Map<String, Object> rowData = list.get(0);
		deleteRowCnt = improvTaskMgmtDAO.deleteMapImprovMgtMst(rowData);
						
		return deleteRowCnt;	
    }


    /**
	* controller에 정의
	* 
	* @param parameter
	*            조회조건 Map
	* @return RecordSet 
	*            조회결과
	* @throws Exception
	*/
	public RecordSet selectMapImprovSupportForEmpNo(Map<String, Object> parameter) throws Exception {
		return improvTaskMgmtDAO.selectMapImprovSupportForEmpNo(parameter);
	}
    
	/**
	* controller에 정의
	* 
	* @param parameter
	*            조회조건 Map
	* @return RecordSet 
	*            조회결과
	* @throws Exception
	*/
	public RecordSet selectMapImprovSupport(Map<String, Object> parameter) throws Exception {
		return improvTaskMgmtDAO.selectMapImprovSupport(parameter);
	}
	
	
	/**
	* controller에 정의
	*
	* @param parameter
	*            저장조건 list
	* @return   
	*            저장결과   
	* @throws Exception
	*/
	@SuppressWarnings("unchecked")
	@Override
	public int saveMapImprovSupport(DataSetMap list) throws Exception
	{
		int insertRowCnt = 0;
		int updateRowCnt = 0;
		int deleteRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) 
		{
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//추가를 수행합니다.
			if (rowType == DataSet.ROW_TYPE_INSERTED) 
			{
				insertRowCnt += improvTaskMgmtDAO.insertMapImprovSupport(rowData);
			}
			//수정을 수행합니다.
			else if (rowType == DataSet.ROW_TYPE_UPDATED) 
			{
				updateRowCnt += improvTaskMgmtDAO.updateMapImprovSupport(rowData);
			}
			//삭제를 수행합니다.
			else if (rowType == DataSet.ROW_TYPE_DELETED) 
			{
				deleteRowCnt += improvTaskMgmtDAO.deleteMapImprovSupport(rowData);
			}
		}
		
		return insertRowCnt + updateRowCnt + deleteRowCnt;
	
	}
	
	/**
	* controller에 정의
	*
	* @param parameter
	*            삭제조건 list
	* @return   
	*            삭제결과   
	* @throws Exception
	*/
	@SuppressWarnings("unchecked")
	@Override
	public int removeMapImprovSupport(DataSetMap list) throws Exception
	{
		int deleteRowCnt = 0;
		
		Map<String, Object> rowData = list.get(0);
		deleteRowCnt = improvTaskMgmtDAO.deleteMapImprovSupport(rowData);
		
		return deleteRowCnt;	
	}


	/**
	* controller에 정의
	* 
	* @param parameter
	*            조회조건 Map
	* @return RecordSet 
	*            조회결과
	* @throws Exception
	*/
	public RecordSet selectMapImprovPlDtl(Map<String, Object> parameter) throws Exception {
		return improvTaskMgmtDAO.selectMapImprovPlDtl(parameter);
	}
	
	/**
	* controller에 정의
	* 
	* @param parameter
	*            조회조건 Map
	* @return RecordSet 
	*            조회결과
	* @throws Exception
	*/
	public RecordSet selectMapImprovPlDtlSum(Map<String, Object> parameter) throws Exception {
		return improvTaskMgmtDAO.selectMapImprovPlDtlSum(parameter);
	}
	
	/**
	* controller에 정의
	*
	* @param parameter
	*            저장조건 list
	* @return   
	*            저장결과   
	* @throws Exception
	*/
	@SuppressWarnings("unchecked")
	@Override
	public int saveMapImprovPlDtl(DataSetMap list) throws Exception
	{
		int insertRowCnt = 0;
		
		Map<String, Object> rowData = list.get(0);
		improvTaskMgmtDAO.deleteAllMapImprovPlDtl(rowData);
		
		for (int i = 0 ; i < list.size() ; i++) 
		{
			rowData = list.get(i);
			
			//추가를 수행합니다.
			insertRowCnt += improvTaskMgmtDAO.insertMapImprovPlDtl(rowData);
			
		}
		
		return insertRowCnt;
	
	}
	
	/**
	* controller에 정의
	*
	* @param parameter
	*            삭제조건 list
	* @return   
	*            삭제결과   
	* @throws Exception
	*/
	@SuppressWarnings("unchecked")
	@Override
	public int removeMapImprovPlDtl(DataSetMap list) throws Exception
	{
		int deleteRowCnt = 0;
		
		Map<String, Object> rowData = list.get(0);
		deleteRowCnt = improvTaskMgmtDAO.deleteMapImprovPlDtl(rowData);
		
		return deleteRowCnt;	
	}


////////////////////////////////사업계획 계정정보
/**
* controller에 정의
* 
* @param parameter
*            조회조건 Map
* @return RecordSet 
*            조회결과
* @throws Exception
*/
public RecordSet selectMapAcctCdInfo(Map<String, Object> parameter) throws Exception {
	return improvTaskMgmtDAO.selectMapAcctCdInfo(parameter);
}


/**
* controller에 정의
*
* @param parameter
*            저장조건 list
* @return   
*            저장결과   
* @throws Exception
*/
@SuppressWarnings("unchecked")
@Override
public int saveMapAcctCdInfo(DataSetMap list) throws Exception
{
	int insertRowCnt = 0;
	int updateRowCnt = 0;
	int deleteRowCnt = 0;
	
	for (int i = 0 ; i < list.size() ; i++) 
	{
		Map<String, Object> rowData = list.get(i);
		int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
		
		
		if (rowType == DataSet.ROW_TYPE_INSERTED)//추가를 수행합니다. 
		{
			insertRowCnt += improvTaskMgmtDAO.insertMapAcctCdInfo(rowData);
		}
		else if (rowType == DataSet.ROW_TYPE_UPDATED)//수정을 수행합니다. 
		{
			updateRowCnt += improvTaskMgmtDAO.updateMapAcctCdInfo(rowData);
		}
		else if (rowType == DataSet.ROW_TYPE_DELETED)//삭제를 수행합니다. 
		{
			deleteRowCnt += improvTaskMgmtDAO.deleteMapAcctCdInfo(rowData);
		}
	}
	
	return insertRowCnt + updateRowCnt + deleteRowCnt;

}

/**
* controller에 정의
*
* @param parameter
*            삭제조건 list
* @return   
*            삭제결과   
* @throws Exception
*/
@SuppressWarnings("unchecked")
@Override
public int removeMapAcctCdInfo(DataSetMap list) throws Exception
{
	int deleteRowCnt = 0;
	
	Map<String, Object> rowData = list.get(0);
	deleteRowCnt = improvTaskMgmtDAO.deleteMapAcctCdInfo(rowData);
	
	return deleteRowCnt;	
}
    
}
