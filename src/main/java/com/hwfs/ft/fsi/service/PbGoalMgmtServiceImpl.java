package com.hwfs.ft.fsi.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ft.fsi.dao.PbGoalMgmtDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * PbGoalMgmtServiceImpl에 대한 설명 작성
 * @ClassName PbGoalMgmtServiceImpl.java
 * @Description PbGoalMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2021. 3. 12.   ITO        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 ITO
 * @since 2021. 3. 12.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ft/fsi/pbGoalMgmtService")
public class PbGoalMgmtServiceImpl extends DefaultServiceImpl implements PbGoalMgmtService {
	
	/** LogService */
    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    
    @Resource(name = "/ft/fsi/pbGoalMgmtDAO")
	private PbGoalMgmtDAO pbGoalMgmtDAO;

	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 * @see com.hwfs.ft.fsi.service.PbGoalMgmtService#selectList(java.util.Map)
	*/
	@Override
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return pbGoalMgmtDAO.selectList(mapParam);
	}

	/**
	 * selectGrpCdList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 * @see com.hwfs.ft.fsi.service.PbGoalMgmtService#selectGrpCdList(java.util.Map)
	*/
	@Override
	public RecordSet selectGrpCdList(Map<String, Object> mapParam) throws Exception {
		return pbGoalMgmtDAO.selectGrpCdList(mapParam);
	}
	
	/**
	 * selectGrpGoalList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 * @see com.hwfs.ft.fsi.service.PbGoalMgmtService#selectGrpGoalList(java.util.Map)
	*/
	@Override
	public RecordSet selectGrpGoalList(Map<String, Object> mapParam) throws Exception {
		return pbGoalMgmtDAO.selectGrpGoalList(mapParam);
	}

	/**
	 * saveGrpGoalList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param dataSetMap
	 * @param loginDTO
	 * @return
	 * @throws Exception
	 * @see com.hwfs.ft.fsi.service.PbGoalMgmtService#saveGrpGoalList(hone.online.xplatform.map.DataSetMap, com.hwfs.sc.cmn.dto.LoginDTO)
	*/
	@Override
	public int saveGrpGoalList(DataSetMap dataSetMap, LoginDTO loginDTO) throws Exception {
		int changeRowCnt=0;
		
		for(int i=0; i<dataSetMap.size(); i++) {
			Map<String, Object> rowData = dataSetMap.get(i);
			int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			// 데이터 머지
			if(rowType==DataSet.ROW_TYPE_INSERTED || rowType == DataSet.ROW_TYPE_UPDATED) {
				rowData.put("uuser", loginDTO.getSabun());
				changeRowCnt +=  pbGoalMgmtDAO.saveGrpGoalList(rowData);
			}
		}
		
		return changeRowCnt;
	}

	/**
	 * saveList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param dataSetMap
	 * @param loginDTO
	 * @return
	 * @throws Exception
	 * @see com.hwfs.ft.fsi.service.PbGoalMgmtService#saveList(hone.online.xplatform.map.DataSetMap, com.hwfs.sc.cmn.dto.LoginDTO)
	*/
	@Override
	public int saveList(DataSetMap dataSetMap, LoginDTO loginDTO) throws Exception {
		int changeRowCnt=0;

		// 듀프 체크 
		if(upjangDupChk(dataSetMap) != 0 ){
			return -1;
		} else {
			
			for(int i=0; i<dataSetMap.size(); i++) {
				Map<String, Object> rowData = dataSetMap.get(i);
				int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
				
				// 데이터 머지
				if(rowType==DataSet.ROW_TYPE_INSERTED || rowType == DataSet.ROW_TYPE_UPDATED) {
					rowData.put("uuser", loginDTO.getSabun());
					changeRowCnt +=  pbGoalMgmtDAO.saveList(rowData);
				}
			}
		}
		
		return changeRowCnt;
	}
	
	/* 업장코드 입력 듀프 체크  */
	public int upjangDupChk(DataSetMap dataSetMap) throws Exception {
		int dupResult=0;
		for(int i=0; i<dataSetMap.size(); i++) {
			Map<String, Object> rowData = dataSetMap.get(i);
			int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			if(rowType==DataSet.ROW_TYPE_INSERTED) {
				// 듀프 체크는 업장코드만 조건으로 함 
				//rowData.remove("pbGrpCd");
				RecordSet rs = pbGoalMgmtDAO.selectList(rowData);
				dupResult += rs.size();
			}
		}
		return dupResult;
	}

	/**
	 * deleteList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param dataSetMap
	 * @return
	 * @throws Exception
	 * @see com.hwfs.ft.fsi.service.PbGoalMgmtService#deleteList(hone.online.xplatform.map.DataSetMap)
	*/
	@Override
	public int deleteList(DataSetMap dataSetMap) throws Exception {
		int changeRowCnt=0;
		String strChk = "0";
		
		for(int i=0; i<dataSetMap.size(); i++) {
			Map<String, Object> rowData = dataSetMap.get(i);
			int rowType = ((Integer) rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			if(rowType==DataSet.ROW_TYPE_INSERTED || rowType == DataSet.ROW_TYPE_UPDATED) {
				strChk = LimsUtil.checkNull(rowData.get("chk"));
				if("1".equals(strChk)) {
					changeRowCnt +=  pbGoalMgmtDAO.deleteList(rowData);
				}
			}
		}
		return changeRowCnt;
	}

}
