package com.hwfs.sc.scm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.idgen.SequenceIdGenService;
import com.hwfs.sc.scm.dao.MenuMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * MenuMgmtServiceImpl에 대한 설명 작성
 * @ClassName MenuMgmtServiceImpl.java
 * @Description MenuMgmtServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 1. 27.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 1. 27.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scm/menuMgmtService")
public class MenuMgmtServiceImpl extends DefaultServiceImpl implements MenuMgmtService {

	@Resource(name="/sc/scm/menuMgmtDAO")
	private MenuMgmtDAO menuMgmt;

	@Resource(name="scMenuIdGenSequence")
	private SequenceIdGenService scMenuIdGenSequence;

	/**
	 * 메뉴정보를 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.scm.service.MenuMgmtService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) {
		return menuMgmt.selectList(parameter);
	}

	/**
	 * 추가/변경/삭제된 메뉴정보를 저장한다.
	 * <pre>
	 * 1. UI에서 전체 Data를 넘겨 받는다.
	 * 2. 추가된 행에 대해서만 신규 메뉴ID와 부모메뉴ID를 적용한다.(메뉴ID는 DB Sequence(SCC_MENU_S)를 사용한다.)
	 * 3. 위 2항에서 가공된 자료를 추가/수정/삭제건에 대하여 DB에 반영한다.
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.scm.service.MenuMgmtService#saveList(hone.online.xplatform.map.DataSetMap)
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public int saveList(DataSetMap parameter) {
		int procCnt = 0;
		List<Map> list = parameter.getRowMaps();
		BigDecimal beforeLvl = BigDecimal.ZERO;

		//신규로 추가된 행에 대하여 MenuId와 ParentMenuId를 설정한다. 즉, 데이터를 가공한다.
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				BigDecimal curLvl = (BigDecimal)rowData.get("lvl");
				Map<String, Object> beforeRowData = null;

				// 신규 메뉴아이디 생성/적용
				rowData.put("menuId", BigDecimal.valueOf(Long.parseLong(scMenuIdGenSequence.getNextStringId().trim())));

				if (i > 0 && !rowData.containsKey("parentMenuId")) {
					beforeRowData = list.get(i-1);
					beforeLvl = (BigDecimal)beforeRowData.get("lvl");

					//이전하고 같다. 이전 ParentMenuId를 적용한다.
					if (curLvl.intValue() == beforeLvl.intValue()) {
						rowData.put("parentMenuId", beforeRowData.get("parentMenuId"));
					}
					//이전보다 크다.  이전 MenuId를 적용한다.
					else if (curLvl.intValue() > beforeLvl.intValue()) {
						rowData.put("parentMenuId", beforeRowData.get("menuId"));
					}
					//이전보다 작다. 단, 현재 레벨이 1이 아니다. 그러므로 기존에서 같은 레벨의 ParentMenuId를 적용한다.
					else if (curLvl.intValue() != 1 && curLvl.intValue() < beforeLvl.intValue()) {
						rowData.put("parentMenuId", findBeforeParentMenuId(list, i, curLvl.intValue()));
					}
				}

				list.set(i, rowData);
			}
		}

		//추가/변경/삭제된 메뉴정보를 저장한다.
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				procCnt += menuMgmt.insertList(rowData);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				procCnt += menuMgmt.updateList(rowData);
			}
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				procCnt += menuMgmt.deleteList(rowData);
			}
		}

		return procCnt;
	}

	/**
	 * 같은 Level상에 부모메뉴아이디를 찾는다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 * @param curRowPos
	 * @param level
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	private BigDecimal findBeforeParentMenuId(List<Map> list, int curRowPos, int level) {
		BigDecimal parentMenuId = BigDecimal.ZERO;

		for (int i = (curRowPos-1) ; i >= 0 ; i--) {
			Map<String, Object> rowData = list.get(i);
			BigDecimal lvl = (BigDecimal)rowData.get("lvl");

			if (lvl.intValue() == level) {
				parentMenuId = BigDecimal.valueOf(Long.parseLong(rowData.get("parentMenuId").toString()));
				break;
			}
		}

		return parentMenuId;
	}
}
