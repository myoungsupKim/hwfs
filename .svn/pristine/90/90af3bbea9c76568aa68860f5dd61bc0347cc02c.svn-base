package com.hwfs.fm.fmc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fmc.dao.OrderClaimCntDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 발주대비클레임건수하는 OrderClaimCnt Service Implementation
 * 
 * @ClassName OrderClaimCntServiceImpl.java
 * @Description OrderClaimCntServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.29    최영준        최초생성
 * </pre>
 * @author FC종합전산구축 : 통하영업 최영준
 * @since 2015.05.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fmc/orderClaimCntService")
public class OrderClaimCntServiceImpl extends DefaultServiceImpl implements OrderClaimCntService {
	
	/** OrderClaimCntDAO Bean 생성 */
	@Resource(name = "/fm/fmc/orderClaimCntDAO")
	private OrderClaimCntDAO orderClaimCntDAO;
	

	/**
	 * 발주대비클레임건수 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet upjangSearch(Map<String, Object> mapParam) throws Exception {
		return orderClaimCntDAO.upjangSearch(mapParam);
	}
	
	/**
	 * 발주대비클레임건수 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet custSearch(Map<String, Object> mapParam) throws Exception {
		return orderClaimCntDAO.custSearch(mapParam);
	}
	
	/**
	 * 발주대비클레임건수 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet custDetailSearch(Map<String, Object> mapParam) throws Exception {
		return orderClaimCntDAO.custDetailSearch(mapParam);
	}
	
	/**
	 * 발주대비클레임건수 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet subCustSearch(Map<String, Object> mapParam) throws Exception {
		return orderClaimCntDAO.subCustSearch(mapParam);
	}
	
	/**
	 * 발주대비클레임건수 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet itemSearch(Map<String, Object> mapParam) throws Exception {
		
	
		// 전체, 구매
		if ( "00".equals(mapParam.get("schTgGnb").toString()) || "02".equals(mapParam.get("schTgGnb").toString()) ) {
			return orderClaimCntDAO.itemSearch(mapParam);
		} else if ( "01".equals(mapParam.get("schTgGnb").toString()) ) { // 영업
			return orderClaimCntDAO.itemSearch(mapParam);
		} else {
			return orderClaimCntDAO.itemSearch(mapParam);
		}
		
		
	}

	/**
	 * 유형별 클레임발생현황을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet chartSearch(Map<String, Object> mapParam) throws Exception {
		return orderClaimCntDAO.chartSearch(mapParam);
	}
	
	/**
	 * 유형별 클레임발생현황을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet typeSearch(Map<String, Object> mapParam) throws Exception {
		
		RecordSet rsDt = null;
		if ( "D".equals(mapParam.get("schGnb")) ) {
			rsDt = orderClaimCntDAO.dayTermSearch(mapParam);
		} else {
			rsDt = orderClaimCntDAO.monthTermSearch(mapParam);
		}
		
		mapParam.put("schVerse", inCode(rsDt.get(0).get("dateInfo").toString()));
		mapParam.put("schPivot", rsDt.get(0).get("dateInfo").toString());
		return orderClaimCntDAO.typeSearch(mapParam);
	}
	
	/**
	 * 발주대비클레임건수 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += orderClaimCntDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += orderClaimCntDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += orderClaimCntDAO.delete(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	
	/**
	 * pivot select 절.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	public String inCode(String schCode) throws Exception {
		String rtn = "";
		String[] strs = schCode.split(",");
		for ( int i=0; i<strs.length; i++ ) {
			rtn += " , NVL(\""+strs[i]+"\", 0) AS \""+strs[i]+"\"";
		}
		System.out.println(rtn);
		return rtn; 
	}
}
