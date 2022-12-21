package com.hwfs.sm.cmn.service;

import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.cmn.dao.CloseCommonDAO;

 /**
 * 마감처리/취소 하는 CloseCommon Service Implementation
 * 
 * @ClassName CloseCommonServiceImpl.java
 * @Description CloseCommonServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.27    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.05.27
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/cmn/closeCommonService")
public class CloseCommonServiceImpl extends DefaultServiceImpl implements CloseCommonService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** CloseCommonDAO Bean 생성 */
	@Resource(name = "/sm/cmn/closeCommonDAO")
	private CloseCommonDAO closeCommonDAO;

	/**
	 * 마감처리/취소 한다.
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public String setPosCloseProc(DataSetMap list) throws Exception {
	    
		String strRtn	= null;
		String strRtnMsg= null;
		
		Map<String, Object> inParam = new HashMap<String, Object>();
		Map<String, Object> rowData = list.get(0);

//		System.out.println("##### SP_SLA_SALS_POS_MAGAM_PROC START #####");
//		System.out.println("###########################################################");
//		System.out.println("##### occurDate:"+String.valueOf(rowData.get("occurDate")));
//		System.out.println("##### sysClass:"+String.valueOf(rowData.get("sysClass")));
//		System.out.println("##### upjangCd:"+String.valueOf(rowData.get("upjangCd")));
//		System.out.println("##### closeYn:"+String.valueOf(rowData.get("closeYn")));
//		System.out.println("###########################################################");
		
		//입력값 Setting
		inParam.put("P_OCCUR_DATE",	String.valueOf(rowData.get("occurDate")));
		inParam.put("P_SYS_CLASS",	String.valueOf(rowData.get("sysClass")));
		inParam.put("P_UPJANG_CD",	String.valueOf(rowData.get("upjangCd")));

		String callProcName = "";
		String closeYn = String.valueOf(rowData.get("closeYn"));

		//마감처리
		if("N".equals(closeYn)) callProcName = "SP_SLA_SALS_POS_MAGAM_PROC";
		
		//마감취소
		else callProcName = "SP_SLA_SALS_POS_MAGAM_CANCEL";
		
		//마감처리/취소 procedure 호출
		Map<String, Object> retVal = closeCommonDAO.callCloseProcedure(inParam, callProcName);
		
		//출력값 Setting
		strRtn		= String.valueOf(retVal.get("O_RTN"));
		strRtnMsg	= String.valueOf(retVal.get("O_RTNMSG"));
		
//		System.out.println("###########################################################");
//		System.out.println("##### strRtn:"+strRtn);
//		System.out.println("##### strRtnMsg:"+strRtnMsg);
//		System.out.println("###########################################################");	
//		System.out.println("##### SP_SLA_SALS_POS_MAGAM_PROC END #####");
		
		return strRtn + "|" + strRtnMsg;
	}
}
