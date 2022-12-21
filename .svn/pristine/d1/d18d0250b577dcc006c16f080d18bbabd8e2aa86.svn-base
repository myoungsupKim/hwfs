package com.hwfs.ft.fsi.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ft.fsi.dao.PortAirportMgmtPortDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 국가별 항구 관리하는 PortAirportMgmtPort Service Implementation
 * 
 * @ClassName PortAirportMgmtPortServiceImpl.java
 * @Description PortAirportMgmtPortServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.10    김종준        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재도매 김종준
 * @since 2015.03.10
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ft/fsi/portAirportMgmtPortService")
public class PortAirportMgmtPortServiceImpl extends DefaultServiceImpl implements PortAirportMgmtPortService {
	
	/** PortAirportMgmtPortDAO Bean 생성 */
	@Resource(name = "/ft/fsi/portAirportMgmtPortDAO")
	private PortAirportMgmtPortDAO portAirportMgmtPortDAO;
	

	/**
	 * 국가별 항구 목록을 조회한다.
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
	public RecordSet selectPortAirportMgmtPort(Map<String, Object> mapParam) throws Exception {
		return portAirportMgmtPortDAO.selectPortAirportMgmtPort(mapParam);
	}

	/**
	 * 국가별 항구 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int savePortAirportMgmtPortList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += portAirportMgmtPortDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += portAirportMgmtPortDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += portAirportMgmtPortDAO.delete(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
