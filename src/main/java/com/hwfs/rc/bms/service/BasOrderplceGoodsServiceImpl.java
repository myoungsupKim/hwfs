package com.hwfs.rc.bms.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.bms.dao.BasOrderplceGoodsDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * BasOrderplceGoodsServiceImpl에 대한 설명 작성
 * @ClassName BasOrderplceGoodsServiceImpl.java
 * @Description BasOrderplceGoodsServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 2. 26.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 2. 26.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/bms/basOrderplceGoodsService")
public class BasOrderplceGoodsServiceImpl extends DefaultServiceImpl implements	BasOrderplceGoodsService {

	@Resource(name="/rc/bms/basOrderplceGoodsDAO")
	private BasOrderplceGoodsDAO basOrderplceGoods;
	
	/**
	 * selectOrderplceGoodsList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @return
	 * @see com.hwfs.rc.bms.service.BasOrderplceGoodsService#selectAmList()
	 */
	 
	@Override
	public RecordSet selectOrderplceGoodsList(Map<String, Object> parameter) {
		
		return basOrderplceGoods.selectList(parameter);
	}
	
	/**
	 * saveAmMgmt 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @return
	 * @see com.hwfs.rc.bms.service.BasAmMgmtService#saveAmMgmt()
	 */
	@Override
	@SuppressWarnings("unchecked")
	public int saveOrderplceGoods(DataSetMap bmsAmMgmt) {
		int procCnt = 0;
		String maxMenuCd = "";
		
		for (int i = 0 ; i < bmsAmMgmt.size() ; i++) {
			Map<String, Object> parameter = bmsAmMgmt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {

				Record chkRs = this.basOrderplceGoods.maxOrderplceGoodsCodeCreate(parameter);
				if(chkRs != null && chkRs.size() > 0) {
					maxMenuCd = chkRs.getString("maxMenuCd");  
					if(!"".equals(maxMenuCd)){
						parameter.put("menuCd", maxMenuCd);
					}
				}

				
				procCnt += basOrderplceGoods.insertOrderplceGoods(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				procCnt += basOrderplceGoods.updateOrderplceGoods(parameter);
			}
		}
 
		return  procCnt;
	}
	
	
	
}
