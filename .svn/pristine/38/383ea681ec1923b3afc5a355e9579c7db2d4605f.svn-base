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
import com.hwfs.fm.fms.dao.ReturnItemMgntDAO;
import com.tobesoft.xplatform.data.DataSet;

/**
* 반환가능품목등록하는 Service Implementation
* 
* @ClassName ReturnItemMgntServiceImpl.java
* @Description ReturnItemMgntServiceImpl Class
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2021.07.08   	DEV02        최초생성
* </pre>
* @author [PJT]주문채널통합 : DEV02
* @since 2021.07.08
* @version 1.0
* @see 
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/

@Service("/fm/fms/returnItemMgntService")
public class ReturnItemMgntServiceImpl extends DefaultServiceImpl implements ReturnItemMgntService {
	
	
	/** returnItemMgntDAO Bean 생성 */
	@Resource(name = "/fm/fms/returnItemMgntDAO")
	private ReturnItemMgntDAO returnItemMgntDAO;
	

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
		return returnItemMgntDAO.selectItem(mapParam);
	}
	
	/**
	 * 반환가능품목을 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	public RecordSet selectReturnItem(Map<String, Object> mapParam) throws Exception {
		return returnItemMgntDAO.selectReturnItem(mapParam);
	}
	
	/**
	 * 반환가능품목을 저장한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return rtnMap
	 *                processCnt      처리건수
	 *                listDupCheck    중복data
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public Map<String, Object> saveReturnItem(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		List<Map<String, Object>> listDupCheck = new ArrayList<Map<String, Object>>();
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			boolean isCheck = StringUtils.equals("1", (String)rowData.get("chk")); //chk가 1인 건만 처리함 (ui에서 CHECKBOX가 선택된 건)
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED && isCheck) {
				
				//중복체크로직
				RecordSet rs = returnItemMgntDAO.selectReturnItem(rowData);
				if(rs.isEmpty()){
					insRowCnt += returnItemMgntDAO.insertReturnItem(rowData);
				} else {
					Map<String, Object> dupRowData = rs.get(0);
					String msg = String.format("[%s] 상품은 [%s-%s]사용자가 %s에 등록한 정보가 있습니다.", (String)dupRowData.get("itemCode"), (String)dupRowData.get("uuser"), (String)dupRowData.get("uuserName"), (String)dupRowData.get("udate"));
					Map<String, Object> dupMsgData = new HashMap<String, Object>();
					dupMsgData.put("msg", msg);
					listDupCheck.add(dupMsgData);
				}
				
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED && isCheck) {
				updRowCnt += returnItemMgntDAO.updateReturnItem(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += returnItemMgntDAO.deleteReturnItem(rowData);
			}
		}
		
		rtnMap.put("processCnt", insRowCnt + updRowCnt + delRowCnt);
		rtnMap.put("listDupCheck", listDupCheck);
		return rtnMap;
	}
}
