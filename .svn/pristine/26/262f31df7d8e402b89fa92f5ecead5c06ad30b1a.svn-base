package com.hwfs.fs.fse.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.idgen.UUIdGenUtil;
import com.hwfs.fs.fse.dao.EventApprovalDAO;
import com.hwfs.sc.scz.dao.UpjangMgmtDAO;

 /**
 * 등록된 업장을 승인하는 EventApproval Service Implementation
 * 
 * @ClassName EventApprovalServiceImpl.java
 * @Description EventApprovalServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.28    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.07.28
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fse/eventApprovalService")
public class EventApprovalServiceImpl extends DefaultServiceImpl implements EventApprovalService {
	
	/** EventApprovalDAO Bean 생성 */
	@Resource(name = "/fs/fse/eventApprovalDAO")
	private EventApprovalDAO eventApprovalDAO;
	
	@Resource(name = "/sc/scz/upjangMgmtDAO")
	private UpjangMgmtDAO upjangMgmtDAO;
	

	/**
	 * 업장승인 목록을 조회한다.
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
		return eventApprovalDAO.selectList(mapParam);
	}

	
	public RecordSet selectLog(Map<String, Object> mapParam) throws Exception {
		return eventApprovalDAO.selectLog(mapParam);
	}
	
	/**
	 * 업장승인 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap list, String approvalStatusCd, String approvalRemark) throws Exception {
		int updRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			if ("1".equals(rowData.get("chk").toString())) {
				rowData.put("apprStatus", approvalStatusCd); // 40 반려 50 승인
				rowData.put("rtnReason", approvalRemark); 
								
				updRowCnt += eventApprovalDAO.update(rowData);
			}
		}
				
		return updRowCnt;
	}
}
