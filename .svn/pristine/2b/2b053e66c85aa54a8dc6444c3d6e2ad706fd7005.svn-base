package com.hwfs.rc.sle.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.sle.dao.ItemGrpMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * ItemGrpMgmtServiceImpl에 대한 설명 작성
 * @ClassName ItemGrpMgmtServiceImpl.java
 * @Description ItemGrpMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 13.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 3. 13.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/sle/itemGrpMgmtService")
public class ItemGrpMgmtServiceImpl extends DefaultServiceImpl implements ItemGrpMgmtService {
	@Resource(name="/rc/sle/itemGrpMgmtDAO")
	private ItemGrpMgmtDAO itemGrpMgmt;
	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.ItemGrpMgmtService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return itemGrpMgmt.selectList(parameter);
	}
	@Override
	public RecordSet searchList(Map<String, Object> parameter) throws Exception {
		return itemGrpMgmt.searchList(parameter);
	}

	@Override
	public RecordSet selectListCheck(Map<String, Object> parameter) throws Exception {
		return itemGrpMgmt.selectListCheck(parameter);
	}

	
	/**
	 * saveData 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param itemGrpMgmt
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.ItemGrpMgmtService#saveData(hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	@SuppressWarnings("unchecked")
	public int saveData(DataSetMap sleitemGrpMgmt) throws Exception {
		int procCnt = 0;
		int recordCnt =0;
		String maxCode = "";
		
		for (int i = 0 ; i < sleitemGrpMgmt.size() ; i++) {
			Map<String, Object> parameter = sleitemGrpMgmt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				//Code 값이 없는 경우 신규 MAX 값을 생성 한다.
				if(!parameter.containsKey("dsplCd") || "".equals(parameter.get("dsplCd")))
				{					
					Record chkRs = itemGrpMgmt.maxCodeCreate(parameter);
					if(chkRs != null && chkRs.size() > 0) {
						maxCode = chkRs.getString("maxCode");
						if(!"".equals(maxCode)){
							
							String treeKey = parameter.get("treeKey").toString();
							
							if (treeKey.equals("1")){
								parameter.put("menuClass", maxCode);
							}else if (treeKey.equals("2")){
								parameter.put("menuClsfi", maxCode);
							}else {
								parameter.put("menuSclass", maxCode);
							}
						}
					}
				}
				
				procCnt += itemGrpMgmt.insertData(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				//사용 유무를 미사용으로 변경 한경우  하위코드 처리를 먼저 해야 한다 없는 경우는 상관 없다.
				String useYn = parameter.get("useYn").toString(); 
				 
				if (useYn.equals("0") ) {
					Record chkRs = itemGrpMgmt.selectRecordCnt(parameter);
					if(chkRs != null && chkRs.size() > 0) {
						recordCnt =  chkRs.getInt("recordCnt");
						if (recordCnt > 0){
							return -1;
						}
					}
				} 
				
				procCnt += itemGrpMgmt.updateData(parameter);
			}
		}
 
		return  procCnt;
	}

}
