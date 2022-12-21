package com.hwfs.fm.fmc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fmc.dao.ClaimProcStatusDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 클레임처리현황하는 ClaimProcStatus Service Implementation
 * 
 * @ClassName ClaimProcStatusServiceImpl.java
 * @Description ClaimProcStatusServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.28    최영준        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015.05.28
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fmc/claimProcStatusService")
public class ClaimProcStatusServiceImpl extends DefaultServiceImpl implements ClaimProcStatusService {
	
	/** ClaimProcStatusDAO Bean 생성 */
	@Resource(name = "/fm/fmc/claimProcStatusDAO")
	private ClaimProcStatusDAO claimProcStatusDAO;
	

	/**
	 * 클레임처리현황 목록을 조회한다.
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
		// CENTER_CODE 다중 처리 : 2016-01-11
		mapParam.put("schCode", inCode(mapParam.get("schCode").toString()));
		return claimProcStatusDAO.selectList(mapParam);
	}

	/**
	 * 클레임처리현황 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += claimProcStatusDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += claimProcStatusDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += claimProcStatusDAO.delete(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 창고 목록을 조회한다.
	 *
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	public RecordSet subinvSearch(Map <String, Object> parm) throws Exception {
		return claimProcStatusDAO.subinvSearch(parm);
	}
	
	/**
	 * 반품자재 목록을 조회한다.
	 *
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	public RecordSet returnItemSearch(Map <String, Object> parm,Map <String, Object> inVar) throws Exception {
		parm.put("schFromDate", inVar.get("schFromDate"));
		parm.put("schToDate", inVar.get("schToDate"));
		parm.put("schSubinv", inVar.get("schSubinv"));
		return claimProcStatusDAO.returnItemSearch(parm);
	}

	/**
	 * 콤마 값을 IN 처리에 맞게 변경.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	public String inCode(String schCode) throws Exception {
		
		if(schCode.indexOf(',') != -1){
			return "'"+schCode.replaceAll(",", "','")+"'";
		}else{
			return "'"+schCode+"'";
		}
	}
	

}
