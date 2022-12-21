package com.hwfs.fs.fse.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;


//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fse.dao.EventInfoMasterDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 기기/기물관리하는 EventInfoMaster Service Implementation
 * 
 * @ClassName EventInfoMasterServiceImpl.java
 * @Description EventInfoMasterServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.05    김예진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.03.05
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fse/eventInfoMasterService")
public class EventInfoMasterServiceImpl extends DefaultServiceImpl implements EventInfoMasterService {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** eventInfoMasterDAO Bean 생성 */
	@Resource(name = "/fs/fse/eventInfoMasterDAO")
	private EventInfoMasterDAO eventInfoMasterDAO;

	/**
	 * 마감현황 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectListCal(Map<String, Object> mapParam) throws Exception {
		return eventInfoMasterDAO.selectListCal(mapParam);
	}
	/**
	 * 마스터등록 목록을 조회한다.
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
	public RecordSet selectComboLclass(Map<String, Object> mapParam, LoginDTO loginDTO) throws Exception {
		//mapParam.put("ccCd", loginDTO.getCcCd());
		//mapParam.put("ccCd", "YA011");
		return eventInfoMasterDAO.selectComboLclass(mapParam);
	}
	public RecordSet selectComboMclass(Map<String, Object> mapParam) throws Exception {
		//mapParam.put("ccCd", "YA011");
		return eventInfoMasterDAO.selectComboMclass(mapParam);
	}
	public RecordSet selectComboSclass(Map<String, Object> mapParam) throws Exception {
		//mapParam.put("ccCd", "YA011");
		return eventInfoMasterDAO.selectComboSclass(mapParam);
	}
	public RecordSet selectCodeUse(Map<String, Object> mapParam) throws Exception {
		return eventInfoMasterDAO.selectCodeUse(mapParam);
	}
	public RecordSet selectMachineMst(Map<String, Object> mapParam, LoginDTO loginDTO) throws Exception {
		//mapParam.put("ccCd", loginDTO.getCcCd());
		//mapParam.put("ccCd", "YA011");
		return eventInfoMasterDAO.selectMachineMst(mapParam);
	}
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return eventInfoMasterDAO.selectList(mapParam);
	}

	/**
	 * 마스터등록 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap parameterMachineMst, DataSetMap parameterGrd, LoginDTO loginDTO) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		//String muCd = loginDTO.getMuCd();
		
		//기기/기물 코드 목록
		for (int i = 0 ; i < parameterMachineMst.size() ; i++) {
			Map<String, Object> rowData = parameterMachineMst.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			if(rowData.get("lev").toString().equals("2")){
				//Insert 처리
				if (rowType == DataSet.ROW_TYPE_INSERTED) {
					//rowData.put("muCd", muCd);
					insRowCnt += eventInfoMasterDAO.insertMachineMstMclass(rowData);
				}
				//Update 처리
				else if (rowType == DataSet.ROW_TYPE_UPDATED) {
					updRowCnt += eventInfoMasterDAO.updateMachineMstMclass(rowData);
				}
				//Delete 처리.
				else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += eventInfoMasterDAO.deleteMachineMstMclass(rowData);
				}
			}else{
				//Insert 처리
				if (rowType == DataSet.ROW_TYPE_INSERTED) {
					//rowData.put("muCd", muCd);
					insRowCnt += eventInfoMasterDAO.insertMachineMstSclass(rowData);
				}
				//Update 처리
				else if (rowType == DataSet.ROW_TYPE_UPDATED) {
					updRowCnt += eventInfoMasterDAO.updateMachineMstSclass(rowData);
				}
				//Delete 처리.
				else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += eventInfoMasterDAO.deleteMachineMstSclass(rowData);
				}
			}
		}

		//기기/기물 등록
		for (int i = 0 ; i < parameterGrd.size() ; i++) {
			Map<String, Object> rowData = parameterGrd.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				//rowData.put("muCd", muCd);
				insRowCnt += eventInfoMasterDAO.insertGrd(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				//rowData.put("muCd", muCd);
				updRowCnt += eventInfoMasterDAO.updateGrd(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += eventInfoMasterDAO.deleteGrd(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
