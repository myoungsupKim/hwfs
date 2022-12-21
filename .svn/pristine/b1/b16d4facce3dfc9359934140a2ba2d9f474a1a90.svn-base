package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fms.dao.ExceptionItemMgntDAO;
import com.tobesoft.xplatform.data.DataSet;

/**
* 수발주제어 예외품목 등록하는 Service
* 
* @ClassName ExceptionItemMgntService.java
* @Description ExceptionItemMgntService Class
* @Modification-Information
* <pre>
*    수정일             수정자                 수정내용
*  ----------   ----------   -------------------------------
*  2022.04.22   hye.jin94    최초생성
* </pre>
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/

@Service("/fm/fms/exceptionItemMgntService")
public class ExceptionItemMgntServiceImpl extends DefaultServiceImpl implements ExceptionItemMgntService {
	
	
	/** returnItemMgntDAO Bean 생성 */
	@Resource(name = "/fm/fms/exceptionItemMgntDAO")
	private ExceptionItemMgntDAO exceptionItemMgntDAO;
	

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	/**
	 * 자재를 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	public RecordSet selectItem(Map<String, Object> mapParam) throws Exception {
		return exceptionItemMgntDAO.selectItem(mapParam);
	}
	
	/**
	 * 수발주제어 예외품목을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	public RecordSet selectExceptionItem(Map<String, Object> mapParam) throws Exception {
		return exceptionItemMgntDAO.selectExceptionItem(mapParam);
	}
	
	/**
	 * 수발주제어 예외품목을 저장한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return rtnMap
	 *                processCnt      처리건수
	 *                listDupCheck    중복data
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public Map<String, Object> saveExceptionItem(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		int hisRowCnt = 0;
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		List<Map<String, Object>> listDupCheck = new ArrayList<Map<String, Object>>();
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			boolean isCheck = StringUtils.equals("1", (String)rowData.get("chk")); //chk가 1인 건만 처리함 (ui에서 CHECKBOX가 선택된 건)
			String rowStatus = null;
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED && isCheck) {
				rowStatus = "I";
				//중복체크로직
				RecordSet rs = exceptionItemMgntDAO.selectExceptionItem(rowData);
				if(rs.isEmpty()){
					insRowCnt += exceptionItemMgntDAO.insertExceptionItem(rowData);
				} else {
					Map<String, Object> dupRowData = rs.get(0);
					String msg = String.format("[%s] 해당 상품은 [%s-%s]사용자가 %s에 등록한 정보가 있습니다.", (String)dupRowData.get("itemCode"), (String)dupRowData.get("uuser"), (String)dupRowData.get("uuserName"), (String)dupRowData.get("udate"));
					Map<String, Object> dupMsgData = new HashMap<String, Object>();
					dupMsgData.put("msg", msg);
					listDupCheck.add(dupMsgData);
				}
				
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED && isCheck) {
				rowStatus = "U";
				updRowCnt += exceptionItemMgntDAO.updateExceptionItem(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				rowStatus = "D";
				delRowCnt += exceptionItemMgntDAO.deleteExceptionItem(rowData);
			}
			
			rowData.put("rowStatus", rowStatus); //작업유형
			//히스토리 남기기 
			hisRowCnt += exceptionItemMgntDAO.insertHisExceptionItem(rowData);
		}
		
		rtnMap.put("processCnt", insRowCnt + updRowCnt + delRowCnt + hisRowCnt);
		rtnMap.put("listDupCheck", listDupCheck);
		return rtnMap;
	}
}
