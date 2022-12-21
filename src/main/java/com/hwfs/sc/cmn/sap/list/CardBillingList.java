package com.hwfs.sc.cmn.sap.list;

import hone.core.util.record.RecordSet;
import hone.core.util.record.RecordUtils;
import hone.online.xplatform.map.DataSetMap;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.hwfs.cmn.util.DTOUtil;
import com.hwfs.sc.cmn.sap.EAIList;
import com.hwfs.sc.cmn.sap.dto.CardBillingDTO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * CardBillingList에 대한 설명 작성
 * @ClassName CardBillingList.java
 * @Description CardBillingList Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 5. 29.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 5. 29.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class CardBillingList implements EAIList {
	public List<CardBillingDTO> dataList = new ArrayList<CardBillingDTO>();

	/**
	 * getInterfaceId 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @return
	 * @see com.hwfs.sc.cmn.sap.EAIList#getInterfaceId()
	*/
	@Override
	public String getInterfaceId() {
		return "TR-003-01";
	}

	/**
	 * getDeleteQueryId 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @return
	 * @see com.hwfs.sc.cmn.sap.EAIList#getDeleteQueryId()
	*/
	@Override
	public String getDeleteQueryId() {
		return "sc.cmn.sap.eaiListDAO.deleteCardBilling";
	}

	/**
	 * getQueryId 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @return
	 * @see com.hwfs.sc.cmn.sap.EAIList#getQueryId()
	*/
	@Override
	public String getQueryId() {
		return "sc.cmn.sap.eaiListDAO.insertCardBilling";
	}

	/**
	 * setDataList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 * @see com.hwfs.sc.cmn.sap.EAIList#setDataList(java.util.List)
	*/
	@SuppressWarnings("unchecked")
	@Override
	public void setDataList(List<?> list) {
		dataList = (List<CardBillingDTO>)list;
	}

	/**
	 * setDataList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param rs
	 * @see com.hwfs.sc.cmn.sap.EAIList#setDataList(hone.core.util.record.RecordSet)
	*/
	@Override
	public void setDataList(RecordSet rs) {
		dataList = RecordUtils.convertToBeanList(rs, CardBillingDTO.class);
	}

	/**
	 * setDataList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param dsm
	 * @see com.hwfs.sc.cmn.sap.EAIList#setDataList(hone.online.xplatform.map.DataSetMap)
	*/
	@SuppressWarnings("unchecked")
	@Override
	public void setDataList(DataSetMap dsm) {
		for(int i = 0 ; i < dsm.getRowMaps().size() ; i++) {
			CardBillingDTO dto = new CardBillingDTO();
			dto = (CardBillingDTO)DTOUtil.convertMapToVo(dsm.getRowMaps().get(i), dto);
			dataList.add(dto);
		}
	}

	/**
	 * setDataList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param dsm
	 * @param rowType
	 * @see com.hwfs.sc.cmn.sap.EAIList#setDataList(hone.online.xplatform.map.DataSetMap, int)
	*/
	@Override
	public void setDataList(DataSetMap dsm, int rowType) {
		List<Map<String, Object>> maps = null;

		if (rowType == DataSet.ROW_TYPE_INSERTED) {
			maps = dsm.getInsRowMaps();
		}
		else if (rowType == DataSet.ROW_TYPE_UPDATED) {
			maps = dsm.getUpdRowMaps();
		}
		else if (rowType == DataSet.ROW_TYPE_DELETED) {
			maps = dsm.getDelRowMaps();
		}

		for(int i = 0 ; i < maps.size() ; i++) {
			CardBillingDTO dto = new CardBillingDTO();
			dto = (CardBillingDTO)DTOUtil.convertMapToVo(maps.get(i), dto);
			dataList.add(dto);
		}
	}

	/**
	 * getDataList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @return
	 * @see com.hwfs.sc.cmn.sap.EAIList#getDataList()
	*/
	@Override
	public List<?> getDataList() {
		return dataList;
	}

}
