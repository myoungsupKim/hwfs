package com.hwfs.rc.bms.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.bms.dao.TmMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * TmGoalMngtServiceImpl에 대한 설명 작성
 * @ClassName TmGoalMngtServiceImpl.java
 * @Description TmGoalMngtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 2.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 3. 2.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/bms/tmMgmtService")
public class TmMgmtServiceImpl extends DefaultServiceImpl implements TmMgmtService {
	@Resource(name="/rc/bms/tmMgmtDAO")
	private TmMgmtDAO tmMgmt;
	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.bms.service.TmMgmtService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectGoalList(Map<String, Object> parameter) throws Exception {
		
		/*
		 RecordSet rs = null;
		int maskAuth = Integer.parseInt(parameter.get("maskAuth").toString());
		//관리용(저장, 삭제, 입력)의 권한이 있는 화면에서 조회권한만 있는 경우에는 아래와 같이 분기처리를 한다.
		if (maskAuth == Const.MaskAuthMode.MASK) { //조회권한만 있으므로 개인정보의 마스킹 처리를 수행한다.
			rs = tmMgmt.selectListMask(parameter);
		}
		else { //저장,삭제,입력등의 권한이 있으므로 비 마스킹처리를 한다.
			rs = tmMgmt.selectList(parameter);
		}
		*/
		
		return tmMgmt.selectGoalList(parameter);
	}
	
	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.bms.service.TmMgmtService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectSaleList(Map<String, Object> parameter) throws Exception {
		
		/*
		 RecordSet rs = null;
		int maskAuth = Integer.parseInt(parameter.get("maskAuth").toString());
		//관리용(저장, 삭제, 입력)의 권한이 있는 화면에서 조회권한만 있는 경우에는 아래와 같이 분기처리를 한다.
		if (maskAuth == Const.MaskAuthMode.MASK) { //조회권한만 있으므로 개인정보의 마스킹 처리를 수행한다.
			rs = tmMgmt.selectListMask(parameter);
		}
		else { //저장,삭제,입력등의 권한이 있으므로 비 마스킹처리를 한다.
			rs = tmMgmt.selectList(parameter);
		}
		*/
		
		return tmMgmt.selectSaleList(parameter);
	}
	
	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.bms.service.TmMgmtService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectAddSaleList(Map<String, Object> parameter) throws Exception {
		
		/*
		 RecordSet rs = null;
		int maskAuth = Integer.parseInt(parameter.get("maskAuth").toString());
		//관리용(저장, 삭제, 입력)의 권한이 있는 화면에서 조회권한만 있는 경우에는 아래와 같이 분기처리를 한다.
		if (maskAuth == Const.MaskAuthMode.MASK) { //조회권한만 있으므로 개인정보의 마스킹 처리를 수행한다.
			rs = tmMgmt.selectListMask(parameter);
		}
		else { //저장,삭제,입력등의 권한이 있으므로 비 마스킹처리를 한다.
			rs = tmMgmt.selectList(parameter);
		}
		*/
		
		return tmMgmt.selectAddSaleList(parameter);
	}
	
	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.bms.service.TmMgmtService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectSaleSumList(Map<String, Object> parameter) throws Exception {
		
		/*
		 RecordSet rs = null;
		int maskAuth = Integer.parseInt(parameter.get("maskAuth").toString());
		//관리용(저장, 삭제, 입력)의 권한이 있는 화면에서 조회권한만 있는 경우에는 아래와 같이 분기처리를 한다.
		if (maskAuth == Const.MaskAuthMode.MASK) { //조회권한만 있으므로 개인정보의 마스킹 처리를 수행한다.
			rs = tmMgmt.selectListMask(parameter);
		}
		else { //저장,삭제,입력등의 권한이 있으므로 비 마스킹처리를 한다.
			rs = tmMgmt.selectList(parameter);
		}
		*/
		
		return tmMgmt.selectSaleSumList(parameter);
	}
	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.bms.service.TmMgmtService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectTmGoalChk(Map<String, Object> parameter) throws Exception {
		
		/*
		 RecordSet rs = null;
		int maskAuth = Integer.parseInt(parameter.get("maskAuth").toString());
		//관리용(저장, 삭제, 입력)의 권한이 있는 화면에서 조회권한만 있는 경우에는 아래와 같이 분기처리를 한다.
		if (maskAuth == Const.MaskAuthMode.MASK) { //조회권한만 있으므로 개인정보의 마스킹 처리를 수행한다.
			rs = tmMgmt.selectListMask(parameter);
		}
		else { //저장,삭제,입력등의 권한이 있으므로 비 마스킹처리를 한다.
			rs = tmMgmt.selectList(parameter);
		}
		*/
		
		return tmMgmt.selectTmGoalChk(parameter);
	}
	/**
	 * saveData 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param bmsAmMgmt
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.bms.service.TmMgmtService#saveData(hone.online.xplatform.map.DataSetMap)
	 */
	
	@Override
	@SuppressWarnings("unchecked")
	public int saveGoalData(DataSetMap bmsTmGoalMngt) throws Exception {
		int procCnt = 0;
		String  upjangNm = "";
		
		for (int i = 0 ; i < bmsTmGoalMngt.size() ; i++) {
			Map<String, Object> parameter = bmsTmGoalMngt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				procCnt += tmMgmt.insertGoalData(parameter);
			} else if (rowType == DataSet.ROW_TYPE_UPDATED){
				procCnt += tmMgmt.updateGoalData(parameter);
			} else if (rowType == DataSet.ROW_TYPE_DELETED){
				procCnt += tmMgmt.deleteGoalData(parameter);
			}
		}
 
		return  procCnt;
	}
	
	
	/**
	 * saveData 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param bmsAmMgmt
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.bms.service.TmMgmtService#saveData(hone.online.xplatform.map.DataSetMap)
	 */
	
	@Override
	@SuppressWarnings("unchecked")
	public int saveSaleData(DataSetMap bmsTmSaleMngt) throws Exception {
		int procCnt = 0;
		
		for (int i = 0 ; i < bmsTmSaleMngt.size() ; i++) {
			Map<String, Object> parameter = bmsTmSaleMngt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				procCnt += tmMgmt.insertSaleData(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				procCnt += tmMgmt.updateSaleData(parameter);
			}
		}
 
		return  procCnt;
	}
	
	/**
	 * saveData 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param bmsAmMgmt
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.bms.service.TmMgmtService#saveData(hone.online.xplatform.map.DataSetMap)
	 */
	
	@Override
	@SuppressWarnings("unchecked")
	public int saveAddSaleData(DataSetMap bmsTmAddSaleMngt) throws Exception {
		int procCnt = 0;
		
		for (int i = 0 ; i < bmsTmAddSaleMngt.size() ; i++) {
			Map<String, Object> parameter = bmsTmAddSaleMngt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				procCnt += tmMgmt.insertAddSaleData(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				procCnt += tmMgmt.updateAddSaleData(parameter);
			}
		}
 
		return  procCnt;
	}
	
	/**
	 * selectBCodeList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.bms.service.TmMgmtService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectBCodeList(Map<String, Object> parameter) throws Exception {
		
		return tmMgmt.selectBCodeList(parameter);
	}
	

}
