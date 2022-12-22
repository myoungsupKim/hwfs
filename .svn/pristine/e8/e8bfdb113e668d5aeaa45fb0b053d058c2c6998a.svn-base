package com.hwfs.fs.fso.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fso.dao.OpProposalDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 손익추정보고서하는 OpProposal Service Implementation
 * 
 * @ClassName OpProposalServiceImpl.java
 * @Description OpProposalServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.24    최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.07.24
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fso/opProposalService")
public class OpProposalServiceImpl extends DefaultServiceImpl implements OpProposalService {
	
	/** OpProposalDAO Bean 생성 */
	@Resource(name = "/fs/fso/opProposalDAO")
	private OpProposalDAO opProposalDAO;
	

	/**
	 * 손익추정보고서 목록을 조회한다.
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
	public RecordSet selectObjectList(Map<String, Object> mapParam) throws Exception {
		return opProposalDAO.selectObjectList(mapParam);
	}
	
	/**
	 * 업장목록을 조회한다.
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
	public RecordSet selectAccObjectUpjang(Map<String, Object> mapParam) throws Exception {
		return opProposalDAO.selectAccObjectUpjang(mapParam);
	}
	
	/**
	 * 손익추정 리스트를 조회한다.
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
	public RecordSet selectPlinvoiceList(Map<String, Object> mapParam) throws Exception {
		return opProposalDAO.selectPlinvoiceList(mapParam);
	}
	

	/**
	 * 손익추정보고서 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int savePlinvoiceList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert , Update 처리
			if ((rowType == DataSet.ROW_TYPE_INSERTED) || (rowType == DataSet.ROW_TYPE_UPDATED)) {
				
				// 해당건 존재하면, update 없으면 insert처리
				RecordSet rs = opProposalDAO.selectExistData(rowData);
				if("Y".equals(rs.get(0).get("cnt").toString())) {
					updRowCnt += opProposalDAO.updatePlinvoice(rowData);
				}else {
					insRowCnt += opProposalDAO.insertPlinvoice(rowData);
				}
				
			//Delete 처리.
			}else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += opProposalDAO.deletePlinvoice(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
