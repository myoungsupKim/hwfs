package com.hwfs.fm.fmc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fm.fmc.dao.DistributionRequestRptProcDAO;
import com.hwfs.sc.cmn.service.AttachFileService;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 물류요청서처리하는 DistributionRequestRptProc Service Implementation
 * 
 * @ClassName DistributionRequestRptProcServiceImpl.java
 * @Description DistributionRequestRptProcServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.11    최영준        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최영준
 * @since 2015.03.11
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fmc/distributionRequestRptProcService")
public class DistributionRequestRptProcServiceImpl extends DefaultServiceImpl implements DistributionRequestRptProcService {

	/** DistributionRequestRptProcDAO Bean 생성 */
	@Resource(name = "/fm/fmc/distributionRequestRptProcDAO")
	private DistributionRequestRptProcDAO distributionRequestRptProcDAO;
	
	/** AttachFile Service Bean 생성 */
	@Resource(name = "/sc/cmn/attachFileService")
	private AttachFileService attachFileService;
	

	/**
	 * 물류요청서 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param parameter
	 *            조회조건 MAP
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return distributionRequestRptProcDAO.selectList(parameter);
	}
	public RecordSet selectMast(Map<String, Object> parameter) throws Exception {
		return distributionRequestRptProcDAO.selectMast(parameter);
	}

	/**
	 * 물류요청서 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	@Override
	public int saveList(DataSetMap list) throws Exception {
		int insertRowCnt = 0;
		int updateRowCnt = 0;
		int deleteRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//추가를 수행합니다.
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insertRowCnt += distributionRequestRptProcDAO.insert(rowData);
			}
			//수정을 수행합니다.
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updateRowCnt += distributionRequestRptProcDAO.update(rowData);
			}
			//삭제를 수행합니다.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				deleteRowCnt += distributionRequestRptProcDAO.delete(rowData);
			}
		}
				
		return insertRowCnt + updateRowCnt + deleteRowCnt;
	}
	
    /**
     * File 데이터를 받아 첨부참조일련번호를 가져온다.
     * <pre>
     * - 데이터와 첨부파일을 함께 처리한다.
     * </pre>
     * 
     * @parma listFile 첨부파일 정보
     * @return 첨부참조일련번호
     * @throws Exception
     */
	@SuppressWarnings({ "unchecked", "unused" })
	public String saveAttachFile(DataSetMap listFile, Map <String, Object> inVar) throws Exception {
		String strRefSeq = "";	//첨부참조일련번호
		
		//첨부파일 처리 : 업무별 저장소의 상대패스를 파라미터로 전달해야 한다.
		strRefSeq = attachFileService.save(listFile, propertiesService.getString("fm.file.path"), false);
		inVar.put("fileId", strRefSeq);
		distributionRequestRptProcDAO.updateMastFile(inVar);
		
		return strRefSeq;
	}
	
	/**
	 * 물류요청서 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	@Override
	public int saveListMast(DataSetMap list) throws Exception {
		int updateRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updateRowCnt += distributionRequestRptProcDAO.updateMast(rowData);
			}
		}
				
		return updateRowCnt;
	}
	
	
}
