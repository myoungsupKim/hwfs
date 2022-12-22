package com.hwfs.sc.scp.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.util.RequestContextUtil;
import com.hwfs.sc.scp.dao.PersEnvConfDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 개인정보 환경설정을 관리하는 PersEnvConf Service Implementation
 * 
 * @ClassName PersEnvConfServiceImpl.java
 * @Description PersEnvConfServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.15    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.05.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scp/persEnvConfService")
public class PersEnvConfServiceImpl extends DefaultServiceImpl implements PersEnvConfService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** PersEnvConfDAO Bean 생성 */
	@Resource(name = "/sc/scp/persEnvConfDAO")
	private PersEnvConfDAO persEnvConfDAO;
	

	/**
	 * 개인정보 환경설정 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return persEnvConfDAO.selectList(mapParam);
	}

	/**
	 * 개인정보 환경설정 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//단위가 SABUN인 경우 사용할 수 있는 사용자인지 체크
			if ((rowType == DataSet.ROW_TYPE_INSERTED || rowType == DataSet.ROW_TYPE_UPDATED) &&
				rowData.get("envInfoUnit").toString().equalsIgnoreCase("SABUN") &&
				!rowData.get("envInfoValue").toString().equalsIgnoreCase("NONE")) {
				int cnt = persEnvConfDAO.checkSabun (rowData);
				if (cnt == 0)
					throw processException("sc.scp.persenvconf.not.use.sabun", new Object[]{rowData.get("envInfoValue")});
			}
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += persEnvConfDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += persEnvConfDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += persEnvConfDAO.delete(rowData);
			}
			logger.info("persEnvConf.saveList={}, work sabun={}", rowData, (String) RequestContextUtil.get(DefaultConsts.THREAD_LOCAL_SABUN_NAME));
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
