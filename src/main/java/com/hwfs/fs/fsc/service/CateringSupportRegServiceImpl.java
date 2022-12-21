package com.hwfs.fs.fsc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsc.dao.CateringSupportRegDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.service.AddrSearchService;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 케터링 지원요청하는 CateringSupportReg Service Implementation
 * 
 * @ClassName CateringSupportRegServiceImpl.java
 * @Description CateringSupportRegServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.05    yanghj        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 yanghj
 * @since 2015.03.05
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsc/cateringSupportRegService")
public class CateringSupportRegServiceImpl extends DefaultServiceImpl implements CateringSupportRegService {

	/** CateringSupportRegDAO Bean 생성 */
	@Resource(name = "/fs/fsc/cateringSupportRegDAO")
	private CateringSupportRegDAO cateringSupportRegDAO;
	

	/**
	 * 케터링 지원요청 행사 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectCeleList(Map<String, Object> mapParam) throws Exception {
		return cateringSupportRegDAO.selectCeleList(mapParam);
	}
	

	//주소를 처리하기 위한 공통 Service
	@Resource(name = "/sc/cmn/addrSearchService")
	private AddrSearchService addressService;
	
	
	/**
	 * 케터링 지원요청 조리인력 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectCookHumanList(Map<String, Object> mapParam) throws Exception {
		return cateringSupportRegDAO.selectCookHumanList(mapParam);
	}
	
	/**
	 * 케터링 지원요청  기기/기물 목록을 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectUtensilList(Map<String, Object> mapParam) throws Exception {
		return cateringSupportRegDAO.selectUtensilList(mapParam);
	}
	
	/**
	 * 케터링 지원요청 교육대상 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectCookGuidList(Map<String, Object> mapParam) throws Exception {
		return cateringSupportRegDAO.selectCookGuidList(mapParam);
	}
	
	/**
	 * 케터링 지원요청 교육대상 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectQuantity(Map<String, Object> mapParam) throws Exception {
		return cateringSupportRegDAO.selectQuantity(mapParam);
	}	
	
	/**
	 * 케터링 사업장 기준정보 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectListUpjangInfo(Map<String, Object> mapParam) throws Exception {
		return cateringSupportRegDAO.selectListUpjangInfo(mapParam);
	}	

	/**
	 * 케터링 지원요청 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap parameterCele, DataSetMap parameterCookHuman, 
			            DataSetMap parameterUtensil, DataSetMap parameterCookGuid , LoginDTO loginDTO) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		
		
		//지원요청
		for (int i = 0 ; i < parameterCele.size() ; i++) {
			Map<String, Object> rowData = parameterCele.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
//				rowData.put("requestUpjangCd", loginDTO.getUpjang());				
				insRowCnt += cateringSupportRegDAO.insertCele(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += cateringSupportRegDAO.updateCele(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += cateringSupportRegDAO.deleteCele(rowData);
			}
		}
		
		//조리인력
		for (int i = 0 ; i < parameterCookHuman.size() ; i++) {
			Map<String, Object> rowData = parameterCookHuman.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
//				rowData.put("requestUpjangCd", loginDTO.getUpjang());
				insRowCnt += cateringSupportRegDAO.insertCookHuman(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += cateringSupportRegDAO.updateCookHuman(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += cateringSupportRegDAO.deleteCookHuman(rowData);
			}
		}
		
		//기기/기물
		for (int i = 0 ; i < parameterUtensil.size() ; i++) {
			Map<String, Object> rowData = parameterUtensil.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			// 주소 처리
			Map<String, Object> rtn = addressService.setAddress(rowData, "addrInfo", loginDTO.getSabun());
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
//				rowData.put("requestUpjangCd", loginDTO.getUpjang());
				insRowCnt += cateringSupportRegDAO.insertUtensil(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += cateringSupportRegDAO.updateUtensil(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += cateringSupportRegDAO.deleteUtensil(rowData);
			}
		}
		
		//교육대상
		for (int i = 0 ; i < parameterCookGuid.size() ; i++) {
			Map<String, Object> rowData = parameterCookGuid.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
//				rowData.put("requestUpjangCd", loginDTO.getUpjang());
				insRowCnt += cateringSupportRegDAO.insertCookGuid(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += cateringSupportRegDAO.updateCookGuid(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += cateringSupportRegDAO.deleteCookGuid(rowData);
			}
		}
		
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
