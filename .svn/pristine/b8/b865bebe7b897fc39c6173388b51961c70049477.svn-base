package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.fm.fms.dao.HubInterfaceStopItemDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 허브메카 Stop자재 설정하는 hubInterfaceStopItem Service Implementation
 * 
 * @ClassName hubInterfaceStopItemServiceImpl.java
 * @Description hubInterfaceStopItemServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.07.08   김혜진      
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.04.14
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fms/hubInterfaceStopItemService")
public class HubInterfaceStopItemServiceImpl extends DefaultServiceImpl implements HubInterfaceStopItemService {
	
	/** hubInterfaceSalePriceDAO Bean 생성 */
	@Resource(name = "/fm/fms/hubInterfaceStopItemDAO")
	private HubInterfaceStopItemDAO hubInterfaceStopItemDAO;
	

	/**
	 * 허브메카 stop자재 목록을 조회한다.
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
			return hubInterfaceStopItemDAO.selectList(mapParam);
	}


	/**
	 * 허브메카 stop자재 사용유무 업데이트 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap list) throws Exception {
		int insRow = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			// 단가디데이  MERGE
			insRow = hubInterfaceStopItemDAO.update(rowData);

		} // end for
			
		return insRow;
	}
		
	
	/**
	 * 허브메카 stop자재등록할 자재정보를 조회한다.
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
	public RecordSet selectItem(Map<String, Object> mapParam) throws Exception {
			return hubInterfaceStopItemDAO.selectItem(mapParam);
	}



	/**
	 * 허브메카 엑셀 업로드 목록을 조회한다.
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
	
	public Map<String, List> searchUpload(DataSetMap list) throws Exception {
		Map<String, List> rsMap = new HashMap<String, List>();	
		List<Map> listMap = new ArrayList<Map>();

		Map<String, Object> temp = list.get(0);
	
		int inCnt = 0;
		int[] inCnts = null;
		
		/*	엑셀 리스트를 TEMP 테이블에 INSERT	*/
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> rowData = list.get(i);
			listMap.add(rowData);
		}
		if(listMap.size() == 0){
			throw new BizException("오류가 발생하였습니다. 재업로드 해주세요.\n(업로드할 데이터가 없습니다.)");
		}else{
			inCnt = hubInterfaceStopItemDAO.tempDelete(temp); //업로드 temp삭제
			
			inCnts = hubInterfaceStopItemDAO.tempInsert(listMap);
		}
		

		List<Map> exlList = hubInterfaceStopItemDAO.selectExcel(temp);
		rsMap.put("dsList", exlList);
		
		return rsMap;
	
	}



	/**
	 * 허브메카 stop자재 저장한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public Map<String, Object> saveList2(DataSetMap list, DataSetMap list2) throws Exception {
		int insRow = 0;

		Map<String, Object> rtnMap = new HashMap<String, Object>();
		List<Map<String, Object>> listDupCheck = new ArrayList<Map<String, Object>>();
		
		for (int i = 0 ; i < list.size() ; i++) { //자재리스트
			for (int j = 0 ; j < list2.size() ; j++) { //userid 리스트
			
			Map<String, Object> rowData = list.get(i);
			
            String userid = (String)list2.get(j).get("userid");
			rowData.put("userid",userid);
			
			//STOP자재 저장
			//insRow = hubInterfaceStopItemDAO.insert(rowData);
			
			
			//중복체크로직
			RecordSet rs = hubInterfaceStopItemDAO.selectStopItem(rowData);
			if(rs.isEmpty()){
				insRow += hubInterfaceStopItemDAO.insert(rowData);
			} else {
				Map<String, Object> dupRowData = rs.get(0);
				String msg = String.format("[%s] 해당 상품은 [%s-%s]사용자가 %s에 등록한 정보가 있습니다.", (String)dupRowData.get("itemCode"), (String)dupRowData.get("uuser"), (String)dupRowData.get("uuserName"), (String)dupRowData.get("udate"));
				Map<String, Object> dupMsgData = new HashMap<String, Object>();
				dupMsgData.put("msg", msg);
				listDupCheck.add(dupMsgData);
			}
			
			}

		} // end for
			
		//return insRow;
		rtnMap.put("processCnt", insRow);
		rtnMap.put("listDupCheck", listDupCheck);
		return rtnMap;
	}
		


}
