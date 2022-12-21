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
import org.springframework.transaction.annotation.Transactional;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fms.dao.HubInterfaceMngtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * Job Repository에 작성된 Job Configuration을 DB에 등록 관리하고 온라인 Job을 실행시키는 BatchJobMngt Service Implementation
 * (주의) HWFS CMN Batch Framework에서 사용하는 updateOnlineExecJobInfo 메소드를 구현해야 한다.
 * 
 * @ClassName BatchJobMngtServiceImpl.java
 * @Description BatchJobMngtServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.08    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.04.08
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fms/hubInterfaceMngtService")
public class HubInterfaceMngtServiceImpl extends DefaultServiceImpl implements HubInterfaceMngtService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** BatchJobMngtDAO Bean 생성 */
	@Resource(name = "/fm/fms/hubInterfaceMngtDAO")
	private HubInterfaceMngtDAO hubInterfaceMngtDAO;
	

	/**
	 * DB에 등록된 Job 정보 목록을 조회한다.
	 *
	 * @param jobList
	 *            DB에 저장된 Job 목록
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectUserIDList (Map<String, Object> mapParam) throws Exception {
		return hubInterfaceMngtDAO.selectUserIDList (mapParam);
	}

	/**
	 * User 정보를 저장한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return rtnMap
	 *                processCnt      처리건수
	 *                listDupCheck    중복data
	 * @throws Exception
	*/
	@Transactional
	@SuppressWarnings("unchecked")
	public Map<String, Object> saveHubInterface(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		int hisRowCnt = 0;
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		List<Map<String, Object>> listDupCheck = new ArrayList<Map<String, Object>>();
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			//boolean isCheck = StringUtils.equals("1", (String)rowData.get("chk")); //chk가 1인 건만 처리함 (ui에서 CHECKBOX가 선택된 건)
			//String rowStatus = null;
			
			//Insert 처리
		/*	if (rowType == DataSet.ROW_TYPE_INSERTED ) {
				//rowStatus = "I";
				//중복체크로직
				RecordSet rs = hubInterfaceMngtDAO.selectHubInterface(rowData);
				if(rs.isEmpty()){
					insRowCnt += hubInterfaceMngtDAO.insertHubInterface(rowData);
				} else {
					Map<String, Object> dupRowData = rs.get(0);
					String msg = String.format("[%s] 해당 고객은 이미 등록된 정보가 있습니다.", (String)dupRowData.get("userId"));
					Map<String, Object> dupMsgData = new HashMap<String, Object>();
					dupMsgData.put("msg", msg);
					listDupCheck.add(dupMsgData);
				}
				
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED ) {*/
				//rowStatus = "U";
				updRowCnt += hubInterfaceMngtDAO.updateHubInterface(rowData);
		/*	}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				//rowStatus = "D";
				delRowCnt += hubInterfaceMngtDAO.deleteHubInterface(rowData);
			}*/
			
		//	rowData.put("rowStatus", rowStatus); //작업유형
			//히스토리 남기기 
		//	hisRowCnt += HubInterfaceMgntDAO.insertHisHubInterface(rowData);
		}
		
		rtnMap.put("processCnt", insRowCnt + updRowCnt + delRowCnt);
		rtnMap.put("listDupCheck", listDupCheck);
		return rtnMap;
	}
	
	/**
	 * 허브메카 수동배치 정보를 클리어한다.
	 *
	 * @param parameter
	 * @return int
	 */
	public int updateHubInterfaceManual(Map<String, Object> parameter) throws Exception{
		return hubInterfaceMngtDAO.updateHubInterfaceManual (parameter);
	}
	
	
	/**
	 * 허브메카 수동배치 정보를 update 한다.
	 *
	 * @param parameter
	 * @return int
	 */
	public int saveHubInterfaceManual(Map<String, Object> parameter) throws Exception{
		return hubInterfaceMngtDAO.saveHubInterfaceManual (parameter);
	}

	/**
	 * 허브메카 수동배치 실행 권한을 조회한다.
	 * 추가일자:20220711  처리자:김혜진  
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectBatchAuth(Map<String, Object> mapParam) throws Exception {
		return hubInterfaceMngtDAO.selectBatchAuth(mapParam);
	}

}
