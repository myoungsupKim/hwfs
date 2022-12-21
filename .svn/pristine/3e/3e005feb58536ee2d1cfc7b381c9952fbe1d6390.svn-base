package com.hwfs.sc.scc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.listener.SessionListener;
import com.hwfs.cmn.util.NullUtil;
import com.hwfs.sc.cmn.dao.LoginDAO;
import com.hwfs.sc.scc.dao.NoPermissionUserMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 무단사용자를 관리하는 NoPermissionUserMgmt Service Implementation
 * 
 * @ClassName NoPermissionUserMgmtServiceImpl.java
 * @Description NoPermissionUserMgmtServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.08    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.07.08
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scc/noPermissionUserMgmtService")
public class NoPermissionUserMgmtServiceImpl extends DefaultServiceImpl implements NoPermissionUserMgmtService {
	
	/** NoPermissionUserMgmtDAO Bean 생성 */
	@Resource(name = "/sc/scc/noPermissionUserMgmtDAO")
	private NoPermissionUserMgmtDAO noPermissionUserMgmtDAO;
	
	/** LoginDAO */
    @Resource(name="/sc/cmn/loginDAO")
    private LoginDAO loginDAO;
	
	/**
	 * 무단사용자 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return noPermissionUserMgmtDAO.selectList(mapParam);
	}

	/**
	 * 무단사용자 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 차단 또는 해지 처리한다.
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap list) throws Exception {
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리 or Update 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED || rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += noPermissionUserMgmtDAO.saveNoPermissionUser(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += noPermissionUserMgmtDAO.delete(rowData);				
			}
		}
				
		return updRowCnt + delRowCnt;
	}
	
	/**
	 * 무단사용자를 접속차단하기 위해 등록한다.
	 * <pre>
	 * - 접속사용자 화면에서 호출한다.
	 * - 미접속 상태로 변경한다.
	 * </pre>
	 *
	 * @param listParam
	 *            무단사용자 정보 List<Map> : sabun, connIp, sessionId, appId로 구성
	 * @param regYn
	 *            무단사용자 등록 여부
	 * @param itctReason
	 *            접속차간사유
	 * @return 처리건수
	 * @throws Exception
	*/
	public int saveNoPermissionUser(List<Map<String, Object>> listParam, String regYn, String itctReason) throws Exception {
		int cnt = 0;
		for (int i=0; i<listParam.size(); i++) {
			//무단사용자 접속차단 등록
			if (regYn.equalsIgnoreCase("y")) {
				Map<String, Object> mapParam = new HashMap<String, Object>();
				mapParam.putAll(listParam.get(i));
				
				mapParam.put("itctYn", "1");
				mapParam.put("itctReason", itctReason);
				mapParam.put("terminReason", "");
				noPermissionUserMgmtDAO.saveNoPermissionUser(mapParam);
			}
			
			//미접속 상태로 변경한다.
			loginDAO.changeLogoutStatus(listParam.get(i));
			
			//접속을 끊는다.
			if (NullUtil.isNotNull(listParam.get(i).get("sessionId"))) {
				SessionListener.sessionInvalidate(listParam.get(i).get("sessionId").toString());
			}
			cnt++;
		}
		return cnt;
	}

}
