package com.hwfs.fs.fso.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fso.dao.UpjangInfoCycleReptDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 업장 정보 활용장표하는 UpjangInfoCycleRept  Service Implementation
 * 
 * @ClassName UpjangInfoCycleRept ServiceImpl.java
 * @Description UpjangInfoCycleRept ServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.07    박준석        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 박준석
 * @since 2015.07.07
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fso/upjangInfoCycleReptService")
public class UpjangInfoCycleReptServiceImpl extends DefaultServiceImpl implements UpjangInfoCycleReptService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** UpjangInfoCycleRept DAO Bean 생성 */
	@Resource(name = "/fs/fso/upjangInfoCycleReptDAO")
	private UpjangInfoCycleReptDAO upjangInfoCycleReptDAO;
	

	/**
	 * 업장 정보 활용장표 목록을 조회한다.
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
		
		if("002".equals(mapParam.get("srchType"))) {
			return upjangInfoCycleReptDAO.selectList(mapParam);
		}else{
			return upjangInfoCycleReptDAO.selectUpjangList(mapParam);
		}
	}

	/**
	 * 업장 정보 활용장표 목록을 상세조회한다.
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
	public Map<String, RecordSet> selectListDetail(Map<String, Object> mapParam) throws Exception {
		
		Map<String, RecordSet> rsMap = new HashMap<String, RecordSet>();
		
		RecordSet rs1 = upjangInfoCycleReptDAO.selectUpjangInfo(mapParam);
		RecordSet rs2 = upjangInfoCycleReptDAO.selectUpjangMenu(mapParam);
		RecordSet rs3 = upjangInfoCycleReptDAO.selectGuarantyAmtInfo(mapParam);
		RecordSet rs4 = upjangInfoCycleReptDAO.selectItem(mapParam);
//		RecordSet rs4 = null;
//		String vChk = upjangInfoCycleReptDAO.selectPlviewCheck(mapParam).get(0).get("viewChk").toString();
//		if("Y".equals(vChk)) {
//			rs4 = upjangInfoCycleReptDAO.selectPlinfoList(mapParam);
//		}else {
//			rs4 = null;
//		}
		
		rsMap.put("upjangInfo", rs1);
		rsMap.put("upjangMenu", rs2);
		rsMap.put("guarantyAmt", rs3);
		rsMap.put("item", rs4);
//		rsMap.put("plinfo", rs4);
		
		return rsMap;
	}
	
	/**
	 * P/L 정보 열람관리 목록을 조회한다.
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
	public RecordSet selectPlviewSignList(Map<String, Object> mapParam) throws Exception {
		return upjangInfoCycleReptDAO.selectPlviewSignList(mapParam);
	}
	
	/**
	 * P/L 현황을 조회한다.
	 *  
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectPlDetail(Map<String, Object> mapParam) throws Exception {
		RecordSet rs = null;
		logger.debug("P/L 현황");
		String vChk = upjangInfoCycleReptDAO.selectPlviewCheck(mapParam).get(0).get("viewChk").toString();
		logger.debug("P/L 현황 : " + vChk);
		if("Y".equals(vChk)) {
			if("1".equals(mapParam.get("schGubun").toString())){
				rs = upjangInfoCycleReptDAO.selectPlinfoListA(mapParam);//재무확정
			}else{
				rs = upjangInfoCycleReptDAO.selectPlinfoListB(mapParam);//관리확정
			}
		}else {
			rs = null;
		}
		return rs;
	}
	
	/**
	 * P/L 정보 열람관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int savePlviewSignList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		//String dupChk = null;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				//dupChk = upjangInfoCycleReptDAO.selectPlviewDupCheck(rowData).get(0).get("dupChk").toString();
				//if("N".equals(dupChk)) {
					insRowCnt += upjangInfoCycleReptDAO.insertPlviewSign(rowData);
				//}
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += upjangInfoCycleReptDAO.updatePlviewSign(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += upjangInfoCycleReptDAO.deletePlviewSign(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
