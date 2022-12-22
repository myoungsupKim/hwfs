package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.idgen.UUIdGenUtil;
import com.hwfs.sc.cmn.dao.KiccApprovalDAO;

 /**
 * KICC의 승인처리를하는 KiccApproval Service Implementation
 *
 * @ClassName KiccApprovalServiceImpl.java
 * @Description KiccApprovalServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.21    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.07.21
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/kiccApprovalService")
public class KiccApprovalServiceImpl extends DefaultServiceImpl implements KiccApprovalService {

	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** KiccApprovalDAO Bean 생성 */
	@Resource(name = "/sc/cmn/kiccApprovalDAO")
	private KiccApprovalDAO kiccApprovalDAO;

	/**
	 * 특정 승인정보를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.cmn.service.KiccApprovalService#selectCardApproval(java.util.Map)
	*/
	public RecordSet selectCardApproval(Map<String, Object> mapParam) throws Exception {
		return kiccApprovalDAO.selectCardApproval(mapParam);
	}

	/**
	 * KICC 승인처리 목록을 조회한다.
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
		return kiccApprovalDAO.selectList(mapParam);
	}

	/**
	 * KICC 승인처리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public Map<String, Object> saveList(Map<String, Object> approvalData) throws Exception {
		Map<String, Object> rtn = new HashMap<String, Object>();
		String refNo = "";
		
		if (!approvalData.containsKey("refNo")) {
			refNo = UUIdGenUtil.getUUID();
			approvalData.put("refNo", refNo);
		}
		else {
			refNo = approvalData.get("refNo").toString();
		}

//		Map<String, Object> rowData = list.get(0);
//		rowData.put("dsctNum", dsctNum);
		rtn.put("refNo", refNo);
		kiccApprovalDAO.insert(approvalData);

//		for (int i = 0 ; i < list.size() ; i++) {
//			Map<String, Object> rowData = list.get(i);
//			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
//
//			//Insert 처리
//			if (rowType == DataSet.ROW_TYPE_INSERTED) {
//				kiccApprovalDAO.insert(rowData);
//			}
//			//Update 처리
//			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
//				kiccApprovalDAO.update(rowData);
//			}
//			//Delete 처리.
//			else if (rowType == DataSet.ROW_TYPE_DELETED) {
//				kiccApprovalDAO.delete(rowData);
//			}
//		}

		return rtn;
	}
}
