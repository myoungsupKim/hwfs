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
import com.hwfs.sc.scz.dao.AddressRevisionDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * 주소정제 결과를 보정하는 AddressRevision Service Implementation
 * 
 * @ClassName AddressRevisionServiceImpl.java
 * @Description AddressRevisionServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.09.26    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.09.26
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scz/addressRevisionService")
public class AddressRevisionServiceImpl extends DefaultServiceImpl implements AddressRevisionService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** AddressRevisionDAO Bean 생성 */
	@Resource(name = "/sc/scz/addressRevisionDAO")
	private AddressRevisionDAO addressRevisionDAO;
	

	/**
	 * 주소 보정 목록을 조회한다.
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
	public RecordSet selectStUpjang(Map<String, Object> mapParam) throws Exception {
		return addressRevisionDAO.selectStUpjang(mapParam);
	}

	public RecordSet selectFmsUpjang1(Map<String, Object> mapParam) throws Exception {
		return addressRevisionDAO.selectFmsUpjang1(mapParam);
	}

	public RecordSet selectFmsUpjang2(Map<String, Object> mapParam) throws Exception {
		return addressRevisionDAO.selectFmsUpjang2(mapParam);
	}
	
	public RecordSet selectStCust(Map<String, Object> mapParam) throws Exception {
		return addressRevisionDAO.selectStCust(mapParam);
	}
	
	public RecordSet selectFmsSecureLand(Map<String, Object> mapParam) throws Exception {
		return addressRevisionDAO.selectFmsSecureLand(mapParam);
	}
	
	public RecordSet selectFmsSecurePerson(Map<String, Object> mapParam) throws Exception {
		return addressRevisionDAO.selectFmsSecurePerson(mapParam);
	}
	
	public RecordSet selectScoUpjangMst(Map<String, Object> mapParam) throws Exception {
		return addressRevisionDAO.selectScoUpjangMst(mapParam);
	}
	
	public RecordSet selectScoUpjangCustHis(Map<String, Object> mapParam) throws Exception {
		return addressRevisionDAO.selectScoUpjangCustHis(mapParam);
	}
	
	public RecordSet selectScoUpjangCust(Map<String, Object> mapParam) throws Exception {
		return addressRevisionDAO.selectScoUpjangCust(mapParam);
	}
	
	public RecordSet selectMakCustMstA(Map<String, Object> mapParam) throws Exception {
		return addressRevisionDAO.selectMakCustMstA(mapParam);
	}
	
	public RecordSet selectMakCustMstB(Map<String, Object> mapParam) throws Exception {
		return addressRevisionDAO.selectMakCustMstB(mapParam);
	}
	
	
	
	/**
	 * 주소 보정 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += addressRevisionDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += addressRevisionDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += addressRevisionDAO.delete(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
