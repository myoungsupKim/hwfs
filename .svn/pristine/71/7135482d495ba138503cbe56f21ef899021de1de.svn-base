package com.hwfs.sc.scz.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.idgen.UUIdGenUtil;
import com.hwfs.sc.scz.dao.UpjangApprovalDAO;
import com.hwfs.sc.scz.dao.UpjangMgmtDAO;

 /**
 * 등록된 업장을 승인하는 UpjangApproval Service Implementation
 * 
 * @ClassName UpjangApprovalServiceImpl.java
 * @Description UpjangApprovalServiceImpl Class
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
@Service("/sc/scz/upjangApprovalService")
public class UpjangApprovalServiceImpl extends DefaultServiceImpl implements UpjangApprovalService {
	
	/** UpjangApprovalDAO Bean 생성 */
	@Resource(name = "/sc/scz/upjangApprovalDAO")
	private UpjangApprovalDAO upjangApprovalDAO;
	
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
		return upjangApprovalDAO.selectList(mapParam);
	}

	
	public RecordSet selectLog(Map<String, Object> mapParam) throws Exception {
		return upjangApprovalDAO.selectLog(mapParam);
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
				rowData.put("approvalStatusCd", approvalStatusCd);
				rowData.put("approvalRemark", approvalRemark);
				updRowCnt += upjangApprovalDAO.update(rowData);
				
				if ("APR".equals(approvalStatusCd)) {
					
					if ( "0".equals(rowData.get("scoCnt").toString())) {				
						upjangMgmtDAO.insertScoUpjangMst(rowData);
					}
	
					if (rowData.containsKey("shopTypCd") && "02".equals(rowData.get("shopTypCd"))) {
						if ("0".equals(rowData.get("fmsCnt").toString())) {
							String newAddrKey = UUIdGenUtil.getUUID().toUpperCase();
							rowData.put("newAddrKey", newAddrKey);
							upjangMgmtDAO.insertFmsUpjang(rowData);
							upjangMgmtDAO.insertSccAddrInfo(rowData);
						}
					}
				}
			}
		}
				
		return updRowCnt;
	}
}
