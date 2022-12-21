package com.hwfs.sc.scc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.rmi.RmiClient;
import com.hwfs.sc.cmn.service.LoadCacheService;
import com.hwfs.sc.scc.dao.OpLogUserMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 운영로그 대상 사용자를 등록관리하는 OpLogUserMgmt Service Implementation
 * 
 * @ClassName OpLogUserMgmtServiceImpl.java
 * @Description OpLogUserMgmtServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.13    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.05.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scc/opLogUserMgmtService")
public class OpLogUserMgmtServiceImpl extends DefaultServiceImpl implements OpLogUserMgmtService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** LoadCacheService Bean 생성 */
	@Autowired
	private LoadCacheService loadCacheService;

	/** OpLogUserMgmtDAO Bean 생성 */
	@Resource(name = "/sc/scc/opLogUserMgmtDAO")
	private OpLogUserMgmtDAO opLogUserMgmtDAO;
	
    /** RMI Service Client */
    @Resource(name = "rmiClient")
    protected RmiClient rmiClient;
    
	/**
	 * 운영로그 대상 사용자 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return opLogUserMgmtDAO.selectList(mapParam);
	}

	/**
	 * 운영로그 대상 사용자 DataSetMap의 데이터를 rowType에 따라 Insert/Delete 처리한다.
	 * <pre>
	 * - (중요) 운영로그 대상 사용자를 DB에 등록 한 후 캐시에 재로딩 한다.
	 * </pre>
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
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += opLogUserMgmtDAO.insert(rowData);
				logger.info("A User for operation logging is inserted![{}]", rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += opLogUserMgmtDAO.delete(rowData);
				logger.info("A User for operation logging is deleted![{}]", rowData);
			}
		}
		//캐시에 재로딩 한다.
		if (insRowCnt + updRowCnt + delRowCnt > 0) {
			loadCacheService.cacheUserIdLog();
			
			//(중요) 이중화 서버인 경우는 상대 서버에 재로딩 명령을 요청 한다.
			rmiClient.reloadUserIdCache();
		}
		
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
