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
import com.hwfs.cmn.exception.BizException;
import com.hwfs.fm.fmc.dao.ClaimAcceptDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 클레임접수하는 ClaimAccept Service Implementation
 * 
 * @ClassName ClaimAcceptServiceImpl.java
 * @Description ClaimAcceptServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.13    최영준        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015.05.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fmc/claimAcceptService")
public class ClaimAcceptServiceImpl extends DefaultServiceImpl implements ClaimAcceptService {
	
	/** ClaimAcceptDAO Bean 생성 */
	@Resource(name = "/fm/fmc/claimAcceptDAO")
	private ClaimAcceptDAO claimAcceptDAO;
	

	/**
	 * 분류 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectItemClass(Map<String, Object> mapParam) throws Exception {
		return claimAcceptDAO.selectItemClass(mapParam);
	}
	
	/**
	 * 클레임접수 목록을 조회한다.
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
		return claimAcceptDAO.selectList(mapParam);
	}
	
	/**
	 * CS사원 체크를 한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return boolean 
	 *            CS사원 true, false
	 * @throws Exception
	*/
	public String checkCS(Map<String, Object> mapParam) throws Exception{
		RecordSet isCS = claimAcceptDAO.checkCS(mapParam);
		int count = isCS.getRowCount();
		String result = "false";
		if(count != 0)	result = "true";
		return result;
	}

	/**
	 * 클레임접수 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap list) throws Exception {
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Update 처리
			if (rowType == DataSet.ROW_TYPE_UPDATED) {
				String ticketFlag = claimAcceptDAO.ticketFlag(rowData);
				if(!"TRUE".equals(ticketFlag)){
					throw new BizException("매출 또는 선수금 등록 건이 있어 식권 전량폐기가 불가능 합니다.");
				}
				updRowCnt += claimAcceptDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += claimAcceptDAO.delete(rowData);
			}
		}
				
		return updRowCnt + delRowCnt;
	}
	
	/**
	 * 클레임접수 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int updateList(DataSetMap list) throws Exception {
		int updRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Update 처리
			if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += claimAcceptDAO.updateFix(rowData);
			}
		}
		return updRowCnt;
	}
}
