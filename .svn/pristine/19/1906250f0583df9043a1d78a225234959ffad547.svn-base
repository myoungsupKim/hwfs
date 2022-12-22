package com.hwfs.fm.fms.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fms.dao.UpriceContractUpjangSetDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 단가계약업장을 설정하는 UpriceContractUpjangSet Service Implementation
 * 
 * @ClassName UpriceContractUpjangSetServiceImpl.java
 * @Description UpriceContractUpjangSetServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.09    최성연        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.03.09
 * @version 1.0
 * @see 
 * <pre> 
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fms/upriceContractUpjangSetService")
public class UpriceContractUpjangSetServiceImpl extends DefaultServiceImpl implements UpriceContractUpjangSetService {
	
	/** UpriceContractUpjangSetDAO Bean 생성 */
	@Resource(name = "/fm/fms/upriceContractUpjangSetDAO")
	private UpriceContractUpjangSetDAO upriceContractUpjangSetDAO;
	
	/**
	 *단가계약업장 DATA를 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectStd(Map<String, Object> mapParam) throws Exception {
		return upriceContractUpjangSetDAO.selectStd(mapParam);
	}

	
	/**
	 *대상업장 DATA를 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return upriceContractUpjangSetDAO.selectList(mapParam);
	}
	
	
	/**
	 *단가계약대상업장 DATA를 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	@Override
	public RecordSet selectUpjangList(Map<String, Object> mapParam) throws Exception {
		return upriceContractUpjangSetDAO.selectUpjangList(mapParam);
	}

	/**
	 *단가계약대상업장 센터정보 DATA를 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	public RecordSet selectCenter(Map<String, Object> mapParam) throws Exception {
		return upriceContractUpjangSetDAO.selectCenter(mapParam);
	}
	
	/**
	 *팀정보 DATA를 조회한다.
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	*/
	public RecordSet selectTeam(Map<String, Object> mapParam) throws Exception {
		mapParam.put("schMuCd", inCode(mapParam.get("schMuCd").toString()));
		return upriceContractUpjangSetDAO.selectTeam(mapParam);
	}
	
	
	/**
	 * 단가계약업장의 이익율 관리항목 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveStdList(LoginDTO loginParameter, DataSetMap list) throws Exception {
		int insRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			//추가를 수행합니다. : 실제는 UPDATE 문 처리
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				// 관리이익/전략이익 SET
				insRowCnt += upriceContractUpjangSetDAO.update2(rowData);
			}
		}
				
		return insRowCnt;
	}

	
	/**
	 * 단가계약업장을 삭제 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int delStdList(LoginDTO loginParameter, DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			//추가를 수행합니다. : 실제는 UPDATE 문 처리
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				// 단가업장 해제
				insRowCnt += upriceContractUpjangSetDAO.updateNon(rowData);
				
				// 해제한 단가업장에 대한 사업장 정보 초기화	
				updRowCnt += upriceContractUpjangSetDAO.updateAll(rowData);
				
			}
		}
		return insRowCnt;
	}
	
	
	
	
	/**
	 * 단가계약업장의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList(LoginDTO loginParameter, DataSetMap list) throws Exception {
		int insRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			//추가를 수행합니다. : 실제는 UPDATE 문 처리
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {

				// 단가계약업장 SET
				insRowCnt +=upriceContractUpjangSetDAO.update(rowData);
				
			}
		}
				
		return insRowCnt;
	}

	
	/**
	 * 단가계약업장을 지정한다.
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList2(LoginDTO loginParameter, DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				rowData.put("cuser", loginParameter.getSabun());
				rowData.put("uuser", loginParameter.getSabun());

				// 단가계약업장 SET
				insRowCnt += upriceContractUpjangSetDAO.update(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}

	
	
	/**
	 * 단가계약업장의 비고사항을 저장한다.(이익율 설정관리)
	 * <pre>
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveAttr(LoginDTO loginParameter, DataSetMap list) throws Exception {
		int updRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_UPDATED) {
				rowData.put("cuser", loginParameter.getSabun());
				rowData.put("uuser", loginParameter.getSabun());

				// 단가계약업장 비고사항 SET
				updRowCnt += upriceContractUpjangSetDAO.updateAttr(rowData);
			}
		}
				
		return updRowCnt;
	}
	
	/**
	 * 콤마 값을 IN 처리에 맞게 변경.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	public String inCode(String schCode) throws Exception {
		
		if(schCode.indexOf(',') != -1){
			return "'"+schCode.replaceAll(",", "','")+"'";
		}else{
			return "'"+schCode+"'";
		}
	}	
	
}
