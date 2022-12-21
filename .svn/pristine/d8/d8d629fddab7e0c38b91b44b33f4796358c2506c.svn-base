package com.hwfs.sc.scz.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.scz.dao.AddrMgmtStCustDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * 거래처 주소를 검증하는 AddrMgmtStCust Service Implementation
 * 
 * @ClassName AddrMgmtStCustServiceImpl.java
 * @Description AddrMgmtStCustServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.10.05    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.10.05
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scz/addrMgmtStCustService")
public class AddrMgmtStCustServiceImpl extends DefaultServiceImpl implements AddrMgmtStCustService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** AddrMgmtStCustDAO Bean 생성 */
	@Resource(name = "/sc/scz/addrMgmtStCustDAO")
	private AddrMgmtStCustDAO addrMgmtStCustDAO;
	

	/**
	 * 거래처 주소 목록을 조회한다.
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
		return addrMgmtStCustDAO.selectList(mapParam);
	}

	/**
	 * 거래처 주소 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap list) throws Exception {
		int updRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += addrMgmtStCustDAO.update(rowData);
			}
		}
				
		return updRowCnt;
	}
}
