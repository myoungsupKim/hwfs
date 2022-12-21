package com.hwfs.ma.mak.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.ma.mak.dao.DriveMgntDAO;
import com.hwfs.sc.cmn.service.AttachFileService;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * DriveMgnt Service Implementation
 * 
 * @ClassName DriveMgntServiceImpl.java
 * @Description DriveMgntServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2019.02.11    kihoon        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 kihoon
 * @since 2019.02.11
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ma/mak/driveMgntService")
public class DriveMgntServiceImpl extends DefaultServiceImpl implements DriveMgntService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** DriveMgntDAO Bean 생성 */
	@Resource(name = "/ma/mak/driveMgntDAO")
	private DriveMgntDAO driveMgntDAO;
	
	/** AttachFile Service Bean 생성 */
	@Resource(name = "/sc/cmn/attachFileService")
	private AttachFileService attachFileService;

	/**
	 * 차량목록을 조회한다.
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
	public RecordSet selectCarList(Map<String, Object> mapParam) throws Exception {
		return driveMgntDAO.selectCarList(mapParam);
	}
	
	public RecordSet selectCarDetail(Map<String, Object> mapParam) throws Exception {
		return driveMgntDAO.selectCarDetail(mapParam);
	}
	

	public int saveList(DataSetMap list) throws Exception {
		
		int resultCnt = 0;
		for ( int i= 0; i <list.size() ; i++ ) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			if (rowType == DataSet.ROW_TYPE_UPDATED) 
			{
				if ( "1".equals(rowData.get("chk").toString() ) )
				{
					resultCnt += driveMgntDAO.deleteCarInfo(rowData);
				}
			}
		}
		return resultCnt;
	
	}
	
	
	public int saveListDetail(DataSetMap list, DataSetMap file) throws Exception {
		
		
		Map<String, Object> chkDup = list.get(0);
		RecordSet rsChk = driveMgntDAO.selectCheckCarInfo(chkDup);
		
		if ( rsChk.size() != 0 && (chkDup.get("udate").toString().length()) == 0 ) {
			String str = "[" + rsChk.get(0).get("mgmtSabun").toString() + "]";
				   str += rsChk.get(0).get("userNm").toString()+"사용자가 동일한 차량정보로\n";
				   str += rsChk.get(0).get("udate").toString() + "에 입력된 차량 정보가 존재합니다.";
			
			throw new BizException(str);
		}
		
		String strRefSeq = "";	//첨부참조일련번호
		int resultCnt = 0;
		strRefSeq = attachFileService.save(file, propertiesService.getString("mk.file.path"), false);
				
		Map<String, Object> rowData = list.get(0);
		rowData.put("attachInfo", strRefSeq);
		int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
		
		if (rowType == DataSet.ROW_TYPE_INSERTED) 
		{
			for ( int j = 0; j <file.size() ; j++ ) {
				Map<String, Object> rowFile = file.get(j);
				String gubun = rowFile.get("evidence").toString();
				String expDate = rowFile.get("expDate").toString();
				
				
				rowData.put("attr"+gubun, gubun);
				rowData.put("set"+gubun, expDate);
				
			}
			resultCnt += driveMgntDAO.insertCarInfo(rowData);
		}
		else
		{
			/*
			if ( file.getDelRowMaps().size() > 0 ) {
				for ( int k = 0; k < file.getDelRowMaps().size() ; k++ ) {
					Map<String, Object> delFile = file.getDelRowMaps().get(k);
					String gubun = delFile.get("evidence").toString();
					String expDate = delFile.get("expDate").toString();
					
					rowData.put("attr"+gubun, null);
					rowData.put("set"+gubun, null);
				}
				
			}
			*/
			
			driveMgntDAO.updateCarInfoReset(rowData);
			
			for ( int j = 0; j <file.size() ; j++ ) {
				Map<String, Object> rowFile = file.get(j);
				String gubun = rowFile.get("evidence").toString();
				String expDate = rowFile.get("expDate").toString();
				rowData.put("attr"+gubun, gubun);
				rowData.put("set"+gubun, expDate);
				
			}
			
			resultCnt += driveMgntDAO.updateCarInfo(rowData);
		}
		
		
		
		return resultCnt;
	}
	
	public Record selectGwDraftMst(Map<String, Object> mapParam) throws Exception {
		return driveMgntDAO.selectGwDraftMst(mapParam);
	}
	

	/**
	 * updateSignInfo 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 * @return
	 * @throws Exception
	 * @see com.hwfs.ma.mak.service.DriveMgntService#updateSignInfo(hone.online.xplatform.map.DataSetMap)
	*/
	@Override
	public int updateSignInfo(DataSetMap list) throws Exception {
		int resultCnt = 0;
		for ( int i= 0; i <list.size() ; i++ ) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			if (rowType == DataSet.ROW_TYPE_UPDATED) 
			{
				if ( "1".equals(rowData.get("chk").toString() ) )
				{
					resultCnt += driveMgntDAO.updateSignInfo(rowData);
				}
			}
		}
		return resultCnt;
	}
}
