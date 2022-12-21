package com.hwfs.rc.bms.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.bms.dao.ProMgmtDAO;
import com.hwfs.sc.cmn.util.Const;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * ProMgmtServiceImpl에 대한 설명 작성
 * @ClassName ProMgmtServiceImpl.java
 * @Description ProMgmtServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 4.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 외식영업(연회판촉)
 * @since 2015. 3. 4.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/bms/proMgmtService")
public class ProMgmtServiceImpl extends DefaultServiceImpl implements ProMgmtService {
	@Resource(name="/rc/bms/proMgmtDAO")
	private ProMgmtDAO proMgmt;
	/**
	 * selectList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.bms.service.ProMgmtService#selectList(java.util.Map)
	 */
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		 
		RecordSet rs = null;
		int maskAuth = Integer.parseInt(parameter.get("maskAuth").toString());
		//관리용(저장, 삭제, 입력)의 권한이 있는 화면에서 조회권한만 있는 경우에는 아래와 같이 분기처리를 한다.
		if (maskAuth == Const.MaskAuthMode.MASK) { //조회권한만 있으므로 개인정보의 마스킹 처리를 수행한다.
			rs = proMgmt.selectMask(parameter);
		}
		else { //저장,삭제,입력등의 권한이 있으므로 비 마스킹처리를 한다.
			rs = proMgmt.selectList(parameter);
		}
		 
		return rs;
	}

	/**
	 * selectData 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.bms.service.ProMgmtService#selectData(java.util.Map)
	 */
	@Override
	public RecordSet searchData(Map<String, Object> parameter) throws Exception {
		RecordSet rs = null;
		int maskAuth = Integer.parseInt(parameter.get("maskAuth").toString());
		//관리용(저장, 삭제, 입력)의 권한이 있는 화면에서 조회권한만 있는 경우에는 아래와 같이 분기처리를 한다.
		if (maskAuth == Const.MaskAuthMode.MASK) { //조회권한만 있으므로 개인정보의 마스킹 처리를 수행한다.
			rs = proMgmt.searchMask(parameter);
		}
		else { //저장,삭제,입력등의 권한이 있으므로 비 마스킹처리를 한다.
			rs = proMgmt.searchData(parameter);
		}
		 
		return rs;
	}

	/**
	 * saveData 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param bmsProMgmt
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.bms.service.ProMgmtService#saveData(hone.online.xplatform.map.DataSetMap)
	 */
	@Override
	@SuppressWarnings("unchecked")
	public int saveData(DataSetMap bmsProMgmt) throws Exception {
		int procCnt = 0;
		String maxSeq = "";
		
		for (int i = 0 ; i < bmsProMgmt.size() ; i++) {
			Map<String, Object> parameter = bmsProMgmt.get(i);
			int rowType = ((Integer)parameter.get(XplatformConstants.DATASET_ROW_TYPE)).intValue(); 
			
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				//amCd 값이 없는 경우 신규로 MAX 값을 생성 한다.
				//if ("".equals(parameter.get("amCd"))) {
					Record chkRs = proMgmt.maxCodeCreate(parameter);
					if(chkRs != null && chkRs.size() > 0) {
						maxSeq = chkRs.getString("maxSeq");
							if(!"".equals(maxSeq)){
								parameter.put("seq", maxSeq);
							}
					}
				//}
				
				procCnt += proMgmt.insertData(parameter);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED){
				procCnt += proMgmt.updateData(parameter);
			}
		}
 
		return  procCnt;
	}

}
