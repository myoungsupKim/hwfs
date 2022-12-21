package com.hwfs.fm.fmf.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import oracle.net.aso.e;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.cmn.util.RequestContextUtil;
import com.hwfs.fm.fmf.dao.ClosingBooksDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.cmn.util.StringUtil;
import com.hwfs.sm.cmn.dao.CloseCommonDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 일마감관리하는 ClosingBooks Service Implementation
 * 
 * @ClassName ClosingBooksServiceImpl.java
 * @Description ClosingBooksServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2021.09.13    김명섭        최초생성
 * </pre>
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fmf/closingBooksService")
public class ClosingBooksServiceImpl extends DefaultServiceImpl implements ClosingBooksService {
	
	/** ClosingBooksDAO Bean 생성 */
	@Resource(name = "/fm/fmf/closingBooksDAO")
	private ClosingBooksDAO closingBooksDAO;
	
    /**
     * 마감장 팩스발송 정보를 저장한다.
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.fm.fmf.service.ClosingBooksService#saveSendList(java.util.Map)
    */
	@SuppressWarnings("unchecked")
	public int saveSendList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		String strChk = "";
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			//int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//if (rowType == DataSet.ROW_TYPE_UPDATED) {

				if(rowData.get("chk") != null)	strChk	= rowData.get("chk").toString();
				//선택
				if("1".equals(strChk)) {

					Map<String, Object> inParam = new HashMap<String, Object>();
					Map<String, Object> retVal = new HashMap<String, Object>();				
					String callProcName = "FMF_CLOSING_BOOKS_HIST_PRO";

					inParam.put("P_UPJANGCD", LimsUtil.checkNull(rowData.get("mainUpjang")));
					inParam.put("P_STARTYMD", LimsUtil.checkNull(rowData.get("schfdate")));
					inParam.put("P_ENDYMD", LimsUtil.checkNull(rowData.get("schtdate")));
					inParam.put("P_RECVNAME", LimsUtil.checkNull(rowData.get("mainUpjangnm")));
					inParam.put("P_RECVNUM", LimsUtil.checkNull(rowData.get("faxNo")));
					inParam.put("P_CUSER", RequestContextUtil.get("loginSabun"));
					
					retVal = closingBooksDAO.callProcedure(inParam, callProcName);

					// 프로시저 실패시 롤백
					if("FALSE".equals(retVal.get("O_RTN").toString())){
						throw new BizException(retVal.get("O_RTNMSG").toString());
					}

					insRowCnt ++;
				}
			//}
		}
				
		return insRowCnt;
	}
	
}
