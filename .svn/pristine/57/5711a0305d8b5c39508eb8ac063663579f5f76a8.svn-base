package com.hwfs.rc.sle.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.sle.dao.DcEventMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * DcEventMgmtServiceImpl에 대한 설명 작성
 * @ClassName DcEventMgmtServiceImpl.java
 * @Description DcEventMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 22.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 4. 22.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/sle/dcEventMgmtService")
public class DcEventMgmtServiceImpl extends DefaultServiceImpl implements DcEventMgmtService {
	@Resource(name="/rc/sle/dcEventMgmtDAO")
	private DcEventMgmtDAO dcEventMgmt;
	/**
	 * selectListPrmt 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.DcEventMgmtService#selectListPrmt(java.util.Map)
	 */
	@Override
	public RecordSet selectListPrmt(Map<String, Object> parameter) throws Exception {
		return dcEventMgmt.selectListPrmt(parameter);
	}

	/**
	 * selectListCond 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.DcEventMgmtService#selectListCond(java.util.Map)
	 */
	@Override
	public RecordSet selectListCond(Map<String, Object> parameter) throws Exception {
		return dcEventMgmt.selectListCond(parameter);
	}

	/**
	 * selectListMixs 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.DcEventMgmtService#selectListMixs(java.util.Map)
	 */
	@Override
	public RecordSet selectListMixs(Map<String, Object> parameter) throws Exception {
		return dcEventMgmt.selectListMixs(parameter);
	}

	/**
	 * selectListRcpt 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.DcEventMgmtService#selectListRcpt(java.util.Map)
	 */
	@Override
	public RecordSet selectListRcpt(Map<String, Object> parameter) throws Exception {
		return dcEventMgmt.selectListRcpt(parameter);
	}

	/**
	 * selectListCard 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.DcEventMgmtService#selectListCard(java.util.Map)
	 */
	@Override
	public RecordSet selectListCard(Map<String, Object> parameter) throws Exception {
		return dcEventMgmt.selectListCard(parameter);
	}

	/**
	 * selectListOutlet 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.DcEventMgmtService#selectListOutlet(java.util.Map)
	 */
	@Override
	public RecordSet selectListOutlet(Map<String, Object> parameter) throws Exception {
		return dcEventMgmt.selectListOutlet(parameter);
	}

