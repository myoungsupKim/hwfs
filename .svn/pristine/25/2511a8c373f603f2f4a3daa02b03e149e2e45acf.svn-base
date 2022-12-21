package com.hwfs.sc.scc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.scc.dao.OrgConfigDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 조직에 대한 환경을 설정하는 OrgConfig Service Implementation
 * 
 * @ClassName OrgConfigServiceImpl.java
 * @Description OrgConfigServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.09.09    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.09.09
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scc/orgConfigService")
public class OrgConfigServiceImpl extends DefaultServiceImpl implements OrgConfigService {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** OrgConfigDAO Bean 생성 */
	@Resource(name = "/sc/scc/orgConfigDAO")
	private OrgConfigDAO orgConfigDAO;
	

	/**
	 * 조직 환경 설정 목록을 조회한다.
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
	public Map<String, RecordSet> selectList() throws Exception {
		Map<String, Object> mapParam = new HashMap<String, Object>();
		Map<String, RecordSet> orgConfig = new HashMap<String, RecordSet>();
		
		orgConfig.put("orgConfig01", orgConfigDAO.selectOrgConfig01(mapParam));
		orgConfig.put("orgConfig02", orgConfigDAO.selectOrgConfig02(mapParam));
		orgConfig.put("orgConfig03", orgConfigDAO.selectOrgConfig03(mapParam));
		orgConfig.put("orgConfig04", orgConfigDAO.selectOrgConfig04(mapParam));
		
		return orgConfig;
	}

	/**
	 * 조직 환경 설정 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap orgConfigList01, DataSetMap orgConfigList02, DataSetMap orgConfigList03, DataSetMap orgConfigList04) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < orgConfigList01.size() ; i++) {
			Map<String, Object> rowData = orgConfigList01.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += orgConfigDAO.insertOrgConfig01(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += orgConfigDAO.updateOrgConfig01(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += orgConfigDAO.deleteOrgConfig01(rowData);
			}
		}

		for (int i = 0 ; i < orgConfigList02.size() ; i++) {
			Map<String, Object> rowData = orgConfigList02.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += orgConfigDAO.insertOrgConfig02(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += orgConfigDAO.updateOrgConfig02(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += orgConfigDAO.deleteOrgConfig02(rowData);
			}
		}

		for (int i = 0 ; i < orgConfigList03.size() ; i++) {
			Map<String, Object> rowData = orgConfigList03.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += orgConfigDAO.insertOrgConfig03(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += orgConfigDAO.updateOrgConfig03(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += orgConfigDAO.deleteOrgConfig03(rowData);
			}
		}

		for (int i = 0 ; i < orgConfigList04.size() ; i++) {
			Map<String, Object> rowData = orgConfigList04.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += orgConfigDAO.insertOrgConfig04(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += orgConfigDAO.updateOrgConfig04(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += orgConfigDAO.deleteOrgConfig04(rowData);
			}
		}
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
