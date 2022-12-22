package com.hwfs.ms.msc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ms.msc.dao.SaniCheckResultDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;

 /**
 * 위생점검결과조회 SaniCheckResult Service Implementation
 * 
 * @ClassName FoodReservesReportServiceImpl.java
 * @Description FoodReservesReportServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.07.29                최초생성
 * </pre>
 * @author 
 * @since 2022.07.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ms/msc/saniCheckResultService")
public class SaniCheckResultServiceImpl extends DefaultServiceImpl implements SaniCheckResultService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** FoodReservesReportDAO Bean 생성 */
	@Resource(name = "/ms/msc/saniCheckResultDAO")
	private SaniCheckResultDAO saniCheckResultDAO;		
	
	/**
	 * 위생점검결과 목록을 조회한다.
	 */
	public RecordSet selectMasterList(Map<String, Object> mapParam) throws Exception {
		
		RecordSet rs = saniCheckResultDAO.selectMasterList(mapParam);
		
		return rs;
	}
	public RecordSet selectDetailNewList(Map<String, Object> mapParam) throws Exception {
		
		RecordSet rs = null;
		// 신규입력일 경우
		//rs = saniCheckResultDAO.selectDetailNewList(mapParam);
		// 입력된 애를 불러올 경우 
		rs = saniCheckResultDAO.selectDetailList(mapParam);
		if(rs.getRowCount() == 0) {
			rs = saniCheckResultDAO.selectDetailNewList(mapParam);
		}
		
		return rs;
	}
	

	
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap dsMaster, DataSetMap dsDetail,  LoginDTO loginDTO) throws Exception {
		
		int insMasterRowCnt = 0;
		int insDetailRowCnt = 0;
		String rowStatus = "";
		
		// insert 인지 update 인지 구분값 설정
		if(dsDetail.size() != 0){
			rowStatus = dsDetail.get(0).get("rowStatus").toString();
		}
		
		//master info
		Map<String, Object> masterRow =  dsMaster.get(0);
		masterRow.put("sabun", loginDTO.getSabun());
		
		if(rowStatus.equals("OLD")) {
			// update
			insMasterRowCnt = saniCheckResultDAO.updateMaster(masterRow);
		} else {
			// insert
			insMasterRowCnt = saniCheckResultDAO.insertMaster(masterRow);
		}
		
		for (int i=0; i<dsDetail.size(); i++) {
			Map<String, Object> detailRow =  dsDetail.get(i);
			detailRow.put("sabun", loginDTO.getSabun());

			if(rowStatus.equals("OLD")) {
				// update
				insDetailRowCnt += saniCheckResultDAO.updateDetail(detailRow);
			} else {
				// insert
				insDetailRowCnt += saniCheckResultDAO.insertDetail(detailRow);
			}
			
			
		}
		
//		for (int i = 0 ; i < dsMaster.size() ; i++) {
//			Map<String, Object> rowData = dsMaster.get(i);
			
//			RecordSet reservNumList = provisionalContractReqtDAO.selectReservNum(rowData);
//			
//			String reservNum = (String) reservNumList.get(i).get("reservNum");
//			
//			//채번한 일련번호를 예약번호에 담는다.
//			rowData.put("reservNum", reservNum);			
//			
//			logger.debug("log >>>>>>>>>>>>" +rowData);
//			
//			insRowCnt += provisionalContractReqtDAO.insertMst(rowData);
//			
//			//예약번호, 행사구분(연회:1, 웨딩:2, 케이터링:3)내용을 BMS_FUNCTION 테이블에 등록한다.
//			insRowFunctionCnt += provisionalContractReqtDAO.insertBmsFunction(rowData);		
			
//		}
		
		return insMasterRowCnt+insDetailRowCnt;
		
	}
	
	
	@SuppressWarnings("unchecked")
	public int deleteList(DataSetMap dsMaster, DataSetMap dsDetail) throws Exception {
	
		int delRowCnt = 0;
		
		Map<String, Object> masterRow =  dsMaster.get(0);
		
		delRowCnt += saniCheckResultDAO.deleteMaster(masterRow);
		delRowCnt += saniCheckResultDAO.deleteDetail(masterRow);
		delRowCnt += saniCheckResultDAO.deletePhoto(masterRow);
		
		
		return delRowCnt;
	}
	
	public RecordSet selectSabunList(Map<String, Object> mapParam) throws Exception {
		return saniCheckResultDAO.selectSabunList(mapParam);
	}
	
	public RecordSet selectFormCdList(Map<String, Object> mapParam) throws Exception {
		return saniCheckResultDAO.selectFormCdList(mapParam);
	}
	
	public RecordSet selectCommonCdList(Map<String, Object> mapParam) throws Exception {
		return saniCheckResultDAO.selectCommonCdList(mapParam);
	}
}
