package com.hwfs.ft.fsi.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.ft.fsi.dao.PbItemMgmtDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.tobesoft.xplatform.data.DataSet;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

/**
*  
*
* @ClassName  
* @Description  
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*                
* </pre>
* @author  
* @since 2015.08.26
* @version 1.0
* @see
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
@Service("/ft/fsi/pbItemMgmtService")
public class PbItemMgmtServiceImpl extends DefaultServiceImpl implements PbItemMgmtService {

    /** LogService */
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource(name = "/ft/fsi/pbItemMgmtDAO")
    private PbItemMgmtDAO pbItemMgmtDAO;

	/**
	 * selectPbItemList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 * @see com.hwfs.ft.fsi.service.PbItemMgmtService#selectPbItemList(java.util.Map)
	*/
	@Override
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return pbItemMgmtDAO.selectList(mapParam);
	}

	/**
	 * saveList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 * @see com.hwfs.ft.fsi.service.PbItemMgmtService#saveList(java.util.Map)
	*/
	@Override
	public int saveList(DataSetMap paramCond, DataSetMap dataSetMap, DataSetMap dataCol, LoginDTO loginDTO) throws Exception {
		
		int changeRowCnt=0;
		String strChk = "0";
		
		// 튜프 체크 해서 익셉션 던지기
		String resultString = selectItemCode(dataSetMap, paramCond);
		if(!resultString.equals("-")) {
			throw new BizException("중복된 코드가 있습니다 => " + resultString);
		}
		
		for(int i=0; i<dataSetMap.size(); i++) {
			Map<String, Object> rowData = dataSetMap.get(i);
			int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			if(rowType==DataSet.ROW_TYPE_INSERTED || rowType == DataSet.ROW_TYPE_UPDATED) {
				
				rowData.put("uuser", loginDTO.getSabun());
				rowData.put("muCd", paramCond.get(0).get("muCd"));
				
				if(  !(dataCol.get(0).get("startDate").equals("") && dataCol.get(0).get("pbGubun").equals("") )) { // 일괄수정저장
					strChk = LimsUtil.checkNull(rowData.get("chk"));
					if("1".equals(strChk)) { //체크된 로우만 업데이트 처리
						rowData.put("startDateMod", dataCol.get(0).get("startDate"));
						rowData.put("endDateMod", dataCol.get(0).get("endDate"));
						rowData.put("pbGubunMod", dataCol.get(0).get("pbGubun"));
						
						changeRowCnt +=  pbItemMgmtDAO.saveList(rowData); 
					}
				} else {
					changeRowCnt +=  pbItemMgmtDAO.saveList(rowData); // 수정저장
				}
			}
		}
		return changeRowCnt;
	}
	

	
	/**
	 * 중복코드 조회
	 * selectItemCode 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param dataSetMap
	 * @return
	 * @throws Exception
	 * @see com.hwfs.ft.fsi.service.PbItemMgmtService#selectItemCode(hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	public String selectItemCode(DataSetMap dataSetMap, DataSetMap paramCond) throws Exception {
		String itemCodeArr = "''";
		String itemCodeList = null;
		
		for(int i=0; i<dataSetMap.size(); i++) {
			Map<String, Object> rowData = dataSetMap.get(i);
			int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			if(rowType==DataSet.ROW_TYPE_INSERTED) {
				itemCodeArr += ",'" + rowData.get("itemCode") + "'";
			}
		}
		
		String muCd = paramCond.get(0).get("muCd").toString();
		
		List<Map> itemCodeLst = pbItemMgmtDAO.selectItemCodeList(itemCodeArr, muCd);
		itemCodeList = itemCodeLst.get(0).get("itemCodeList").toString();
		
		return itemCodeList;
	}

	

}
