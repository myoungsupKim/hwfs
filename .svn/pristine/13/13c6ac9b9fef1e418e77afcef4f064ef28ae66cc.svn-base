package com.hwfs.sc.cmn.sap.list;

import hone.core.util.record.RecordSet;
import hone.core.util.record.RecordUtils;
import hone.online.xplatform.map.DataSetMap;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.hwfs.cmn.util.DTOUtil;
import com.hwfs.sc.cmn.sap.EAIList;
import com.hwfs.sc.cmn.sap.dto.ElctnTaxShetAppendDTO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * ElctnTaxShetAppendList에 대한 설명 작성
 * @ClassName ElctnTaxShetAppendList.java
 * @Description ElctnTaxShetAppendList Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 6. 18.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 6. 18.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class ElctnTaxShetAppendList implements EAIList {
	public List<ElctnTaxShetAppendDTO> dataList = new ArrayList<ElctnTaxShetAppendDTO>();

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
		return "FI-059-02";
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
		return "sc.cmn.sap.eaiListDAO.deleteElctnTaxShetAppend";
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
		return "sc.cmn.sap.eaiListDAO.insertElctnTaxShetAppend";
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
		dataList = (List<ElctnTaxShetAppendDTO>)list;
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
		dataList = RecordUtils.convertToBeanList(rs, ElctnTaxShetAppendDTO.class);
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
			ElctnTaxShetAppendDTO dto = new ElctnTaxShetAppendDTO();
			dto = (ElctnTaxShetAppendDTO)DTOUtil.convertMapToVo(dsm.getRowMaps().get(i), dto);
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
			ElctnTaxShetAppendDTO dto = new ElctnTaxShetAppendDTO();
			dto = (ElctnTaxShetAppendDTO)DTOUtil.convertMapToVo(maps.get(i), dto);
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
