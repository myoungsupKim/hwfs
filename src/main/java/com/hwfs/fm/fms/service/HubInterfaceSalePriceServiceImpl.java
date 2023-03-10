package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.fm.fms.dao.HubInterfaceSalePriceDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 허브메카 디데이 설정하는 hubInterfaceSalePrice Service Implementation
 * 
 * @ClassName hubInterfaceSalePriceServiceImpl.java
 * @Description hubInterfaceSalePriceServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.06.26   김혜진      
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.04.14
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fms/hubInterfaceSalePriceService")
public class HubInterfaceSalePriceServiceImpl extends DefaultServiceImpl implements HubInterfaceSalePriceService {
	
	/** hubInterfaceSalePriceDAO Bean 생성 */
	@Resource(name = "/fm/fms/hubInterfaceSalePriceDAO")
	private HubInterfaceSalePriceDAO hubInterfaceSalePriceDAO;
	

	/**
	 * 허브메카 id를 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectUser(Map<String, Object> mapParam) throws Exception {
			return hubInterfaceSalePriceDAO.selectUser(mapParam);
	}
	

	/**
	 * 허브메카 단가 목록을 조회한다.
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
			return hubInterfaceSalePriceDAO.selectList(mapParam);
	}
	
	/**
	 * 허브메카 단가 i/f 로그를 조회한다.
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
	public RecordSet selectLogList(Map<String, Object> mapParam) throws Exception {
			return hubInterfaceSalePriceDAO.selectLogList(mapParam);
	}


	/**
	 * 허브메카 단가 디데이 변경내역을 merge 처리한다.
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
			insRow = hubInterfaceSalePriceDAO.insert(rowData);

		} // end for
			
		return insRow;
	}
		
	
	
	
	/**
	 * 허브메카 단가를 Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int deleteHubPrice(DataSetMap list) throws Exception {
		int delRow = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			delRow = hubInterfaceSalePriceDAO.deleteHubPrice(rowData);

		}
		return delRow;
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
			inCnt = hubInterfaceSalePriceDAO.tempDelete(temp); //업로드 temp삭제
			
			inCnts = hubInterfaceSalePriceDAO.tempInsert(listMap);
		}
		

		List<Map> exlList = hubInterfaceSalePriceDAO.selectExcel(temp);
		rsMap.put("dsList", exlList);
		
		return rsMap;
	
	}
	
	/**
	 * 허브메카 단가 목록을 조회한다. (자재 추가 건)
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
	public RecordSet selectListAdd(Map<String, Object> mapParam) throws Exception {
			return hubInterfaceSalePriceDAO.selectListAdd(mapParam);
	}



}
