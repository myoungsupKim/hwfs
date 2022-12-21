package com.hwfs.ma.mas.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ma.mas.dao.CloseMgmtDAO;

 /**
 * 사업장 일마감 취소 기획승인 하는하는 CloseMgmt Service Implementation
 * 
 * @ClassName CloseMgmtServiceImpl.java
 * @Description CloseMgmtServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.08.17    박준석        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 박준석
 * @since 2015.08.17
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ma/mas/closeMgmtService")
public class CloseMgmtServiceImpl extends DefaultServiceImpl implements CloseMgmtService {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** CloseMgmtDAO Bean 생성 */
	@Resource(name = "/ma/mas/closeMgmtDAO")
	private CloseMgmtDAO closeMgmtDAO;
	

	/**
	 * 사업장 일마감 취소 기획승인 하는 목록을 조회한다.
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
		return closeMgmtDAO.selectList(mapParam);
	}

	/**
	 * 사업장 일마감 취소 기획승인 하는 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public String saveList(DataSetMap list) throws Exception {
		
		String strRtn	= null;
		String strRtnMsg= null;
		String strRtnDate= null;
		
		Map<String, Object> inParam = new HashMap<String, Object>();
		Map<String, Object> rowData = list.get(0);
		
		//입력값 Setting
		inParam.put("P_OCCUR_SDATE",	String.valueOf(rowData.get("occurSdate")));
		inParam.put("P_OCCUR_EDATE",	String.valueOf(rowData.get("occurEdate")));
		inParam.put("P_SYS_CLASS",	String.valueOf(rowData.get("sysClass")));
		inParam.put("P_CLOSE_GUBUN",	String.valueOf(rowData.get("closeGubun")));
		inParam.put("P_REQ_ID",	String.valueOf(rowData.get("reqId")));
		inParam.put("P_EMP_NUM",	String.valueOf(rowData.get("loginSabun")));
		inParam.put("P_UPJANG_CD",	String.valueOf(rowData.get("upjangCd")));
				
		String callProcName = "";
		
		callProcName = "SP_FS_MAGAM_CANCEL_PROC";
		
		//마감취소 procedure 호출
		Map<String, Object> retVal = closeMgmtDAO.callCloseProcedure(inParam, callProcName);
		
		//출력값 Setting
		strRtn		= String.valueOf(retVal.get("O_RTN"));
		strRtnMsg	= String.valueOf(retVal.get("O_RTNMSG"));
		strRtnDate	= String.valueOf(retVal.get("O_RTNDATE"));
				
				
		return strRtn + "|" + strRtnMsg + "|" + strRtnDate;
	}
	
	/**
	 * 마감관리자 조정 마감 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public String closeProc(DataSetMap list) throws Exception {
		
		String strRtn	= null;
		String strRtnMsg= null;
		String strRtnDate= null;
		
		Map<String, Object> inParam = new HashMap<String, Object>();
		Map<String, Object> rowData = list.get(0);
		
		//입력값 Setting
		inParam.put("P_OCCUR_SDATE",	String.valueOf(rowData.get("occurSdate")));
		inParam.put("P_OCCUR_EDATE",	String.valueOf(rowData.get("occurEdate")));
		inParam.put("P_SYS_CLASS",	String.valueOf(rowData.get("sysClass")));
		inParam.put("P_CLOSE_GUBUN",	String.valueOf(rowData.get("closeGubun")));
		inParam.put("P_EMP_NUM",	String.valueOf(rowData.get("loginSabun")));
		inParam.put("P_UPJANG_CD",	String.valueOf(rowData.get("upjangCd")));
		
		String callProcName = "";
		String closeYn = String.valueOf(rowData.get("closeYn"));
		
		// 마감처리
		if("N".equals(closeYn)) callProcName = "SP_FS_MAGAM_PROC";
		// 마감 취소
		else callProcName = "SP_FS_MAGAM_CANCEL";
		
		//마감취소 procedure 호출
		Map<String, Object> retVal = closeMgmtDAO.callCloseProcedure(inParam, callProcName);
		
		//출력값 Setting
		strRtn		= String.valueOf(retVal.get("O_RTN"));
		strRtnMsg	= String.valueOf(retVal.get("O_RTNMSG"));
		strRtnDate	= String.valueOf(retVal.get("O_RTNDATE"));
		
		
		return strRtn + "|" + strRtnMsg + "|" + strRtnDate;
	}
}
