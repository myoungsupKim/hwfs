package com.hwfs.rc.bms.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.bms.dao.BuffetMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * BuffetMgmtServiceImpl에 대한 설명 작성
 * @ClassName BuffetMgmtServiceImpl.java
 * @Description BuffetMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 8. 3.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 연회웨딩
 * @since 2015. 8. 3.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/bms/buffetMgmtService")
public class BuffetMgmtServiceImpl extends DefaultServiceImpl implements BuffetMgmtService {
	@Resource(name="/rc/bms/buffetMgmtDAO")
	private BuffetMgmtDAO buffetMgmt;
	/**
	 * selectListCst 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.bms.service.BuffetMgmtService#selectListCst(java.util.Map)
	 */
	@Override
	public RecordSet selectListCst(Map<String, Object> parameter) throws Exception {
		return buffetMgmt.selectListCst(parameter);
	}

	/**
	 * selectListCstDetail 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.bms.service.BuffetMgmtService#selectListCstDetail(java.util.Map)
	 */
	@Override
	public RecordSet selectListCstDetail(Map<String, Object> parameter) throws Exception {
		return buffetMgmt.selectListCstDetail(parameter);
	}

	/**
	 * saveData 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param reservMst
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.bms.service.BuffetMgmtService#saveData(hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	@SuppressWarnings("unchecked")
	public int saveData(DataSetMap cstMst, DataSetMap cstDetail) throws Exception {
		int procCnt = 0;
		String cstNum = ""; //원가번호
		int    cstSeq = 0; //일련번호 
		
		for (int i = 0 ; i < cstMst.size() ; i++) {
			Map<String, Object> parameter = cstMst.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if(!parameter.containsKey("cstNum") || "".equals(parameter.get("cstNum")))
			{					
				Record chkRs = buffetMgmt.maxCodeCreateMst(parameter);
				if(chkRs != null && chkRs.size() > 0) {
					cstNum = chkRs.getString("maxCode");
					if(!"".equals(cstNum)){
						parameter.put("cstNum", cstNum);
					}
				}
			} else {
				
				cstNum = parameter.get("cstNum").toString();
			}
			 
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				procCnt += buffetMgmt.insertDataCst(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				procCnt += buffetMgmt.insertDataCst(parameter);
			}
		}
		
		//세부사항은 무조건 cstNum 값을 넣어 저장 한다.
		for (int i = 0 ; i < cstDetail.size() ; i++) {
			Map<String, Object> parameter = cstDetail.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 

			//예약번호 없는 경우 신규 MAX 값을 생성 한다.
			if(!parameter.containsKey("cstNum") || "".equals(parameter.get("cstNum")))
			{					
				parameter.put("cstNum", cstNum);
			}
			//일련번호생성
			if(!parameter.containsKey("seq") || "".equals(parameter.get("seq")))
			{
				Record chkRs = buffetMgmt.maxCodeCreateDetail(parameter);
				if(chkRs != null && chkRs.size() > 0) {
					cstSeq = chkRs.getInt("maxSeq");
					if(!"".equals(cstSeq)){
						parameter.put("seq", cstSeq);
					}
				}
			}
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				procCnt += buffetMgmt.insertDataDetail(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				procCnt += buffetMgmt.insertDataDetail(parameter);	 
			}
		}
 
		return  procCnt;
	}

}
