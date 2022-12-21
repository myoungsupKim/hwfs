package com.hwfs.fs.fso.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fso.dao.NewOpProposalPlanMngtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 신규수주계획하는 NewOpProposalPlanMngt Service Implementation
 * 
 * @ClassName NewOpProposalPlanMngtServiceImpl.java
 * @Description NewOpProposalPlanMngtServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.03    최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.07.03
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fso/newOpProposalPlanMngtService")
public class NewOpProposalPlanMngtServiceImpl extends DefaultServiceImpl implements NewOpProposalPlanMngtService {
	
	/** NewOpProposalPlanMngtDAO Bean 생성 */
	@Resource(name = "/fs/fso/newOpProposalPlanMngtDAO")
	private NewOpProposalPlanMngtDAO newOpProposalPlanMngtDAO;
	
	/**
	 * 담당 마케터(급식,식재, 외식) 코드를 조회한다.
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
	public RecordSet selectMarketer(Map<String, Object> mapParam) throws Exception {
		return newOpProposalPlanMngtDAO.selectMarketer(mapParam);
	}

	/**
	 * 신규수주계획 목록을 조회한다.
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
	public RecordSet selectProposalPlanList(Map<String, Object> mapParam) throws Exception {
		return newOpProposalPlanMngtDAO.selectProposalPlanList(mapParam);
	}
	
	/**
	 * 수주계획을 조회한다.
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
	public RecordSet selectOrderPlanList(Map<String, Object> mapParam) throws Exception {
		return newOpProposalPlanMngtDAO.selectOrderPlanList(mapParam);
	}
	
	/**
	 * 배부반영 계획을 조회한다.
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
	public RecordSet selectAccOrderDivplanList(Map<String, Object> mapParam) throws Exception {
		return newOpProposalPlanMngtDAO.selectAccOrderDivplanList(mapParam);
	}
	
	/**
	 * 물건카드 팝업을 조회한다.
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
	public RecordSet selectObjectCardPopup(Map<String, Object> mapParam) throws Exception {
		return newOpProposalPlanMngtDAO.selectObjectCardPopup(mapParam);
	}
	
	/**
	 * 수주계획 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveAccOrderPlanList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				insRowCnt += newOpProposalPlanMngtDAO.insertAccOrderPlanList(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				
				updRowCnt += newOpProposalPlanMngtDAO.updateAccOrderPlanList(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += newOpProposalPlanMngtDAO.deleteAccOrderPlanList(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 배부반영 계획 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveAccOrderDivplanList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += newOpProposalPlanMngtDAO.insertAccOrderDivplanList(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += newOpProposalPlanMngtDAO.updateAccOrderDivplanList(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += newOpProposalPlanMngtDAO.deleteAccOrderDivplanList(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 배부반영 계획 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	public int saveBaseDivplanList(Map<String, Object> mapParam) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		delRowCnt += newOpProposalPlanMngtDAO.deleteAccOrderDivplanList(mapParam);		
		insRowCnt += newOpProposalPlanMngtDAO.insertAccOrderDivplanList(mapParam);
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
