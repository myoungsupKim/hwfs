package com.hwfs.fs.fso.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fso.dao.NewOpProposalActMngtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 신규운영품의 대비 실적관리하는 NewOpProposalActMngt Service Implementation
 * 
 * @ClassName NewOpProposalActMngtServiceImpl.java
 * @Description NewOpProposalActMngtServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.15    최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.07.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fso/newOpProposalActMngtService")
public class NewOpProposalActMngtServiceImpl extends DefaultServiceImpl implements NewOpProposalActMngtService {
	
	/** NewOpProposalActMngtDAO Bean 생성 */
	@Resource(name = "/fs/fso/newOpProposalActMngtDAO")
	private NewOpProposalActMngtDAO newOpProposalActMngtDAO;
	

	/**
	 * 신규운영품의 대비 실적관리 목록을 조회한다.
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
	public RecordSet selectNewOpProposalActMngtList(Map<String, Object> mapParam) throws Exception {
		return newOpProposalActMngtDAO.selectNewOpProposalActMngtList(mapParam);
	}
	
	/**
	 * 신규운영품의 대비 실적관리 업장별실적및 손익계산서를 상세조회한다.
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
	public Map<String, RecordSet> selectDetailList(Map<String, Object> mapParam) throws Exception {
		
		Map<String, RecordSet> rsMap = new HashMap<String, RecordSet>();
		RecordSet rs2 = null;

		
		RecordSet rs1 = newOpProposalActMngtDAO.selectAccOrderPlan(mapParam);	// 업장별 실적조회
		if(mapParam.get("srchClass").equals("002")){
			// 실적
			rs2 = newOpProposalActMngtDAO.selectPlinvoiceList(mapParam);
		}else{
			// 품의
			rs2 = newOpProposalActMngtDAO.selectPlinvoiceList2(mapParam);
		}
						
		rsMap.put("accOrderPlan", rs1);
		rsMap.put("plinvoice", rs2);
		
		return rsMap;
	}

	/**
	 * 신규운영품의 대비 실적관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveNewOpProposalActMngtList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += newOpProposalActMngtDAO.insertUpjangAct(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += newOpProposalActMngtDAO.updateUpjangAct(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += newOpProposalActMngtDAO.deleteUpjangAct(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