	/**
	 * saveData 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param slePrmt
	 * @param slePrmtOutlet
	 * @param slePrmtCond
	 * @param slePrmtMixs
	 * @param slePrmtRcpt
	 * @param slePrmtCard
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.sle.service.DcEventMgmtService#saveData(hone.online.xplatform.map.DataSetMap,
	 *  hone.online.xplatform.map.DataSetMap, hone.online.xplatform.map.DataSetMap, hone.online.xplatform.map.DataSetMap, 
	 *  hone.online.xplatform.map.DataSetMap, hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	@SuppressWarnings("unchecked")
	public int saveData(DataSetMap slePrmt, 	DataSetMap slePrmtOutlet,
						DataSetMap slePrmtCond, DataSetMap slePrmtMixs,
						DataSetMap slePrmtRcpt, DataSetMap slePrmtCard) throws Exception {
		int prmtProcCnt = 0;
		int outletProcCnt = 0;
		int condProcCnt = 0;
		int mixsProcCnt = 0;
		int rcptProcCnt = 0;
		int cardProcCnt = 0;
		
		String prmtCd ="";
		String maxSeq = "";
		String maxCode = "";
		
		//기본정보
		for (int i = 0 ; i < slePrmt.size() ; i++) {
			Map<String, Object> parameter = slePrmt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				//Code 값이 없는 경우 신규 MAX 값을 생성 한다.
				if(!parameter.containsKey("prmtCd") || "".equals(parameter.get("prmtCd")))
				{					
					Record chkRs = dcEventMgmt.maxCodeCreatePrmt(parameter);
					if(chkRs != null && chkRs.size() > 0) {
						maxCode = chkRs.getString("maxCode");
						if(!"".equals(maxCode)){
							parameter.put("prmtCd", maxCode);
							prmtCd = maxCode;
						}
					}
				}
				prmtProcCnt += dcEventMgmt.insertDataPrmt(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				prmtProcCnt += dcEventMgmt.updateDataPrmt(parameter);
				
				prmtCd = parameter.get("prmtCd").toString();
				
				//특정 그룹코드의 사용여부의 값이 [사용안함] 상태인 경우에는 하위에 해당하는 공통코드의 사용상태도 [사용안함] 상태로 변경한다.
				//if ("0".equals(parameter.get("useYn"))) {
				//	Map<String, Object> useAllCode = new HashMap<String, Object>();
				//	useAllCode.put("prmtCd", parameter.get("prmtCd"));
				//	useAllCode.put("useYn", parameter.get("useYn"));
					 
				//	dcEventMgmt.updateDataUseAllCond(useAllCode);
				//	dcEventMgmt.updateDataUseAllOutlet(useAllCode);
				//	dcEventMgmt.updateDataUseAllMixs(useAllCode);
				//	dcEventMgmt.updateDataUseAllRcpt(useAllCode);
				//	dcEventMgmt.updateDataUseAllCard(useAllCode);
				//}
			}
		}
		
		//업장
		for (int i = 0 ; i < slePrmtOutlet.size() ; i++) {
			Map<String, Object> parameter = slePrmtOutlet.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				if(!parameter.containsKey("prmtCd") || "".equals(parameter.get("prmtCd")))
				{
					parameter.put("prmtCd", prmtCd);
				}
				
				//Code 값이 없는 경우 신규 MAX 값을 생성 한다.
				if(!parameter.containsKey("seq") || "".equals(parameter.get("seq")))
				{					
					Record chkRs = dcEventMgmt.maxCodeCreateOutlet(parameter);
					if(chkRs != null && chkRs.size() > 0) {
						maxSeq = chkRs.getString("maxSeq");
						if(!"".equals(maxSeq)){
							parameter.put("seq", maxSeq);
						}
					}
				}
				
				condProcCnt += dcEventMgmt.insertDataOutlet(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				condProcCnt += dcEventMgmt.updateDataOutlet(parameter);
			}
		}
		
		//조건
		for (int i = 0 ; i < slePrmtCond.size() ; i++) {
			Map<String, Object> parameter = slePrmtCond.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				if(!parameter.containsKey("prmtCd") || "".equals(parameter.get("prmtCd")))
				{
					parameter.put("prmtCd", prmtCd);
				}
				
				//Code 값이 없는 경우 신규 MAX 값을 생성 한다.
				if(!parameter.containsKey("seq") || "".equals(parameter.get("seq")))
				{					
					Record chkRs = dcEventMgmt.maxCodeCreateCond(parameter);
					if(chkRs != null && chkRs.size() > 0 ) {
						maxSeq = chkRs.getString("maxSeq");
						if(!"".equals(maxSeq)){
							parameter.put("seq", maxSeq);
						}
					}
				}
				
				condProcCnt += dcEventMgmt.insertDataCond(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				condProcCnt += dcEventMgmt.updateDataCond(parameter);
			}
		}

		//믹스
		for (int i = 0 ; i < slePrmtMixs.size() ; i++) {
			Map<String, Object> parameter = slePrmtMixs.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				if(!parameter.containsKey("prmtCd") || "".equals(parameter.get("prmtCd")))
				{
					parameter.put("prmtCd", prmtCd);
				}
				
				//Code 값이 없는 경우 신규 MAX 값을 생성 한다.
				if(!parameter.containsKey("seq") || "".equals(parameter.get("seq")))
				{					
					Record chkRs = dcEventMgmt.maxCodeCreateMixs(parameter);
					if(chkRs != null && chkRs.size() > 0) {
							maxSeq = chkRs.getString("maxSeq");
							if(!"".equals(maxSeq)){
								parameter.put("seq", maxSeq);
							}
					}
				}
				
				condProcCnt += dcEventMgmt.insertDataMixs(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				condProcCnt += dcEventMgmt.updateDataMixs(parameter);
			}
		}

		//영수증
		for (int i = 0 ; i < slePrmtRcpt.size() ; i++) {
			Map<String, Object> parameter = slePrmtRcpt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				if(!parameter.containsKey("prmtCd") || "".equals(parameter.get("prmtCd")))
				{
					parameter.put("prmtCd", prmtCd);
				}
				
				//Code 값이 없는 경우 신규 MAX 값을 생성 한다.
				if(!parameter.containsKey("seq") || "".equals(parameter.get("seq")))
				{					
					Record chkRs = dcEventMgmt.maxCodeCreateRcpt(parameter);
					if(chkRs != null && chkRs.size() > 0) {
						maxSeq = chkRs.getString("maxSeq");
						if(!"".equals(maxSeq)){
							parameter.put("seq", maxSeq);
						}
					}
				}
				
				condProcCnt += dcEventMgmt.insertDataRcpt(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				condProcCnt += dcEventMgmt.updateDataRcpt(parameter);
			}
		}		
		

		//카드
		for (int i = 0 ; i < slePrmtCard.size() ; i++) {
			Map<String, Object> parameter = slePrmtCard.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {

				if(!parameter.containsKey("prmtCd") || "".equals(parameter.get("prmtCd")))
				{
					parameter.put("prmtCd", prmtCd);
				}
				
				//Code 값이 없는 경우 신규 MAX 값을 생성 한다.
				if(!parameter.containsKey("seq") || "".equals(parameter.get("seq")))
				{					
					Record chkRs = dcEventMgmt.maxCodeCreateCard(parameter);
					if(chkRs != null && chkRs.size() > 0) {
						maxSeq = chkRs.getString("maxSeq");
						if(!"".equals(maxSeq)){
							parameter.put("seq", maxSeq);
						}
					}
				}
				
				condProcCnt += dcEventMgmt.insertDataCard(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				condProcCnt += dcEventMgmt.updateDataCard(parameter);
			}
		}		
		
		return prmtProcCnt + outletProcCnt + condProcCnt + mixsProcCnt + rcptProcCnt + cardProcCnt;
	}

}
